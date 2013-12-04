

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
	env = EnvGen.ar(Env.new([0, 1, 0],[0.0001, 0.1], -4), gate:t_trig, doneAction:0);
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

	chain = Osc.ar(bufnum, wave.abs.linexp(0, 1, 0.1, 1.0).round(0.1) * env, [modX, modZ]) * env;
	/*
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

	wave = [IFFT(chain[0]), IFFT(chain[1])] * env;*/
	wave = Shaper.ar(bufnum, chain) * env;

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

	//chain = SinOsc.ar(80 - (modY * 40).round(5), wave + [modX, modZ]) * env;
	wave = Shaper.ar(bufnum, wave * in * 0.0001);
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

	wave = chain = Osc.ar(bufnum, wave.abs.linexp(0, 1, 0.1, 1.0), [modX, modZ]) * env;
	/*
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

	wave = [IFFT(chain[0]), IFFT(chain[1])];*/

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
			); env = gateEnv;
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
			); env = gateEnv;
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
			); env = gateEnv;
// Generated prototype body code
	varMarzia2048C8 = APF.ar(gate, varMarzia2048C8 * signal, modX * modY, FMGrainI.ar(env, env, Crackle.ar(wave * DC.ar(0.0040748119354248), wave * DC.ar(0.24953091144562), wave * DC.ar(0.73893332481384)).exprange(1, SampleRate.ir), varMarzia2048C8 * signal, gateEnv * varMarzia2048C8, bufnum, bufnum, x, DoubleWell2.ar(wave * DC.ar(0.18203675746918), wave * DC.ar(0.59441447257996), wave * DC.ar(0.21811354160309), wave * DC.ar(0.28706240653992), wave * DC.ar(0.75139713287354), wave * DC.ar(0.95625674724579), wave * DC.ar(0.011800169944763), wave * DC.ar(0.23941135406494), wave * DC.ar(0.041837453842163), wave * DC.ar(0.77965462207794)), ScopeOut.ar(wave * DC.ar(0.64348709583282), wave * DC.ar(0.53317153453827))), Silent.ar());
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
			); env = gateEnv;
// Generated prototype body code
varMayhem8 = InRect.ar(env, island, Rect(0, 0, 0.63978576660156, 0.9258199930191));
varMayhem9 = varMayhem8;

	/*
	varMayhem9 = BPZ2.ar(varMayhem9, SOS.ar(varMayhem9 * varMayhem9, modZ * varMayhem9, varMayhem11 * varMayhem10, gateEnv * env, gateEnv * wave, bufnum, LTI.ar(wave * DC.ar(0.24194228649139), wave * DC.ar(0.95368313789368), wave * DC.ar(0.72494053840637), wave * DC.ar(0.73539423942566), wave * DC.ar(0.24995493888855)), Silent.ar().round(StandardL.ar(wave * DC.ar(0.44233083724976), wave * DC.ar(0.60011005401611), wave * DC.ar(0.18233370780945), wave * DC.ar(0.45098102092743), wave * DC.ar(0.17058289051056), wave * DC.ar(0.52024507522583)))), Silent.ar());
*/
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
			); env = gateEnv;
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
			); env = gateEnv;

	varRideon8 = wave;

	/*
// Generated prototype body code
	varRideon8 = FMGrainI.ar(env, 253.38006102823 * signal, MonoGrainBF.ar(env * modY, env, 77.365018075497 * varRideon8, island, gate, modZ * varRideon8, 314.55300488581 * signal * env, modZ * env, signal * modX, 0.99991469481942 * FoaZoomZ.ar(wave * DC.ar(0.42038178443909), wave * DC.ar(0.95616781711578), wave * DC.ar(0.31794142723083), wave * DC.ar(0.5752124786377)), CheckBadValues.ar(wave * DC.ar(0.11356401443481), wave * DC.ar(0.50741410255432), wave * DC.ar(0.93774843215942))) * 17 + 1, varRideon8 * modX + 1, 17.1977985877 * varRideon8 * signal % 2, bufnum, bufnum, y, 0.99976418754544 * modZ * modX, Silent.ar());*/
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
			); env = gateEnv;
// Generated prototype body code
varTrivialow1068 = BufWr.ar([LinCongL.ar(LFNoise0.ar(wave * DC.ar(0.81017541885376), wave * DC.ar(0.85068881511688), wave * DC.ar(0.50738573074341)).exprange(1, SampleRate.ir), 2181.2217732136 * modX * varTrivialow1068, modZ, 124.70019717011 * varTrivialow1068 * signal, modY * modX, Amplitude.ar(wave * DC.ar(0.821444272995), wave * DC.ar(0.052536249160767), wave * DC.ar(0.31951987743378), wave * DC.ar(0.86133754253387), wave * DC.ar(0.091158032417297)), Silent.ar()), FoaNFC.ar(env, t_trig, wave, Silent.ar())], Array.fill(2.pow(14), { |i| rrand(-1, 1) }).as(LocalBuf), modY * env, modX);
varTrivialow1069 = BufCombL.ar(Array.fill(2.pow(14), { |i| rrand(-1, 1) }).as(LocalBuf), varTrivialow1068 * env, y, bufnum, env, Silent.ar());
varTrivialow1068 = WeaklyNonlinear.ar(signal, bufnum, env * modZ, varTrivialow1069, modX, signal * modZ, 275.39907718648 * varTrivialow1068 * env, modZ * modX, env * varTrivialow1069, amp, signal, Standard2DL.ar(SinGrain.ar(env, wave * DC.ar(0.48179364204407), wave * DC.ar(0.32100248336792), wave * DC.ar(0.045841813087463), wave * DC.ar(0.39793705940247)).exprange(1, SampleRate.ir), modX, x, gateEnv * modZ, gateEnv * gateEnv, signal, Silent.ar()), Silent.ar());
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
			); env = gateEnv;
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
			); env = gateEnv;
// Generated prototype body code
varDEADMAN5488 = Formant.ar(wave * modX, gateEnv * modX, varDEADMAN5488 * gateEnv, 0.07736498197552 * modX * modX, Silent.ar());
varDEADMAN5488 = BufGrainBF.ar(env, env, bufnum, signal, wave * gateEnv, gateEnv * modX, island, varDEADMAN5488, modY * modZ, env * modY, 0.52992719148964 * modY * modX, Silent.ar());

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
			); env = gateEnv;
// Generated prototype body code
varHLLP83088 = FoaPsychoShelf.ar(modZ, varHLLP83088 * modZ, island, modX, 0.82609114385719 * modZ * modZ, Silent.ar());
varHLLP83088 = FoaDirectZ.ar(x, modY * modX, ZeroCrossing.ar(0.45728051662445 * modY * varHLLP8308110), Henon2DN.ar(gateEnv * modZ, BLowPass.ar(wave * DC.ar(0.52002286911011), wave * DC.ar(0.29264414310455), wave * DC.ar(0.32239496707916), wave * DC.ar(0.56788206100464), wave * DC.ar(0.0048892498016357)).exprange(1, SampleRate.ir), wave * varHLLP8308110, gate, wave * varHLLP830819, varHLLP8308110 * modY, 0.91592956110661 * gateEnv * modZ, OSFold8.ar(wave * DC.ar(0.1066586971283), wave * DC.ar(0.97044348716736), wave * DC.ar(0.22676432132721))));
// Variation test code
varHLLP830819 = Fold.ar(gateEnv * varHLLP83088, varHLLP830819 * gateEnv, modY);
varHLLP8308110 = LPF.ar(modY * signal, modZ, 0.99910927601823 * Gendy4.ar(varHLLP83088 * DC.ar(0.04048478603363), varHLLP83088 * DC.ar(0.28631186485291), varHLLP83088 * DC.ar(0.060926556587219), varHLLP83088 * DC.ar(0.6011518239975), varHLLP83088 * DC.ar(0.10169899463654), varHLLP83088 * DC.ar(0.38327980041504), varHLLP83088 * DC.ar(0.61779356002808), varHLLP83088 * DC.ar(0.88580250740051), varHLLP83088 * DC.ar(0.55032277107239), varHLLP83088 * DC.ar(0.2176616191864), varHLLP83088 * DC.ar(0.75999510288239), varHLLP83088 * DC.ar(0.73146855831146)), Silent.ar());
//varHLLP830819 = AtsFreq.ar(Array.fill(2.pow(11), { |i| rrand(-1, 1) }).as(LocalBuf), varHLLP83088 * gateEnv.lag3(varHLLP83088 * DC.ar(0.78079807758331), varHLLP83088 * DC.ar(0.16732859611511)), 0.34392714500427 * modY * modY, varHLLP830819, Silent.ar());
	varHLLP830819 = varHLLP8308110;
	varHLLP8308110 = Pluck.ar(gate, varHLLP83088 * env, SinGrainI.ar(env, gateEnv, modY * modY, bufnum, bufnum, x, 0.99824716766163 * modY * varHLLP830819, Silent.ar()), signal * wave, y, x, 0.97584818895818 * gateEnv * varHLLP8308110, Silent.ar());
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
			); env = gateEnv;
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
			); env = gateEnv;
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
			); env = gateEnv;
// Generated prototype body code
varW97MThusBS8 = TTendency.ar(wave * signal, signal, 0.9641444683075 * env * wave, modX, env.unipolar(0.99596785745523 * modZ * gateEnv), varW97MThusBS8 * gateEnv);
	varW97MThusBS8 = LFClipNoise.ar(gateEnv * modZ, SinGrain.ar(env, y, env * modY, 0.99156761698389 * env * wave, Silent.ar()), Silent.ar());

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
			);

env = gateEnv;
// Generated prototype body code
varOCXFinalX8 = AmpCompA.ar(varOCXFinalX10, signal * env, y, wave * varOCXFinalX9);
varOCXFinalX9 = FoaPushX.ar(varOCXFinalX10 * modY, modY * wave, 0.40379584288092 * modX * modZ, Silent.ar());
varOCXFinalX10 = Demand.ar(varOCXFinalX8 * modZ, gateEnv, gateEnv);
varOCXFinalX8 = DiskOut.ar(Array.fill(2.pow(16), { |i| rrand(-1, 1) }).as(LocalBuf), [FMHEncode2.ar(amp, modZ * env, modZ * gateEnv, amp, OSFold4.ar(RedPhasor.ar(wave * DC.ar(0.51845216751099), wave * DC.ar(0.30371236801147), wave * DC.ar(0.11925184726715), wave * DC.ar(0.93580293655396), wave * DC.ar(0.9227876663208), wave * DC.ar(0.23851191997528), wave * DC.ar(0.7012779712677)), x, wave * env.linexp(wave * DC.ar(0.42103910446167), wave * DC.ar(0.52195835113525), wave * DC.ar(0.0043148994445801), wave * DC.ar(0.49424684047699), wave * DC.ar(0.49100744724274))), varOCXFinalX9 * modY), RedPhasor2.ar(signal * signal, varOCXFinalX8 * modX, modZ, x.leftShift(LFClipNoise.ar(wave * DC.ar(0.72703289985657), wave * DC.ar(0.33575618267059), wave * DC.ar(0.87109994888306))), gateEnv, varOCXFinalX8 * varOCXFinalX9, signal * modX)]);
varOCXFinalX9 = Clipper4.ar(0.44191992282867 * modX * modZ, x, t_trig);
varOCXFinalX10 = GlitchHPF.ar(modZ * modZ, varOCXFinalX10 * modX, InRange.ar(modX, gateEnv * varOCXFinalX8, 0.4704338312149 * modX * modX), Gendy4.ar(signal * varOCXFinalX10, modZ, signal * modZ, XFade2.ar(modY * env, wave * signal), wave * modY, varOCXFinalX9, signal, modX * varOCXFinalX10, varOCXFinalX9, 0.22467410564423 * FoaPressZ.ar(wave * DC.ar(0.8598964214325), wave * DC.ar(0.69316840171814), wave * DC.ar(0.47205579280853), wave * DC.ar(0.33974730968475)), 0.99871082667421 * SoftClipAmp8.ar(wave * DC.ar(0.020733118057251), wave * DC.ar(0.51388156414032), wave * DC.ar(0.56076812744141), wave * DC.ar(0.43646168708801)), Silent.ar()));

signal = varOCXFinalX10;
signal = SanityCheck2.ar(signal);
			Out.ar(50, Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001));
}).store;

/////////////////////////////////////////////////////////
// PDP.1563
/////////////////////////////////////////////////////////

SynthDef.new("PDP.1563", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varPDP15632230299, varPDP156322302910, varPDP156322302911;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varPDP15632230299 = varPDP156322302910 = varPDP156322302911 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
			modX = K2A.ar(x / 430);
			modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
			modZ = K2A.ar(z / 430);
			env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), ExpRand(0.05, 0.25)], -4), gate:t_trig, doneAction:0);

			in = InFeedback.ar(80 + (island * 2), 2);
			wave = WaveTerrain.ar(
			    bufnum,
			    env.linlin(0, 1, [modX * 72, modZ * 72], modY * 72),
			    env.linlin(0, 1, [modZ * 72, modX * 72], modY * 72),
			    72,
			    72
			);

env = gateEnv;
			wave = in + wave * gateEnv;


// Generated prototype body code
varPDP15632230299 = TRand.ar(0.35734367370605 * modX * modY, in * varPDP156322302911, wave * varPDP156322302911);
	varPDP156322302910 = FMGrain.ar(env, gateEnv, in * modZ.bipolar(wave * DC.ar(0.73247349262238)), env.exprange(1, SampleRate.ir), varPDP15632230299 * modY.fold(wave * DC.ar(0.87165522575378), wave * DC.ar(0.62181127071381)), 0.98076601386993 * Lag3.ar(wave * DC.ar(0.73954880237579), wave * DC.ar(0.49133884906769), wave * DC.ar(0.61706686019897), wave * DC.ar(0.52739131450653)), Silent.ar());
varPDP156322302911 = LinXFade2.ar(gateEnv, env, t_trig, 0.36532640457153 * in * modY);
varPDP15632230299 = Pluck.ar(varPDP15632230299, modY * in, 0.59316658973694 * modY, modX * modZ, modY * signal, signal * signal, 0.99853294079914 * varPDP156322302911, Silent.ar());
varPDP156322302910 = Balance2.ar(wave * DC.ar(0.65512812137604), wave * DC.ar(0.024487376213074), wave * DC.ar(0.8501672744751), wave * DC.ar(0.36301028728485));
// varPDP156322302911 = Blip.ar(env * varPDP156322302910, 0.5030632019043 * modZ, 0.91689848171337 * modY * modY, Silent.ar());

signal = varPDP156322302910;
signal = SanityCheck2.ar(signal);
			signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
			Out.ar(50, signal);
			Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs");



/////////////////////////////////////////////////////////
// Idie.3520223154
/////////////////////////////////////////////////////////

SynthDef.new("Idie.3520223154", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varIdie35202231549, varIdie352022315410, varIdie352022315411, varIdie352022315412, varIdie352022315413, varIdie352022315414;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varIdie35202231549 = varIdie352022315410 = varIdie352022315411 = varIdie352022315412 = varIdie352022315413 = varIdie352022315414 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
			modX = K2A.ar(x / 430);
			modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
			modZ = K2A.ar(z / 430);
			env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), ExpRand(0.05, 0.25)], -4), gate:t_trig, doneAction:0);

			in = InFeedback.ar(80 + (island * 2), 2);
			wave = WaveTerrain.ar(
			    bufnum,
			    env.linlin(0, 1, [modX * 72, modZ * 72], modY * 72),
			    env.linlin(0, 1, [modZ * 72, modX * 72], modY * 72),
			    72,
			    72
			);

			env = gateEnv; wave = in + wave * env;


// Generated prototype body code
varIdie35202231549 = TTendency.ar(modY * varIdie352022315411.atan2(LinCongL.ar(wave * DC.ar(0.028663158416748), wave * DC.ar(0.52078998088837), wave * DC.ar(0.48529863357544), wave * DC.ar(0.82479739189148), wave * DC.ar(0.8903888463974), wave * DC.ar(0.19654750823975), wave * DC.ar(0.92394316196442))), 0.10861229896545 * varIdie35202231549 * signal, bufnum, varIdie352022315412, x, x);
varIdie352022315410 = BufDelayL.ar(Array.fill(2.pow(12), { |i| rrand(-1, 1) }).as(LocalBuf), gateEnv * env, varIdie352022315411 * in, LFNoise2.ar(varIdie352022315412, Tilt.ar(wave * DC.ar(0.22460865974426), wave * DC.ar(0.060095906257629), wave * DC.ar(0.25948333740234), wave * DC.ar(0.6739399433136), wave * DC.ar(0.67287945747375)), Silent.ar()), Silent.ar());
	/*varIdie352022315411 = StkBlowHole.ar((varIdie352022315412 * in).abs + 1, gate.abs, (varIdie352022315414 * varIdie35202231549).abs, varIdie352022315411.abs, 0.98939657211304 * (in * gateEnv).abs, gate.abs, 0.97092102876009 * modZ.abs * varIdie352022315412.abs, Silent.ar());*/
	varIdie352022315411 = varIdie352022315410;
varIdie352022315412 = BiPanB2.ar(in, varIdie352022315412 * modX, in * modX.clip(wave * DC.ar(0.25381517410278), wave * DC.ar(0.64636969566345)), varIdie352022315414 * modZ);
varIdie352022315411 = QuadC.ar(varIdie352022315413 * signal, signal * varIdie352022315413, modX, varIdie352022315414 * modX, varIdie352022315410, TTendency.ar(wave * DC.ar(0.44380521774292), wave * DC.ar(0.061190605163574), wave * DC.ar(0.1565500497818), wave * DC.ar(0.44070994853973), wave * DC.ar(0.11381876468658), wave * DC.ar(0.49854648113251)), Silent.ar());
varIdie352022315413 = EnvDetect.ar(env, modX * gateEnv, varIdie352022315411 * modX);
varIdie352022315414 = FoaFocusY.ar(wave * DC.ar(0.90905904769897), wave * DC.ar(0.65950977802277), wave * DC.ar(0.59252488613129), wave * DC.ar(0.87484788894653));

signal = varIdie352022315414;
signal = SanityCheck2.ar(signal);
			signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
			Out.ar(50, signal);
			Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// InDOS223105
/////////////////////////////////////////////////////////

SynthDef.new("InDOS223105", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varInDOS2231059, varInDOS22310510;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varInDOS2231059 = varInDOS22310510 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
			modX = K2A.ar(x / 430);
			modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
			modZ = K2A.ar(z / 430);
			env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), ExpRand(0.05, 0.25)], -4), gate:t_trig, doneAction:0);

			in = InFeedback.ar(80 + (island * 2), 2);
			wave = WaveTerrain.ar(
			    bufnum,
			    env.linlin(0, 1, [modX * 72, modZ * 72], modY * 72),
			    env.linlin(0, 1, [modZ * 72, modX * 72], modY * 72),
			    72,
			    72
			);

			env = gateEnv; wave = in + wave * env;


