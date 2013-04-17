

// Shoggoth Synths
// Arguments and ranges:
// x: 1 to 430
// y: -200 to 200
// z: 1 to 430
// island: 0 to 4

(

(
SynthDef.new("ShoggothMasterOut", {
	|amp=1.0, preAmp=4.0, in=50, out=0|
	var inputSignal, limit;
	inputSignal = In.ar(in, 2);
	inputSignal = BLowShelf.ar(inputSignal, 80, 0.3, 6);
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

(
SynthDef.new("ElkCloner",{
	|amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0|
	var env, signal, modY, gateEnv, phase, feedIn, step, offset, wave, in;
	gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
	modY = y.linlin(-200, 200, 0, 0.999);
	env = EnvGen.ar(Env.new([0, 1, 0],[0.0001, 0.05], -4), gate:t_trig, doneAction:0);

	// in = InFeedback.ar(80 + (island * 2), 2);
	wave = WaveTerrain.ar(
		bufnum,
		env.linlin(0, 1, [x / 430 * 72, z / 430 * 72], modY * 72),
		env.linlin(0, 1, [z / 430 * 72, x / 430 * 72], modY * 72),
		72,
		72
	) * env;
	signal = HPF.ar(wave * env, (env + 0.01).linexp(0.01, 1.01, 20, 20000));
	signal = SanityCheck2.ar(signal);
	Out.ar(50, Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001));

	signal = BufDelayC.ar(LocalBuf(SampleRate.ir / 4), Integrator.ar(signal, modY), x.linexp(0, 430, 4, 20000).reciprocal);
	Out.ar(80 + ( island * 2), LeakDC.ar(signal.softclip));

}).writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs").store.add;
);

(
SynthDef.new("ElkCloner",{
	|amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0|
	var env, signal, modY, gateEnv, phase, feedIn, step, offset, wave, in;
	gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
	modY = y.linlin(-200, 200, 0, 0.999);
	env = EnvGen.ar(Env.new([0, 1, 0],[0.0001, 0.05], -4), gate:t_trig, doneAction:0);

	// in = InFeedback.ar(80 + (island * 2), 2);
	wave = WaveTerrain.ar(
		bufnum,
		env.linlin(0, 1, [x / 430 * 72, z / 430 * 72], modY * 72),
		env.linlin(0, 1, [z / 430 * 72, x / 430 * 72], modY * 72),
		72,
		72
	) * env;

	// offset = (Pitch.kr(wave)[0] * 2).reciprocal;
	// signal = LeakDC.ar(wave + DelayC.ar(wave.neg, 0.2, z / 430 * 0.2));
	signal = HPF.ar(wave * env, (env + 0.01).linexp(0.01, 1.01, 20, 20000));
	signal = SanityCheck2.ar(signal);
	Out.ar(50, Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001));

	signal = BufDelayC.ar(LocalBuf(SampleRate.ir / 4), Integrator.ar(signal, modY), x.linexp(0, 430, 4, 20000).reciprocal);
	Out.ar(80 + ( island * 2), LeakDC.ar(signal.softclip));

}).writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs").store.add;
);

/////////////////////////////////////////////////////////
// Muha.4608
/////////////////////////////////////////////////////////

SynthDef.new("Muha.4608", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, varMuha46088;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = varMuha46088 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
			modX = K2A.ar(x / 430);
			modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
			modZ = K2A.ar(z / 430);
			env = EnvGen.ar(Env.new([0, 1, 0],[0.0001, 0.05], -4), gate:t_trig, doneAction:0);

			// in = InFeedback.ar(80 + (island * 2), 2);
			wave = WaveTerrain.ar(
			    bufnum,
			    env.linlin(0, 1, [modX * 72, modZ * 72], modY * 72),
			    env.linlin(0, 1, [modZ * 72, modX * 72], modY * 72),
			    72,
			    72
			) * env;
// Generated prototype body code
varMuha46088 = DelayL.ar(y, bufnum, island, modY, Silent.ar());
varMuha46088 = OSTrunc8.ar(env * signal, amp.ring2(Clip.ar(wave, gateEnv * varMuha46088, signal)));

signal = varMuha46088;
signal = SanityCheck2.ar(signal);
			Out.ar(50, Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001));
}).store;

