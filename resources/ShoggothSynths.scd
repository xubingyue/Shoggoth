

// Shoggoth Synths
// Arguments and ranges:
// x: 1 to 430
// y: -200 to 200
// z: 1 to 430
// island: 0 to 4

(

(
SynthDef.new("ShoggothMasterOut", {
	|amp=1.0, preAmp=1.0, in=50, out=0|
	var inputSignal, limit;
	inputSignal = In.ar(in, 2);
	limit = Limiter.ar(LeakDC.ar(inputSignal * preAmp));
	Out.ar(0, limit);
}).writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs").store;
);

(
SynthDef.new("ShoggothTestSine",{
	|amp=0.1, freq=440|
	var env, signal;
	env = EnvGen.ar(Env.new([0, 1, 0],[0.1, 5], -4), gate:1, doneAction:2);
	signal = SinOsc.ar(freq) * env * amp;
	Out.ar(50, signal.dup);
}).writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs").store;
);

// ~sine = Synth("ShoggothTestSine");

(
SynthDef.new("ShoggothPerc",{
	|amp=0.125, x=0, y=0, z=0, island=0, gate=1, t_trig=0|
	var env, signal, mod, gateEnv, in;
	gateEnv = EnvGen.ar(Env.asr(0, 1, 1, -4), gate:gate, doneAction:2);
	env = EnvGen.ar(Env.new([0, 1, 0],[0.0001, 0.1], -4), gate:t_trig, doneAction:0);
	mod = z.linexp(1, 430, 0.1, 1000);
	in = InFeedback.ar(80 + (island * 2), 2);
	signal = in + SinOsc.ar(55 * y.linexp(-200, 200, 1, 20).round(1)).clip2(Saw.ar(x.linexp(1, 430, 20, 80), z/860/2, z/860/2));
	signal = Pan2.ar(signal, island.linlin(0, 3, -1 , 1)) * env * amp;
	Out.ar(50, signal);
	Out.ar(80 + (island * 2), signal);
}).writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs").store;
);

// ~sine = Synth("ShoggothPerc");
// ~sine.set(\t_trig, 1, \x, rrand(1, 430), \y, rrand(-200, 200), \z, rrand(1, 430));
// ~sine.set(\gate, 0);


(
SynthDef.new("PlatedGeopede",{
	|amp=0.5, x=0, y=0, z=0, island=0, gate=1, t_trig=0|
	var env, signal, mod, feedIn, feedOut, spring, damp, springs, sel, modX, modY, modZ, sawFreq;
	var sel2, scale, matrix, matrixFreq, env3, gateEnv;
	gateEnv = EnvGen.ar(Env.asr(0, 1, 4, -4), gate:gate, doneAction:2);
	env = EnvGen.ar(Env.new([0, 1, 0],[0.1, 0.25], -4), gate:t_trig, doneAction:0);
	env3 = EnvGen.ar(Env.new([0, 1, 0],[1.5, 1], -4), gate:t_trig, doneAction:0);
	modX = x.linlin(1, 430, 0, 1);
	modY = y.linlin(-200, 200, 0, 1);
	modZ = z.linlin(1, 430, 0, 1);
	spring = (0.107421875).dup(10);
	damp = (0.0537109375).dup(10);
	scale = [9, 12, 14, 16, 19, 21, 24, 26, 28, 31, 33].midicps * 2;
	matrix = Array.fill2D(430 / 5, 430 / 5, { |x, y| scale[(x + y) % scale.size] * 2.pow(y % 3) });
	matrixFreq = Select.kr(z / 5, Select.kr(x / 5, matrix));

	feedIn = LPF.ar(LocalIn.ar(1), matrixFreq)
		+ LPF.ar(Saw.ar(matrixFreq / 32, env / 2) + WhiteNoise.ar(env3 * 0.1), matrixFreq * 2.pow(modY.linexp(0, 1, 1, 5).round(1)));
	feedIn = HPF.ar(feedIn, 20);
	feedOut = feedIn;

	springs = spring.collect{ |spr, i|
		feedOut = Spring.ar(feedOut, spr, damp[i]);
		// feedOut = CombC.ar(feedOut, spr, spr, damp[i]);
	};

	LocalOut.ar(feedOut);

	sel = LFTri.ar(matrixFreq / 32, 0, 0.5, 0.5) * spring.size;
	//sel2 = Slew.ar(Saw.ar(matrixFreq * 2, 0.5, 0.5), SampleRate.ir / 10, SampleRate.ir) * spring.size;
	signal = Splay.ar(SelectX.ar(sel, springs), 1);
	signal = Limiter.ar(signal);
	signal = Pan2.ar(signal, island.linlin(0, 3, -1 , 1)) * env * amp * gateEnv;
	signal = SanityCheck2.ar(signal);
	Out.ar(50, signal);
	Out.ar(80 + (island * 2), signal);
}).writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs").store;
);

// ~plate = Synth("PlatedGeopede", [\x, rrand(1, 430), \y, rrand(-200, 200), \z, rrand(1, 430)]);
// ~plate.set(\t_trig, 1, \x, rrand(1, 430), \y, rrand(-200, 200), \z, rrand(1, 430));
// ~plate.set(\gate, 0);

(
SynthDef("ShogSnare",{
		|out = 0, t_trig = 0, freq = 440, amp=0.6, pan = 0, x, y, z, island, gate=1
		freqLo= 0, freqHi= 0, pwLo= 0, pwHi= 0, ctrl= 65, atkDcy= 5, susRel= 5, fcLo= 0, fcHi= 0, res= 0, mode= 15, rate= 1|
		var modX, modY, modZ;
		var env, signal, osc, attackEnv,noteFreq;
		modX = x.linlin(1, 430, 0, 1);
		modY = y.linlin(-200, 200, 0, 1);
		modZ = z.linlin(1, 430, 0, 1);
		noteFreq = freq.linlin(0,127,127,0).midicps;
		attackEnv = EnvGen.ar(
			Env.new(
				[0.0,1,0.1,0],
				[0.0001,modX * 0.125, modY * 0.125],
				-4),
			gate:t_trig,
			doneAction:0);
		env = EnvGen.ar(Env.asr(0.001,0.25,1,-4),gate:gate,doneAction:2);
		osc = WhiteNoise.ar(1);
		//osc = RLPF.ar( osc, attackEnv.range( TExpRand.kr(500,10000,t_trig), TExpRand.kr(100,10000,t_trig) ), TRand.kr(0.01,1) );
		osc = BMoog.ar(
			attackEnv+osc,
			Lag.kr(modY.linexp(0, 1, 1000, 10000), modX.linexp(0, 1, 0.0001, 0.1)),
			modZ,
			attackEnv.range( modX * 2, modZ * 2),
			Lag.kr( modY, modZ * 0.1)
			);
		osc = (modX * 8 *osc).clip2(Lag.kr(modY / 2 + 0.5, modZ * 0.1));
		signal = Pan2.ar( osc, 0.5 );
		Out.ar(out, signal * amp * attackEnv / 4);
	    Out.ar(80 +( island * 2), signal * 4);
	}).writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs").store;
);

// ~snare = Synth("ShogSnare", [\x, rrand(1, 430), \y, rrand(-200, 200), \z, rrand(1, 430)]);
// ~snare.set(\t_trig, 1, \x, rrand(1, 430), \y, rrand(-200, 200), \z, rrand(1, 430));
// ~snare.set(\gate, 0);

(
SynthDef("ShoggothBassDrum",{
		|out = 0, t_trig = 0, freq = 440, gate = 1, amp=0.75, pan = 0, x, y, z, island,
		freqLo= 0, freqHi= 0, pwLo= 0, pwHi= 0, ctrl= 65, atkDcy= 5, susRel= 5, fcLo= 0, fcHi= 0, res= 0, mode= 15, rate= 1|
		var modX, modY, modZ;
		var env, signal, osc, attackEnv,noteFreq,fmSine, imp, gateEnv;
		imp = t_trig;
		modX = x.linlin(1, 430, 0, 1);
		modY = y.linlin(-200, 200, 0, 1);
		modZ = z.linlin(1, 430, 0, 1);
		gateEnv = EnvGen.ar(Env.asr(0, 1, 1, -4), gate:gate, doneAction:2);
		attackEnv = EnvGen.ar(
			Env.new(
				[0.0,1,0.1,0],
				[0.0001,modX * 0.25, modY * 2.5 + 0.5],
				-4),
			gate:imp,
			doneAction:0);
		env = EnvGen.ar(Env.asr(0.0001,1,1,-4),gate:imp,doneAction:0);
		osc = SinOsc.ar(47,modZ * 0.8 + 0.1,0.5,0.5);
		//osc = RLPF.ar( osc, attackEnv.range( TExpRand.kr(500,10000,t_trig), TExpRand.kr(100,10000,t_trig) ), TRand.kr(0.01,1) );
		osc = RLPF.ar(
			imp+osc,
			Select.kr(modY * 3,[27.5, 55, 43]),
			modZ.linexp(0, 1, 0.01, 0.9)
			).softclip*0.5 + osc;
		osc = LPF.ar( osc, 400 );
		fmSine = SinOsc.ar(modY.linexp(0, 1, 1, 5000), 0, 0.5, 0.5 ).range(modX.linlin(0, 1, -500, 500), modZ.linlin(0, 1, -1000, 10000));
		osc = osc + SinOsc.ar(15000+fmSine,0,0.05);
		signal = Pan2.ar( osc, 0 );
		Out.ar( out, signal * amp * attackEnv * gateEnv);
	    Out.ar(80 +( island * 2), signal * 4);
	}).writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs").store;
);

// ~bassdrum = Synth("ShoggothBassDrum", [\x, rrand(1, 430), \y, rrand(-200, 200), \z, rrand(1, 430)]);
// ~bassdrum.set(\t_trig, 1, \x, rrand(1, 430), \y, rrand(-200, 200), \z, rrand(1, 430));
// ~bassdrum.set(\gate, 0);

(
SynthDef("ShogHiHat",{
		|out = 0, t_trig = 0, freq = 440, gate = 1, amp=0.4, pan = 0, x, y, z, island,
		freqLo= 0, freqHi= 0, pwLo= 0, pwHi= 0, ctrl= 65, atkDcy= 5, susRel= 5, fcLo= 0, fcHi= 0, res= 0, mode= 15, rate= 1|
		var env, signal, osc, attackEnv,noteFreq, gateEnv;
		var modX, modY, modZ, imp;
		noteFreq = freq.linlin(0,127,127,0).midicps;
		imp = t_trig;
		modX = x.linlin(1, 430, 0, 1);
		modY = y.linlin(-200, 200, 0, 1);
		modZ = z.linlin(1, 430, 0, 1);
		gateEnv = EnvGen.ar(Env.asr(0, 1, 2, -4), gate:gate, doneAction:2);
		attackEnv = EnvGen.ar(
			Env.new(
				[0.0,1,0.1,0],
				[0.0001, modX.linexp(0, 1, 0.0001, 0.075), modZ.linexp(0, 1, 0.01, 0.125)],
				-4),
			gate:imp,
			doneAction:0);
		env = EnvGen.ar(Env.asr(0.001,0.125,1,-4),gate:imp,doneAction:0);
		osc = WhiteNoise.ar(1);
		//osc = RLPF.ar( osc, attackEnv.range( TExpRand.kr(500,10000,t_trig), TExpRand.kr(100,10000,t_trig) ), TRand.kr(0.01,1) );
		osc = BMoog.ar(
			attackEnv+osc,
			TWChoose.kr(
				imp,
				[
					modY.linexp(0, 1, 5000, 20000),
					modY.linexp(0, 1, 5000, 5200)
				],
				[
					0.2,
					0.8
				].normalizeSum),
			modX.linlin(0, 1, 0.7, 0.99),
			2.9
			);
		signal = Pan2.ar( osc, -0.5 );
		Out.ar( out, signal * amp * attackEnv * gateEnv / 4);
	    Out.ar(80 +( island * 2), signal * 4);
	}).writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs").store;
);

// ~hihat = Synth("ShogHiHat", [\x, rrand(1, 430), \y, rrand(-200, 200), \z, rrand(1, 430)]);
// ~hihat.set(\t_trig, 1, \x, rrand(1, 430), \y, rrand(-200, 200), \z, rrand(1, 430));
// ~hihat.set(\gate, 0);

( // Create the buffer for testing only
// ~wasteland = Buffer.new(s, 5184, 1, 1);
// ~wasteland.alloc();
// ~wasteland.sendCollection(Array.fill(5184, { rrand(-1, 1) }), 0, 0);
// ~wasteland.plot;
);

(
SynthDef.new("BlastedWasteland",{
	|amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0|
	var env, signal, modY, gateEnv, phase, wave, in;
	gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
	env = EnvGen.ar(Env.new([0, 1, 0],[0.1, 0.5], 0), gate:t_trig, doneAction:0);
	modY = y.linlin(-200, 200, 0, 0.999);

	in = InFeedback.ar(80 + ( island * 2), 2);

	phase = [
		Saw.ar(x.linexp(1, 430, 0.1, SampleRate.ir), 0.5, 0.5) * 72,
		Saw.ar(z.linexp(1, 430, 0.1, SampleRate.ir), 0.5, 0.5) * 72
	];

	wave = WaveTerrain.ar(
				bufnum,
				phase[0],
				phase[1],
				72,
				72
	);

	// signal = LeakDC.ar(signal);
	// wave = BufCombC.ar(LocalBuf(SampleRate.ir, 2), wave, modY.linexp(0, 1, 1, 10).reciprocal, [x / 430, z / 430]);
	wave = signal = Integrator.ar(wave + (in / 2), [x, z] / 430);
	signal = Pulse.ar(Latch.kr(phase, CoinGate.kr(0.1, t_trig)).linexp(0, 72, 1, 4) * 20 + 20, env) thresh: wave.dup * amp * gateEnv;
	signal = BLowShelf.ar(LeakDC.ar(signal), 40, 0.3, 3);
	signal = Integrator.ar(signal, modY);
	signal = SanityCheck2.ar(signal);
	// signal = Pan2.ar(signal, island.linlin(0, 3, -1 , 1)) * amp * gateEnv;
	Out.ar(50, signal.sum.dup);
	Out.ar(80 +( island * 2), signal * 4);
}).writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs").store.add;
);

// ~blasted = Synth("BlastedWasteland", [\bufnum, // ~wasteland.bufnum]);
// ~blasted.set(\t_trig, 1, \x, rrand(1, 430), \y, rrand(-200, 200), \z, rrand(1, 430));
// ~blasted.set(\gate, 0);

(
SynthDef.new("SkyrimBelongsToTheNords",{
	|amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0|
	var env, signal, modY, gateEnv, phase, feedIn;
	gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
	env = EnvGen.ar(Env.new([0, 1, 0],[0.0001, 0.3], -4), gate:t_trig, doneAction:0);
	modY = y.linlin(-200, 200, 0, 0.999);
	feedIn = LocalIn.ar(2).linlin(-1, 1, [x / 430 * 72, z / 43 * 72], modY * 72);

	/*
	phase = [
		Saw.ar(x.linexp(1, 430, 0.1, SampleRate.ir), 0.5, 0.5) * 72,
		Saw.ar(z.linexp(1, 430, 0.1, SampleRate.ir), 0.5, 0.5) * 72
	];

	feedIn = feedIn + phase;*/

	signal = WaveTerrain.ar(
				bufnum,
				feedIn[0],
				feedIn[1],
				72,
				72
	);

	// signal = BufCombC.ar(LocalBuf(SampleRate.ir, 2), signal, modY.linexp(0, 1, 1, 80).reciprocal, 0.1 * env);
	signal = signal * amp * gateEnv;

	signal = Select.ar(
		Rand(0, 2),
		[
			[
				signal,
				BufCombC.ar(LocalBuf(SampleRate.ir, 2), signal, modY.linexp(0, 1, 1, 20).reciprocal, 0.1 * env)
			],

			[
				signal,
				signal
			]/*,

			[
				BufCombC.ar(LocalBuf(SampleRate.ir, 2), signal, x.linexp(1, 430, 1, 80).reciprocal, 0.1 * env),
				BufCombC.ar(LocalBuf(SampleRate.ir, 2), signal, z.linexp(1, 430, 1, 80).reciprocal, 0.1 * env)
			],

			[
				LPF.ar(signal, modY.linexp(0, 1, 20, 20000)),
				LPF.ar(signal, modY.linexp(0, 1, 20, 20000))
			],*/
		]
	);

	signal = SanityCheck2.ar(signal);
	Out.ar(50, signal);
	Out.ar(80 + ( island * 2), signal * 4);

	signal = Select.ar(
		Rand(0, 1),
		[
			[
				signal,
				signal.reciprocal
			]
		]
	);

	LocalOut.ar(signal);
}).writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs").store.add;
);

// ~skyrim = Synth("SkyrimBelongsToTheNords", [\bufnum, // ~wasteland.bufnum]);
// ~skyrim.set(\t_trig, 1, \x, rrand(1, 430), \y, rrand(-200, 200), \z, rrand(1, 430));
// ~skyrim.set(\gate, 0);


(
SynthDef.new("MyComputerAteItselfAgain",{
	|amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0|
	var env, signal, modY, gateEnv, phase, feedIn, feedAmp;
	gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
	env = EnvGen.ar(Env.new([0, 1, 0],[0.0001, 1], -4), gate:t_trig, doneAction:0);
	modY = y.linlin(-200, 200, 0, 0.999);
	feedIn = LocalIn.ar(2);
	feedAmp = 0.49;
	signal = WaveTerrain.ar(
		bufnum,
		feedIn[0].linlin(-1, 1, 0, [x, modY] / 430 * 72),
		feedIn[1].linlin(-1, 1, 0, [modY, z] / 430 * 72),
		72,
		72
	);

	// signal = SinOsc.ar(20, signal * 8pi * modY);
	signal = signal * gateEnv;
	signal = SanityCheck2.ar(signal);
	Out.ar(50, signal * amp);
	Out.ar(80 +( island * 2), signal * 4);
	LocalOut.ar(
		BufDelayC.ar(
			LocalBuf(SampleRate.ir, 2),
			(signal * feedAmp).reverse.reciprocal,
			[x / 430, z / 430].linlin(0, 1, 1, 2000).reciprocal
		)
	);

}).writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs").store.add;
);

// ~lunchbox = Synth("LunchBoxMonster", [\bufnum, // ~wasteland.bufnum]);
// ~lunchbox.set(\t_trig, 1, \x, rrand(1, 430), \y, rrand(-200, 200), \z, rrand(1, 430));
// ~lunchbox.set(\gate, 0);

(
SynthDef.new("LunchBoxMonster",{
	|amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0|
	var env, signal, modY, gateEnv, phase, feedIn, feedAmp;
	gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
	env = EnvGen.ar(Env.new([0, 1, 0],[0.0001, 1], -4), gate:t_trig, doneAction:0);
	modY = y.linlin(-200, 200, 0, 0.999);
	feedIn = LocalIn.ar(2);
	feedAmp = 0.49;
	signal = WaveTerrain.ar(
				bufnum,
				feedIn[0].linlin(-1, 1, [x / 430 * 72, z / 43 * 72], modY * 72),
				feedIn[1].linlin(-1, 1, [x / 430 * 72, z / 43 * 72], modY * 72),
				72,
				72
	);

	signal = SinOsc.ar(signal, signal * 8pi);
	signal = signal * gateEnv;
	signal = SanityCheck2.ar(signal);
	Out.ar(50, signal * amp);
	Out.ar(80 +( island * 2), signal * 4);
	LocalOut.ar(
		BufDelayC.ar(
			LocalBuf(SampleRate.ir, 2),
			(signal * feedAmp).reverse.reciprocal,
			[x / 430, z / 430].linlin(0, 1, 1, 2000) / SampleRate.ir
		)
	);

}).writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs").store.add;
);

// ~lunchbox = Synth("LunchBoxMonster", [\bufnum, // ~wasteland.bufnum]);
// ~lunchbox.set(\t_trig, 1, \x, rrand(1, 430), \y, rrand(-200, 200), \z, rrand(1, 430));
// ~lunchbox.set(\gate, 0);

(
SynthDef.new("StalagmiteFight",{
	|amp=0.1, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0|
	var env, signal, modY, gateEnv, phase, feedIn;
	gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
	env = EnvGen.ar(Env.new([0, 1, 0],[0.0001, 1], -4), gate:t_trig, doneAction:0);
	modY = y.linlin(-200, 200, 0, 0.999);
	feedIn = LocalIn.ar(2);

	signal = WaveTerrain.ar(
				bufnum,
				feedIn[0].linlin(-1, 1, [x / 430 * 72, z / 43 * 72], modY * 72),
				feedIn[1].linlin(-1, 1, [x / 430 * 72, z / 43 * 72], modY * 72),
				72,
				72
	);

	signal = Decay.ar(Trig.ar(signal), modY.linlin(0, 1, 1, 2000) / SampleRate.ir, signal);
	signal = signal * amp * gateEnv;
	signal = SanityCheck2.ar(signal);
	Out.ar(50, Limiter.ar(LeakDC.ar(signal * 0.9), 1, 0.001));
	Out.ar(80 +( island * 2), signal * 4);

	LocalOut.ar(
		BufDelayC.ar(
			LocalBuf(SampleRate.ir, 2),
			signal.reverse,
			[x / 430, z / 430].linlin(0, 1, 1, 2000) / SampleRate.ir
		)
	);

}).writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs").store.add;
);

// ~lunchbox = Synth("StalagmiteFight", [\bufnum, // ~wasteland.bufnum]);
// ~lunchbox.set(\t_trig, 1, \x, rrand(1, 430), \y, rrand(-200, 200), \z, rrand(1, 430));
// ~lunchbox.set(\gate, 0);


(
SynthDef.new("AllMyFriendsAreAquatic",{
	|amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0|
	var env, signal, modY, gateEnv, phase, feedIn, step, offset, wave;
	gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
	modY = y.linlin(-200, 200, 0, 0.999);
	env = EnvGen.ar(Env.new([0, 1, 0],[0.0001, 0.1], -4), gate:t_trig, doneAction:0);
	feedIn = LeakDC.ar(LocalIn.ar(2));
	wave = WaveTerrain.ar(
				bufnum,
				feedIn[1].clip2(1).linlin(-1, 1, [x / 430 * 72, z / 43 * 72], modY * 72),
				feedIn[1].clip2(1).linlin(-1, 1, [x / 430 * 72, z / 43 * 72], modY * 72),
				72,
				72
	);

	// offset = (Pitch.kr(wave)[0] * 2).reciprocal;
	// signal = LeakDC.ar(wave + DelayC.ar(wave.neg, 0.2, offset));

	signal = LPF.ar(PinkNoise.ar(env / 2), (env + 0.01).linexp(0.01, 1.01, 20, 20000));
	signal = SanityCheck2.ar(signal);
	Out.ar(50, Limiter.ar(LeakDC.ar(signal + wave * 4) * amp * gateEnv, 1, 0.001));
	Out.ar(80 +( island * 2), signal * 4);

	LocalOut.ar(
		Ringz.ar(Latch.ar(t_trig, wave) + signal, Decay.ar(wave, 5 / SampleRate.ir).linexp(-1, 1, 20, 20000), 0.05 * modY)
	);

}).writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs").store.add;
);

// ~aquatic = Synth("AllMyFriendsAreAquatic", [\bufnum, // ~wasteland.bufnum]);
// ~aquatic.set(\t_trig, 1, \x, rrand(1, 430), \y, rrand(-200, 200), \z, rrand(1, 430));
// ~aquatic.set(\gate, 0);

(
SynthDef.new("PumpkinHeadIII",{
	|amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0|
	var env, signal, modY, gateEnv, phase, feedIn, step, offset, wave, in;
	gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
	modY = y.linlin(-200, 200, 0, 0.999);
	env = EnvGen.ar(Env.new([0, 1, 0],[0.0001, 0.2], -4), gate:t_trig, doneAction:0);

	in = InFeedback.ar(80 + ( island * 2), 2);
	wave = WaveTerrain.ar(
				bufnum,
		        (Saw.ar(20 * env + 20) thresh: in[0]).clip2(1).linlin(-1, 1, [x / 430 * 72, z / 430 * 72], modY * 72),
				(Saw.ar(20 * env + 20) * -1 thresh: in[1]).clip2(1).linlin(-1, 1, [x / 430 * 72, z / 430 * 72], modY * 72),
				72,
				72
	) * env;

	// offset = (Pitch.kr(wave)[0] * 2).reciprocal;
	// signal = LeakDC.ar(wave + DelayC.ar(wave.neg, 0.2, offset));

	signal = RLPF.ar(wave * env * 0.1, (Lag.ar(in, 0.25)).linexp(0.01, 1.01, 20, 1000), modY);
	signal = SanityCheck2.ar(signal);
	Out.ar(50, Limiter.ar(LeakDC.ar(signal + wave * 4) * amp * gateEnv, 1, 0.001));

	signal = Ringz.ar(
		signal + (in / 2),
		Decay.ar(Latch.ar(wave, CoinGate.kr(0.2, t_trig)), 5 / SampleRate.ir).linexp(-1, 1, 20, 160).round(40),
		0.05 * modY
	);

	Out.ar(80 + (island * 2), (signal / 8 thresh: wave).clip2(0.5));

}).writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs").store.add;
);

(
SynthDef.new("MyLittlePony",{
	|amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0|
	var env, signal, modY, gateEnv, phase, feedIn, step, offset, wave, in;
	gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
	modY = y.linlin(-200, 200, 0, 0.999);
	env = EnvGen.ar(Env.new([0, 1, 0],[0.0001, 0.2], -4), gate:t_trig, doneAction:0);

	in = InFeedback.ar(80 + ( island * 2), 2);
	wave = WaveTerrain.ar(
				bufnum,
		        (in[0] thresh: Pulse.ar(20)).wrap2(1).linlin(-1, 1, [x / 430 * 72, z / 430 * 72], modY * 72),
		        (in[1] thresh: Pulse.ar(20)).wrap2(1).linlin(-1, 1, [x / 430 * 72, z / 430 * 72], modY * 72),
				72,
				72
	) * env;

	// offset = (Pitch.kr(wave)[0] * 2).reciprocal;
	signal = LeakDC.ar(wave + DelayC.ar(wave.neg, 0.2, z / 430 * 0.2));
	signal = LPF.ar(signal + (in * 0.5) * env * 0.1, (env + 0.01).linexp(0.01, 1.01, 20, 20000));
	signal = SanityCheck2.ar(signal);
	Out.ar(50, Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001));

	signal = BufDelayC.ar(LocalBuf(SampleRate.ir / 4), Integrator.ar(signal, modY), x.linexp(0, 430, 4, 20000).reciprocal);
	Out.ar(80 + ( island * 2), LeakDC.ar(signal.softclip));

}).writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs").store.add;
);