// Generated prototype body code
varInDOS2231059 = IFFT.ar(Array.fill(2.pow(12), { |i| rrand(-1, 1) }).as(LocalBuf), modX, island);
varInDOS22310510 = LatoocarfianL.ar(YigMandelbulbN.ar(wave * DC.ar(0.76924812793732), wave * DC.ar(0.93977189064026), wave * DC.ar(0.99661099910736), wave * DC.ar(0.15717887878418), wave * DC.ar(0.20744490623474), wave * DC.ar(0.20021963119507), wave * DC.ar(0.01087760925293)).exprange(1, SampleRate.ir), modY * varInDOS22310510.minNyquist(), env * modZ, wave * varInDOS2231059, varInDOS22310510 * env, signal, env * modX, 0.9999083643133 * env * modX, GrayNoise.ar(wave * DC.ar(0.12255942821503), wave * DC.ar(0.47273540496826)));
varInDOS2231059 = Standard2DL.ar(gateEnv * wave, CombFormlet.ar(varInDOS22310510, env, varInDOS2231059, varInDOS2231059, varInDOS22310510, Silent.ar(), signal * modY).exprange(1, SampleRate.ir), modZ * wave, 0.43579173088074 * varInDOS2231059.lag3(env, varInDOS2231059 * varInDOS22310510), varInDOS2231059 * in, 0.99811845043803 * env * wave, Silent.ar());
varInDOS22310510 = SVF.ar(in, modZ * signal, gateEnv * gateEnv, bufnum, modX * gateEnv, varInDOS22310510 * in, wave * modX, modY * wave, varInDOS22310510, Silent.ar());

signal = varInDOS22310510;
signal = SanityCheck2.ar(signal);
			signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
			Out.ar(50, signal);
			Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// Trojan.Brutecode223152
/////////////////////////////////////////////////////////

SynthDef.new("Trojan.Brutecode223152", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varTrojanBrutecode2231529;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varTrojanBrutecode2231529 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
			modX = K2A.ar(x / 430);
			modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
			modZ = K2A.ar(z / 430);
			env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), ExpRand(0.05, 0.25)], -4), gate:t_trig, doneAction:0);

			in = InFeedback.ar(80 + (island * 2), 2);
			wave = WaveTerrain.ar(
			    bufnum,
			    env.linlin(0, 1, [modX * 72, modZ * 72], modY * 72),
			    env.linlin(0, 1, [modZ * 72, modX * 72], modY * 72),
			    72,
			    72
			);

			env = gateEnv; wave = in + wave * env;


// Generated prototype body code
varTrojanBrutecode2231529 = ScopeOut.ar([SpruceBudworm.ar(BPeakEQ.ar(wave * DC.ar(0.18226563930511), wave * DC.ar(0.15209114551544), wave * DC.ar(0.64845895767212), wave * DC.ar(0.72360730171204), wave * DC.ar(0.60952615737915), wave * DC.ar(0.91146469116211)), 0.60486221313477 * modY * varTrojanBrutecode2231529, island.roundUp(Clipper4.ar(wave * DC.ar(0.45286405086517), wave * DC.ar(0.32647728919983), wave * DC.ar(0.98029959201813))), wave * modY, modX * gateEnv, in, bufnum, BHiPass.ar(wave * DC.ar(0.62159383296967), wave * DC.ar(0.38823413848877), wave * DC.ar(0.88315880298615), wave * DC.ar(0.093932747840881), wave * DC.ar(0.041055798530579)), gate, bufnum, 0.99532175655456 * modZ * varTrojanBrutecode2231529, Silent.ar()), SinOsc.ar(BFDecode1.ar(wave * DC.ar(0.41646420955658), wave * DC.ar(0.86417782306671), wave * DC.ar(0.069454073905945), wave * DC.ar(0.22360396385193), wave * DC.ar(0.51782786846161), wave * DC.ar(0.041956424713135), wave * DC.ar(0.48144280910492), wave * DC.ar(0.83900535106659), wave * DC.ar(0.37525165081024)).exprange(1, SampleRate.ir), env * varTrojanBrutecode2231529, TDelay.ar(wave * DC.ar(0.72099781036377), wave * DC.ar(0.11408495903015)), Silent.ar())], Array.fill(2.pow(14), { |i| rrand(-1, 1) }).as(LocalBuf).lagud(island, modX * modX));
varTrojanBrutecode2231529 = EnvFollow.ar(wave * DC.ar(0.74774718284607), wave * DC.ar(0.2766364812851), wave * DC.ar(0.062121868133545), wave * DC.ar(0.76622843742371));

signal = varTrojanBrutecode2231529;
signal = SanityCheck2.ar(signal);
			signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
			Out.ar(50, signal);
			Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// Vien.361223211
/////////////////////////////////////////////////////////

SynthDef.new("Vien.361223211", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varVien3612232119, varVien36122321110, varVien36122321111, varVien36122321112;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varVien3612232119 = varVien36122321110 = varVien36122321111 = varVien36122321112 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
			modX = K2A.ar(x / 430);
			modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
			modZ = K2A.ar(z / 430);
			env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), ExpRand(0.05, 0.25)], -4), gate:t_trig, doneAction:0);

			in = InFeedback.ar(80 + (island * 2), 2);
			wave = WaveTerrain.ar(
			    bufnum,
			    env.linlin(0, 1, [modX * 72, modZ * 72], modY * 72),
			    env.linlin(0, 1, [modZ * 72, modX * 72], modY * 72),
			    72,
			    72
			);

			env = gateEnv; wave = in + wave * env;


// Generated prototype body code
varVien3612232119 = TermanWang.ar(modZ, gateEnv, varVien36122321111, varVien36122321111, signal * varVien3612232119, MZPokey.ar(wave * DC.ar(0.37637197971344), wave * DC.ar(0.68830096721649), wave * DC.ar(0.80072951316833), wave * DC.ar(0.49669599533081), wave * DC.ar(0.63231635093689), wave * DC.ar(0.50745129585266), wave * DC.ar(0.60767340660095), wave * DC.ar(0.71752631664276), wave * DC.ar(0.11210763454437)), env, modX * varVien36122321111, 0.75765955448151 * modZ * varVien36122321112, 0.99988862683788 * modY * modZ, Silent.ar());
varVien36122321110 = Metro.ar(z, modX * gateEnv.blend(varVien36122321111 * wave, varVien36122321110 * wave.clip(wave * DC.ar(0.80591380596161), wave * DC.ar(0.099918484687805))), LFClipNoise.ar(wave * modY.exprange(wave * DC.ar(0.66997933387756), wave * DC.ar(0.21506655216217)), 0.99858245682475 * varVien36122321111 * varVien36122321111, Silent.ar()), Silent.ar());
varVien36122321111 = LastValue.ar(varVien36122321110 * varVien36122321111, signal);
varVien36122321112 = Slope.ar(varVien3612232119, PanB2.ar(wave * DC.ar(0.60265374183655), wave * DC.ar(0.53122866153717), wave * DC.ar(0.97148966789246)), Silent.ar());
	varVien3612232119 = PinkNoise.ar(wave);
varVien36122321110 = LPFVS6.ar(bufnum, Fhn2DL.ar(wave * varVien36122321112, varVien36122321111, gateEnv, y, varVien36122321112 * varVien36122321111, z, Hilbert.ar(wave * DC.ar(0.66863882541656), wave * DC.ar(0.97769999504089), wave * DC.ar(0.83861100673676)), varVien36122321112 * varVien36122321111, modX * modX, XFadeRotate.ar(wave * DC.ar(0.79565417766571), wave * DC.ar(0.84312009811401)), Silent.ar()).exprange(1, SampleRate.ir), wave);
varVien36122321111 = FincoSprottS.ar(FoaPsychoShelf.ar(wave * DC.ar(0.32095122337341), wave * DC.ar(0.44263207912445), wave * DC.ar(0.70035898685455), wave * DC.ar(0.23781847953796), wave * DC.ar(0.50350916385651), wave * DC.ar(0.77808547019958)).exprange(1, SampleRate.ir), modZ * signal, varVien36122321110, t_trig, modY, 0.25289988517761 * modZ, varVien36122321112, Henon2DL.ar(wave * DC.ar(0.81486105918884), wave * DC.ar(0.029651045799255), wave * DC.ar(0.3261935710907), wave * DC.ar(0.25258219242096), wave * DC.ar(0.72601544857025), wave * DC.ar(0.56706011295319), wave * DC.ar(0.64819121360779), wave * DC.ar(0.67804670333862)), Silent.ar());
varVien36122321112 = IndexInBetween.ar(wave * DC.ar(0.20705509185791), wave * DC.ar(0.45844173431396), wave * DC.ar(0.89634788036346), wave * DC.ar(0.34463047981262));

signal = varVien36122321112;
signal = SanityCheck2.ar(signal);
			signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
			Out.ar(50, signal);
			Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// XM.Laroux.E223058
/////////////////////////////////////////////////////////

SynthDef.new("XM.Laroux.E223058", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varXMLarouxE2230589;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varXMLarouxE2230589 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
			modX = K2A.ar(x / 430);
			modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
			modZ = K2A.ar(z / 430);
			env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), ExpRand(0.05, 0.25)], -4), gate:t_trig, doneAction:0);

			in = InFeedback.ar(80 + (island * 2), 2);
			wave = WaveTerrain.ar(
			    bufnum,
			    env.linlin(0, 1, [modX * 72, modZ * 72], modY * 72),
			    env.linlin(0, 1, [modZ * 72, modX * 72], modY * 72),
			    72,
			    72
			);

			env = gateEnv; wave = in + wave * env;


// Generated prototype body code
	varXMLarouxE2230589 = MonoGrain.ar(2, env, modX, varXMLarouxE2230589, 0.99322929125391 * varXMLarouxE2230589 * env, Silent.ar());
varXMLarouxE2230589 = TGrains2.ar(2, env, Array.fill(2.pow(15), { |i| rrand(-1, 1) }).as(LocalBuf), y, y, island, gateEnv * modZ, wave * modX, gate, modZ, varXMLarouxE2230589 * varXMLarouxE2230589);

signal = varXMLarouxE2230589;
signal = SanityCheck2.ar(signal);
			signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
			Out.ar(50, signal);
			Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");





/////////////////////////////////////////////////////////
// EXE.2562230591
/////////////////////////////////////////////////////////

SynthDef.new("EXE.2562230591", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varEXE2562230599, varEXE25622305910, varEXE256223059111, varEXE256223059112, varEXE256223059113;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varEXE2562230599 = varEXE25622305910 = varEXE256223059111 = varEXE256223059112 = varEXE256223059113 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
			modX = K2A.ar(x / 430);
			modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
			modZ = K2A.ar(z / 430);
			env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), ExpRand(0.05, 0.25)], -4), gate:t_trig, doneAction:0);

			in = InFeedback.ar(80 + (island * 2), 2);
			wave = WaveTerrain.ar(
			    bufnum,
			    env.linlin(0, 1, [modX * 72, modZ * 72], modY * 72),
			    env.linlin(0, 1, [modZ * 72, modX * 72], modY * 72),
			    72,
			    72
			);

			env = gateEnv; wave = in + wave * env;


// Generated prototype body code
varEXE2562230599 = Allpass1.ar(y, modY * varEXE256223059111, 0.99902568354071 * wave * gateEnv, Silent.ar());
varEXE25622305910 = NL.ar(x, Array.fill(2.pow(10), { |i| rrand(-1, 1) }).as(LocalBuf).lag2ud(varEXE256223059111 * varEXE256223059111, x), Array.fill(2.pow(13), { |i| rrand(-1, 1) }).as(LocalBuf), 0.80560266971588 * varEXE256223059112 * varEXE256223059111, modX * varEXE25622305910, 0.20085967151439 * varEXE256223059111 * varEXE256223059112, Silent.ar());
varEXE2562230599 = Rotate2.ar(wave * DC.ar(0.35062038898468), wave * DC.ar(0.9726904630661), wave * DC.ar(0.38735866546631));
varEXE25622305910 = Demand.ar(gateEnv * in, varEXE256223059111 * wave, t_trig);
// Variation test code
varEXE256223059111 = SinOscFB.ar(modY * modY, gate, 0.99831875057237 * wave * signal, GlitchRHPF.ar(varEXE25622305910 * DC.ar(0.54512345790863), varEXE25622305910 * DC.ar(0.15468978881836), varEXE2562230599 * DC.ar(0.023855328559875), varEXE25622305910 * DC.ar(0.79397320747375), varEXE25622305910 * DC.ar(0.28496313095093)));
varEXE256223059112 = DiskIn.ar(2, Array.fill(2.pow(14), { |i| rrand(-1, 1) }).as(LocalBuf), amp);
varEXE256223059113 = LinCongN.ar(Pluck.ar(varEXE2562230599 * DC.ar(0.30232512950897), varEXE25622305910 * DC.ar(0.23571193218231), varEXE25622305910 * DC.ar(0.33426177501678), varEXE2562230599 * DC.ar(0.017455220222473), varEXE25622305910 * DC.ar(0.87733972072601), varEXE2562230599 * DC.ar(0.98734211921692), varEXE2562230599 * DC.ar(0.47471809387207), varEXE25622305910 * DC.ar(0.83683800697327)).exprange(1, SampleRate.ir), varEXE256223059113 * modY, signal * modY, signal, varEXE256223059111 * wave, 0.99731923514347 * in, Silent.ar());
varEXE256223059111 = Trig1.ar(t_trig, gateEnv);
varEXE256223059112 = DiskIn.ar(2, Array.fill(2.pow(15), { |i| rrand(-1, 1) }).as(LocalBuf), env * signal);
	varEXE256223059113 = BufGrainBF.ar(env, bufnum, bufnum, signal, varEXE25622305910, varEXE256223059112, modX * modX, varEXE25622305910, varEXE2562230599 * modY, modZ, 0.78890771929715 * modY * varEXE256223059113, Silent.ar());
varEXE256223059111 = FoaTumble.ar(in * varEXE256223059111, x, modX, Silent.ar());
varEXE256223059112 = AllpassL.ar(in, 0.2616308927536 * gateEnv * modX, amp, gateEnv, env, Silent.ar());
varEXE256223059113 = LFSaw.ar(varEXE25622305910 * varEXE256223059112, 0.81877267360687 * varEXE256223059112 * modX, modX, Silent.ar());

signal = varEXE256223059113;
signal = SanityCheck2.ar(signal);
			signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
			Out.ar(50, signal);
			Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");





/////////////////////////////////////////////////////////
// W32.Bumdoc.Worm223106
/////////////////////////////////////////////////////////

SynthDef.new("W32.Bumdoc.Worm223106", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varW32BumdocWorm2231069;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varW32BumdocWorm2231069 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
			modX = K2A.ar(x / 430);
			modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
			modZ = K2A.ar(z / 430);
			env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), ExpRand(0.05, 0.25)], -4), gate:t_trig, doneAction:0);

			in = InFeedback.ar(80 + (island * 2), 2);
			wave = WaveTerrain.ar(
			    bufnum,
			    env.linlin(0, 1, [modX * 72, modZ * 72], modY * 72),
			    env.linlin(0, 1, [modZ * 72, modX * 72], modY * 72),
			    72,
			    72
			);

			env = gateEnv; wave = in + wave * env;


// Generated prototype body code
varW32BumdocWorm2231069 = GravityGrid.ar(bufnum, bufnum, modY * in, gateEnv, Array.fill(2.pow(16), { |i| rrand(-1, 1) }).as(LocalBuf), LFBrownNoise1.ar(wave * DC.ar(0.15088927745819), wave * DC.ar(0.48338639736176), wave * DC.ar(0.71412837505341), wave * DC.ar(0.30270385742188), wave * DC.ar(0.53178679943085)), Silent.ar());
varW32BumdocWorm2231069 = LFPar.ar(wave * DC.ar(0.73263394832611), wave * DC.ar(0.89488518238068), wave * DC.ar(0.5922429561615), wave * DC.ar(0.23698556423187));

signal = varW32BumdocWorm2231069;
signal = SanityCheck2.ar(signal);
			signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
			Out.ar(50, signal);
			Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");





/////////////////////////////////////////////////////////
// _1987223146
/////////////////////////////////////////////////////////

SynthDef.new("_1987223146", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, var_19872231469;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = var_19872231469 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
			modX = K2A.ar(x / 430);
			modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
			modZ = K2A.ar(z / 430);
			env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), ExpRand(0.05, 0.25)], -4), gate:t_trig, doneAction:0);

			in = InFeedback.ar(80 + (island * 2), 2);
			wave = WaveTerrain.ar(
			    bufnum,
			    env.linlin(0, 1, [modX * 72, modZ * 72], modY * 72),
			    env.linlin(0, 1, [modZ * 72, modX * 72], modY * 72),
			    72,
			    72
			);

			env = gateEnv; wave = in + wave * env;


// Generated prototype body code
//var_19872231469 = VBAP.ar(2, var_19872231469 * gateEnv, Array.fill(2.pow(12), { |i| rrand(-1, 1) }).as(LocalBuf), modZ * signal, env * signal, modX * modY);
	var_19872231469 = wave;
	var_19872231469 = CuspL.ar(modZ, signal * modX, env * wave, PinkNoise.ar(wave).bipolar(wave * DC.ar(0.35126960277557)), 0.99831273198427 * gateEnv * wave, Silent.ar());

signal = var_19872231469;
signal = SanityCheck2.ar(signal);
			signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
			Out.ar(50, signal);
			Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");





/////////////////////////////////////////////////////////
// W97M.Mamm.B223123
/////////////////////////////////////////////////////////

SynthDef.new("W97M.Mamm.B223123", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varW97MMammB2231239, varW97MMammB22312310, varW97MMammB22312311, varW97MMammB22312312;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varW97MMammB2231239 = varW97MMammB22312310 = varW97MMammB22312311 = varW97MMammB22312312 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
			modX = K2A.ar(x / 430);
			modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
			modZ = K2A.ar(z / 430);
			env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), ExpRand(0.05, 0.25)], -4), gate:t_trig, doneAction:0);

			in = InFeedback.ar(80 + (island * 2), 2);
			wave = WaveTerrain.ar(
			    bufnum,
			    env.linlin(0, 1, [modX * 72, modZ * 72], modY * 72),
			    env.linlin(0, 1, [modZ * 72, modX * 72], modY * 72),
			    72,
			    72
			);

			env = gateEnv; wave = in + wave * env;