/////////////////////////////////////////////////////////
// Dialer.Livegirls
/////////////////////////////////////////////////////////

SynthDef.new("Dialer.Livegirls", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, varDialerLivegirls8, varDialerLivegirls9, varDialerLivegirls10;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = varDialerLivegirls8 = varDialerLivegirls9 = varDialerLivegirls10 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
			modX = K2A.ar(x / 430);
			modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
			modZ = K2A.ar(z / 430);
			env = EnvGen.ar(Env.new([0, 1, 0],[0.0001, 0.05], -4), gate:t_trig, doneAction:0);

			// in = InFeedback.ar(80 + (island * 2), 2);
			wave = WaveTerrain.ar(
			    bufnum,
			    env.linlin(0, 1, [modX * 72, modZ * 72], modY * 72),
			    env.linlin(0, 1, [modZ * 72, modX * 72], modY * 72),
			    72,
			    72
			) * env;
// Generated prototype body code
varDialerLivegirls8 = BFEncode2.ar(modY, amp, modY, gateEnv, modY * varDialerLivegirls10, gateEnv);
varDialerLivegirls9 = LinXFade2.ar(varDialerLivegirls9 * modX, modY * varDialerLivegirls8, varDialerLivegirls10, 25.837220948356 * modZ * modZ);
varDialerLivegirls10 = LinCongC.ar(modZ, t_trig, x, varDialerLivegirls9, BAllPass.ar(signal, modZ * varDialerLivegirls10, env * varDialerLivegirls9, modZ, Silent.ar()), 0.91257899675156 * varDialerLivegirls8 * modY, Silent.ar());
varDialerLivegirls8 = TRand.ar(y, z, wave * env);
varDialerLivegirls9 = FoaDominateZ.ar(gateEnv * wave, env, signal, Silent.ar());
varDialerLivegirls10 = FoaProximity.ar(814.20471938145 * signal * varDialerLivegirls10, wave, 0.99998021344838 * modZ * env, Silent.ar());

signal = varDialerLivegirls10;
signal = SanityCheck2.ar(signal);
			Out.ar(50, Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001));
}).store;

/////////////////////////////////////////////////////////
// Marzia.2048.C
/////////////////////////////////////////////////////////

SynthDef.new("Marzia.2048.C", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, varMarzia2048C8;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = varMarzia2048C8 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
			modX = K2A.ar(x / 430);
			modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
			modZ = K2A.ar(z / 430);
			env = EnvGen.ar(Env.new([0, 1, 0],[0.0001, 0.05], -4), gate:t_trig, doneAction:0);

			// in = InFeedback.ar(80 + (island * 2), 2);
			wave = WaveTerrain.ar(
			    bufnum,
			    env.linlin(0, 1, [modX * 72, modZ * 72], modY * 72),
			    env.linlin(0, 1, [modZ * 72, modX * 72], modY * 72),
			    72,
			    72
			) * env;
// Generated prototype body code
varMarzia2048C8 = APF.ar(gate, varMarzia2048C8 * signal, modX * modY, FMGrainI.ar(gateEnv * varMarzia2048C8, env, Crackle.ar(wave * DC.ar(0.0040748119354248), wave * DC.ar(0.24953091144562), wave * DC.ar(0.73893332481384)).exprange(1, SampleRate.ir), varMarzia2048C8 * signal, gateEnv * varMarzia2048C8, bufnum, bufnum, x, DoubleWell2.ar(wave * DC.ar(0.18203675746918), wave * DC.ar(0.59441447257996), wave * DC.ar(0.21811354160309), wave * DC.ar(0.28706240653992), wave * DC.ar(0.75139713287354), wave * DC.ar(0.95625674724579), wave * DC.ar(0.011800169944763), wave * DC.ar(0.23941135406494), wave * DC.ar(0.041837453842163), wave * DC.ar(0.77965462207794)), ScopeOut.ar(wave * DC.ar(0.64348709583282), wave * DC.ar(0.53317153453827))), Silent.ar());
varMarzia2048C8 = AudioMSG.ar(gateEnv, modZ * wave.lagud(wave * modX, modZ.div(EnvDetect.ar(wave * DC.ar(0.49490988254547), wave * DC.ar(0.57147443294525), wave * DC.ar(0.94639527797699)))), modX, Silent.ar());

signal = varMarzia2048C8;
signal = SanityCheck2.ar(signal);
			Out.ar(50, Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001));
}).store;