(
SynthDef.new("SecretOfTheOoze",{
	|amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0|
	var env, signal, modY, gateEnv, phase, feedIn, step, offset, wave, in;
	gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
	modY = y.linlin(-200, 200, 0, 0.999);
	env = EnvGen.ar(Env.new([0, 1, 0],[0.0001, 0.125], -4), gate:t_trig, doneAction:0);

	in = InFeedback.ar(80 + (island * 2), 2);
	step = Stepper.ar(Decay.ar(t_trig + in, 0.01, ClipNoise.ar(env)), 0, 0, 72, 1);
	wave = WaveTerrain.ar(
				bufnum,
		        step[0],
		        step[1],
				72,
				72
	);

	signal = wave + (in * 0.5) * env * 0.25;
	signal = BufCombC.ar(LocalBuf(SampleRate.ir, 2), signal, (80 - (modY * 40).round(5)).reciprocal, in.abs.linexp(0, 1, 0.1, 1));
	signal = SanityCheck2.ar(signal);
	Out.ar(50, Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001));

	signal = OnePole.ar(signal * 4, [x, z] / 430 * 2 - 1);
	Out.ar(80 + (island * 2), LeakDC.ar(signal.clip2(1)));

}).writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs").store.add;
);

(
SynthDef.new("GutsBrainz",{
	|amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0|
	var env, signal, modY, gateEnv, phase, feedIn, in;
	gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
	env = EnvGen.ar(Env.new([0, 1, 0],[0.0001, 1], -4), gate:t_trig, doneAction:0);
	modY = y.linlin(-200, 200, 0, 0.999);
	feedIn = LocalIn.ar(2);
	in = InFeedback.ar(80 + (island * 2), 2);

	signal = WaveTerrain.ar(
				bufnum,
		        (feedIn[0] thresh: in[1]).linlin(-1, 1, [x / 430 * 72, z / 43 * 72], modY * 72),
		        (feedIn[1] thresh: in[0]).linlin(-1, 1, [x / 430 * 72, z / 43 * 72], modY * 72),
				72,
				72
	);

	signal = Decay.ar(Trig.ar(signal), modY.linlin(0, 1, 1, 200) / SampleRate.ir, signal);
	signal = signal * amp * gateEnv;
	signal = SanityCheck2.ar(signal);
	Out.ar(50, Limiter.ar(LeakDC.ar(signal * 0.9), 1, 0.001));
	Out.ar(80 + (island * 2), signal);

	LocalOut.ar(
		BufDelayC.ar(
			LocalBuf(SampleRate.ir, 2),
			signal.reverse / 13,
			[x / 430, z / 430].linlin(0, 1, 20, 160).round(20).reciprocal
		)
	);

}).writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs").store.add;
);