// Generated prototype body code
varW97MMammB2231239 = Concat.ar(varW97MMammB2231239 * modY, 0.53590846061707 * env, amp, varW97MMammB2231239 * varW97MMammB22312312, wave * in, modY, 0.95353221893311 * env * varW97MMammB22312310, varW97MMammB22312312 * modY, varW97MMammB22312310 * env, modY * varW97MMammB22312311, gateEnv, 0.10833132266998 * modZ * wave, modX, Silent.ar());
varW97MMammB22312310 = Schmidt.ar(varW97MMammB22312312 * gateEnv, wave * modZ, env);
varW97MMammB22312311 = BufGrain.ar(env, wave * DC.ar(0.46182179450989), wave * DC.ar(0.74634957313538), wave * DC.ar(0.57068872451782), wave * DC.ar(0.41116809844971), wave * DC.ar(0.43594777584076), wave * DC.ar(0.07545804977417), wave * DC.ar(0.85592699050903), wave * DC.ar(0.26894629001617), wave * DC.ar(0.8300803899765), wave * DC.ar(0.89652729034424));
varW97MMammB22312312 = LinCongC.ar(LFBrownNoise2.ar(wave * DC.ar(0.10689163208008), wave * DC.ar(0.50352036952972), wave * DC.ar(0.34722054004669), wave * DC.ar(0.096770882606506), wave * DC.ar(0.32387483119965)).exprange(1, SampleRate.ir), wave, in * gateEnv, modZ * modX, varW97MMammB22312310 * varW97MMammB22312311, in, Silent.ar());
varW97MMammB2231239 = WrapIndex.ar(Array.fill(2.pow(12), { |i| rrand(-1, 1) }).as(LocalBuf), env * varW97MMammB22312312, 0.9811657476971 * signal * varW97MMammB22312311, Silent.ar());
varW97MMammB22312310 = Slope.ar(island, FoaDirectO.ar(wave * DC.ar(0.21214962005615), wave * DC.ar(0.28103268146515), wave * DC.ar(0.55898761749268), wave * DC.ar(0.55298590660095)), Silent.ar());
varW97MMammB22312311 = BufGrainIBF.ar(env, in * env, bufnum, OscN.ar(Array.fill(2.pow(12), { |i| rrand(-1, 1) }).as(LocalBuf), SVF.ar(wave * DC.ar(0.10019779205322), wave * DC.ar(0.93236410617828), wave * DC.ar(0.41523504257202), wave * DC.ar(0.50537180900574), wave * DC.ar(0.53733921051025), wave * DC.ar(0.87996745109558), wave * DC.ar(0.51211810112), wave * DC.ar(0.12386870384216), wave * DC.ar(0.21045017242432), wave * DC.ar(0.63834011554718)).exprange(1, SampleRate.ir), modX, 0.99113239235431 * varW97MMammB22312312 * varW97MMammB22312311, Silent.ar()).trunc(TwoZero.ar(signal * modY, Select.ar(wave * DC.ar(0.17087924480438), wave * DC.ar(0.92512238025665)).exprange(1, SampleRate.ir), varW97MMammB22312310, MZPokey.ar(wave * DC.ar(0.49342715740204), wave * DC.ar(0.19756388664246), wave * DC.ar(0.62779009342194), wave * DC.ar(0.98470139503479), wave * DC.ar(0.17931246757507), wave * DC.ar(0.38788151741028), wave * DC.ar(0.0040698051452637), wave * DC.ar(0.83263599872589), wave * DC.ar(0.8858722448349)), Silent.ar())), modY * signal, bufnum, bufnum, modZ * modY, in, 0.017645835876465 * FincoSprottM.ar(modX * signal, modX, modZ * gateEnv, modY * modX, amp.atan2(RedDPCMencode.ar(wave * DC.ar(0.20561027526855), wave * DC.ar(0.91680824756622))), bufnum, RedDPCMencode.ar(wave * DC.ar(0.19952690601349), wave * DC.ar(0.19404733181)).lag(wave * DC.ar(0.86542236804962), wave * DC.ar(0.35847127437592)), in, Silent.ar()), varW97MMammB22312311, varW97MMammB22312310 * varW97MMammB22312312, signal * gateEnv, AnalyseEvents2.ar(signal, Array.fill(2.pow(10), { |i| rrand(-1, 1) }).as(LocalBuf), varW97MMammB22312311, wave * in, 0.25194144248962 * wave * varW97MMammB2231239.linexp(wave * DC.ar(0.11807763576508), wave * DC.ar(0.95094895362854), wave * DC.ar(0.41361439228058), wave * DC.ar(0.0876544713974), wave * DC.ar(0.1088639497757)), varW97MMammB22312310 * varW97MMammB22312311.clip(wave * DC.ar(0.91189134120941), wave * DC.ar(0.31875956058502))), Silent.ar());
varW97MMammB22312312 = ToggleFF.ar(modX * varW97MMammB22312311);

signal = varW97MMammB22312312;
signal = SanityCheck2.ar(signal);
			signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
			Out.ar(50, signal);
			Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// Sepultura.242223046
/////////////////////////////////////////////////////////

SynthDef.new("Sepultura.242223046", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varSepultura2422230469, varSepultura24222304610, varSepultura24222304611;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varSepultura2422230469 = varSepultura24222304610 = varSepultura24222304611 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
			modX = K2A.ar(x / 430);
			modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
			modZ = K2A.ar(z / 430);
			env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), ExpRand(0.05, 0.25)], -4), gate:t_trig, doneAction:0);

			in = InFeedback.ar(80 + (island * 2), 2);
			wave = WaveTerrain.ar(
			    bufnum,
			    env.linlin(0, 1, [modX * 72, modZ * 72], modY * 72),
			    env.linlin(0, 1, [modZ * 72, modX * 72], modY * 72),
			    72,
			    72
			);

			env = gateEnv; wave = in + wave * env;


// Generated prototype body code
varSepultura2422230469 = BufGrainB.ar(env, env * modX, bufnum, env, amp, bufnum, FitzHughNagumo.ar(signal, 0.031422138214111 * wave * modX, env, modX, OnePole.ar(wave * DC.ar(0.084592223167419), wave * DC.ar(0.20662260055542), wave * DC.ar(0.39494824409485), wave * DC.ar(0.55438494682312)), WeaklyNonlinear2.ar(wave * DC.ar(0.35159635543823), wave * DC.ar(0.23307478427887), wave * DC.ar(0.0065534114837646), wave * DC.ar(0.51605224609375), wave * DC.ar(0.30784094333649), wave * DC.ar(0.94363927841187), wave * DC.ar(0.26413643360138), wave * DC.ar(0.090383172035217), wave * DC.ar(0.77845311164856), wave * DC.ar(0.28981590270996), wave * DC.ar(0.55580365657806), wave * DC.ar(0.020954012870789), wave * DC.ar(0.64001429080963)), 0.76398658752441 * AverageOutput.ar(wave * DC.ar(0.10218298435211), wave * DC.ar(0.56095707416534), wave * DC.ar(0.59604692459106), wave * DC.ar(0.61591279506683)), 0.77247023132551 * signal * env, Silent.ar()), Dust2.ar(wave * DC.ar(0.77383804321289), wave * DC.ar(0.48613691329956), wave * DC.ar(0.66906607151031)), Silent.ar());
varSepultura24222304610 = Rotate2.ar(varSepultura24222304611, bufnum, gateEnv * modX);
varSepultura24222304611 = BufGrain.ar(env, env, bufnum, 0.39589393138885 * signal * varSepultura2422230469, env * varSepultura24222304610, modX, RLPFD.ar(wave * DC.ar(0.7970609664917), wave * DC.ar(0.74694168567657), wave * DC.ar(0.34496569633484), wave * DC.ar(0.84213817119598), wave * DC.ar(0.44390082359314), wave * DC.ar(0.00063800811767578)), Silent.ar());
varSepultura2422230469 = Pan4.ar(wave * DC.ar(0.10196733474731), wave * DC.ar(0.99227678775787), wave * DC.ar(0.21140086650848), wave * DC.ar(0.21591067314148));
varSepultura24222304610 = BufCombC.ar(wave * DC.ar(0.070192217826843), wave * DC.ar(0.67521178722382), wave * DC.ar(0.91380083560944), wave * DC.ar(0.97139322757721), wave * DC.ar(0.088229298591614), wave * DC.ar(0.6166650056839));
varSepultura24222304611 = RedNoise.ar(0.7594176530838 * varSepultura24222304610 * modY.lincurve(0.99865663051605 * env, varSepultura2422230469, modY * gateEnv, modY * modZ, 0.40409982204437 * gateEnv, \minmax), 0.99980869908662 * in * modZ, NestedAllpassN.ar(modX, modY, signal * wave, wave, amp, x, 0.96895790100098 * modZ * gateEnv, 0.99871433889427 * Compander.ar(wave * DC.ar(0.31240010261536), wave * DC.ar(0.54724979400635), wave * DC.ar(0.26926732063293), wave * DC.ar(0.67600584030151), wave * DC.ar(0.44922292232513), wave * DC.ar(0.99356257915497), wave * DC.ar(0.98837602138519), wave * DC.ar(0.90725648403168), wave * DC.ar(0.35212111473083)), Hilbert.ar(wave * DC.ar(0.27989327907562), wave * DC.ar(0.38542973995209), wave * DC.ar(0.23014724254608))));

signal = varSepultura24222304611;
signal = SanityCheck2.ar(signal);
			signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
			Out.ar(50, signal);
			Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");


/////////////////////////////////////////////////////////
// X97M.Reten.Gen223210
/////////////////////////////////////////////////////////

SynthDef.new("X97M.Reten.Gen223210", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varX97MRetenGen2232109, varX97MRetenGen22321010;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varX97MRetenGen2232109 = varX97MRetenGen22321010 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
			modX = K2A.ar(x / 430);
			modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
			modZ = K2A.ar(z / 430);
			env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), ExpRand(0.05, 0.25)], -4), gate:t_trig, doneAction:0);

			in = InFeedback.ar(80 + (island * 2), 2);
			wave = WaveTerrain.ar(
			    bufnum,
			    env.linlin(0, 1, [modX * 72, modZ * 72], modY * 72),
			    env.linlin(0, 1, [modZ * 72, modX * 72], modY * 72),
			    72,
			    72
			);

			env = gateEnv; wave = in + wave * env;


// Generated prototype body code
varX97MRetenGen2232109 = GravityGrid.ar(env, wave, modY * env, 0.89115822315216 * in * gateEnv, Array.fill(2.pow(15), { |i| rrand(-1, 1) }).as(LocalBuf), 0.7521808335266 * varX97MRetenGen2232109, Silent.ar());
varX97MRetenGen22321010 = Pan2.ar(env * modY, amp, modZ * modY);
varX97MRetenGen2232109 = FOS.ar(signal.lag3(gate, bufnum), 0.014585256576538 * LPF18.ar(env, in * modX, t_trig, varX97MRetenGen2232109 * varX97MRetenGen2232109), wave, signal * signal, RLPFD.ar(0.61047470569611 * wave * signal, varX97MRetenGen22321010, island, modY, 0.99480628761632 * OSWrap8.ar(wave * DC.ar(0.58131778240204), wave * DC.ar(0.2917685508728), wave * DC.ar(0.75283861160278)), Silent.ar()), Silent.ar());
varX97MRetenGen22321010 = BPeakEQ.ar(wave * DC.ar(0.92627477645874), wave * DC.ar(0.98751902580261), wave * DC.ar(0.69503748416901), wave * DC.ar(0.26086211204529), wave * DC.ar(0.53087556362152), wave * DC.ar(0.35684382915497));

signal = varX97MRetenGen22321010;
signal = SanityCheck2.ar(signal);
			signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
			Out.ar(50, signal);
			Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// VBS.Bunny.Intended2231421
/////////////////////////////////////////////////////////

SynthDef.new("VBS.Bunny.Intended2231421", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varVBSBunnyIntended2231429, varVBSBunnyIntended223142110, varVBSBunnyIntended223142111;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varVBSBunnyIntended2231429 = varVBSBunnyIntended223142110 = varVBSBunnyIntended223142111 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
			modX = K2A.ar(x / 430);
			modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
			modZ = K2A.ar(z / 430);
			env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), ExpRand(0.05, 0.25)], -4), gate:t_trig, doneAction:0);

			in = InFeedback.ar(80 + (island * 2), 2);
			wave = WaveTerrain.ar(
			    bufnum,
			    env.linlin(0, 1, [modX * 72, modZ * 72], modY * 72),
			    env.linlin(0, 1, [modZ * 72, modX * 72], modY * 72),
			    72,
			    72
			);

			env = gateEnv; wave = in + wave * env;


// Generated prototype body code
varVBSBunnyIntended2231429 = PanX.ar(2, modZ * env, varVBSBunnyIntended223142110 * modZ, signal * varVBSBunnyIntended223142110, island);
varVBSBunnyIntended2231429 = FoaDirectZ.ar(varVBSBunnyIntended223142111 * in, varVBSBunnyIntended223142111, 0.99996843524017 * in * modZ, Silent.ar());
// Variation test code
varVBSBunnyIntended223142110 = Decimator.ar(island, modX, varVBSBunnyIntended2231429 * varVBSBunnyIntended2231429, Oregonator.ar(varVBSBunnyIntended2231429 * DC.ar(0.58605027198792), varVBSBunnyIntended2231429 * DC.ar(0.10575973987579), varVBSBunnyIntended2231429 * DC.ar(0.56154918670654), varVBSBunnyIntended2231429 * DC.ar(0.082568407058716), varVBSBunnyIntended2231429 * DC.ar(0.79238140583038), varVBSBunnyIntended2231429 * DC.ar(0.59268295764923), varVBSBunnyIntended2231429 * DC.ar(0.21386086940765), varVBSBunnyIntended2231429 * DC.ar(0.63798534870148), varVBSBunnyIntended2231429 * DC.ar(0.81865227222443), varVBSBunnyIntended2231429 * DC.ar(0.97471642494202)), Silent.ar());
varVBSBunnyIntended223142111 = COsc.ar(Array.fill(2.pow(14), { |i| rrand(-1, 1) }).as(LocalBuf), varVBSBunnyIntended223142111 * varVBSBunnyIntended223142111, bufnum, 0.96935132678448 * signal * varVBSBunnyIntended223142111, Silent.ar());
varVBSBunnyIntended223142110 = RunningMax.ar(x, modX * varVBSBunnyIntended2231429);
varVBSBunnyIntended223142111 = ReplaceOut.ar((80 + (island * 2)), [FoaPressZ.ar(varVBSBunnyIntended2231429 * DC.ar(0.99750173091888), varVBSBunnyIntended2231429 * DC.ar(0.52634966373444), varVBSBunnyIntended2231429 * DC.ar(0.6096385717392), varVBSBunnyIntended2231429 * DC.ar(0.25590920448303)), LPZ2.ar(varVBSBunnyIntended2231429 * DC.ar(0.51395213603973), varVBSBunnyIntended2231429 * DC.ar(0.073708653450012), varVBSBunnyIntended2231429 * DC.ar(0.69870221614838))]);
varVBSBunnyIntended223142110 = TDuty.ar(varVBSBunnyIntended223142110, in * modZ, env, 0.015182137489319 * TGaussRand.ar(varVBSBunnyIntended2231429 * DC.ar(0.80524098873138), varVBSBunnyIntended2231429 * DC.ar(0.38346123695374), varVBSBunnyIntended2231429 * DC.ar(0.81832432746887), varVBSBunnyIntended2231429 * DC.ar(0.55404698848724), varVBSBunnyIntended2231429 * DC.ar(0.75767958164215)), varVBSBunnyIntended223142110 * in);
varVBSBunnyIntended223142111 = Standard2DC.ar(GrayNoise.ar(varVBSBunnyIntended2231429 * DC.ar(0.36924612522125), varVBSBunnyIntended2231429 * DC.ar(0.97602868080139)).exprange(1, SampleRate.ir), modZ * modY, modY * signal, 0.71599614620209, modY * varVBSBunnyIntended2231429, varVBSBunnyIntended223142110, Silent.ar());

signal = varVBSBunnyIntended223142111;
signal = SanityCheck2.ar(signal);
			signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
			Out.ar(50, signal);
			Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// WM.Epidemic.B:Tw2231131
/////////////////////////////////////////////////////////

SynthDef.new("WM.Epidemic.B:Tw2231131", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varWMEpidemicBTw2231139, varWMEpidemicBTw223113110;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varWMEpidemicBTw2231139 = varWMEpidemicBTw223113110 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
			modX = K2A.ar(x / 430);
			modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
			modZ = K2A.ar(z / 430);
			env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), ExpRand(0.05, 0.25)], -4), gate:t_trig, doneAction:0);

			in = InFeedback.ar(80 + (island * 2), 2);
			wave = WaveTerrain.ar(
			    bufnum,
			    env.linlin(0, 1, [modX * 72, modZ * 72], modY * 72),
			    env.linlin(0, 1, [modZ * 72, modX * 72], modY * 72),
			    72,
			    72
			);

			env = gateEnv; wave = in + wave * env;


// Generated prototype body code
varWMEpidemicBTw2231139 = LFDNoise0.ar(modZ * wave, 0.99970251294859 * varWMEpidemicBTw2231139 * env, GbmanL.ar(wave * DC.ar(0.19358015060425), wave * DC.ar(0.18311965465546), wave * DC.ar(0.4072345495224), wave * DC.ar(0.043897271156311), wave * DC.ar(0.22378718852997)));
varWMEpidemicBTw2231139 = FoaDirectX.ar(wave * DC.ar(0.29721295833588), wave * DC.ar(0.37287271022797), wave * DC.ar(0.56225752830505), wave * DC.ar(0.64593148231506));
// Variation test code
	/*
	varWMEpidemicBTw223113110 = FoaPressY.ar(StkPluck.ar(modY * signal.abs.max(0.01), env * modX.max(0.25), StkFlute.ar(varWMEpidemicBTw2231139.abs.max(0.1) * DC.ar(0.96671283245087), varWMEpidemicBTw2231139 * DC.ar(0.01), varWMEpidemicBTw2231139 * DC.ar(0.38272488117218), varWMEpidemicBTw2231139.abs * DC.ar(0.15874075889587), varWMEpidemicBTw2231139 * DC.ar(0.73475885391235), varWMEpidemicBTw2231139 * DC.ar(0.91304540634155)), SinOscFB.ar(varWMEpidemicBTw2231139 * DC.ar(0.29471623897552), varWMEpidemicBTw2231139 * DC.ar(0.59818279743195), varWMEpidemicBTw2231139 * DC.ar(0.19077897071838), varWMEpidemicBTw2231139 * DC.ar(0.96008777618408))).roundUp(FoaDominateY.ar(varWMEpidemicBTw2231139 * DC.ar(0.16851687431335), varWMEpidemicBTw2231139 * DC.ar(0.9396378993988), varWMEpidemicBTw2231139 * DC.ar(0.84964990615845), varWMEpidemicBTw2231139 * DC.ar(0.93317556381226))), varWMEpidemicBTw2231139, 0.99998702360346 * LFTri.ar(varWMEpidemicBTw2231139 * DC.ar(0.64983665943146), varWMEpidemicBTw2231139 * DC.ar(0.3079422712326), varWMEpidemicBTw2231139 * DC.ar(0.43548965454102), varWMEpidemicBTw2231139 * DC.ar(0.33565068244934)), Silent.ar());*/
	varWMEpidemicBTw223113110 = varWMEpidemicBTw2231139;
varWMEpidemicBTw223113110 = Friction.ar(Atari2600.ar(island, in * gateEnv, 0.23582172393799 * RedNoise.ar(varWMEpidemicBTw2231139 * DC.ar(0.66500306129456), varWMEpidemicBTw2231139 * DC.ar(0.98750829696655), varWMEpidemicBTw2231139 * DC.ar(0.42825031280518)), in * varWMEpidemicBTw223113110, gateEnv * modY, in * modY, env * modX), signal * modX, x, y, modY, Poll.ar(FoaPressZ.ar(varWMEpidemicBTw2231139 * DC.ar(0.58193922042847), varWMEpidemicBTw2231139 * DC.ar(0.72513222694397), varWMEpidemicBTw2231139 * DC.ar(0.15831685066223), varWMEpidemicBTw2231139 * DC.ar(0.21850371360779)), amp, island, varWMEpidemicBTw2231139 * modX), env, Silent.ar());
varWMEpidemicBTw223113110 = FincoSprottM.ar(env, modZ * modY, amp, modX, wave * modX, gate, varWMEpidemicBTw2231139, 0.9991442862994 * varWMEpidemicBTw2231139 * modZ, Silent.ar());

signal = varWMEpidemicBTw223113110;
signal = SanityCheck2.ar(signal);
			signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
			Out.ar(50, signal);
			Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// WM.Concept.AB223137
/////////////////////////////////////////////////////////

SynthDef.new("WM.Concept.AB223137", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varWMConceptAB2231379, varWMConceptAB22313710;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varWMConceptAB2231379 = varWMConceptAB22313710 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
			modX = K2A.ar(x / 430);
			modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
			modZ = K2A.ar(z / 430);
			env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), ExpRand(0.05, 0.25)], -4), gate:t_trig, doneAction:0);

			in = InFeedback.ar(80 + (island * 2), 2);
			wave = WaveTerrain.ar(
			    bufnum,
			    env.linlin(0, 1, [modX * 72, modZ * 72], modY * 72),
			    env.linlin(0, 1, [modZ * 72, modX * 72], modY * 72),
			    72,
			    72
			);

			env = gateEnv; wave = in + wave * env;