/////////////////////////////////////////////////////////
// Mayhem
/////////////////////////////////////////////////////////

SynthDef.new("Mayhem", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, varMayhem8, varMayhem9, varMayhem10, varMayhem11;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = varMayhem8 = varMayhem9 = varMayhem10 = varMayhem11 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
			modX = K2A.ar(x / 430);
			modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
			modZ = K2A.ar(z / 430);
			env = EnvGen.ar(Env.new([0, 1, 0],[0.0001, 0.05], -4), gate:t_trig, doneAction:0);

			// in = InFeedback.ar(80 + (island * 2), 2);
			wave = WaveTerrain.ar(
			    bufnum,
			    env.linlin(0, 1, [modX * 72, modZ * 72], modY * 72),
			    env.linlin(0, 1, [modZ * 72, modX * 72], modY * 72),
			    72,
			    72
			) * env;
// Generated prototype body code
varMayhem8 = InRect.ar(env, island, Rect(0, 0, 0.63978576660156, 0.9258199930191));
varMayhem9 = BPZ2.ar(varMayhem9, SOS.ar(varMayhem9 * varMayhem9, modZ * varMayhem9, varMayhem11 * varMayhem10, gateEnv * env, gateEnv * wave, bufnum, LTI.ar(wave * DC.ar(0.24194228649139), wave * DC.ar(0.95368313789368), wave * DC.ar(0.72494053840637), wave * DC.ar(0.73539423942566), wave * DC.ar(0.24995493888855)), Silent.ar().round(StandardL.ar(wave * DC.ar(0.44233083724976), wave * DC.ar(0.60011005401611), wave * DC.ar(0.18233370780945), wave * DC.ar(0.45098102092743), wave * DC.ar(0.17058289051056), wave * DC.ar(0.52024507522583)))), Silent.ar());
varMayhem10 = LatoocarfianN.ar(gateEnv, wave, z, varMayhem11 * wave, varMayhem10 * signal, amp, modY * gateEnv, 0.3856787029628 * wave * modX, Silent.ar());
varMayhem11 = SinTone.ar(env * wave, bufnum, gateEnv, VDiskIn.ar(2, Array.fill(2.pow(10), { |i| rrand(-1, 1) }).as(LocalBuf), Select.ar(varMayhem10 * signal, [HPZ2.ar(wave * DC.ar(0.089601635932922), wave * DC.ar(0.19423377513885), wave * DC.ar(0.79860973358154)), LFDNoise3.ar(wave * DC.ar(0.7325005531311), wave * DC.ar(0.51325440406799), wave * DC.ar(0.5639181137085))]), gateEnv * varMayhem10, 27.286191149202 * wave * varMayhem9));
varMayhem8 = Duty.ar(107.99712486599 * modZ * signal, varMayhem11 * modY, env * modX, signal * varMayhem8);
varMayhem9 = VOsc.ar(Array.fill(2.pow(15), { |i| rrand(-1, 1) }).as(LocalBuf), signal, gate, LinCongL.ar(varMayhem8 * env, bufnum, varMayhem11 * varMayhem9, env, modX * modY, 0.98733129457719 * env * modY, Silent.ar()), Silent.ar());
varMayhem10 = Decimator.ar(t_trig, modY * modX, modY, Henon2DN.ar(signal, modZ * varMayhem11, env, varMayhem10 * modZ, gateEnv, gateEnv * varMayhem10, 0.99998694443798 * gateEnv * varMayhem11, Silent.ar()), Silent.ar());
varMayhem11 = BufDelayL.ar(Array.fill(2.pow(10), { |i| rrand(-1, 1) }).as(LocalBuf), 216.90468294972 * Rotate2.ar(varMayhem9 * modY, x, z), wave * gateEnv, 0.99978389418176 * gateEnv * signal, Silent.ar());

signal = varMayhem11;
signal = SanityCheck2.ar(signal);
			Out.ar(50, Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001));
}).store;

/////////////////////////////////////////////////////////
// Prot.B.720
/////////////////////////////////////////////////////////