(
SynthDef.new("SludgeMyEyesAreSludge",{
	|amp=0.15, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0|
	var env, signal, modY, gateEnv, phase, feedIn, in;
	gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
	env = EnvGen.ar(Env.new([0, 1, 0],[0.0001, 1], -4), gate:t_trig, doneAction:0);
	modY = y.linlin(-200, 200, 0, 0.999);
	feedIn = LocalIn.ar(2);
	in = LPF.ar(InFeedback.ar(80 + (island * 2), 2), 1000);

	signal = WaveTerrain.ar(
				bufnum,
		        (feedIn[0] - in[1]).linlin(-1, 1, [x / 430 * 72, z / 43 * 72], modY * 72),
		        (feedIn[1] - in[0]).linlin(-1, 1, [x / 430 * 72, z / 43 * 72], modY * 72),
				72,
				72
	);

	signal = Decay.ar(Pulse.ar(20 * (modY * 4).round(1), env), 0.2 * env, signal);
	signal = LeakDC.ar(signal * amp * gateEnv).checkBadValues(Silent.ar);
	signal = SanityCheck2.ar(signal);
	Out.ar(50, Limiter.ar(signal * 0.9, 1, 0.001).softclip);
	Out.ar(80 + (island * 2), signal);

	LocalOut.ar(
		Decay2.ar(
			signal.reverse / 13,
			modY,
			[x / 430, z / 430].linlin(0, 1, 0, 0.1)
		)
	);

}).writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs").store.add;
);