// Generated prototype body code
varWMConceptAB2231379 = BPF.ar(varWMConceptAB2231379 * varWMConceptAB22313710, DelTapWr.ar(Array.fill(2.pow(15), { |i| rrand(-1, 1) }).as(LocalBuf), modX * in.bitOr(Delay2.ar(wave * DC.ar(0.093942284584045), wave * DC.ar(0.31931149959564), wave * DC.ar(0.8680065870285)))).exprange(1, SampleRate.ir), in * env, Clip.ar(env, 0.68082058429718 * gateEnv, varWMConceptAB22313710 * wave), Silent.ar());
varWMConceptAB22313710 = RedNoise.ar(gate, 0.99983859967463 * FMHEncode0.ar(wave * DC.ar(0.46472465991974), wave * DC.ar(0.25495362281799), wave * DC.ar(0.92492604255676), wave * DC.ar(0.77793443202972)), Silent.ar());
varWMConceptAB2231379 = SkipNeedle.ar(0.35071098804474 * in, env, varWMConceptAB2231379 * gateEnv);
varWMConceptAB22313710 = OSWrap4.ar(wave * DC.ar(0.35416758060455), wave * DC.ar(0.43567371368408), wave * DC.ar(0.73190355300903));

signal = varWMConceptAB22313710;
signal = SanityCheck2.ar(signal);
			signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
			Out.ar(50, signal);
			Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");



/////////////////////////////////////////////////////////
// BAT.PG94.A174530
/////////////////////////////////////////////////////////

SynthDef.new("BAT.PG94.A174530", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varBATPG94A1745309, varBATPG94A17453010, varBATPG94A17453011, varBATPG94A17453012;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varBATPG94A1745309 = varBATPG94A17453010 = varBATPG94A17453011 = varBATPG94A17453012 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.25), ExpRand(0.05, 2)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         env.linlin(0, 1, [modX * 72, modZ * 72], modY * 72),
                         env.linlin(0, 1, [modZ * 72, modX * 72], modY * 72),
                         72,
                         72
                        );

                        wave = in + wave * env;


// Generated prototype body code
varBATPG94A1745309 = BBandPass.ar(x, wave * in, varBATPG94A1745309, signal, Silent.ar());
varBATPG94A17453010 = Lorenz2DC.ar(varBATPG94A17453011 * signal, env, t_trig, z, FoaFocusX.ar(varBATPG94A17453012, varBATPG94A1745309, 0.99992001906401 * gateEnv, Silent.ar()), signal * signal, amp, signal, gateEnv * signal, FincoSprottS.ar(wave * DC.ar(0.57350444793701), wave * DC.ar(0.59438383579254), wave * DC.ar(0.51876997947693), wave * DC.ar(0.33450543880463), wave * DC.ar(0.73773109912872), wave * DC.ar(0.14128363132477), wave * DC.ar(0.51020610332489), wave * DC.ar(0.42558288574219), wave * DC.ar(0.30270910263062)), Silent.ar());
varBATPG94A17453011 = Gendy1.ar(varBATPG94A1745309 * varBATPG94A1745309, varBATPG94A17453012 * modZ, gateEnv * varBATPG94A17453012, env * env, varBATPG94A17453011, varBATPG94A17453012, t_trig, amp, wave * wave, modZ * gateEnv, FincoSprottL.ar(wave * DC.ar(0.34187662601471), wave * DC.ar(0.23213672637939), wave * DC.ar(0.73111259937286), wave * DC.ar(0.98731791973114), wave * DC.ar(0.057564735412598), wave * DC.ar(0.27289748191833), wave * DC.ar(0.75558745861053), wave * DC.ar(0.49498963356018)), Silent.ar());
varBATPG94A17453012 = TBall.ar(0.78772914409637 * modY * signal, varBATPG94A17453012 * modY, 0.28427934646606 * varBATPG94A1745309 * in, signal * varBATPG94A17453012);
varBATPG94A1745309 = KmeansToBPSet1.ar(wave * DC.ar(0.075147747993469), wave * DC.ar(0.75134038925171), wave * DC.ar(0.71171844005585), wave * DC.ar(0.85833430290222), wave * DC.ar(0.91940546035767), wave * DC.ar(0.92983150482178), wave * DC.ar(0.49963665008545), wave * DC.ar(0.91072034835815), wave * DC.ar(0.68194317817688), wave * DC.ar(0.20997846126556));
varBATPG94A17453010 = WrapSummer.ar(varBATPG94A17453011 * gateEnv, gateEnv, wave, signal, modY * varBATPG94A17453012, varBATPG94A17453011 * varBATPG94A17453011);
varBATPG94A17453011 = FincoSprottS.ar(wave * DC.ar(0.47064685821533), wave * DC.ar(0.3212023973465), wave * DC.ar(0.67526459693909), wave * DC.ar(0.0055859088897705), wave * DC.ar(0.88405418395996), wave * DC.ar(0.76556348800659), wave * DC.ar(0.32988524436951), wave * DC.ar(0.69174158573151), wave * DC.ar(0.60683703422546));
varBATPG94A17453012 = MidEQ.ar(wave * DC.ar(0.77644991874695), wave * DC.ar(0.72566497325897), wave * DC.ar(0.93622982501984), wave * DC.ar(0.27312612533569), wave * DC.ar(0.74983060359955), wave * DC.ar(0.06727921962738));

signal = varBATPG94A17453012;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// Tankar.2361745541
/////////////////////////////////////////////////////////

SynthDef.new("Tankar.2361745541", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varTankar2361745549, varTankar23617455410, varTankar23617455411, varTankar23617455412, varTankar236174554113, varTankar236174554114, varTankar236174554115;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varTankar2361745549 = varTankar23617455410 = varTankar23617455411 = varTankar23617455412 = varTankar236174554113 = varTankar236174554114 = varTankar236174554115 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.25), ExpRand(0.05, 2)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         env.linlin(0, 1, [modX * 72, modZ * 72], modY * 72),
                         env.linlin(0, 1, [modZ * 72, modX * 72], modY * 72),
                         72,
                         72
                        );

                        wave = in + wave * env;


// Generated prototype body code
varTankar2361745549 = BufDelayN.ar(Array.fill(2.pow(13), { |i| rrand(-1, 1) }).as(LocalBuf).mod(Resonz.ar(wave * DC.ar(0.46931993961334), wave * DC.ar(0.80055069923401), wave * DC.ar(0.6803617477417), wave * DC.ar(0.43652021884918), wave * DC.ar(0.54338872432709))), island, modY, wave, Silent.ar());
varTankar23617455410 = Lorenz2DC.ar(varTankar23617455412, env * wave, varTankar23617455412 * varTankar23617455412, in * varTankar23617455411, varTankar23617455411, varTankar236174554114 * in, varTankar23617455411 * varTankar23617455411, varTankar236174554114 * modZ, gateEnv * varTankar2361745549, MoogFF.ar(wave * DC.ar(0.39910662174225), wave * DC.ar(0.20389294624329), wave * DC.ar(0.7318811416626), wave * DC.ar(0.43637239933014), wave * DC.ar(0.17959177494049), wave * DC.ar(0.47115993499756)), Silent.ar());
varTankar23617455411 = MembraneCircle.ar(gate, t_trig, bufnum, modZ, Silent.ar());
varTankar23617455412 = RandSeed.ar(varTankar236174554113.explin(wave * DC.ar(0.674396276474), wave * DC.ar(0.49473881721497), wave * DC.ar(0.69298219680786), wave * DC.ar(0.93120181560516), wave * DC.ar(0.52110385894775)), 0.1147552728653 * modX * modZ);
varTankar2361745549 = DemandEnvGen.ar(z, modX.round(BRZ2.ar(wave * DC.ar(0.55712199211121), wave * DC.ar(0.21138679981232), wave * DC.ar(0.17659783363342))), t_trig, env * modY, varTankar23617455410 * varTankar236174554113, gateEnv * varTankar23617455410, modX * varTankar236174554115, t_trig, island, varTankar2361745549);
varTankar23617455410 = FincoSprottL.ar(varTankar23617455412 * modY, modX, modY * varTankar23617455412, island, modZ * varTankar23617455411, env * varTankar23617455412, 0.99795543527317 * varTankar236174554113 * varTankar236174554113, Silent.ar());
varTankar23617455411 = SVF.ar(varTankar23617455412 * in.madd(wave * DC.ar(0.36080276966095), wave * DC.ar(0.5602639913559)), modZ * varTankar23617455411, LinPan2.ar(modZ.linlin(wave * DC.ar(0.21627843379974), wave * DC.ar(0.31717467308044), wave * DC.ar(0.015120387077332), wave * DC.ar(0.065792322158813), wave * DC.ar(0.6327338218689)), varTankar236174554115, island), gate, varTankar2361745549, in * modZ, env, varTankar23617455410 * varTankar2361745549, varTankar236174554113, Silent.ar());
varTankar23617455412 = LFDNoise3.ar(SinGrainBF.ar(env, wave * DC.ar(0.69635450839996), wave * DC.ar(0.21296381950378), wave * DC.ar(0.27083957195282), wave * DC.ar(0.35072445869446), wave * DC.ar(0.83553266525269), wave * DC.ar(0.68829834461212), wave * DC.ar(0.74669861793518), wave * DC.ar(0.63463866710663)).exprange(1, SampleRate.ir), 0.9919814256649 * signal * varTankar2361745549, Silent.ar());
// Variation test code
varTankar236174554113 = LPCError.ar(0.25648045539856 * in * modX, modX * varTankar23617455410, Fhn2DN.ar(varTankar23617455411 * DC.ar(0.75736403465271), varTankar23617455410 * DC.ar(0.40779840946198), varTankar2361745549 * DC.ar(0.64779913425446), varTankar23617455411 * DC.ar(0.59023201465607), varTankar2361745549 * DC.ar(0.76430177688599), varTankar23617455412 * DC.ar(0.14542174339294), varTankar23617455411 * DC.ar(0.11447072029114), varTankar2361745549 * DC.ar(0.51483821868896), varTankar23617455411 * DC.ar(0.48495256900787), varTankar2361745549 * DC.ar(0.34539675712585), varTankar23617455411 * DC.ar(0.90273785591125)), Silent.ar());
varTankar236174554114 = BMoog.ar(modX, env * varTankar236174554115, gate, modY * varTankar23617455412, y, env, BFEncode2.ar(varTankar2361745549 * DC.ar(0.82538783550262), varTankar23617455412 * DC.ar(0.60066282749176), varTankar23617455410 * DC.ar(0.41804087162018), varTankar23617455410 * DC.ar(0.18105614185333), varTankar2361745549 * DC.ar(0.50679993629456), varTankar2361745549 * DC.ar(0.034576058387756)).madd(varTankar23617455411 * DC.ar(0.84607136249542), varTankar2361745549 * DC.ar(0.87186515331268)));
varTankar236174554115 = SoftClipAmp4.ar(varTankar236174554113 * signal, 0.0023280382156372 * modZ * varTankar2361745549, 0.99933567695404 * DoubleWell3.ar(varTankar23617455411 * DC.ar(0.65672731399536), varTankar23617455412 * DC.ar(0.74995112419128), varTankar2361745549 * DC.ar(0.2702910900116), varTankar23617455411 * DC.ar(0.159947514534), varTankar23617455410 * DC.ar(0.12985479831696), varTankar23617455410 * DC.ar(0.88961374759674), varTankar2361745549 * DC.ar(0.6198422908783), varTankar23617455410 * DC.ar(0.16584384441376)), Silent.ar());
varTankar236174554113 = QuadL.ar(varTankar23617455411 * varTankar23617455412, 0.26616549491882 * Select.ar(varTankar23617455411 * DC.ar(0.18383884429932), varTankar23617455410 * DC.ar(0.1750580072403)), wave * varTankar23617455411, BLowShelf.ar(t_trig, varTankar2361745549 * env, signal * modX, gateEnv * gateEnv, 0.99901039427259 * wave * varTankar236174554114, Silent.ar()), 0.57541227340698 * in * gateEnv, 0.99982155863274 * varTankar236174554114 * varTankar236174554113, Silent.ar());
varTankar236174554114 = DoubleNestedAllpassC.ar(modZ * wave, varTankar2361745549, 0.46765828132629 * varTankar23617455411 * gateEnv, varTankar2361745549 * modY, 0.10730361938477 * RMEQ.ar(varTankar23617455412 * DC.ar(0.74444460868835), varTankar23617455411 * DC.ar(0.12402141094208), varTankar23617455412 * DC.ar(0.80479919910431), varTankar2361745549 * DC.ar(0.63477122783661), varTankar23617455412 * DC.ar(0.035658478736877), varTankar2361745549 * DC.ar(0.42822349071503)), env * varTankar23617455412, 0.4040892124176 * varTankar23617455411 * varTankar236174554115, varTankar236174554113, 0.93538951873779 * in * varTankar23617455411, 0.40425622463226 * in * varTankar236174554115, 0.99865567728909 * modX * in, Silent.ar());
varTankar236174554115 = Beep.ar(signal * varTankar23617455412, z);
varTankar236174554113 = SN76489.ar(varTankar23617455412, in * gateEnv, env, island, IIRFilter.ar(varTankar23617455411 * varTankar236174554113, modX, varTankar236174554113 * wave, 0.9257794446766 * varTankar236174554113 * gateEnv, Silent.ar()), varTankar23617455412 * varTankar236174554115, varTankar23617455410, gate, modX * modZ);
varTankar236174554114 = Demand.ar(modZ * modZ, varTankar236174554113 * modZ, 0.42337369918823 * varTankar23617455410 * wave);
varTankar236174554115 = Astrocade.ar(modX * varTankar236174554113, 0.10824275016785 * EnvDetect.ar(varTankar23617455411 * DC.ar(0.66238582134247), varTankar23617455411 * DC.ar(0.78189384937286), varTankar23617455412 * DC.ar(0.45084714889526)), modZ, z, bufnum, gateEnv * modX, amp, varTankar236174554114 * modZ);

signal = varTankar236174554115;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// XM.Laroux.AM:Jp1745561
/////////////////////////////////////////////////////////

SynthDef.new("XM.Laroux.AM:Jp1745561", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varXMLarouxAMJp1745569, varXMLarouxAMJp17455610, varXMLarouxAMJp17455611, varXMLarouxAMJp174556112, varXMLarouxAMJp174556113, varXMLarouxAMJp174556114;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varXMLarouxAMJp1745569 = varXMLarouxAMJp17455610 = varXMLarouxAMJp17455611 = varXMLarouxAMJp174556112 = varXMLarouxAMJp174556113 = varXMLarouxAMJp174556114 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.25), ExpRand(0.05, 2)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         env.linlin(0, 1, [modX * 72, modZ * 72], modY * 72),
                         env.linlin(0, 1, [modZ * 72, modX * 72], modY * 72),
                         72,
                         72
                        );

                        wave = in + wave * env;


// Generated prototype body code
	varXMLarouxAMJp1745569 = PinkNoise.ar(wave);
varXMLarouxAMJp17455610 = OSTrunc4.ar(varXMLarouxAMJp174556113 * modY, varXMLarouxAMJp1745569 * env);
varXMLarouxAMJp17455611 = LFDNoise1.ar(varXMLarouxAMJp1745569 * wave.lag(wave * DC.ar(0.39445745944977), wave * DC.ar(0.23823487758636)), varXMLarouxAMJp174556114.bipolar(wave * DC.ar(0.52581918239594)), Silent.ar());
varXMLarouxAMJp1745569 = Maxamp.ar(t_trig, varXMLarouxAMJp17455610 * modX);
varXMLarouxAMJp17455610 = OSTrunc4.ar(0.35065793991089 * env * signal, varXMLarouxAMJp174556112);
varXMLarouxAMJp17455611 = LFBrownNoise0.ar(varXMLarouxAMJp17455610 * in, 0.56941378116608 * signal * in, wave, 0.98373700866809 * varXMLarouxAMJp174556114 * modX, Silent.ar());
// Variation test code
	varXMLarouxAMJp174556112 = BFEncode2.ar(modZ, varXMLarouxAMJp174556113 * gateEnv, in, 0.17224204540253 * CombC.ar(varXMLarouxAMJp17455611 * DC.ar(0.15721344947815), 0.25, (varXMLarouxAMJp17455610 * DC.ar(0.11392998695374)).abs.max(0.0001).min(0.25), varXMLarouxAMJp1745569 * DC.ar(0.12659931182861), varXMLarouxAMJp17455610 * DC.ar(0.22474205493927), varXMLarouxAMJp17455611 * DC.ar(0.85394215583801)), varXMLarouxAMJp17455611, varXMLarouxAMJp1745569);
	varXMLarouxAMJp174556113 = GrainSin.ar(2, env, (varXMLarouxAMJp17455611 * varXMLarouxAMJp174556112).lag, FoaTilt.ar(varXMLarouxAMJp1745569 * DC.ar(0.010325908660889), varXMLarouxAMJp17455611 * DC.ar(0.52912938594818), varXMLarouxAMJp17455610 * DC.ar(0.60909461975098), varXMLarouxAMJp1745569 * DC.ar(0.50148725509644)).exprange(1, SampleRate.ir), varXMLarouxAMJp1745569 * gateEnv, bufnum, 0.47285389900208 * modX, 0.99929689358285 * signal * varXMLarouxAMJp17455611, Silent.ar());
varXMLarouxAMJp174556114 = APF.ar(gateEnv, signal, x, modX, Silent.ar());
varXMLarouxAMJp174556112 = LeastChange.ar(gate, varXMLarouxAMJp17455611);
varXMLarouxAMJp174556113 = Lag2.ar(x, 0.88786733150482 * GbmanTrig.ar(varXMLarouxAMJp1745569 * DC.ar(0.050983071327209), varXMLarouxAMJp17455611 * DC.ar(0.38179218769073), varXMLarouxAMJp17455611 * DC.ar(0.853196144104), varXMLarouxAMJp1745569 * DC.ar(0.12995588779449), varXMLarouxAMJp1745569 * DC.ar(0.56599378585815), varXMLarouxAMJp17455610 * DC.ar(0.61395144462585)), 0.92070040101802 * modX * modZ, Silent.ar());
varXMLarouxAMJp174556114 = LFBrownNoise0.ar(env * in, signal, amp, 0.99996825623966 * modX * varXMLarouxAMJp174556112, Silent.ar());
varXMLarouxAMJp174556112 = DoubleWell2.ar(varXMLarouxAMJp17455611, varXMLarouxAMJp174556114 * modX, varXMLarouxAMJp174556113, modX, gate, modZ * modY, 0.72119617462158 * modX * varXMLarouxAMJp17455610, gateEnv, 0.99683268035343 * wave * varXMLarouxAMJp174556113, Silent.ar().expexp(varXMLarouxAMJp1745569 * DC.ar(0.532186627388), varXMLarouxAMJp1745569 * DC.ar(0.98893523216248), varXMLarouxAMJp17455611 * DC.ar(0.69522607326508), varXMLarouxAMJp17455611 * DC.ar(0.12098729610443), varXMLarouxAMJp17455610 * DC.ar(0.40275168418884)));
varXMLarouxAMJp174556113 = BufAllpassL.ar(Array.fill(2.pow(11), { |i| rrand(-1, 1) }).as(LocalBuf), LPZ1.ar(varXMLarouxAMJp174556112 * varXMLarouxAMJp17455611, wave, Silent.ar()), 0.55533194541931 * varXMLarouxAMJp174556113 * gateEnv, varXMLarouxAMJp174556112 * modZ, varXMLarouxAMJp1745569, FBSineN.ar(varXMLarouxAMJp17455611 * DC.ar(0.1082546710968), varXMLarouxAMJp17455610 * DC.ar(0.84017527103424), varXMLarouxAMJp1745569 * DC.ar(0.33298552036285), varXMLarouxAMJp1745569 * DC.ar(0.11041402816772), varXMLarouxAMJp1745569 * DC.ar(0.073888897895813), varXMLarouxAMJp17455610 * DC.ar(0.81902015209198), varXMLarouxAMJp17455611 * DC.ar(0.3339695930481), varXMLarouxAMJp17455610 * DC.ar(0.16849339008331), varXMLarouxAMJp17455611 * DC.ar(0.55838298797607)));
varXMLarouxAMJp174556114 = Impulse.ar(varXMLarouxAMJp17455611, signal * varXMLarouxAMJp174556114, 0.99988793182828 * VMScan2D.ar(varXMLarouxAMJp17455610 * DC.ar(0.77243316173553), varXMLarouxAMJp17455611 * DC.ar(0.32252824306488), varXMLarouxAMJp17455610 * DC.ar(0.084136128425598)), Silent.ar());