SynthDef.new("Prot.B.720", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, varProtB7208;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = varProtB7208 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
			modX = K2A.ar(x / 430);
			modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
			modZ = K2A.ar(z / 430);
			env = EnvGen.ar(Env.new([0, 1, 0],[0.0001, 0.05], -4), gate:t_trig, doneAction:0);

			// in = InFeedback.ar(80 + (island * 2), 2);
			wave = WaveTerrain.ar(
			    bufnum,
			    env.linlin(0, 1, [modX * 72, modZ * 72], modY * 72),
			    env.linlin(0, 1, [modZ * 72, modX * 72], modY * 72),
			    72,
			    72
			) * env;
// Generated prototype body code
varProtB7208 = FreeVerb2.ar(t_trig, y, env * modZ, env * modZ, gateEnv * env, 0.99993745871765 * modZ * gateEnv, Silent.ar());
varProtB7208 = LatoocarfianN.ar(SOS.ar(gateEnv * gateEnv, t_trig, modY * gateEnv, gate, modX * env, modX * signal, 0.99965852883662 * wave * modX, Silent.ar()).exprange(1, SampleRate.ir), modZ * modY, modX * gateEnv, varProtB7208, env * wave, env, gateEnv * env, env, LinPan2.ar(wave, env * gateEnv, modZ));

signal = varProtB7208;
signal = SanityCheck2.ar(signal);
			Out.ar(50, Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001));
}).store;

/////////////////////////////////////////////////////////
// Rideon
/////////////////////////////////////////////////////////

SynthDef.new("Rideon", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, varRideon8;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = varRideon8 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
			modX = K2A.ar(x / 430);
			modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
			modZ = K2A.ar(z / 430);
			env = EnvGen.ar(Env.new([0, 1, 0],[0.0001, 0.05], -4), gate:t_trig, doneAction:0);

			// in = InFeedback.ar(80 + (island * 2), 2);
			wave = WaveTerrain.ar(
			    bufnum,
			    env.linlin(0, 1, [modX * 72, modZ * 72], modY * 72),
			    env.linlin(0, 1, [modZ * 72, modX * 72], modY * 72),
			    72,
			    72
			) * env;
// Generated prototype body code
varRideon8 = FMGrainI.ar(varRideon8 * signal, 253.38006102823 * signal, MonoGrainBF.ar(env * modY, t_trig, 77.365018075497 * varRideon8, island, gate, modZ * varRideon8, 314.55300488581 * signal * env, modZ * env, signal * modX, 0.99991469481942 * FoaZoomZ.ar(wave * DC.ar(0.42038178443909), wave * DC.ar(0.95616781711578), wave * DC.ar(0.31794142723083), wave * DC.ar(0.5752124786377)), CheckBadValues.ar(wave * DC.ar(0.11356401443481), wave * DC.ar(0.50741410255432), wave * DC.ar(0.93774843215942))).exprange(1, SampleRate.ir), varRideon8 * modX, 1726.1977985877 * varRideon8 * signal, bufnum, bufnum, y, 0.99976418754544 * modZ * modX, Silent.ar());
varRideon8 = LatoocarfianN.ar(modY * modZ, signal * varRideon8.round(FoaDominateX.ar(env * modX, x, TTendency.ar(wave * DC.ar(0.39479160308838), wave * DC.ar(0.27166271209717), wave * DC.ar(0.67992448806763), wave * DC.ar(0.0610671043396), wave * DC.ar(0.010618448257446), wave * DC.ar(0.16097509860992)), Silent.ar())), wave, wave, env * modY, gateEnv * modY, signal * modX, 0.99955268737334 * modX * gateEnv, FoaPressY.ar(gateEnv * varRideon8, wave * modZ, 0.99942272485509 * modY * gateEnv, Silent.ar()));

signal = varRideon8;
signal = SanityCheck2.ar(signal);
			Out.ar(50, Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001));
}).store;

/////////////////////////////////////////////////////////
// Trivial.ow.106
/////////////////////////////////////////////////////////