(
SynthDef.new("SkullClamp",{
	|amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0|
	var env, signal, modY, gateEnv, phase, feedIn, in;
	gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
	env = EnvGen.ar(Env.new([0, 1, 0],[0.0001, 1], -4), gate:t_trig, doneAction:0);
	modY = y.linlin(-200, 200, 0, 0.999);
	feedIn = LocalIn.ar(2);
	in = InFeedback.ar(80 + (island * 2), 2);

	signal = WaveTerrain.ar(
		bufnum,
		(feedIn[0] + in[0] / 2).linlin(-1, 1, [x / 430 * 72, z / 43 * 72], modY * 72),
		(feedIn[1] + in[1] / 2).linlin(-1, 1, [x / 430 * 72, z / 43 * 72], modY * 72),
		72,
		72
	);

	signal = Decay.ar(PulseDivider.ar(signal + in / 2), modY * 10);
	signal = signal * amp * gateEnv;
	signal = SanityCheck2.ar(signal);
	Out.ar(50, Limiter.ar(LeakDC.ar(signal * 0.9), 1, 0.001));
	Out.ar(80 + (island * 2), signal);

	LocalOut.ar(
		OnePole.ar(
			signal.reverse,
			[x / 430, z / 430] * 2 - 1
		)
	);

}).writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs").store.add;
);