signal = varXMLarouxAMJp174556114;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// Zorm.1123174600
/////////////////////////////////////////////////////////

SynthDef.new("Zorm.1123174600", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varZorm11231746009, varZorm112317460010;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varZorm11231746009 = varZorm112317460010 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.25), ExpRand(0.05, 2)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         env.linlin(0, 1, [modX * 72, modZ * 72], modY * 72),
                         env.linlin(0, 1, [modZ * 72, modX * 72], modY * 72),
                         72,
                         72
                        );

                        wave = in + wave * env;


// Generated prototype body code
varZorm11231746009 = NestedAllpassN.ar(env, varZorm11231746009, wave, env * modX, modY * varZorm112317460010, modX * modZ, varZorm112317460010 * signal, 0.99993995295481 * gateEnv * signal, Silent.ar());
varZorm112317460010 = PV_JensenAndersen.ar(Array.fill(2.pow(10), { |i| rrand(-1, 1) }).as(LocalBuf), modX, modY * varZorm112317460010, 0.12721526622772 * gateEnv * varZorm112317460010, env * modY, varZorm11231746009 * modX, varZorm11231746009);
varZorm11231746009 = BFEncode1.ar(wave * DC.ar(0.073047757148743), wave * DC.ar(0.89324152469635), wave * DC.ar(0.69237720966339), wave * DC.ar(0.60068500041962), wave * DC.ar(0.56722986698151), wave * DC.ar(0.23436641693115));
varZorm112317460010 = LFClipNoise.ar(wave * DC.ar(0.097043633460999), wave * DC.ar(0.44351100921631), wave * DC.ar(0.62778067588806));

signal = varZorm112317460010;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");


/////////////////////////////////////////////////////////
// Xiangi.1664174602
/////////////////////////////////////////////////////////

SynthDef.new("Xiangi.1664174602", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varXiangi16641746029;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varXiangi16641746029 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.25), ExpRand(0.05, 2)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         env.linlin(0, 1, [modX * 72, modZ * 72], modY * 72),
                         env.linlin(0, 1, [modZ * 72, modX * 72], modY * 72),
                         72,
                         72
                        );

                        wave = in + wave * env;


// Generated prototype body code
varXiangi16641746029 = PinkNoise.ar(wave, Silent.ar().clip(wave * DC.ar(0.23956477642059), wave * DC.ar(0.1359224319458)));
varXiangi16641746029 = Perlin3.ar(wave * wave, env, wave);

signal = varXiangi16641746029;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");



/////////////////////////////////////////////////////////
// Chelle.2397174607
/////////////////////////////////////////////////////////

SynthDef.new("Chelle.2397174607", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varChelle23971746079;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varChelle23971746079 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.25), ExpRand(0.05, 2)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         env.linlin(0, 1, [modX * 72, modZ * 72], modY * 72),
                         env.linlin(0, 1, [modZ * 72, modX * 72], modY * 72),
                         72,
                         72
                        );

                        wave = in + wave * env;


// Generated prototype body code
varChelle23971746079 = YigClifford3DL.ar(wave * env, env * signal, in * in.sqrsum(RunningMax.ar(wave * DC.ar(0.31131970882416), wave * DC.ar(0.98374962806702))), varChelle23971746079 * signal, amp, modZ.clip(wave * DC.ar(0.5466331243515), wave * DC.ar(0.93191134929657)), island, bufnum, 0.99391759744963 * in * modZ, Silent.ar());
varChelle23971746079 = RedDPCMencode.ar(wave * DC.ar(0.60056853294373), wave * DC.ar(0.3599705696106));

signal = varChelle23971746079;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");





/////////////////////////////////////////////////////////
// Whitey174622
/////////////////////////////////////////////////////////

SynthDef.new("Whitey174622", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varWhitey1746229, varWhitey17462210;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varWhitey1746229 = varWhitey17462210 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.25), ExpRand(0.05, 2)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         env.linlin(0, 1, [modX * 72, modZ * 72], modY * 72),
                         env.linlin(0, 1, [modZ * 72, modX * 72], modY * 72),
                         72,
                         72
                        );

                        wave = in + wave * env;


// Generated prototype body code
varWhitey1746229 = DoubleWell2.ar(z, x, x, modY * wave, varWhitey1746229.gcd(BufGrainBBF.ar(env, wave * DC.ar(0.26944899559021), wave * DC.ar(0.27266442775726), wave * DC.ar(0.59751307964325), wave * DC.ar(0.069399118423462), wave * DC.ar(0.36663901805878), wave * DC.ar(0.1769415140152), wave * DC.ar(0.3077152967453), wave * DC.ar(0.9012907743454), wave * DC.ar(0.95442759990692), wave * DC.ar(0.69382750988007), wave * DC.ar(0.25538218021393), wave * DC.ar(0.13940584659576))), in * modZ, in, env, 0.95634301399457 * in * in, Silent.ar());
varWhitey17462210 = BBandStop.ar(y, signal * in, SinGrain.ar(env, z, FSinOsc.ar(wave * DC.ar(0.11727023124695), wave * DC.ar(0.58982181549072), wave * DC.ar(0.59484720230103), wave * DC.ar(0.44105982780457)).exprange(1, SampleRate.ir), Stepper.ar(wave * DC.ar(0.84831595420837), wave * DC.ar(0.71499347686768), wave * DC.ar(0.4348578453064), wave * DC.ar(0.55864524841309), wave * DC.ar(0.50092339515686), wave * DC.ar(0.82441711425781)), Atari2600.ar(wave * DC.ar(0.64605057239532), wave * DC.ar(0.82487964630127), wave * DC.ar(0.43744003772736), wave * DC.ar(0.078419804573059), wave * DC.ar(0.93294966220856), wave * DC.ar(0.31238901615143), wave * DC.ar(0.90780973434448))), FSinOsc.ar(wave * DC.ar(0.26759302616119), wave * DC.ar(0.96864783763885), wave * DC.ar(0.24364054203033), wave * DC.ar(0.49881160259247)), Silent.ar());
varWhitey1746229 = YigClifford3DN.ar(LFBrownNoise1.ar(wave * DC.ar(0.50349497795105), wave * DC.ar(0.72244954109192), wave * DC.ar(0.010698437690735), wave * DC.ar(0.54242789745331), wave * DC.ar(0.95562553405762)).exprange(1, SampleRate.ir), signal, y, wave * signal, 0.51280474662781 * wave * modZ, modY, signal, modZ * wave, 0.99975444162577 * modX * in, Silent.ar());
varWhitey17462210 = GbmanL.ar(wave * DC.ar(0.35945796966553), wave * DC.ar(0.015637397766113), wave * DC.ar(0.040817618370056), wave * DC.ar(0.69066298007965), wave * DC.ar(0.37221038341522));

signal = varWhitey17462210;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// Jeru.CVEX.5120.C174624
/////////////////////////////////////////////////////////

SynthDef.new("Jeru.CVEX.5120.C174624", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varJeruCVEX5120C1746249;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varJeruCVEX5120C1746249 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.25), ExpRand(0.05, 2)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         env.linlin(0, 1, [modX * 72, modZ * 72], modY * 72),
                         env.linlin(0, 1, [modZ * 72, modX * 72], modY * 72),
                         72,
                         72
                        );

                        wave = in + wave * env;


// Generated prototype body code
varJeruCVEX5120C1746249 = BufRd.ar(2, Array.fill(2.pow(16), { |i| rrand(-1, 1) }).as(LocalBuf), varJeruCVEX5120C1746249 * gateEnv, modZ * modX, varJeruCVEX5120C1746249 * wave);
varJeruCVEX5120C1746249 = FoaTilt.ar(modX, LinPan2.ar(wave * DC.ar(0.025245308876038), wave * DC.ar(0.85980188846588), wave * DC.ar(0.54020500183105)), Balance.ar(wave * DC.ar(0.16689658164978), wave * DC.ar(0.16800546646118), wave * DC.ar(0.62451708316803), wave * DC.ar(0.12435245513916), wave * DC.ar(0.25637483596802), wave * DC.ar(0.71820724010468)), Silent.ar());

signal = varJeruCVEX5120C1746249;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// BadBoy.1000.K174631
/////////////////////////////////////////////////////////

SynthDef.new("BadBoy.1000.K174631", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varBadBoy1000K1746319, varBadBoy1000K17463110, varBadBoy1000K17463111;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varBadBoy1000K1746319 = varBadBoy1000K17463110 = varBadBoy1000K17463111 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.25), ExpRand(0.05, 2)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         env.linlin(0, 1, [modX * 72, modZ * 72], modY * 72),
                         env.linlin(0, 1, [modZ * 72, modX * 72], modY * 72),
                         72,
                         72
                        );

                        wave = in + wave * env;


// Generated prototype body code
varBadBoy1000K1746319 = RunningMin.ar(modZ * gateEnv, modZ * varBadBoy1000K17463111);
varBadBoy1000K17463110 = SetResetFF.ar(signal * varBadBoy1000K1746319, amp);
varBadBoy1000K17463111 = FMHEncode2.ar(varBadBoy1000K17463111, 0.70230436325073 * varBadBoy1000K17463110 * varBadBoy1000K1746319, varBadBoy1000K17463111, modZ * wave, z, 0.42193746566772 * Friction.ar(wave * DC.ar(0.79389715194702), wave * DC.ar(0.19421577453613), wave * DC.ar(0.17569005489349), wave * DC.ar(0.25870227813721), wave * DC.ar(0.81203949451447), wave * DC.ar(0.057960152626038), wave * DC.ar(0.3289053440094), wave * DC.ar(0.37544405460358)));
varBadBoy1000K1746319 = Spreader.ar(modX, varBadBoy1000K17463110, varBadBoy1000K17463111 * modY, 0.97359417766471 * modX * env, Silent.ar());
varBadBoy1000K17463110 = LPF18.ar(0.58646011352539 * in * varBadBoy1000K17463110, modY, modY * env.unipolar(wave * DC.ar(0.53029954433441)), signal * in);
varBadBoy1000K17463111 = varBadBoy1000K17463110;

signal = varBadBoy1000K17463111;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// Verwolf.3202.b174631
/////////////////////////////////////////////////////////

SynthDef.new("Verwolf.3202.b174631", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varVerwolf3202b1746319;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varVerwolf3202b1746319 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.25), ExpRand(0.05, 2)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         env.linlin(0, 1, [modX * 72, modZ * 72], modY * 72),
                         env.linlin(0, 1, [modZ * 72, modX * 72], modY * 72),
                         72,
                         72
                        );

                        wave = in + wave * env;


// Generated prototype body code
varVerwolf3202b1746319 = FoaZoomZ.ar(bufnum, in * signal, BLowPass.ar(wave * DC.ar(0.2929368019104), wave * DC.ar(0.40237867832184), wave * DC.ar(0.013041615486145), wave * DC.ar(0.90840327739716), wave * DC.ar(0.30610764026642)), Silent.ar());
varVerwolf3202b1746319 = TermanWang.ar(signal, wave, varVerwolf3202b1746319, 0.95128262042999 * env * signal, y, z, modZ * signal, signal * varVerwolf3202b1746319, 0.24664628505707 * modX * modX, 0.99989117951284 * modX * in);

signal = varVerwolf3202b1746319;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// W32.Netsky.Z@mm174631
/////////////////////////////////////////////////////////

SynthDef.new("W32.Netsky.Z@mm174631", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varW32NetskyZmm1746319;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varW32NetskyZmm1746319 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.25), ExpRand(0.05, 2)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         env.linlin(0, 1, [modX * 72, modZ * 72], modY * 72),
                         env.linlin(0, 1, [modZ * 72, modX * 72], modY * 72),
                         72,
                         72
                        );

                        wave = in + wave * env;


// Generated prototype body code
varW32NetskyZmm1746319 = SMS.ar(0.44688725471497 * in * gateEnv, gateEnv, modX * modX, in, modX, 0.99998446975135 * Spreader.ar(wave * DC.ar(0.72218632698059), wave * DC.ar(0.39408874511719), wave * DC.ar(0.88240420818329), wave * DC.ar(0.86582636833191), wave * DC.ar(0.38007283210754)), Silent.ar(), bufnum, signal * in.mod(LFDNoise3.ar(wave * DC.ar(0.80557560920715), wave * DC.ar(0.75066244602203), wave * DC.ar(0.9886509180069))), 0.99998595237 * signal, Array.fill(2.pow(10), { |i| rrand(-1, 1) }).as(LocalBuf).lincurve(wave * DC.ar(0.5463947057724), wave * DC.ar(0.11677932739258), wave * DC.ar(0.010632157325745), wave * DC.ar(0.81463575363159), wave * DC.ar(0.69182622432709), wave * DC.ar(0.40754616260529)), modX, Silent.ar());
varW32NetskyZmm1746319 = Lag2UD.ar(wave * DC.ar(0.95181214809418), wave * DC.ar(0.0090759992599487), wave * DC.ar(0.82742691040039), wave * DC.ar(0.13122141361237), wave * DC.ar(0.67351198196411));

signal = varW32NetskyZmm1746319;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");



/////////////////////////////////////////////////////////
// PS-MPC.Greetings174635
/////////////////////////////////////////////////////////

SynthDef.new("PS-MPC.Greetings174635", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varPSMPCGreetings1746359;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varPSMPCGreetings1746359 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.25), ExpRand(0.05, 2)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         env.linlin(0, 1, [modX * 72, modZ * 72], modY * 72),
                         env.linlin(0, 1, [modZ * 72, modX * 72], modY * 72),
                         72,
                         72
                        );

                        wave = in + wave * env;


// Generated prototype body code
varPSMPCGreetings1746359 = FincoSprottL.ar(varPSMPCGreetings1746359, wave, y.difsqr(DoubleWell.ar(wave * DC.ar(0.40947902202606), wave * DC.ar(0.29062235355377), wave * DC.ar(0.21105802059174), wave * DC.ar(0.95644080638885), wave * DC.ar(0.66980540752411), wave * DC.ar(0.79945123195648), wave * DC.ar(0.79534924030304), wave * DC.ar(0.08618426322937), wave * DC.ar(0.99436902999878), wave * DC.ar(0.36090111732483))), LPF18.ar(wave * DC.ar(0.41582846641541), wave * DC.ar(0.0027302503585815), wave * DC.ar(0.32210838794708), wave * DC.ar(0.37783181667328)), 0.84399235248566 * env * modZ, gateEnv * in, MZPokey.ar(wave * DC.ar(0.7986912727356), wave * DC.ar(0.084652066230774), wave * DC.ar(0.031649708747864), wave * DC.ar(0.45812833309174), wave * DC.ar(0.38163661956787), wave * DC.ar(0.50940299034119), wave * DC.ar(0.64250218868256), wave * DC.ar(0.44420528411865), wave * DC.ar(0.58928728103638)), Silent.ar());
varPSMPCGreetings1746359 = AmplitudeMod.ar(wave * DC.ar(0.36590933799744), wave * DC.ar(0.91453659534454), wave * DC.ar(0.32963955402374), wave * DC.ar(0.22954475879669), wave * DC.ar(0.088265180587769));

signal = varPSMPCGreetings1746359;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// AOS.Reaper.629174636
/////////////////////////////////////////////////////////

SynthDef.new("AOS.Reaper.629174636", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varAOSReaper6291746369, varAOSReaper62917463610;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varAOSReaper6291746369 = varAOSReaper62917463610 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.25), ExpRand(0.05, 2)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         env.linlin(0, 1, [modX * 72, modZ * 72], modY * 72),
                         env.linlin(0, 1, [modZ * 72, modX * 72], modY * 72),
                         72,
                         72
                        );

                        wave = in + wave * env;


// Generated prototype body code
varAOSReaper6291746369 = InGrainBF.ar(env, modZ, 0.66345846652985 * in * varAOSReaper62917463610, varAOSReaper6291746369 * gateEnv, signal * wave, FhnTrig.ar(wave * DC.ar(0.21991968154907), wave * DC.ar(0.095365762710571), wave * DC.ar(0.95671093463898), wave * DC.ar(0.50320112705231), wave * DC.ar(0.90032947063446), wave * DC.ar(0.89542675018311), wave * DC.ar(0.90705990791321), wave * DC.ar(0.41636192798615), wave * DC.ar(0.50506246089935), wave * DC.ar(0.15991961956024), wave * DC.ar(0.52471244335175)), signal * in, 0.93290921424655 * modY * varAOSReaper6291746369, Silent.ar());
varAOSReaper62917463610 = SVF.ar(env, 0.63049244880676 * env, amp, modY * signal, x, varAOSReaper6291746369 * in, 0.4040002822876 * signal * modX, modZ * in, 0.99992831508677 * varAOSReaper6291746369 * in, Silent.ar());
varAOSReaper6291746369 = FoaFocusY.ar(wave * DC.ar(0.026978373527527), wave * DC.ar(0.80287730693817), wave * DC.ar(0.029837131500244), wave * DC.ar(0.32394933700562));
varAOSReaper62917463610 = GbmanTrig.ar(wave * DC.ar(0.35580396652222), wave * DC.ar(0.46659409999847), wave * DC.ar(0.42845571041107), wave * DC.ar(0.43622541427612), wave * DC.ar(0.87162601947784), wave * DC.ar(0.50339496135712));

signal = varAOSReaper62917463610;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// BAT.GoodBy.A174639
/////////////////////////////////////////////////////////

SynthDef.new("BAT.GoodBy.A174639", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varBATGoodByA1746399, varBATGoodByA17463910, varBATGoodByA17463911;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varBATGoodByA1746399 = varBATGoodByA17463910 = varBATGoodByA17463911 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.25), ExpRand(0.05, 2)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         env.linlin(0, 1, [modX * 72, modZ * 72], modY * 72),
                         env.linlin(0, 1, [modZ * 72, modX * 72], modY * 72),
                         72,
                         72
                        );

                        wave = in + wave * env;


// Generated prototype body code
varBATGoodByA1746399 = GbmanN.ar(gateEnv, signal, env, Streson.ar(wave * DC.ar(0.90791296958923), wave * DC.ar(0.5868616104126), wave * DC.ar(0.37398660182953), wave * DC.ar(0.054423332214355), wave * DC.ar(0.65303719043732)), Silent.ar());
varBATGoodByA17463910 = LFDNoise3.ar(gateEnv * varBATGoodByA17463911, 0.18554315647256 * varBATGoodByA17463911 * gateEnv, Silent.ar());
varBATGoodByA17463911 = ArrayMax.ar([BHiPass.ar(wave * DC.ar(0.88212907314301), wave * DC.ar(0.52902555465698), wave * DC.ar(0.70194661617279), wave * DC.ar(0.90572917461395), wave * DC.ar(0.19211041927338)), Lag2UD.ar(wave * DC.ar(0.14080476760864), wave * DC.ar(0.27688431739807), wave * DC.ar(0.56163203716278), wave * DC.ar(0.56025433540344), wave * DC.ar(0.95329821109772))]);
	varBATGoodByA1746399 = BufGrainI.ar(env, env, bufnum, modZ * signal, in * in, bufnum, bufnum, modZ * varBATGoodByA1746399, varBATGoodByA17463910 * modZ, OSTrunc8.ar(wave * DC.ar(0.55028998851776), wave * DC.ar(0.40519785881042)), Silent.ar());