SynthDef.new("Trivial.ow.106", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, varTrivialow1068, varTrivialow1069;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = varTrivialow1068 = varTrivialow1069 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
			modX = K2A.ar(x / 430);
			modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
			modZ = K2A.ar(z / 430);
			env = EnvGen.ar(Env.new([0, 1, 0],[0.0001, 0.05], -4), gate:t_trig, doneAction:0);

			// in = InFeedback.ar(80 + (island * 2), 2);
			wave = WaveTerrain.ar(
			    bufnum,
			    env.linlin(0, 1, [modX * 72, modZ * 72], modY * 72),
			    env.linlin(0, 1, [modZ * 72, modX * 72], modY * 72),
			    72,
			    72
			) * env;
// Generated prototype body code
varTrivialow1068 = BufWr.ar([LinCongL.ar(LFNoise0.ar(wave * DC.ar(0.81017541885376), wave * DC.ar(0.85068881511688), wave * DC.ar(0.50738573074341)).exprange(1, SampleRate.ir), 2181.2217732136 * modX * varTrivialow1068, modZ, 124.70019717011 * varTrivialow1068 * signal, modY * modX, Amplitude.ar(wave * DC.ar(0.821444272995), wave * DC.ar(0.052536249160767), wave * DC.ar(0.31951987743378), wave * DC.ar(0.86133754253387), wave * DC.ar(0.091158032417297)), Silent.ar()), FoaNFC.ar(env, t_trig, wave, Silent.ar())], Array.fill(2.pow(14), { |i| rrand(-1, 1) }).as(LocalBuf), modY * env, modX);
varTrivialow1069 = BufCombL.ar(Array.fill(2.pow(14), { |i| rrand(-1, 1) }).as(LocalBuf), varTrivialow1068 * env, y, bufnum, env, Silent.ar());
varTrivialow1068 = WeaklyNonlinear.ar(signal, bufnum, env * modZ, varTrivialow1069, modX, signal * modZ, 275.39907718648 * varTrivialow1068 * env, modZ * modX, env * varTrivialow1069, amp, signal, Standard2DL.ar(SinGrain.ar(wave * DC.ar(0.94473302364349), wave * DC.ar(0.48179364204407), wave * DC.ar(0.32100248336792), wave * DC.ar(0.045841813087463), wave * DC.ar(0.39793705940247)).exprange(1, SampleRate.ir), modX, x, gateEnv * modZ, gateEnv * gateEnv, signal, Silent.ar()), Silent.ar());
varTrivialow1069 = GravityGrid.ar(modY * varTrivialow1069, signal * modX, island, 50.74047073139 * modZ * modX, Array.fill(2.pow(15), { |i| rrand(-1, 1) }).as(LocalBuf), 0.99473004916937 * env * wave, Silent.ar());

signal = varTrivialow1069;
signal = SanityCheck2.ar(signal);
			Out.ar(50, Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001));
}).store;

/////////////////////////////////////////////////////////
// Vienna.583
/////////////////////////////////////////////////////////

SynthDef.new("Vienna.583", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, varVienna5838, varVienna5839;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = varVienna5838 = varVienna5839 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
			modX = K2A.ar(x / 430);
			modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
			modZ = K2A.ar(z / 430);
			env = EnvGen.ar(Env.new([0, 1, 0],[0.0001, 0.05], -4), gate:t_trig, doneAction:0);

			// in = InFeedback.ar(80 + (island * 2), 2);
			wave = WaveTerrain.ar(
			    bufnum,
			    env.linlin(0, 1, [modX * 72, modZ * 72], modY * 72),
			    env.linlin(0, 1, [modZ * 72, modX * 72], modY * 72),
			    72,
			    72
			) * env;
// Generated prototype body code
varVienna5838 = InRange.ar(varVienna5839, y, gateEnv);
varVienna5839 = Formant.ar(gateEnv, modX, env * varVienna5839, 0.99924215827212 * modX * modX, Silent.ar());
varVienna5838 = OSWrap8.ar(signal * signal, amp, gateEnv * gateEnv);
varVienna5839 = Convolution3.ar(varVienna5838 * modZ, z, gateEnv * modY, modY * varVienna5839, 0.99173906531849 * varVienna5838 * varVienna5839, Silent.ar());

signal = varVienna5839;
signal = SanityCheck2.ar(signal);
			Out.ar(50, Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001));
}).store;

/////////////////////////////////////////////////////////
// DEADMAN.548
/////////////////////////////////////////////////////////