(
SynthDef.new("ElectricSheepDream",{
	|amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0|
	var env, signal, modY, gateEnv, phase, feedIn, in, modX, modZ, wave;
	gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
	env = EnvGen.ar(Env.new([0, 1, 0.25],[0.0001, 0.25, 0.75], -4), gate:t_trig, doneAction:0);
	modY = y.linlin(-200, 200, 0, 0.999);
	modX = x / 430;
	modZ = y / 430;
	in = InFeedback.ar(80 + (island * 2), 2);

	wave = WaveTerrain.ar(
		bufnum,
		Phasor.ar(0, 4, CoinGate.ar(0.1, Trig.ar(in)), 72),
		Phasor.ar(0, 1, CoinGate.ar(0.1, Trig.ar(in)), 72),
		72,
		72
	) + in * env;

	signal = FreqShift.ar(wave, SampleRate.ir / 4 * -1);
	signal = Pluck.ar(wave, signal, 0.2, modY.linexp(0, 1, 5, 80).round(5).reciprocal, [modX, modZ], Decay.ar(in, modY).wrap2(1));
	// signal = FreqShift.ar(signal, modY.linexp(0, 1, 1, 5).round(1));
	signal = signal * amp * gateEnv;
	signal = SanityCheck2.ar(signal);
	Out.ar(50, Limiter.ar(LeakDC.ar(signal * 0.9), 1, 0.001));
	Out.ar(80 + (island * 2), signal);

}).writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs").store.add;
);

(
SynthDef.new("H.P.Hatecraft",{
	|amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0|
	var env, signal, modY, gateEnv, phase, feedIn, in, modX, modZ, wave, chain;
	gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
	env = EnvGen.ar(Env.new([0, 1, 0.125, 0],[0.0001, 0.25, 0.25], -4), gate:t_trig, doneAction:0);
	modY = y.linlin(-200, 200, 0, 0.999);
	modX = x / 430;
	modZ = y / 430;
	in = InFeedback.ar(80 + (island * 2), 2);

	wave = WaveTerrain.ar(
		bufnum,
		(Phasor.ar(0, 4, 0, 72)).wrap2(72),
		(Phasor.ar(0, 1, 0, 72)).wrap2(72),
		72,
		72
	);

	wave = DFM1.ar(
		Pulse.ar(80 / (modY * 5).round(1), wave.abs.wrap2(1)),
		(wave.abs.linexp(0, 1, 40, 1000) * env).max(20),
		0.5
	) + in * env;

	signal = LeakDC.ar(wave * amp * gateEnv);
	signal = SanityCheck2.ar(signal);
	Out.ar(50, Limiter.ar(signal * 0.9, 1, 0.001));
	Out.ar(80 + (island * 2), BufDelayC.ar(LocalBuf(SampleRate.ir, 2), signal, modY));

}).writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs").store.add;
);

(
SynthDef.new("Trogdor",{
	|amp=0.1, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0|
	var env, signal, modY, gateEnv, phase, feedIn, in, modX, modZ, wave, chain;
	gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
	env = EnvGen.ar(Env.new([0, 1, 1, 0],[0.0001, 0.25, 0], -4), gate:t_trig, doneAction:0);
	modY = y.linlin(-200, 200, 0, 0.999);
	modX = x / 430;
	modZ = y / 430;
	in = InFeedback.ar(80 + (island * 2), 2);

	wave = WaveTerrain.ar(
		bufnum,
		(Phasor.ar(0, 4, 0, 72) + (in * 72)).wrap2(72),
		(Phasor.ar(0, 1, 0, 72) + (in * 72)).wrap2(72),
		72,
		72
	);

	wave = Osc.ar(bufnum, wave.abs.linexp(0, 1, 0.1, 1), [modX, modY] * env) + (in / 2);

	signal = LeakDC.ar(wave * amp * gateEnv);
	signal = SanityCheck2.ar(signal);
	Out.ar(50, Limiter.ar(signal * 0.9, 1, 0.001));
	Out.ar(80 + (island * 2), BufDelayC.ar(LocalBuf(SampleRate.ir, 2), signal, modY));

}).writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs").store.add;
);

(
SynthDef.new("IHateGlitchLich",{
	|amp=0.4, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0|
	var env, signal, modY, gateEnv, phase, feedIn, in, modX, modZ, wave, chain;
	gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
	env = EnvGen.ar(Env.new([0, 1, 1, 0],[0.0001, 0.25, 0], -4), gate:t_trig, doneAction:0);
	modY = y.linlin(-200, 200, 0, 0.999);
	modX = x / 430;
	modZ = y / 430;
	in = InFeedback.ar(80 + (island * 2), 2);

	wave = WaveTerrain.ar(
		bufnum,
		(Phasor.ar(0, 4, 0, 72) + (in * 72)).wrap2(72),
		(Phasor.ar(0, 1, 0, 72) + (in * 72)).wrap2(72),
		72,
		72
	);

	chain = Osc.ar(bufnum, wave.abs.linlin(0, 1, 0.00001, 0.1), [modX, modZ]) + in;

	chain = [
		FFT.new(LocalBuf(1024), chain[0]),
		FFT.new(LocalBuf(1024), chain[1])
	];

	chain = [
		PV_Freeze(chain[0], wave[0]),
		PV_Freeze(chain[1], wave[1])
	];

	wave = [IFFT(chain[0]), IFFT(chain[1])];

	signal = LeakDC.ar(wave * amp * gateEnv);
	signal = SanityCheck2.ar(signal);
	Out.ar(50, Limiter.ar(signal * 0.9, 1, 0.001));
	Out.ar(80 + (island * 2), BufDelayC.ar(LocalBuf(SampleRate.ir, 2), signal, 1 / modY.linexp(0, 1, 1, SampleRate.ir)));

}).writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs").store.add;
);

(
SynthDef.new("MantisRigorMortis",{
	|amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0|
	var env, signal, modY, gateEnv, phase, feedIn, in, modX, modZ, wave, chain, env2;
	gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
	env = EnvGen.ar(Env.new([0, 1, 1, 0],[0.0001, 0.25, 0], -4), gate:t_trig, doneAction:0);
	env2 = EnvGen.ar(Env.new([0, 1, 1, 0],[0.0001, 0.01, 0], -4), gate:t_trig, doneAction:0);
	modY = y.linlin(-200, 200, 0, 0.999);
	modX = x / 430;
	modZ = y / 430;
	in = InFeedback.ar(80 + (island * 2), 2);

	wave = WaveTerrain.ar(
		bufnum,
		(Phasor.ar(0, 4, 0, 72) + (in * 72)).wrap2(72),
		(Phasor.ar(0, 1, 0, 72) + (in * 72)).wrap2(72),
		72,
		72
	);

	chain = Osc.ar(bufnum, wave.abs.linexp(0, 1, SampleRate.ir, SampleRate.ir * 2), [modX, modZ]) * env2 + in;

	chain = [
		FFT.new(LocalBuf(1024), chain[0]),
		FFT.new(LocalBuf(1024), chain[1])
	];

	chain = [
		PV_MagSmooth(chain[0], wave[0].abs),
		PV_MagSmooth(chain[1], wave[1].abs)
	];

	wave = [IFFT(chain[0]), IFFT(chain[1])];

	signal = LeakDC.ar(wave * amp * gateEnv);
	signal = SanityCheck2.ar(signal);
	Out.ar(50, Limiter.ar(signal * 0.9, 1, 0.001));
	Out.ar(80 + (island * 2), BufDelayC.ar(LocalBuf(SampleRate.ir, 2), signal, 1 / modY.linexp(0, 1, 20, SampleRate.ir)));

}).writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs").store.add;
);