varBATGoodByA17463910 = RedLbyl.ar(varBATGoodByA17463911, modZ * modX, modY);
varBATGoodByA17463911 = MoogFF.ar(modX * modY, varBATGoodByA1746399, y, gateEnv * varBATGoodByA1746399, 0.99972051267137 * varBATGoodByA1746399 * signal, Silent.ar());

signal = varBATGoodByA17463911;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// Proto.1799174647
/////////////////////////////////////////////////////////

SynthDef.new("Proto.1799174647", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varProto17991746479, varProto179917464710, varProto179917464711;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varProto17991746479 = varProto179917464710 = varProto179917464711 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.25), ExpRand(0.05, 2)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         env.linlin(0, 1, [modX * 72, modZ * 72], modY * 72),
                         env.linlin(0, 1, [modZ * 72, modX * 72], modY * 72),
                         72,
                         72
                        );

                        wave = in + wave * env;


// Generated prototype body code
varProto17991746479 = PeakEQ4.ar(signal, BufCombN.ar(wave * DC.ar(0.52202439308167), wave * DC.ar(0.7717113494873), wave * DC.ar(0.97930335998535), wave * DC.ar(0.58494853973389), wave * DC.ar(0.43691611289978), wave * DC.ar(0.53056347370148)).exprange(1, SampleRate.ir), 0.79741036891937 * modY * signal, varProto179917464710 * in);
varProto179917464710 = Spreader.ar(bufnum, wave * wave, FoaZoomY.ar(wave * DC.ar(0.27919125556946), wave * DC.ar(0.80076789855957), wave * DC.ar(0.66109323501587), wave * DC.ar(0.68205940723419)), gateEnv, Silent.ar());
varProto179917464711 = RLPF.ar(in * varProto179917464711, varProto17991746479, signal * varProto179917464710, 0.9988673869676 * modZ * gateEnv, Silent.ar());
varProto17991746479 = FoaDominateY.ar(modZ * gateEnv, modY, 0.15488204117819 * modX * modZ, LPF18.ar(wave * DC.ar(0.49198770523071), wave * DC.ar(0.1549346446991), wave * DC.ar(0.50179958343506), wave * DC.ar(0.62355351448059)));
varProto179917464710 = FoaTumble.ar(wave * DC.ar(0.66212046146393), wave * DC.ar(0.054680347442627), wave * DC.ar(0.5375269651413), wave * DC.ar(0.37028777599335));
varProto179917464711 = SineShaper.ar(wave * DC.ar(0.98046612739563), wave * DC.ar(0.044996380805969), wave * DC.ar(0.78083062171936), wave * DC.ar(0.19002568721771));

signal = varProto179917464711;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// W97M.BPTK174649
/////////////////////////////////////////////////////////

SynthDef.new("W97M.BPTK174649", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varW97MBPTK1746499;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varW97MBPTK1746499 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.25), ExpRand(0.05, 2)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         env.linlin(0, 1, [modX * 72, modZ * 72], modY * 72),
                         env.linlin(0, 1, [modZ * 72, modX * 72], modY * 72),
                         72,
                         72
                        );

                        wave = in + wave * env;


// Generated prototype body code
varW97MBPTK1746499 = Standard2DN.ar(signal * modY, in, env, signal * wave, gateEnv * in, Hasher.ar(wave * DC.ar(0.59476518630981), wave * DC.ar(0.56497311592102), wave * DC.ar(0.1245539188385)), Silent.ar());
varW97MBPTK1746499 = AudioMSG.ar(wave * DC.ar(0.51095998287201), wave * DC.ar(0.2094452381134), wave * DC.ar(0.74232709407806), wave * DC.ar(0.28800618648529));

signal = varW97MBPTK1746499;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// BAT.Com.4481746511
/////////////////////////////////////////////////////////

SynthDef.new("BAT.Com.4481746511", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varBATCom4481746519, varBATCom44817465110, varBATCom448174651111, varBATCom448174651112, varBATCom448174651113, varBATCom448174651114, varBATCom448174651115;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varBATCom4481746519 = varBATCom44817465110 = varBATCom448174651111 = varBATCom448174651112 = varBATCom448174651113 = varBATCom448174651114 = varBATCom448174651115 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.25), ExpRand(0.05, 2)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         env.linlin(0, 1, [modX * 72, modZ * 72], modY * 72),
                         env.linlin(0, 1, [modZ * 72, modX * 72], modY * 72),
                         72,
                         72
                        );

                        wave = in + wave * env;


// Generated prototype body code
varBATCom4481746519 = DiskIn.ar(2, Array.fill(2.pow(11), { |i| rrand(-1, 1) }).as(LocalBuf), varBATCom4481746519);
varBATCom44817465110 = Brusselator.ar(0.74680387973785 * varBATCom448174651111 * signal, z, 0.62408709526062 * varBATCom448174651114 * varBATCom448174651113, varBATCom44817465110, 0.20770084857941 * signal * modY, modZ * varBATCom448174651112, 0.99992574902501 * modX * gateEnv, Silent.ar());
varBATCom4481746519 = LastValue.ar(varBATCom448174651112 * gateEnv, varBATCom448174651112 * gateEnv);
varBATCom44817465110 = FoaDominateZ.ar(0.36045026779175 * modZ * varBATCom44817465110, x, BFDecode1.ar(wave * DC.ar(0.99967110157013), wave * DC.ar(0.54432237148285), wave * DC.ar(0.72938990592957), wave * DC.ar(0.29138267040253), wave * DC.ar(0.14871275424957), wave * DC.ar(0.3083416223526), wave * DC.ar(0.60064041614532), wave * DC.ar(0.32607555389404), wave * DC.ar(0.75244033336639)), Silent.ar());
// Variation test code
	varBATCom448174651111 = varBATCom44817465110;/*SinGrainIBF.ar(env, modZ * varBATCom448174651115, env * env, bufnum, bufnum, varBATCom44817465110, in * in, varBATCom4481746519 * varBATCom448174651115, varBATCom448174651113, modY * varBATCom448174651113, AudioMSG.ar(varBATCom4481746519 * DC.ar(0.3825306892395), varBATCom4481746519 * DC.ar(0.84196424484253), varBATCom44817465110 * DC.ar(0.91836655139923), varBATCom44817465110 * DC.ar(0.07641613483429)), Silent.ar());
varBATCom448174651112 = StandardN.ar(modX * wave, 0.32622003555298 * wave * varBATCom448174651111, wave * wave, gate, varBATCom44817465110, Silent.ar());
varBATCom448174651113 = Ramp.ar(gateEnv * modZ, varBATCom448174651114 * varBATCom448174651113, 0.99988006724105 * varBATCom448174651114 * varBATCom448174651112, Silent.ar());*/
varBATCom448174651114 = StandardL.ar(varBATCom448174651113, 0.02556848526001 * in * modY, in * varBATCom448174651113, varBATCom448174651113 * modZ, 0.99958232723342 * wave * modZ, Silent.ar());
varBATCom448174651115 = Latch.ar(bufnum, FoaPsychoShelf.ar(varBATCom44817465110 * DC.ar(0.71482181549072), varBATCom4481746519 * DC.ar(0.32070243358612), varBATCom44817465110 * DC.ar(0.55917084217072), varBATCom4481746519 * DC.ar(0.64844727516174), varBATCom44817465110 * DC.ar(0.72661221027374), varBATCom44817465110 * DC.ar(0.96301031112671)));
varBATCom448174651111 = IIRFilter.ar(x, varBATCom448174651112 * modY, env, wave, Silent.ar());
varBATCom448174651112 = Friction.ar(gateEnv, varBATCom44817465110 * varBATCom448174651114, amp, wave * varBATCom448174651114, varBATCom448174651115, BRF.ar(gateEnv, modX, 0.49308776855469 * RLPF.ar(varBATCom44817465110 * DC.ar(0.30157923698425), varBATCom44817465110 * DC.ar(0.11790204048157), varBATCom44817465110 * DC.ar(0.61797511577606), varBATCom4481746519 * DC.ar(0.72573494911194), varBATCom4481746519 * DC.ar(0.50628781318665)), gateEnv, Silent.ar()), 0.84967287738764 * varBATCom448174651112 * varBATCom448174651115, Silent.ar());
varBATCom448174651113 = BBlockerBuf.ar(varBATCom448174651114 * in, Array.fill(2.pow(15), { |i| rrand(-1, 1) }).as(LocalBuf), varBATCom448174651112);
varBATCom448174651114 = BufCombL.ar(Array.fill(2.pow(13), { |i| rrand(-1, 1) }).as(LocalBuf), varBATCom448174651111 * env, 0.50016403198242 * signal * modZ, modY * modZ, 0.97637540956626 * wave * varBATCom448174651114, Silent.ar());
varBATCom448174651115 = SelectL.ar(gate, [LFNoise0.ar(varBATCom4481746519 * DC.ar(0.30008590221405), varBATCom44817465110 * DC.ar(0.55992364883423), varBATCom4481746519 * DC.ar(0.11495006084442)), B2A.ar(varBATCom4481746519 * DC.ar(0.076642274856567), varBATCom44817465110 * DC.ar(0.64617538452148), varBATCom44817465110 * DC.ar(0.68682134151459), varBATCom4481746519 * DC.ar(0.66141486167908))]);
varBATCom448174651111 = FitzHughNagumo.ar(signal * in, varBATCom448174651115, env, env, wave * varBATCom448174651113, in * varBATCom448174651113, varBATCom448174651114, 0.99997474456589 * LatoocarfianC.ar(varBATCom4481746519 * DC.ar(0.9786297082901), varBATCom44817465110 * DC.ar(0.98413872718811), varBATCom4481746519 * DC.ar(0.32320690155029), varBATCom44817465110 * DC.ar(0.15876042842865), varBATCom4481746519 * DC.ar(0.67516124248505), varBATCom44817465110 * DC.ar(0.2078253030777), varBATCom4481746519 * DC.ar(0.64620447158813), varBATCom4481746519 * DC.ar(0.83622205257416), varBATCom44817465110 * DC.ar(0.22526788711548)), Silent.ar());
varBATCom448174651112 = TDuty.ar(modZ.curvelin(varBATCom4481746519 * DC.ar(0.77625370025635), varBATCom4481746519 * DC.ar(0.88484442234039), varBATCom44817465110 * DC.ar(0.98627805709839), varBATCom4481746519 * DC.ar(0.19285011291504), varBATCom4481746519 * DC.ar(0.31844592094421), varBATCom44817465110 * DC.ar(0.69712316989899)), varBATCom448174651112, modY, signal, gateEnv);
varBATCom448174651113 = BinData.ar(Array.fill(2.pow(15), { |i| rrand(-1, 1) }).as(LocalBuf), t_trig, varBATCom448174651115 * in);
varBATCom448174651114 = Nes2.ar(signal * modY, varBATCom44817465110 * in, BPZ2.ar(modZ * gateEnv, varBATCom448174651111, Silent.ar()), signal * env, in, varBATCom448174651114 * varBATCom448174651115, varBATCom448174651112, env * varBATCom448174651112, 0.7910932302475 * varBATCom4481746519 * modY, gate, modX * varBATCom448174651114, varBATCom448174651112 * varBATCom448174651115, wave * varBATCom448174651111, t_trig, varBATCom448174651114, signal * in.wrap(varBATCom4481746519 * DC.ar(0.17996549606323), varBATCom44817465110 * DC.ar(0.19348394870758)), Sweep.ar(SineShaper.ar(varBATCom44817465110 * DC.ar(0.28445947170258), varBATCom4481746519 * DC.ar(0.59385597705841), varBATCom4481746519 * DC.ar(0.44478166103363), varBATCom44817465110 * DC.ar(0.48135673999786)), modZ * gateEnv), varBATCom448174651113 * signal, y, 0.86283206939697 * env * varBATCom448174651115);
varBATCom448174651115 = VarSaw.ar(varBATCom448174651112 * wave, modY * varBATCom448174651112, env, varBATCom448174651111, Silent.ar());

signal = varBATCom448174651115;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");

/////////////////////////////////////////////////////////
// Szoveg.959233024
/////////////////////////////////////////////////////////

SynthDef.new("Szoveg.959233024", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varSzoveg9592330249;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varSzoveg9592330249 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[0.0001, modY.linexp(0, 1, 0.001, modY.linexp(0, 1, 0.1, 1))], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         (Phasor.ar(0, modY * 72, 0, 72) + (in * 72)) % 73,
                         (Phasor.ar(0, modY * 72, 0, 72) + (in * 72)) % 73,
                         72,
                         72
                        );

			wave = wave + in + Decay.ar(t_trig, 0.1, PinkNoise.ar);


// Generated prototype body code
varSzoveg9592330249 = EnvFollow.ar(varSzoveg9592330249, amp, in, Silent.ar());
varSzoveg9592330249 = LPZ1.ar(in * env, env, Silent.ar());

signal = varSzoveg9592330249;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");


/*

/////////////////////////////////////////////////////////
// Adware.Coolpp2330201
/////////////////////////////////////////////////////////

SynthDef.new("Adware.Coolpp2330201", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varAdwareCoolpp2330209, varAdwareCoolpp23302010, varAdwareCoolpp23302011, varAdwareCoolpp233020112, varAdwareCoolpp233020113;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varAdwareCoolpp2330209 = varAdwareCoolpp23302010 = varAdwareCoolpp23302011 = varAdwareCoolpp233020112 = varAdwareCoolpp233020113 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[0.0001, modY.linexp(0, 1, 0.001, modY.linexp(0, 1, 0.1, 1))], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         (Phasor.ar(0, modY * 72, 0, 72) + (in * 72)) % 73,
                         (Phasor.ar(0, modY * 72, 0, 72) + (in * 72)) % 73,
                         72,
                         72
                        );

			wave = wave + in + Decay.ar(t_trig, 0.1, PinkNoise.ar);


// Generated prototype body code
varAdwareCoolpp2330209 = HenonN.ar(SanityCheck2.ar(wave * DC.ar(0.0067735910415649)).exprange(1, SampleRate.ir), varAdwareCoolpp2330209 * modX, x, wave * varAdwareCoolpp23302011, signal, IIRFilter.ar(wave * DC.ar(0.86041641235352), wave * DC.ar(0.044792413711548), wave * DC.ar(0.37058389186859), wave * DC.ar(0.91746842861176), wave * DC.ar(0.36565291881561)), Silent.ar());
varAdwareCoolpp23302010 = OffsetOut.ar((80 + (island * 2)), [LTI.ar(wave * DC.ar(0.84145557880402), wave * DC.ar(0.8408203125), wave * DC.ar(0.33424925804138), wave * DC.ar(0.76125013828278), wave * DC.ar(0.68659174442291)), OscN.ar(wave * DC.ar(0.71262192726135), wave * DC.ar(0.87664091587067), wave * DC.ar(0.89948093891144), wave * DC.ar(0.56451714038849), wave * DC.ar(0.28309988975525))]);
varAdwareCoolpp23302011 = BFEncodeSter.ar(varAdwareCoolpp2330209 * modZ, modY * modZ, 0.38497674465179 * modX, varAdwareCoolpp233020113, modY * modZ, varAdwareCoolpp2330209 * modZ, signal * wave, varAdwareCoolpp233020113 * varAdwareCoolpp233020113);
varAdwareCoolpp2330209 = HenonTrig.ar(wave * DC.ar(0.47566890716553), wave * DC.ar(0.86007452011108), wave * DC.ar(0.4252063035965), wave * DC.ar(0.32619571685791), wave * DC.ar(0.51528787612915), wave * DC.ar(0.061101078987122), wave * DC.ar(0.98226845264435), wave * DC.ar(0.47450232505798));
varAdwareCoolpp23302010 = FhnTrig.ar(wave * DC.ar(0.58152854442596), wave * DC.ar(0.99088537693024), wave * DC.ar(0.34617280960083), wave * DC.ar(0.23429358005524), wave * DC.ar(0.83022677898407), wave * DC.ar(0.87622964382172), wave * DC.ar(0.87657701969147), wave * DC.ar(0.86815738677979), wave * DC.ar(0.30545890331268), wave * DC.ar(0.045986890792847), wave * DC.ar(0.99676287174225));
varAdwareCoolpp23302011 = LPF.ar(wave * DC.ar(0.0044195652008057), wave * DC.ar(0.80546796321869), wave * DC.ar(0.48132824897766), wave * DC.ar(0.49130141735077));
// Variation test code
varAdwareCoolpp233020112 = TGrains.ar(2, t_trig, varAdwareCoolpp23302011 * DC.ar(0.44214737415314), varAdwareCoolpp23302011 * DC.ar(0.25167429447174), varAdwareCoolpp2330209 * DC.ar(0.98298227787018), varAdwareCoolpp2330209 * DC.ar(0.63354301452637), varAdwareCoolpp2330209 * DC.ar(0.1937872171402))), Array.fill(2.pow(16), { |i| rrand(-1, 1) }).as(LocalBuf), env * modY, gateEnv * env, y, amp, y, varAdwareCoolpp23302010);
varAdwareCoolpp233020113 = LFPulse.ar(modY * in, wave, varAdwareCoolpp23302011, 0.99974482623203 * in * varAdwareCoolpp23302010, Silent.ar());
varAdwareCoolpp233020112 = LFClipNoise.ar(modY, MostChange.ar(varAdwareCoolpp23302010 * DC.ar(0.23451459407806), varAdwareCoolpp23302011 * DC.ar(0.37073409557343)).minNyquist(), Silent.ar());
varAdwareCoolpp233020113 = FBSineN.ar(IndexL.ar(varAdwareCoolpp2330209 * DC.ar(0.62046802043915), varAdwareCoolpp23302010 * DC.ar(0.76723802089691), varAdwareCoolpp23302010 * DC.ar(0.77872431278229), varAdwareCoolpp23302011 * DC.ar(0.77097511291504)).exprange(1, SampleRate.ir), modZ * in, VOsc.ar(Array.fill(2.pow(14), { |i| rrand(-1, 1) }).as(LocalBuf), in, gateEnv, BufAllpassN.ar(varAdwareCoolpp23302010 * DC.ar(0.11191523075104), varAdwareCoolpp23302010 * DC.ar(0.44003176689148), varAdwareCoolpp23302010 * DC.ar(0.56128835678101), varAdwareCoolpp2330209 * DC.ar(0.0090219974517822), varAdwareCoolpp23302011 * DC.ar(0.69766008853912), varAdwareCoolpp23302010 * DC.ar(0.98686897754669)), Silent.ar()), modZ * varAdwareCoolpp233020113, modX * signal, Clipper8.ar(varAdwareCoolpp23302010 * modZ, varAdwareCoolpp2330209 * in, gate), varAdwareCoolpp233020112 * varAdwareCoolpp23302011, HenonL.ar(varAdwareCoolpp23302011 * DC.ar(0.27196753025055), varAdwareCoolpp23302011 * DC.ar(0.88601160049438), varAdwareCoolpp2330209 * DC.ar(0.49642074108124), varAdwareCoolpp23302010 * DC.ar(0.88215017318726), varAdwareCoolpp23302010 * DC.ar(0.56603407859802), varAdwareCoolpp23302010 * DC.ar(0.84657979011536), varAdwareCoolpp23302011 * DC.ar(0.53402268886566)), Silent.ar());
varAdwareCoolpp233020112 = BFEncode2.ar(varAdwareCoolpp23302010 * varAdwareCoolpp2330209, in, varAdwareCoolpp23302010 * wave, varAdwareCoolpp23302011 * varAdwareCoolpp23302011, in, varAdwareCoolpp2330209 * varAdwareCoolpp233020113);
varAdwareCoolpp233020113 = FMGrainBF.ar(in.lag, varAdwareCoolpp233020112 * varAdwareCoolpp233020113, in * in, modZ, modZ * varAdwareCoolpp23302011, gateEnv * modX, varAdwareCoolpp233020113, amp, y, 0.99995806635664 * varAdwareCoolpp23302010 * modZ, Silent.ar());

signal = varAdwareCoolpp233020113;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");

*/