SynthDef.new("DEADMAN.548", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, varDEADMAN5488;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = varDEADMAN5488 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
			modX = K2A.ar(x / 430);
			modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
			modZ = K2A.ar(z / 430);
			env = EnvGen.ar(Env.new([0, 1, 0],[0.0001, 0.05], -4), gate:t_trig, doneAction:0);

			// in = InFeedback.ar(80 + (island * 2), 2);
			wave = WaveTerrain.ar(
			    bufnum,
			    env.linlin(0, 1, [modX * 72, modZ * 72], modY * 72),
			    env.linlin(0, 1, [modZ * 72, modX * 72], modY * 72),
			    72,
			    72
			) * env;
// Generated prototype body code
varDEADMAN5488 = Formant.ar(wave * modX, gateEnv * modX, varDEADMAN5488 * gateEnv, 0.07736498197552 * modX * modX, Silent.ar());
varDEADMAN5488 = BufGrainBF.ar(wave * gateEnv, env, bufnum, signal, wave * gateEnv, gateEnv * modX, island, varDEADMAN5488, modY * modZ, env * modY, 0.52992719148964 * modY * modX, Silent.ar());

signal = varDEADMAN5488;
signal = SanityCheck2.ar(signal);
			Out.ar(50, Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001));
}).store;

/////////////////////////////////////////////////////////
// HLLP.83081
/////////////////////////////////////////////////////////

SynthDef.new("HLLP.83081", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, varHLLP83088, varHLLP830819, varHLLP8308110;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = varHLLP83088 = varHLLP830819 = varHLLP8308110 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
			modX = K2A.ar(x / 430);
			modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
			modZ = K2A.ar(z / 430);
			env = EnvGen.ar(Env.new([0, 1, 0],[0.0001, 0.05], -4), gate:t_trig, doneAction:0);

			// in = InFeedback.ar(80 + (island * 2), 2);
			wave = WaveTerrain.ar(
			    bufnum,
			    env.linlin(0, 1, [modX * 72, modZ * 72], modY * 72),
			    env.linlin(0, 1, [modZ * 72, modX * 72], modY * 72),
			    72,
			    72
			) * env;
// Generated prototype body code
varHLLP83088 = FoaPsychoShelf.ar(modZ, varHLLP83088 * modZ, island, modX, 0.82609114385719 * modZ * modZ, Silent.ar());
varHLLP83088 = FoaDirectZ.ar(x, modY * modX, ZeroCrossing.ar(0.45728051662445 * modY * varHLLP8308110), Henon2DN.ar(gateEnv * modZ, BLowPass.ar(wave * DC.ar(0.52002286911011), wave * DC.ar(0.29264414310455), wave * DC.ar(0.32239496707916), wave * DC.ar(0.56788206100464), wave * DC.ar(0.0048892498016357)).exprange(1, SampleRate.ir), wave * varHLLP8308110, gate, wave * varHLLP830819, varHLLP8308110 * modY, 0.91592956110661 * gateEnv * modZ, OSFold8.ar(wave * DC.ar(0.1066586971283), wave * DC.ar(0.97044348716736), wave * DC.ar(0.22676432132721))));
// Variation test code
varHLLP830819 = Fold.ar(gateEnv * varHLLP83088, varHLLP830819 * gateEnv, modY);
varHLLP8308110 = LPF.ar(modY * signal, modZ, 0.99910927601823 * Gendy4.ar(varHLLP83088 * DC.ar(0.04048478603363), varHLLP83088 * DC.ar(0.28631186485291), varHLLP83088 * DC.ar(0.060926556587219), varHLLP83088 * DC.ar(0.6011518239975), varHLLP83088 * DC.ar(0.10169899463654), varHLLP83088 * DC.ar(0.38327980041504), varHLLP83088 * DC.ar(0.61779356002808), varHLLP83088 * DC.ar(0.88580250740051), varHLLP83088 * DC.ar(0.55032277107239), varHLLP83088 * DC.ar(0.2176616191864), varHLLP83088 * DC.ar(0.75999510288239), varHLLP83088 * DC.ar(0.73146855831146)), Silent.ar());
varHLLP830819 = AtsFreq.ar(Array.fill(2.pow(11), { |i| rrand(-1, 1) }).as(LocalBuf), varHLLP83088 * gateEnv.lag3(varHLLP83088 * DC.ar(0.78079807758331), varHLLP83088 * DC.ar(0.16732859611511)), 0.34392714500427 * modY * modY, varHLLP830819, Silent.ar());
varHLLP8308110 = Pluck.ar(gate, varHLLP83088 * env, SinGrainI.ar(varHLLP830819, gateEnv, modY * modY, bufnum, bufnum, x, 0.99824716766163 * modY * varHLLP830819, Silent.ar()), signal * wave, y, x, 0.97584818895818 * gateEnv * varHLLP8308110, Silent.ar());
varHLLP830819 = DemandEnvGen.ar(amp, signal * varHLLP8308110, signal * gateEnv, y, gate, env * varHLLP830819, varHLLP83088, varHLLP8308110 * wave, z, z);
varHLLP8308110 = InRect.ar(t_trig, 0.98728096485138 * wave * varHLLP83088, Rect.new(0, 0, 0.64293074607849, 0.031936645507812));

signal = varHLLP8308110;
signal = SanityCheck2.ar(signal);
			Out.ar(50, Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001));
}).store;