(
SynthDef.new("AllOurBaseAreBelongToYou",{
	|amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0|
	var env, signal, modY, gateEnv, phase, feedIn, in, modX, modZ, wave, chain, env2, chain2;
	gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
	env = EnvGen.ar(Env.new([0, 1, 1, 0],[0.0001, 0.25, 0], -4), gate:t_trig, doneAction:0);
	env2 = EnvGen.ar(Env.new([0, 1, 1, 0],[0.0001, 0.01, 0], -4), gate:t_trig, doneAction:0);
	modY = y.linlin(-200, 200, 0, 0.999);
	modX = x / 430;
	modZ = y / 430;
	in = InFeedback.ar(80 + (island * 2), 2);

	wave = WaveTerrain.ar(
		bufnum,
		(Phasor.ar(0, 4, 0, 72)).wrap2(72),
		(Phasor.ar(0, [modX, modY], 0, 72)).wrap2(72),
		72,
		72
	) * env;

	chain = Osc.ar(bufnum, wave.abs.linexp(0, 1, 0.1, 1.0).round(0.1), [modX, modZ]) * env;

	chain2 = [
		FFT.new(LocalBuf(1024), in[1]),
		FFT.new(LocalBuf(1024), in[0])
	];

	chain = [
		FFT.new(LocalBuf(1024), chain[0]),
		FFT.new(LocalBuf(1024), chain[1])
	];

	chain = [
		PV_SpectralMap(chain[0], chain2[0], wave[0].abs, CoinGate.kr(0.25, t_trig)),
		PV_SpectralMap(chain[1], chain2[1], wave[1].abs, CoinGate.kr(0.25, t_trig))
	];

	wave = [IFFT(chain[0]), IFFT(chain[1])] * env;
	wave = Shaper.ar(bufnum, wave);

	signal = LeakDC.ar(wave * amp * gateEnv);
	signal = SanityCheck2.ar(signal);
	Out.ar(50, Limiter.ar(signal * 0.9, 1, 0.001));
	Out.ar(80 + (island * 2), BufDelayC.ar(LocalBuf(SampleRate.ir, 2), signal, 1 / modY.linexp(0, 1, 20, SampleRate.ir)));

}).writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs").store.add;
);

(
SynthDef.new("WhyCantWeBeEnemies?",{
	|amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0|
	var env, signal, modY, gateEnv, phase, feedIn, in, modX, modZ, wave, chain, env2, chain2;
	gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
	env = EnvGen.ar(Env.new([0, 1, 1, 0],[0, 0.2, 0.2], -4), gate:t_trig, doneAction:0);
	modY = y.linlin(-200, 200, 0, 0.999);
	modX = x / 430;
	modZ = y / 430;
	in = InFeedback.ar(80 + (island * 2), 2);

	wave = WaveTerrain.ar(
		bufnum,
		(Phasor.ar(0, 4, 0, 72)).wrap2(72),
		(Phasor.ar(0, [modX, modZ], 0, 72)).wrap2(72),
		72,
		72
	) * env;

	chain = Osc.ar(bufnum, modY * 0.1, [modX, modZ]) * env;
	wave = Shaper.ar(bufnum, chain + wave + in * env).distort;
	BLowShelf.ar(wave, 80, 0.3, 3);

	signal = LeakDC.ar(wave * amp * gateEnv);
	signal = SanityCheck2.ar(signal);
	Out.ar(50, Limiter.ar(signal * 0.9, 1, 0.001));
	Out.ar(80 + (island * 2), Ringz.ar(signal, 40, 0.25));

}).writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs").store.add;
);

(
SynthDef.new("YouDontHaveAnyRealFriends",{
	|amp=0.1, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0|
	var env, signal, modY, gateEnv, phase, feedIn, in, modX, modZ, wave, chain, env2, chain2;
	gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
	env = EnvGen.ar(Env.new([0, 1, 0],[0.1, 0.5, 0], -4), gate:t_trig, doneAction:0);
	modY = y.linlin(-200, 200, 0, 0.999);
	modX = x / 430;
	modZ = y / 430;
	in = InFeedback.ar(80 + (island * 2), 2);

	wave = WaveTerrain.ar(
		bufnum,
		(Phasor.ar(0, 4, 0, 72)).wrap2(72),
		(Phasor.ar(0, [modX, modZ], 0, 72)).wrap2(72),
		72,
		72
	) * env;

	chain = Pulse.ar(80 - (modY * 40).round(5), [modX, modZ]) * env;
	wave = Shaper.ar(bufnum, wave * in * 0.0001) * 8;
	BLowShelf.ar(wave, 80, 0.3, 3);

	signal = LeakDC.ar(wave * amp * gateEnv * env);
	signal = SanityCheck2.ar(signal);
	Out.ar(50, Limiter.ar(signal * 0.9, 1, 0.001));
	Out.ar(80 + (island * 2), Integrator.ar(signal, modY));

}).writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs").store.add;
);

(
SynthDef.new("SlimeTimeSlimeTimeSlimeTimeSlimeTimeSlimeTimeSlimeTimeSlimeTimeSlimeTime",{
	|amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0|
	var env, signal, modY, gateEnv, phase, feedIn, in, modX, modZ, wave, chain, env2, chain2;
	gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
	env = EnvGen.ar(Env.new([0, 1, 0],[0.1, 0.5, 0], -4), gate:t_trig, doneAction:0);
	modY = y.linlin(-200, 200, 0, 0.999);
	modX = x / 430;
	modZ = y / 430;
	in = InFeedback.ar(80 + (island * 2), 2);

	wave = WaveTerrain.ar(
		bufnum,
		(Phasor.ar(0, 4, 0, 72)).wrap2(72),
		(Phasor.ar(0, [modX, modZ], 0, 72)).wrap2(72),
		72,
		72
	) * env;

	chain = SinOsc.ar(80 - (modY * 40).round(5), wave + [modX, modZ]) * env;
	wave = Shaper.ar(bufnum, chain * in * 0.0001) * 8;
	wave = BLowShelf.ar(wave, 80, 0.3, 3);

	signal = LeakDC.ar(wave * amp * gateEnv * env);
	signal = SanityCheck2.ar(signal);
	Out.ar(50, Limiter.ar(signal * 0.9, 1, 0.001));
	Out.ar(80 + (island * 2), Integrator.ar(signal, modY));

}).writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs").store.add;
);

(
SynthDef.new("BloodMeridian",{
	|amp=0.1, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0|
	var env, signal, modY, gateEnv, phase, feedIn, in;
	gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
	env = EnvGen.ar(Env.new([0, 1, 0],[0.0001, 1], -4), gate:t_trig, doneAction:0);
	modY = y.linlin(-200, 200, 0, 0.999);
	feedIn = LocalIn.ar(2);
	in = InFeedback.ar(80 + (island * 2), 2);

	signal = WaveTerrain.ar(
				bufnum,
		        (feedIn[0] thresh: in[1]).linlin(-1, 1, [x / 430 * 72, z / 43 * 72], modY * 72),
		        (feedIn[1] thresh: in[0]).linlin(-1, 1, [x / 430 * 72, z / 43 * 72], modY * 72),
				72,
				72
	);

	signal = Decay2.ar(Latch.ar(signal + in, Trig.ar(signal)), modY, modY.linlin(0, 1, 1, 200) / SampleRate.ir, signal);
	signal = signal * amp * gateEnv;
	signal = SanityCheck2.ar(signal);
	Out.ar(50, Limiter.ar(LeakDC.ar(signal * 0.9), 1, 0.001));
	Out.ar(80 + (island * 2),
		BufDelayC.ar(
			LocalBuf(SampleRate.ir, 2),
			signal / 13,
			[x / 430, z / 430].linlin(0, 1, 20, 160).round(20).reciprocal
		)
	);

	LocalOut.ar(
		BufDelayC.ar(
			LocalBuf(SampleRate.ir, 2),
			signal.reverse / 13,
			[x / 430, z / 430].linlin(0, 1, 20, 160).round(20).reciprocal
		)
	);

}).writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs").store.add;
);