/////////////////////////////////////////////////////////
// Blood233017
/////////////////////////////////////////////////////////

SynthDef.new("Blood233017", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varBlood2330179, varBlood23301710;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varBlood2330179 = varBlood23301710 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[0.0001, modY.linexp(0, 1, 0.001, modY.linexp(0, 1, 0.1, 1))], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         (Phasor.ar(0, modY * 72, 0, 72) + (in * 72)) % 73,
                         (Phasor.ar(0, modY * 72, 0, 72) + (in * 72)) % 73,
                         72,
                         72
                        );

			wave = wave + in + Decay.ar(t_trig, 0.1, PinkNoise.ar);


// Generated prototype body code
	/*
varBlood2330179 = FoaDominateY.ar(varBlood23301710 * modY, BrownNoise.ar(0.9994052038197 * wave * varBlood2330179, Silent.ar()), varBlood23301710, Silent.ar());
varBlood23301710 = FoaTilt.ar(signal * gateEnv, varBlood2330179 * modX, in, Silent.ar().bitOr(BBandStop.ar(wave * DC.ar(0.59522032737732), wave * DC.ar(0.91291832923889), wave * DC.ar(0.62202572822571), wave * DC.ar(0.13478481769562), wave * DC.ar(0.62496721744537))));
varBlood2330179 = Hilbert.ar(0.76815128326416 * modZ * gateEnv, 0.99330389085365 * FoaTilt.ar(wave * DC.ar(0.12853991985321), wave * DC.ar(0.10409510135651), wave * DC.ar(0.0067107677459717), wave * DC.ar(0.3663341999054)), Silent.ar());*/
varBlood23301710 = PulseCount.ar(env * in, FoaTilt.ar(wave * DC.ar(0.21421587467194), wave * DC.ar(0.094895720481873), wave * DC.ar(0.023848176002502), wave * DC.ar(0.59971845149994)));

signal = varBlood23301710;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// XM.Laroux.DX233015
/////////////////////////////////////////////////////////

SynthDef.new("XM.Laroux.DX233015", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varXMLarouxDX2330159;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varXMLarouxDX2330159 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[0.0001, modY.linexp(0, 1, 0.001, modY.linexp(0, 1, 0.1, 1))], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         (Phasor.ar(0, modY * 72, 0, 72) + (in * 72)) % 73,
                         (Phasor.ar(0, modY * 72, 0, 72) + (in * 72)) % 73,
                         72,
                         72
                        );

			wave = wave + in + Decay.ar(t_trig, 0.1, PinkNoise.ar);


// Generated prototype body code
	varXMLarouxDX2330159 = Integrator.ar(varXMLarouxDX2330159 * signal, wave * in, wave, Silent.ar());
varXMLarouxDX2330159 = DetectIndex.ar(Array.fill(2.pow(12), { |i| rrand(-1, 1) }).as(LocalBuf), varXMLarouxDX2330159 * in, modY, Silent.ar());

signal = varXMLarouxDX2330159;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");



/////////////////////////////////////////////////////////
// DREG.20792330141
/////////////////////////////////////////////////////////

SynthDef.new("DREG.20792330141", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varDREG20792330149, varDREG2079233014110;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varDREG20792330149 = varDREG2079233014110 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[0.0001, modY.linexp(0, 1, 0.001, modY.linexp(0, 1, 0.1, 1))], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         (Phasor.ar(0, modY * 72, 0, 72) + (in * 72)) % 73,
                         (Phasor.ar(0, modY * 72, 0, 72) + (in * 72)) % 73,
                         72,
                         72
                        );

			wave = wave + in + Decay.ar(t_trig, 0.1, PinkNoise.ar);


// Generated prototype body code
varDREG20792330149 = Lag2.ar(0.65622615814209 * varDREG20792330149 * signal, varDREG2079233014110 * env, LFSaw.ar(wave * DC.ar(0.74024903774261), wave * DC.ar(0.92966151237488), wave * DC.ar(0.61943674087524), wave * DC.ar(0.16758894920349)), Silent.ar());
	/*
varDREG20792330149 = PartConv.ar(MeanTriggered.ar(wave * DC.ar(0.88088643550873), wave * DC.ar(0.48221147060394), wave * DC.ar(0.25944674015045), wave * DC.ar(0.12814497947693), wave * DC.ar(0.95844972133636)), env * varDREG20792330149, Array.fill(2.pow(15), { |i| rrand(-1, 1) }).as(LocalBuf), 0.7650141392878 * NLFiltN.ar(wave * DC.ar(0.98696386814117), wave * DC.ar(0.1642678976059), wave * DC.ar(0.1723780632019), wave * DC.ar(0.56101393699646), wave * DC.ar(0.23220574855804), wave * DC.ar(0.97382748126984), wave * DC.ar(0.38779735565186), wave * DC.ar(0.645840883255)), Silent.ar());*/

	varDREG20792330149 = varDREG20792330149;
	// Variation test code
varDREG2079233014110 = HPZ1.ar(signal * modY, Clipper4.ar(varDREG20792330149 * DC.ar(0.089681386947632), varDREG20792330149 * DC.ar(0.39162218570709), varDREG20792330149 * DC.ar(0.29446530342102)), Silent.ar());
varDREG2079233014110 = LorenzTrig.ar(wave * modX, varDREG2079233014110.slew(varDREG20792330149 * DC.ar(0.27020227909088), varDREG20792330149 * DC.ar(0.71125960350037)), 0.93821978569031 * gateEnv * modX, PulseCount.ar(wave * varDREG2079233014110, 0.11011576652527 * gateEnv * modZ), x, x, varDREG20792330149 * varDREG2079233014110, varDREG20792330149 * varDREG2079233014110, in * signal, modZ, WalshHadamard.ar(varDREG20792330149 * DC.ar(0.4357568025589), varDREG20792330149 * DC.ar(0.63863062858582), varDREG20792330149 * DC.ar(0.51681625843048), varDREG20792330149 * DC.ar(0.093138933181763)));
varDREG2079233014110 = FreeVerb2.ar(gate, 0.83003342151642 * modY * gateEnv, modZ * signal, wave, z, modX.slew(varDREG20792330149 * DC.ar(0.23706519603729), varDREG20792330149 * DC.ar(0.75936126708984)), Silent.ar());

signal = varDREG2079233014110;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// JS.Screegor232959
/////////////////////////////////////////////////////////

SynthDef.new("JS.Screegor232959", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varJSScreegor2329599, varJSScreegor23295910, varJSScreegor23295911, varJSScreegor23295912;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varJSScreegor2329599 = varJSScreegor23295910 = varJSScreegor23295911 = varJSScreegor23295912 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[0.0001, modY.linexp(0, 1, 0.001, modY.linexp(0, 1, 0.1, 1))], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         (Phasor.ar(0, modY * 72, 0, 72) + (in * 72)) % 73,
                         (Phasor.ar(0, modY * 72, 0, 72) + (in * 72)) % 73,
                         72,
                         72
                        );

			wave = wave + in + Decay.ar(t_trig, 0.1, PinkNoise.ar);


// Generated prototype body code
varJSScreegor2329599 = Ball.ar(varJSScreegor23295910 * in, varJSScreegor23295912, 0.25912129878998 * in * varJSScreegor2329599, bufnum);
varJSScreegor23295910 = BPF.ar(wave * varJSScreegor23295912, wave * modX, modX * modZ, 0.99982564152505 * modY * wave, Silent.ar());
varJSScreegor23295911 = GrainIn.ar(2, env, modY, wave * varJSScreegor2329599, gate, bufnum, varJSScreegor23295912, 0.73789232122052 * gateEnv * varJSScreegor2329599, Silent.ar());
varJSScreegor23295912 = NL.ar(varJSScreegor23295912 * varJSScreegor23295911, Array.fill(2.pow(10), { |i| rrand(-1, 1) }).as(LocalBuf), Array.fill(2.pow(13), { |i| rrand(-1, 1) }).as(LocalBuf), amp, modZ * varJSScreegor23295910, wave, Silent.ar());
varJSScreegor2329599 = Maxamp.ar(wave * DC.ar(0.50780785083771), wave * DC.ar(0.62957239151001));
varJSScreegor23295910 = LFBrownNoise1.ar(varJSScreegor23295912, wave * varJSScreegor23295912, varJSScreegor23295910, gateEnv, Silent.ar());
varJSScreegor23295911 = LTI.ar(wave * DC.ar(0.30146169662476), wave * DC.ar(0.66027796268463), wave * DC.ar(0.78566944599152), wave * DC.ar(0.14442527294159), wave * DC.ar(0.4792172908783));
varJSScreegor23295912 = Balance2.ar(modX, modZ * modX, Latoocarfian2DN.ar(wave * DC.ar(0.77355051040649), wave * DC.ar(0.093095183372498), wave * DC.ar(0.63178372383118), wave * DC.ar(0.42548489570618), wave * DC.ar(0.76632189750671), wave * DC.ar(0.92967259883881), wave * DC.ar(0.56055891513824), wave * DC.ar(0.037862062454224), wave * DC.ar(0.37425708770752), wave * DC.ar(0.44565796852112)), modX * signal);

signal = varJSScreegor23295912;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Austr_Parasite.320232957
/////////////////////////////////////////////////////////

SynthDef.new("Austr_Parasite.320232957", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varAustr_Parasite3202329579;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varAustr_Parasite3202329579 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[0.0001, modY.linexp(0, 1, 0.001, modY.linexp(0, 1, 0.1, 1))], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         (Phasor.ar(0, modY * 72, 0, 72) + (in * 72)) % 73,
                         (Phasor.ar(0, modY * 72, 0, 72) + (in * 72)) % 73,
                         72,
                         72
                        );

			wave = wave + in + Decay.ar(t_trig, 0.1, PinkNoise.ar);


// Generated prototype body code
varAustr_Parasite3202329579 = Gendy1.ar(modX * env, wave, signal * modX, gate, in * wave, env, gateEnv * modY, gate, FSinOsc.ar(FincoSprottM.ar(wave * DC.ar(0.90810668468475), wave * DC.ar(0.50611555576324), wave * DC.ar(0.78153884410858), wave * DC.ar(0.14996087551117), wave * DC.ar(0.3352792263031), wave * DC.ar(0.2739372253418), wave * DC.ar(0.39801645278931), wave * DC.ar(0.045127749443054), wave * DC.ar(0.82582080364227)).exprange(1, SampleRate.ir), env, 0.99808030943888 * Oregonator.ar(wave * DC.ar(0.91482675075531), wave * DC.ar(0.12314581871033), wave * DC.ar(0.80669927597046), wave * DC.ar(0.45283842086792), wave * DC.ar(0.056694030761719), wave * DC.ar(0.42127597332001), wave * DC.ar(0.78053855895996), wave * DC.ar(0.88908135890961), wave * DC.ar(0.63341319561005), wave * DC.ar(0.037650227546692)), Silent.ar()), env, varAustr_Parasite3202329579, FoaDirectY.ar(wave * DC.ar(0.17868840694427), wave * DC.ar(0.42966938018799), wave * DC.ar(0.91474723815918), wave * DC.ar(0.97656786441803)));
varAustr_Parasite3202329579 = Henon2DL.ar(YigClifford3DL.ar(wave * DC.ar(0.68160796165466), wave * DC.ar(0.64822542667389), wave * DC.ar(0.47043454647064), wave * DC.ar(0.53059124946594), wave * DC.ar(0.070807456970215), wave * DC.ar(0.82099759578705), wave * DC.ar(0.93321573734283), wave * DC.ar(0.58978033065796), wave * DC.ar(0.091419816017151), wave * DC.ar(0.01822817325592)).exprange(1, SampleRate.ir), wave, z, gate, env, modZ * in, 0.99987097971768 * env * modX, Silent.ar());

signal = varAustr_Parasite3202329579;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// WM.AntiWazzu.A232955
/////////////////////////////////////////////////////////

SynthDef.new("WM.AntiWazzu.A232955", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varWMAntiWazzuA2329559;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varWMAntiWazzuA2329559 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[0.0001, modY.linexp(0, 1, 0.001, modY.linexp(0, 1, 0.1, 1))], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         (Phasor.ar(0, modY * 72, 0, 72) + (in * 72)) % 73,
                         (Phasor.ar(0, modY * 72, 0, 72) + (in * 72)) % 73,
                         72,
                         72
                        );

			wave = wave + in + Decay.ar(t_trig, 0.1, PinkNoise.ar);


// Generated prototype body code
varWMAntiWazzuA2329559 = SoftClipper8.ar(signal);
//varWMAntiWazzuA2329559 = CombFormlet.ar(wave * DC.ar(0.010276913642883), wave * DC.ar(0.19187748432159), wave * DC.ar(0.90240716934204), wave * DC.ar(0.022828578948975), wave * DC.ar(0.405482172966), wave * DC.ar(0.33277189731598), wave * DC.ar(0.42270088195801));

signal = varWMAntiWazzuA2329559;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Atas2329551
/////////////////////////////////////////////////////////

SynthDef.new("Atas2329551", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varAtas2329559, varAtas232955110, varAtas232955111;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varAtas2329559 = varAtas232955110 = varAtas232955111 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[0.0001, modY.linexp(0, 1, 0.001, modY.linexp(0, 1, 0.1, 1))], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         (Phasor.ar(0, modY * 72, 0, 72) + (in * 72)) % 73,
                         (Phasor.ar(0, modY * 72, 0, 72) + (in * 72)) % 73,
                         72,
                         72
                        );

			wave = wave + in + Decay.ar(t_trig, 0.1, PinkNoise.ar);


// Generated prototype body code
varAtas2329559 = Fhn2DC.ar(varAtas2329559, varAtas2329559 * env, modZ * varAtas232955111, z, env * in, y, in, z, y, 0.99987637976867 * wave * modZ, Silent.ar());/*
varAtas2329559 = Rotate2.ar(in, amp, amp);
// Variation test code
varAtas232955110 = AnalyseEvents2.ar(gateEnv * varAtas2329559, Array.fill(2.pow(14), { |i| rrand(-1, 1) }).as(LocalBuf), signal * modY, wave * modX, modY * in.expexp(varAtas2329559 * DC.ar(0.11817455291748), varAtas2329559 * DC.ar(0.36922192573547), varAtas2329559 * DC.ar(0.13828206062317), varAtas2329559 * DC.ar(0.61664164066315), varAtas2329559 * DC.ar(0.62803375720978)), modZ * modX);
varAtas232955111 = YigMandelbulbN.ar(in * signal, modX * varAtas232955110, 0.11650204658508 * modY * modZ, varAtas232955111 * in, gateEnv * varAtas2329559, 0.98027328512162 * FincoSprottL.ar(varAtas2329559 * DC.ar(0.96644735336304), varAtas2329559 * DC.ar(0.8574492931366), varAtas2329559 * DC.ar(0.31543946266174), varAtas2329559 * DC.ar(0.30822384357452), varAtas2329559 * DC.ar(0.40010726451874), varAtas2329559 * DC.ar(0.16839563846588), varAtas2329559 * DC.ar(0.55595552921295), varAtas2329559 * DC.ar(0.66608929634094)), Silent.ar());
varAtas232955110 = OSFold8.ar(z, varAtas232955111, modX);
varAtas232955111 = Sweep.ar(modZ * env.minNyquist(), varAtas232955111 * wave);
varAtas232955110 = TRand.ar(0.52973282337189 * Spring.ar(varAtas2329559 * DC.ar(0.73199069499969), varAtas2329559 * DC.ar(0.41127192974091), varAtas2329559 * DC.ar(0.36657345294952)), 0.080885291099548 * CuspL.ar(varAtas2329559 * DC.ar(0.53728008270264), varAtas2329559 * DC.ar(0.30438256263733), varAtas2329559 * DC.ar(0.28666949272156), varAtas2329559 * DC.ar(0.8818883895874), varAtas2329559 * DC.ar(0.48487687110901), varAtas2329559 * DC.ar(0.57841145992279)), varAtas2329559 * modZ);
varAtas232955111 = WarpZ.ar(2, Array.fill(2.pow(11), { |i| rrand(-1, 1) }).as(LocalBuf), in * signal, env, 0.041017055511475 * env * env, bufnum, y, modX * varAtas2329559, 0.67159402370453 * modY * in, modZ * varAtas232955111, bufnum, 0.99568486853593 * T2A.ar(varAtas2329559 * DC.ar(0.39321327209473), varAtas2329559 * DC.ar(0.35252153873444)), SoftClipper8.ar(varAtas2329559 * DC.ar(0.55459940433502)));
*/
signal = varAtas2329559;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Deadly.1638232953
/////////////////////////////////////////////////////////

SynthDef.new("Deadly.1638232953", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varDeadly16382329539, varDeadly163823295310, varDeadly163823295311;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varDeadly16382329539 = varDeadly163823295310 = varDeadly163823295311 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[0.0001, modY.linexp(0, 1, 0.001, modY.linexp(0, 1, 0.1, 1))], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         (Phasor.ar(0, modY * 72, 0, 72) + (in * 72)) % 73,
                         (Phasor.ar(0, modY * 72, 0, 72) + (in * 72)) % 73,
                         72,
                         72
                        );

			wave = wave + in + Decay.ar(t_trig, 0.1, PinkNoise.ar);


// Generated prototype body code
varDeadly16382329539 = FoaDominateY.ar(in * modY, island, 0.99981956016474 * modZ, Silent.ar());
	varDeadly163823295310 = FoaPressZ.ar(PV_HainsworthFoote.ar(LocalBuf(2048, 2), wave * DC.ar(0.08500075340271), wave * DC.ar(0.036184787750244), wave * DC.ar(0.4298061132431), wave * DC.ar(0.27797067165375)), varDeadly163823295311, 0.99254739004058 * wave, Silent.ar());
	varDeadly163823295311 = DoubleNestedAllpassN.ar(in * wave, modY, in * gateEnv, z, gateEnv, gateEnv, env * modY, varDeadly163823295311, wave * in, wave * gateEnv, wave.excess(SoftClipAmp4.ar(wave * DC.ar(0.73694026470184), wave * DC.ar(0.15589916706085), wave * DC.ar(0.87450397014618), wave * DC.ar(0.84585630893707))), DelayC.ar(wave * DC.ar(0.79266905784607), 0.25, (wave * DC.ar(0.88195765018463)).max(0.0001).min(0.25), wave * DC.ar(0.57875692844391), wave * DC.ar(0.12637662887573)));
varDeadly16382329539 = Pan2.ar(wave * DC.ar(0.79246819019318), wave * DC.ar(0.024186491966248), wave * DC.ar(0.38911783695221));
varDeadly163823295310 = Crackle.ar(gateEnv, 0.98835089277933 * env * in, Silent.ar());
varDeadly163823295311 = PosRatio.ar(wave * DC.ar(0.30294418334961), wave * DC.ar(0.72397673130035), wave * DC.ar(0.59913861751556));