/////////////////////////////////////////////////////////
// Kysia.3072.a
/////////////////////////////////////////////////////////

SynthDef.new("Kysia.3072.a", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, varKysia3072a8;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = varKysia3072a8 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
			modX = K2A.ar(x / 430);
			modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
			modZ = K2A.ar(z / 430);
			env = EnvGen.ar(Env.new([0, 1, 0],[0.0001, 0.05], -4), gate:t_trig, doneAction:0);

			// in = InFeedback.ar(80 + (island * 2), 2);
			wave = WaveTerrain.ar(
			    bufnum,
			    env.linlin(0, 1, [modX * 72, modZ * 72], modY * 72),
			    env.linlin(0, 1, [modZ * 72, modX * 72], modY * 72),
			    72,
			    72
			) * env;
// Generated prototype body code
varKysia3072a8 = Slope.ar(env, 0.98842363526342 * wave, Silent.ar());
varKysia3072a8 = MantissaMask.ar(wave, gateEnv * gateEnv, 0.88402347894039 * modY * signal, Silent.ar());

signal = varKysia3072a8;
signal = SanityCheck2.ar(signal);
			Out.ar(50, Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001));
}).store;

/////////////////////////////////////////////////////////
// MegaDevil.665
/////////////////////////////////////////////////////////

SynthDef.new("MegaDevil.665", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, varMegaDevil6658;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = varMegaDevil6658 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
			modX = K2A.ar(x / 430);
			modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
			modZ = K2A.ar(z / 430);
			env = EnvGen.ar(Env.new([0, 1, 0],[0.0001, 0.05], -4), gate:t_trig, doneAction:0);

			// in = InFeedback.ar(80 + (island * 2), 2);
			wave = WaveTerrain.ar(
			    bufnum,
			    env.linlin(0, 1, [modX * 72, modZ * 72], modY * 72),
			    env.linlin(0, 1, [modZ * 72, modX * 72], modY * 72),
			    72,
			    72
			) * env;
// Generated prototype body code
varMegaDevil6658 = FoaDirectO.ar(modY, signal * modX, FoaNFC.ar(modY.ring1(HPF.ar(wave * DC.ar(0.04008162021637), wave * DC.ar(0.47724175453186), wave * DC.ar(0.28542184829712), wave * DC.ar(0.93627369403839))), env * gateEnv, modZ, Silent.ar()), Silent.ar());
varMegaDevil6658 = Median.ar(gateEnv, wave, env, Silent.ar());

signal = varMegaDevil6658;
signal = SanityCheck2.ar(signal);
			Out.ar(50, Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001));
}).store;

/////////////////////////////////////////////////////////
// W97M.Thus.BS
/////////////////////////////////////////////////////////

SynthDef.new("W97M.Thus.BS", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, varW97MThusBS8;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = varW97MThusBS8 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
			modX = K2A.ar(x / 430);
			modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
			modZ = K2A.ar(z / 430);
			env = EnvGen.ar(Env.new([0, 1, 0],[0.0001, 0.05], -4), gate:t_trig, doneAction:0);

			// in = InFeedback.ar(80 + (island * 2), 2);
			wave = WaveTerrain.ar(
			    bufnum,
			    env.linlin(0, 1, [modX * 72, modZ * 72], modY * 72),
			    env.linlin(0, 1, [modZ * 72, modX * 72], modY * 72),
			    72,
			    72
			) * env;
// Generated prototype body code
varW97MThusBS8 = TTendency.ar(wave * signal, signal, 0.9641444683075 * env * wave, modX, env.unipolar(0.99596785745523 * modZ * gateEnv), varW97MThusBS8 * gateEnv);
varW97MThusBS8 = LFClipNoise.ar(gateEnv * modZ, SinGrain.ar(varW97MThusBS8 * wave, y, env * modY, 0.99156761698389 * env * wave, Silent.ar()), Silent.ar());

signal = varW97MThusBS8;
signal = SanityCheck2.ar(signal);
			Out.ar(50, Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001));
}).store;