(
SynthDef.new("EraserHead",{
	|amp=0.1, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0|
	var env, signal, modY, gateEnv, phase, feedIn, in;
	gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
	env = EnvGen.ar(Env.new([0, 1, 0],[0.0001, 1], -4), gate:t_trig, doneAction:0);
	modY = y.linlin(-200, 200, 0, 0.999);
	feedIn = LocalIn.ar(2);
	in = InFeedback.ar(80 + (island * 2), 2);

	signal = WaveTerrain.ar(
				bufnum,
		        (feedIn[0] thresh: in[1]).linlin(-1, 1, [x / 430 * 72, z / 43 * 72], modY * 72),
		        (feedIn[1] thresh: in[0]).linlin(-1, 1, [x / 430 * 72, z / 43 * 72], modY * 72),
				72,
				72
	);

	signal = Shaper.ar(bufnum, signal);

	signal = Decay2.ar(
		Latch.ar(signal + in, Trig.ar(PulseDivider.ar(signal, [x / 430, z / 430] * 10))),
		modY,
		modY.linlin(0, 1, 1, 2000) / SampleRate.ir, signal
	) thresh: in;

	signal = signal * amp * gateEnv;
	signal = SanityCheck2.ar(signal);
	Out.ar(50, Limiter.ar(LeakDC.ar(signal * 0.9), 1, 0.001));
	Out.ar(80 + (island * 2),
		BufDelayC.ar(
			LocalBuf(SampleRate.ir, 2),
			signal / 13,
			[x / 430, z / 430].linlin(0, 1, 20, 160).round(20).reciprocal
		)
	);

	LocalOut.ar(
		BufDelayC.ar(
			LocalBuf(SampleRate.ir, 2),
			signal.reverse / 13,
			[x / 430, z / 430].linlin(0, 1, 20, 160).round(20).reciprocal
		)
	);

}).writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs").store.add;
);

(
SynthDef.new("WeHateYouAll",{
	|amp=0.1, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0|
	var env, signal, modY, gateEnv, phase, feedIn, in, wave;
	gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
	env = EnvGen.ar(Env.new([0, 1, 0],[0.0001, 0.5], -4), gate:t_trig, doneAction:0);
	modY = y.linlin(-200, 200, 0, 0.999);
	feedIn = LocalIn.ar(2);
	in = InFeedback.ar(80 + (island * 2), 2);

	wave = WaveTerrain.ar(
				bufnum,
		        (feedIn[0] thresh: in[1]).linlin(-1, 1, [x / 430 * 72, z / 43 * 72], modY * 72),
		        (feedIn[1] thresh: in[0]).linlin(-1, 1, [x / 430 * 72, z / 43 * 72], modY * 72),
				72,
				72
	);

	signal = Shaper.ar(bufnum, wave);
	signal = Decay2.ar(
		Latch.ar(signal + in, PulseDivider.ar(signal, [x / 430, z / 430] * 100)),
		modY * 20,
		modY.linlin(0, 1, 1, 2000), signal
	).trunc(0.5 ** (modY * 8));

	signal = RLPF.ar(
		signal,
		[Pitch.kr(in[0], 40, 40, SampleRate.ir)[0], Pitch.kr(in[1], 40, 40, SampleRate.ir)[0]] * env,
		0.1
	);

	signal = signal * amp * gateEnv;
	signal = SanityCheck2.ar(signal);
	Out.ar(50, Limiter.ar(LeakDC.ar(signal * 0.9), 1, 0.001));
	Out.ar(80 + (island * 2),
		BufDelayC.ar(
			LocalBuf(SampleRate.ir, 2),
			HPZ2.ar(signal / 13),
			[x / 430, z / 430].linlin(0, 1, 20, 160).round(20).reciprocal
		)
	);

	LocalOut.ar(
		BufDelayC.ar(
			LocalBuf(SampleRate.ir, 2),
			Integrator.ar(signal.reverse / 13, modY),
			[x / 430, z / 430].linlin(0, 1, 20, 160).round(20).reciprocal
		)
	);

}).writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs").store.add;
);

(
SynthDef.new("StealThisSynth",{
	|amp=0.1, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0|
	var env, signal, modY, gateEnv, phase, feedIn, step, offset, wave, in;
	gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
	modY = y.linlin(-200, 200, 0, 0.999);
	env = EnvGen.ar(Env.new([0, 1, 0],[0.1, 1], -4), gate:t_trig, doneAction:0);
	feedIn = LeakDC.ar(LocalIn.ar(2));
	in = InFeedback.ar(80 + (island * 2), 2);

	wave = WaveTerrain.ar(
				bufnum,
				in[0].clip2(1).linlin(-1, 1, [x / 430 * 72, z / 43 * 72], modY * 72),
				in[1].clip2(1).linlin(-1, 1, [x / 430 * 72, z / 43 * 72], modY * 72),
				72,
				72
	);

	// offset = (Pitch.kr(wave)[0] * 2).reciprocal;
	// signal = LeakDC.ar(wave + DelayC.ar(wave.neg, 0.2, offset));

	signal = GrayNoise.ar(0.5) + wave * env;

	signal = [
		FFT.new(LocalBuf(1024), signal[0]),
		FFT.new(LocalBuf(1024), signal[1])
	];

	signal = [
		PV_BrickWall(signal[0], wave[0]),
		PV_BrickWall(signal[1], wave[1])
	];

	signal = [IFFT(signal[0]), IFFT(signal[1])];
	signal = SanityCheck2.ar(signal);
	Out.ar(50, Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001));
	Out.ar(80 + (island * 2),
		Ringz.ar(Latch.ar(t_trig, wave) + signal, Decay.ar(wave, 5 / SampleRate.ir).linexp(-1, 1, 20, 20000), 0.05 * modY)
	);

}).writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs").store.add;
);

(
SynthDef.new("Demipenteract", {
	|amp=0.75, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0|
	var signal, modY, gateEnv, phase, in, modX, modZ, wave, chain;
	var imp,imp2,freq,freq2,env,rd,rd2,delay,delay2,input,input2,numFrames,buffer5,buffer6;
	var buffer,buffer2,wr,wr2,duty,trig,trig2,buffer3,buffer4,env2,buffer7,buffer8,feed;
	var env3,duty2,drd,drd2,wr3,wr4,drd3,drd4,chain2,phasor,phasor2,fftNumFrames, feedIn;
	var form,form2, fund, scale, fftBuf1, fftBuf2, fftBuf3, fftBuf4, loopBuf1, loopBuf2;
	var loopBuf3, loopBuf4, fftDelayBuf1, fftDelayBuf2, fftFeedBuf1, fftFeedBuf2;
	var param1, param2, param3, param4, bufNum, bufNum2;

	modY = y.linlin(-200, 200, 0, 0.999);
	modX = x / 430;
	modZ = y / 430;

	gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
	env = EnvGen.ar(Env.new([0, 1, 0.1],[0.01, 0.1], -4), gate:t_trig, doneAction:0);


	in = InFeedback.ar(80 + (island * 2), 2);

	wave = WaveTerrain.ar(
		bufnum,
		(Phasor.ar(0, 0.25, 0, 72)).wrap2(72),
		(Phasor.ar(0, 1, 0, 72)).wrap2(72),
		72,
		72
	);



	//param1 = MouseX.kr;
	//param2 = MouseY.kr;
	param1 = modX;
	param2 = modY;
	param3 = modZ;
	param4 = Latch.ar(wave.abs, t_trig);

	fund = 51.midicps * 4;

	//Just Intonated Minor
	scale = [
		/*fund / 4,
		fund / 4 / 27/25,*/
		fund / 2,
		fund*27/25,
		fund*6/5,
		fund*4/3,
		fund,
		fund*2,
		fund*2*27/25,
		fund*2*6/5,
		fund*2*4/3,
		fund*2*27/20,
		fund*2*8/5,
		fund*2*9/5,
		fund*4,
		// fund*4*27/25,
		// fund*4*6/5,
		// fund*4*4/3,
		fund*4*27/20,
		fund*4*8/5,
		fund*4*9/5,
		fund * 8,
		fund*8*9/5,
	].cpsmidi-12;

	scale = (scale-12)++scale;
	scale = scale.midicps;

	buffer = bufNum;
	buffer2 = bufNum2;

	// feedIn = LocalIn.ar(2);
	imp = t_trig;

	trig = PulseDivider.kr(imp, 2);

	imp = imp + TDelay.ar(
		K2A.ar(imp * (param2 * 0.6).round(1)),
		1 / (param3.linexp(0, 1, 1, 10).round(1))
	);

	env2 = EnvGen.ar(Env.new([0, 1, 0], [0.00001, 0.5], -4), gate: imp);

	freq = Select.kr(
		Stepper.ar(
			CoinGate.ar(0.3, imp.dup) + Impulse.ar(0),
			0,
			TIRand.kr(0, 4, trig),
			scale.size - TIRand.kr(1, 4, trig),
			TIRand.kr(-1, 1, trig)
		),
		scale
	);

	form = DFM1.ar(
		Pulse.ar(freq / 8, [0.4, 0.6]),
		Lag.ar(Amplitude.ar(wave, 0.1, 0.1)).linexp(0, 1, 200, 4000), 0.2) + (in / 2);

	form = form + BufDelayC.ar(LocalBuf(SampleRate.ir * 2), form, modY * 2) / 3;

	/*
	fftBuf1 = LocalBuf(512);
	fftBuf2 = LocalBuf(512);
	fftDelayBuf1 = Array.fill(256, { arg i; 1 / (i % 512 + 1) }).as(LocalBuf);
	fftDelayBuf2 = Array.fill(256, { arg i; 1 / (i % 512 + 1) }).as(LocalBuf);
	fftFeedBuf1 = Array.fill(256, { arg i; 1.0.rand }).as(LocalBuf);
	fftFeedBuf2 = Array.fill(256, { arg i; 1.0.rand }).as(LocalBuf);
*/
	/*
	chain = [
		FFT.new(fftBuf1, form[0]),
		FFT.new(fftBuf2, form[1])
	];

	chain = [
		PV_BinDelay(chain[0], 1.0, fftDelayBuf1, fftFeedBuf1),
		PV_BinDelay(chain[1], 1.0, fftDelayBuf2, fftFeedBuf2)
	];

	chain = [
		IFFT(chain[0]),
		IFFT(chain[1])
	];*/

	input = LeakDC.ar(form);

	signal = Compander.ar(
		input,
		input,
		0.2,
		1,
		0.1,
		0.001,
		0.1
	);

	signal = Limiter.ar(LeakDC.ar(signal), 0.95, 0.0001);
	signal = input * amp * env;
	signal = SanityCheck2.ar(signal);
	Out.ar(50, Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001));
	Out.ar(80 + (island * 2),
		signal / 2
	);

}).writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs").store.add;
);