signal = varDeadly163823295311;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Backdoor.BlackD232952
/////////////////////////////////////////////////////////

SynthDef.new("Backdoor.BlackD232952", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varBackdoorBlackD2329529;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varBackdoorBlackD2329529 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[0.0001, modY.linexp(0, 1, 0.001, modY.linexp(0, 1, 0.1, 1))], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         (Phasor.ar(0, modY * 72, 0, 72) + (in * 72)) % 73,
                         (Phasor.ar(0, modY * 72, 0, 72) + (in * 72)) % 73,
                         72,
                         72
                        );

			wave = wave + in + Decay.ar(t_trig, 0.1, PinkNoise.ar);


// Generated prototype body code
varBackdoorBlackD2329529 = CombLP.ar(bufnum, y, signal * modY, gateEnv * varBackdoorBlackD2329529, 0.31582653522491 * in * varBackdoorBlackD2329529, modZ * env, in, Silent.ar());
	/*varBackdoorBlackD2329529 = StkShakers.ar((wave * DC.ar(0.1245813369751)).abs, (wave * DC.ar(0.99678194522858)).abs, (wave * DC.ar(0.4988226890564)).abs, (wave * DC.ar(0.10387480258942)).abs, (wave * DC.ar(0.95112609863281)).abs, (wave * DC.ar(0.33699798583984)).abs, (wave * DC.ar(0.51101422309875)).abs);
*/
signal = varBackdoorBlackD2329529;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Bin.Auto.BRQ232949
/////////////////////////////////////////////////////////

SynthDef.new("Bin.Auto.BRQ232949", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varBinAutoBRQ2329499, varBinAutoBRQ23294910, varBinAutoBRQ23294911;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varBinAutoBRQ2329499 = varBinAutoBRQ23294910 = varBinAutoBRQ23294911 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[0.0001, modY.linexp(0, 1, 0.001, modY.linexp(0, 1, 0.1, 1))], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         (Phasor.ar(0, modY * 72, 0, 72) + (in * 72)) % 73,
                         (Phasor.ar(0, modY * 72, 0, 72) + (in * 72)) % 73,
                         72,
                         72
                        );

			wave = wave + in + Decay.ar(t_trig, 0.1, PinkNoise.ar);


// Generated prototype body code
varBinAutoBRQ2329499 = COsc.ar(Array.fill(2.pow(11), { |i| rrand(-1, 1) }).as(LocalBuf), modX * modX, wave, 0.9999836606167 * varBinAutoBRQ23294911, Silent.ar());
	/*
varBinAutoBRQ23294910 = Latoocarfian2DL.ar(FMGrainBF.ar(env, wave * DC.ar(0.68839383125305), wave * DC.ar(0.51304841041565), wave * DC.ar(0.59182190895081), wave * DC.ar(0.93306839466095), wave * DC.ar(0.78067719936371), wave * DC.ar(0.0040508508682251), wave * DC.ar(0.77929067611694), wave * DC.ar(0.069395661354065), wave * DC.ar(0.35326969623566), wave * DC.ar(0.60659158229828)).exprange(1, SampleRate.ir), signal * signal, modZ, varBinAutoBRQ23294910, modY, gateEnv * modX, modZ * modY, signal * modY, 0.93889962049224 * varBinAutoBRQ23294911 * modX, SanityCheck.ar(wave * DC.ar(0.77679884433746)));
varBinAutoBRQ23294911 = Maxamp.ar(varBinAutoBRQ23294911, varBinAutoBRQ23294910 * modY);
varBinAutoBRQ2329499 = HenonN.ar(Line.ar(wave * DC.ar(0.47685539722443), wave * DC.ar(0.058790564537048), wave * DC.ar(0.85671842098236), wave * DC.ar(0.4223804473877), wave * DC.ar(0.22239184379578), wave * DC.ar(0.32613170146942)).exprange(1, SampleRate.ir), modX * in, modX, amp, wave * signal, 0.8714394689937 * modZ * env, Silent.ar());
varBinAutoBRQ23294910 = SOS.ar(wave * DC.ar(0.32780337333679), wave * DC.ar(0.67689740657806), wave * DC.ar(0.61939382553101), wave * DC.ar(0.23377513885498), wave * DC.ar(0.97255158424377), wave * DC.ar(0.39438605308533), wave * DC.ar(0.083172559738159), wave * DC.ar(0.36830198764801));
varBinAutoBRQ23294911 = SinGrain.ar(env, 0.76202583312988 * modZ * wave, LatoocarfianTrig.ar(wave * DC.ar(0.70537555217743), wave * DC.ar(0.063812017440796), wave * DC.ar(0.6259514093399), wave * DC.ar(0.25372636318207), wave * DC.ar(0.85723674297333), wave * DC.ar(0.62165057659149), wave * DC.ar(0.46120047569275), wave * DC.ar(0.54658997058868), wave * DC.ar(0.021997094154358), wave * DC.ar(0.30188977718353)).exprange(1, SampleRate.ir), 0.94407044515321 * varBinAutoBRQ2329499 * signal, Silent.ar());*/

signal = varBinAutoBRQ2329499;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// W95.Epip@m232947
/////////////////////////////////////////////////////////

SynthDef.new("W95.Epip@m232947", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varW95Epipm2329479, varW95Epipm23294710, varW95Epipm23294711, varW95Epipm23294712, varW95Epipm23294713;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varW95Epipm2329479 = varW95Epipm23294710 = varW95Epipm23294711 = varW95Epipm23294712 = varW95Epipm23294713 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[0.0001, modY.linexp(0, 1, 0.001, modY.linexp(0, 1, 0.1, 1))], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         (Phasor.ar(0, modY * 72, 0, 72) + (in * 72)) % 73,
                         (Phasor.ar(0, modY * 72, 0, 72) + (in * 72)) % 73,
                         72,
                         72
                        );

			wave = wave + in + Decay.ar(t_trig, 0.1, PinkNoise.ar);


// Generated prototype body code
varW95Epipm2329479 = Rotate.ar(modY, modZ * signal, GbmanN.ar(modY * varW95Epipm23294712, 0.62350189685822 * modZ * gateEnv, signal * varW95Epipm23294711, 0.98579284678958 * varW95Epipm2329479 * wave, Silent.ar()), modZ * varW95Epipm23294713, varW95Epipm23294713);
varW95Epipm23294710 = LPZ1.ar(varW95Epipm23294710, 0.91805747292428 * varW95Epipm23294713 * wave, Silent.ar());
varW95Epipm23294711 = TBall.ar(modZ, varW95Epipm23294712 * varW95Epipm23294711, 0.20718550682068 * FBSineL.ar(wave * DC.ar(0.40033388137817), wave * DC.ar(0.29980254173279), wave * DC.ar(0.72985851764679), wave * DC.ar(0.22952222824097), wave * DC.ar(0.44266152381897), wave * DC.ar(0.29773855209351), wave * DC.ar(0.45419943332672), wave * DC.ar(0.2803715467453), wave * DC.ar(0.92836725711823)), signal * wave);
varW95Epipm23294712 = Line.ar(modX, varW95Epipm23294710 * wave, bufnum, wave, Silent.ar(), varW95Epipm2329479 * modZ);
varW95Epipm23294713 = NestedAllpassN.ar(in * env, varW95Epipm23294712 * signal, gateEnv * in, varW95Epipm23294711, z, z, signal * wave, in, Silent.ar());
varW95Epipm2329479 = InRange.ar(wave * DC.ar(0.90586364269257), wave * DC.ar(0.66363751888275), wave * DC.ar(0.54135704040527));
varW95Epipm23294710 = LorenzL.ar(varW95Epipm23294712 * modX, modX * env, varW95Epipm23294713, modZ * env, wave * gateEnv, in, varW95Epipm23294711 * modY, varW95Epipm23294710 * env, varW95Epipm23294711, Silent.ar());
varW95Epipm23294711 = RMShelf2.ar(wave * DC.ar(0.020031452178955), wave * DC.ar(0.52678346633911), wave * DC.ar(0.19608008861542), wave * DC.ar(0.77292716503143), wave * DC.ar(0.14653587341309));/*
	varW95Epipm23294712 = StkShakers.ar((varW95Epipm23294711 * env).abs.min(128), varW95Epipm23294711.abs.min(128), wave.abs.min(128), varW95Epipm2329479.abs.min(128), signal.abs.min(128), LinXFade2.ar(wave * DC.ar(0.1555814743042).abs.min(128), wave.abs.min(128) * DC.ar(0.59236800670624), wave.abs.min(128) * DC.ar(0.715247631073), wave.abs.min(128) * DC.ar(0.14977765083313)), Silent.ar());*/
	varW95Epipm23294712 = varW95Epipm23294711;
varW95Epipm23294713 = BHiPass.ar(wave * DC.ar(0.94175016880035), wave * DC.ar(0.88314640522003), wave * DC.ar(0.66867923736572), wave * DC.ar(0.61407375335693), wave * DC.ar(0.21796238422394));

signal = varW95Epipm23294713;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");



/////////////////////////////////////////////////////////
// Linux.Orig232942
/////////////////////////////////////////////////////////

SynthDef.new("Linux.Orig232942", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varLinuxOrig2329429, varLinuxOrig23294210, varLinuxOrig23294211, varLinuxOrig23294212, varLinuxOrig23294213;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varLinuxOrig2329429 = varLinuxOrig23294210 = varLinuxOrig23294211 = varLinuxOrig23294212 = varLinuxOrig23294213 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[0.0001, modY.linexp(0, 1, 0.001, modY.linexp(0, 1, 0.1, 1))], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         (Phasor.ar(0, modY * 72, 0, 72) + (in * 72)) % 73,
                         (Phasor.ar(0, modY * 72, 0, 72) + (in * 72)) % 73,
                         72,
                         72
                        );

			wave = wave + in + Decay.ar(t_trig, 0.1, PinkNoise.ar);


// Generated prototype body code
varLinuxOrig2329429 = BLowShelf.ar(varLinuxOrig2329429, signal * signal, t_trig, island, 0.81366665570502 * varLinuxOrig2329429 * gateEnv, Silent.ar());
varLinuxOrig23294210 = varLinuxOrig2329429;
varLinuxOrig23294211 = RandSeed.ar(wave * modX, signal * in);
varLinuxOrig23294212 = AllpassC.ar(modZ * varLinuxOrig2329429, varLinuxOrig23294213, t_trig, 0.8884584903717 * varLinuxOrig23294211 * env, 0.98119820162967 * modY * env, Silent.ar());
varLinuxOrig23294213 = AverageOutput.ar(bufnum, env * varLinuxOrig23294212, 0.17915171879355 * modX * varLinuxOrig2329429, VOsc.ar(wave * DC.ar(0.50895535945892), wave * DC.ar(0.40540087223053), wave * DC.ar(0.48595428466797), wave * DC.ar(0.84983468055725), wave * DC.ar(0.19734537601471)));
varLinuxOrig2329429 = LatoocarfianC.ar(env * varLinuxOrig23294211, varLinuxOrig23294211 * signal, varLinuxOrig23294211, wave * varLinuxOrig23294210, y, varLinuxOrig23294212, modZ * varLinuxOrig23294212, modX, Silent.ar());/*
varLinuxOrig23294210 = SanityCheck.ar(modZ);
varLinuxOrig23294211 = LFSaw.ar(wave * DC.ar(0.64873445034027), wave * DC.ar(0.17079305648804), wave * DC.ar(0.57484710216522), wave * DC.ar(0.57509315013885));
varLinuxOrig23294212 = RMShelf.ar(x, StkBowed.ar(wave * DC.ar(0.01585853099823), wave * DC.ar(0.77348446846008), wave * DC.ar(0.49366295337677), wave * DC.ar(0.25429272651672), wave * DC.ar(0.13019263744354), wave * DC.ar(0.41565001010895), wave * DC.ar(0.8952032327652), wave * DC.ar(0.46842968463898), wave * DC.ar(0.02053165435791), wave * DC.ar(0.55144560337067), wave * DC.ar(0.73965907096863)).exprange(1, SampleRate.ir), modX, 0.99998972054384 * env, Silent.ar());
varLinuxOrig23294213 = varLinuxOrig23294212;*/

signal = varLinuxOrig2329429;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Trivial.109232937
/////////////////////////////////////////////////////////

SynthDef.new("Trivial.109232937", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varTrivial1092329379;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varTrivial1092329379 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[0.0001, modY.linexp(0, 1, 0.001, modY.linexp(0, 1, 0.1, 1))], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         (Phasor.ar(0, modY * 72, 0, 72) + (in * 72)) % 73,
                         (Phasor.ar(0, modY * 72, 0, 72) + (in * 72)) % 73,
                         72,
                         72
                        );

			wave = wave + in + Decay.ar(t_trig, 0.1, PinkNoise.ar);


// Generated prototype body code
varTrivial1092329379 = SinOsc.ar(varTrivial1092329379, modY * wave, wave * gateEnv, 0.46606075763702 * gateEnv * wave, 0.61137568950653 * modX * gateEnv, island, 0.24469077587128 * env, modZ, Silent.ar());
	/*
varTrivial1092329379 = DoubleNestedAllpassL.ar(wave * DC.ar(0.50801396369934), wave * DC.ar(0.95548057556152), wave * DC.ar(0.93277490139008), wave * DC.ar(0.47076463699341), wave * DC.ar(0.98754227161407), wave * DC.ar(0.24920034408569), wave * DC.ar(0.49644124507904), wave * DC.ar(0.026647329330444), wave * DC.ar(0.55956339836121), wave * DC.ar(0.088456749916077), wave * DC.ar(0.26985049247742), wave * DC.ar(0.9791921377182));*/

signal = varTrivial1092329379;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// SillyOC.256232932
/////////////////////////////////////////////////////////

SynthDef.new("SillyOC.256232932", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varSillyOC2562329329;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varSillyOC2562329329 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[0.0001, modY.linexp(0, 1, 0.001, modY.linexp(0, 1, 0.1, 1))], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         (Phasor.ar(0, modY * 72, 0, 72) + (in * 72)) % 73,
                         (Phasor.ar(0, modY * 72, 0, 72) + (in * 72)) % 73,
                         72,
                         72
                        );

			wave = wave + in + Decay.ar(t_trig, 0.1, PinkNoise.ar);


// Generated prototype body code
varSillyOC2562329329 = FoaNFC.ar(env, modY, 0.99969615375393 * wave, Silent.ar());
varSillyOC2562329329 = Standard2DC.ar(AllpassN.ar(wave * DC.ar(0.19360876083374), wave * DC.ar(0.24510514736176), wave * DC.ar(0.3765994310379), wave * DC.ar(0.84183526039124), wave * DC.ar(0.48468792438507), wave * DC.ar(0.58439826965332)).exprange(1, SampleRate.ir), modY * modZ, varSillyOC2562329329 * env, env * env, gate, 0.15005067147818 * env * wave, Silent.ar().exprange(wave * DC.ar(0.63868510723114), wave * DC.ar(0.65999841690063)));

signal = varSillyOC2562329329;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");



/////////////////////////////////////////////////////////
// HLLO.4213232924
/////////////////////////////////////////////////////////

SynthDef.new("HLLO.4213232924", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varHLLO42132329249, varHLLO421323292410, varHLLO421323292411, varHLLO421323292412;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varHLLO42132329249 = varHLLO421323292410 = varHLLO421323292411 = varHLLO421323292412 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[0.0001, modY.linexp(0, 1, 0.001, modY.linexp(0, 1, 0.1, 1))], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         (Phasor.ar(0, modY * 72, 0, 72) + (in * 72)) % 73,
                         (Phasor.ar(0, modY * 72, 0, 72) + (in * 72)) % 73,
                         72,
                         72
                        );

			wave = wave + in + Decay.ar(t_trig, 0.1, PinkNoise.ar);


// Generated prototype body code
varHLLO42132329249 = MoogVCF.ar(gateEnv * varHLLO421323292410, modX * signal, amp, env, Silent.ar());
varHLLO421323292410 = wave; /*SinGrain.ar(modY, 0.66066575050354 * varHLLO421323292411 * varHLLO421323292411, modY * env, 0.68196958986656 * wave, Silent.ar());*/
varHLLO421323292411 = BLowPass.ar(signal * wave.round(Decay.ar(wave * DC.ar(0.98041641712189), wave * DC.ar(0.46653890609741), wave * DC.ar(0.11997544765472), wave * DC.ar(0.5370591878891))), signal, varHLLO421323292411 * signal, 0.99955168244661 * varHLLO42132329249 * varHLLO421323292411, Silent.ar());
varHLLO421323292412 = YigClifford3DL.ar(wave * modX, in, wave * modZ, y, modZ * env, gate, gate, signal * varHLLO421323292411, 0.99987614705921 * wave * modY, Silent.ar());
varHLLO42132329249 = LFDClipNoise.ar(QuadL.ar(wave * DC.ar(0.74963271617889), wave * DC.ar(0.72088217735291), wave * DC.ar(0.61224281787872), wave * DC.ar(0.66530287265778), wave * DC.ar(0.26236522197723), wave * DC.ar(0.92800986766815), wave * DC.ar(0.48801565170288)).exprange(1, SampleRate.ir), 0.99841637286237 * modY * gateEnv, Silent.ar());
varHLLO421323292410 = 1;/*BFDecode1.ar(z, varHLLO421323292411 * modX, modX * modZ, modY * env, varHLLO42132329249, gateEnv, varHLLO42132329249, 0.99953994488842 * gateEnv, Silent.ar());*/
varHLLO421323292411 = InRange.ar(gateEnv * wave, z, varHLLO421323292412 * varHLLO421323292410);
varHLLO421323292412 = Gendy2.ar(in * modY, modZ, gateEnv * modZ, x, modY, wave * wave, env, in * varHLLO421323292412, island, amp, bufnum, modZ, 0.99624617139832 * in * varHLLO421323292412, Silent.ar());

signal = varHLLO421323292412;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");



/////////////////////////////////////////////////////////
// Kode.335232953
/////////////////////////////////////////////////////////

SynthDef.new("Kode.335232953", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varKode3352329539, varKode33523295310;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varKode3352329539 = varKode33523295310 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[0.0001, modY.linexp(0, 1, 0.001, modY.linexp(0, 1, 0.1, 1))], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         (Phasor.ar(0, modY * 72, 0, 72) + (in * 72)) % 73,
                         (Phasor.ar(0, modY * 72, 0, 72) + (in * 72)) % 73,
                         72,
                         72
                        );

			wave = wave + in + Decay.ar(t_trig, 0.1, PinkNoise.ar);


// Generated prototype body code
varKode3352329539 = OSWrap4.ar(modY, modY * modZ, signal);
varKode33523295310 = LFSaw.ar(FreqShift.ar(wave * DC.ar(0.5563428401947), wave * DC.ar(0.070133805274963), wave * DC.ar(0.75861537456512), wave * DC.ar(0.68305814266205), wave * DC.ar(0.7358113527298)).exprange(1, SampleRate.ir), island, 0.99702752360399 * Demand.ar(wave * DC.ar(0.701016664505), wave * DC.ar(0.78998470306396), wave * DC.ar(0.0052615404129028)), Silent.ar());
varKode3352329539 = FBSineL.ar(wave * DC.ar(0.43450260162354), wave * DC.ar(0.56694757938385), wave * DC.ar(0.35348212718964), wave * DC.ar(0.67775881290436), wave * DC.ar(0.39786767959595), wave * DC.ar(0.54222941398621), wave * DC.ar(0.45087862014771), wave * DC.ar(0.33572709560394), wave * DC.ar(0.38725697994232));
varKode33523295310 = PeakFollower.ar(t_trig, island);

signal = varKode33523295310;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");



)