/////////////////////////////////////////////////////////
// OCX.FinalX
/////////////////////////////////////////////////////////

SynthDef.new("OCX.FinalX", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, varOCXFinalX8, varOCXFinalX9, varOCXFinalX10;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = varOCXFinalX8 = varOCXFinalX9 = varOCXFinalX10 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
			modX = K2A.ar(x / 430);
			modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
			modZ = K2A.ar(z / 430);
			env = EnvGen.ar(Env.new([0, 1, 0],[0.0001, 0.05], -4), gate:t_trig, doneAction:0);

			// in = InFeedback.ar(80 + (island * 2), 2);
			wave = WaveTerrain.ar(
			    bufnum,
			    env.linlin(0, 1, [modX * 72, modZ * 72], modY * 72),
			    env.linlin(0, 1, [modZ * 72, modX * 72], modY * 72),
			    72,
			    72
			) * env;
// Generated prototype body code
varOCXFinalX8 = AmpCompA.ar(varOCXFinalX10, signal * env, y, wave * varOCXFinalX9);
varOCXFinalX9 = FoaPushX.ar(varOCXFinalX10 * modY, modY * wave, 0.40379584288092 * modX * modZ, Silent.ar());
varOCXFinalX10 = Demand.ar(varOCXFinalX8 * modZ, gateEnv, gateEnv);
varOCXFinalX8 = DiskOut.ar(Array.fill(2.pow(16), { |i| rrand(-1, 1) }).as(LocalBuf), [FMHEncode2.ar(amp, modZ * env, modZ * gateEnv, amp, OSFold4.ar(RedPhasor.ar(wave * DC.ar(0.51845216751099), wave * DC.ar(0.30371236801147), wave * DC.ar(0.11925184726715), wave * DC.ar(0.93580293655396), wave * DC.ar(0.9227876663208), wave * DC.ar(0.23851191997528), wave * DC.ar(0.7012779712677)), x, wave * env.linexp(wave * DC.ar(0.42103910446167), wave * DC.ar(0.52195835113525), wave * DC.ar(0.0043148994445801), wave * DC.ar(0.49424684047699), wave * DC.ar(0.49100744724274))), varOCXFinalX9 * modY), RedPhasor2.ar(signal * signal, varOCXFinalX8 * modX, modZ, x.leftShift(LFClipNoise.ar(wave * DC.ar(0.72703289985657), wave * DC.ar(0.33575618267059), wave * DC.ar(0.87109994888306))), gateEnv, varOCXFinalX8 * varOCXFinalX9, signal * modX)]);
varOCXFinalX9 = Clipper4.ar(0.44191992282867 * modX * modZ, x, t_trig);
varOCXFinalX10 = GlitchHPF.ar(modZ * modZ, varOCXFinalX10 * modX, InRange.ar(modX, gateEnv * varOCXFinalX8, 0.4704338312149 * modX * modX), Gendy4.ar(signal * varOCXFinalX10, modZ, signal * modZ, XFadeRotate.ar(modY * env, wave * signal), wave * modY, varOCXFinalX9, signal, modX * varOCXFinalX10, varOCXFinalX9, 0.22467410564423 * FoaPressZ.ar(wave * DC.ar(0.8598964214325), wave * DC.ar(0.69316840171814), wave * DC.ar(0.47205579280853), wave * DC.ar(0.33974730968475)), 0.99871082667421 * SoftClipAmp8.ar(wave * DC.ar(0.020733118057251), wave * DC.ar(0.51388156414032), wave * DC.ar(0.56076812744141), wave * DC.ar(0.43646168708801)), Silent.ar()));

signal = varOCXFinalX10;
signal = SanityCheck2.ar(signal);
			Out.ar(50, Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001));
}).store;

)