(
SynthDef.new("BenoitAndTheMandelBratwurst",{
	|amp=0.3, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0|
	var env, signal, modY, gateEnv, phase, feedIn, in, modX, modZ, wave, chain;
	gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
	env = EnvGen.ar(Env.new([0, 1, 0],[0.0001, TExpRand.kr(0.05, 1.0, t_trig)], -4), gate:t_trig, doneAction:0);
	modY = y.linlin(-200, 200, 0, 0.999);
	modX = x / 430;
	modZ = y / 430;
	in = InFeedback.ar(80 + (island * 2), 2);

	wave = WaveTerrain.ar(
		bufnum,
		(Phasor.ar(0, 4, 0, 72) + (in * 72)).wrap2(72),
		(Phasor.ar(0, 1, 0, 72) + (in * 72)).wrap2(72),
		72,
		72
	);

	chain = Osc.ar(bufnum, wave.abs.linlin(0, 1, 0.1, 0.0001), [modX, modZ]) / 3 + in * env;

	chain = [
		FFT.new(LocalBuf(1024), chain[0]),
		FFT.new(LocalBuf(1024), chain[1])
	];

	chain = [
		PV_Freeze(chain[0], Trig.ar(wave[0])),
		PV_Freeze(chain[1], Trig.ar(wave[1]))
	];

	wave = [IFFT(chain[0]), IFFT(chain[1])];

	signal = LeakDC.ar(wave * amp * gateEnv);
	signal = SanityCheck2.ar(signal);
	Out.ar(50, Limiter.ar(signal * 0.9, 1, 0.001));
	Out.ar(80 + (island * 2), OnePole.ar(signal, modY));

}).writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs").store.add;
);

(
SynthDef.new("PsySplice",{
	|amp=0.3, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0|
	var env, signal, modY, gateEnv, phase, feedIn, in, modX, modZ, wave, chain;
	gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
	env = EnvGen.ar(Env.new([0, 1, 0],[0.0001, 0.1], -4), gate:t_trig, doneAction:0);
	modY = y.linlin(-200, 200, 0, 0.999);
	modX = x / 430;
	modZ = y / 430;
	in = InFeedback.ar(80 + (island * 2), 2);

	wave = WaveTerrain.ar(
		bufnum,
		(Phasor.ar(0, [modX, modZ] * 72, 0, 72)).wrap2(72),
		(Phasor.ar(0, modY, 0, 72)).wrap2(72),
		72,
		72
	);

	wave = chain = Osc.ar(bufnum, wave.abs.linexp(0, 1, 0.1, 1.0), [modX, modZ]);
	chain = in * env;

	chain = [
		FFT.new(LocalBuf(1024), chain[0]),
		FFT.new(LocalBuf(1024), chain[1])
	];

	chain = [
		PV_MagGate(chain[0], wave[0]),
		PV_MagGate(chain[1], wave[1])
	];

	chain = [
		PV_Invert(chain[0]),
		PV_Invert(chain[1])
	];

	wave = [IFFT(chain[0]), IFFT(chain[1])];

	signal = LeakDC.ar(wave * amp * gateEnv * env);
	signal = SanityCheck2.ar(signal);
	Out.ar(50, Limiter.ar(signal * 0.9, 1, 0.001));
	Out.ar(80 + (island * 2), BufDelayC.ar(LocalBuf(SampleRate.ir), signal, modY.linexp(0, 1, 1, 80).reciprocal));

}).writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs").store.add;
);

(
SynthDef.new("TheDayTheEarthStoodStill",{
	|amp=0.3, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0|
	var env, signal, modY, gateEnv, phase, feedIn, in, modX, modZ, wave, chain;
	var scale, fund;
	gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
	env = EnvGen.ar(Env.new([0, 1, 0],[0.0001, 0.1], -4), gate:t_trig, doneAction:0);
	modY = y.linlin(-200, 200, 0, 0.999);
	modX = x / 430;
	modZ = y / 430;
	in = InFeedback.ar(80 + (island * 2), 2);

	wave = WaveTerrain.ar(
		bufnum,
		(Phasor.ar(0, [modX, modZ] * 72, 0, 72)).wrap2(72),
		(Phasor.ar(0, modY, 0, 72)).wrap2(72),
		72,
		72
	);

	wave = chain = Osc.ar(bufnum, wave.abs.linexp(0, 1, 0.1, 1.0), [modX, modZ]);
	wave = Decay.ar(wave, modY * 5).wrap2(1);

	chain = in * env;

	chain = [
		FFT.new(LocalBuf(1024), chain[0]),
		FFT.new(LocalBuf(1024), chain[1])
	];

	chain = [
		PV_BrickWall(chain[0], wave[0]),
		PV_BrickWall(chain[1], wave[1])
	];

	wave = [IFFT(chain[0]), IFFT(chain[1])] * env;

	fund = 51.midicps * 4;

	//Just Intonated Minor
	scale = [
		/*fund / 4,
		fund / 4 / 27/25,*/
		fund / 2,
		fund*27/25,
		fund*6/5,
		fund*4/3,
		fund,
		fund*2,
		fund*2*27/25,
		fund*2*6/5,
		fund*2*4/3,
		fund*2*27/20,
		fund*2*8/5,
		fund*2*9/5,
		fund*4,
		// fund*4*27/25,
		// fund*4*6/5,
		// fund*4*4/3,
		fund*4*27/20,
		fund*4*8/5,
		fund*4*9/5,
		fund * 8,
		fund*8*9/5,
	].cpsmidi-12;

	scale = (scale-12)++scale;
	scale = scale.midicps;

	wave = Ringz.ar(wave, Select.kr(modY * scale.size, scale), TExpRand.kr(0.01, 0.5, t_trig));

	signal = LeakDC.ar(wave * amp * gateEnv * env);
	signal = SanityCheck2.ar(signal);
	Out.ar(50, Limiter.ar(signal * 0.9, 1, 0.001));
		Out.ar(80 + (island * 2), Integrator.ar(signal * 0.95, [modX, modY]).softclip);

}).writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs").store.add;
);

)