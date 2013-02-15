

// Shoggoth Synths
// Arguments and ranges:
// x: 1 to 430
// y: -200 to 200
// z: 1 to 430
// island: 0 to 4


(
SynthDef.new("ShoggothTestSine",{
	|amp=0.1, freq=440|
	var env, signal;
	env = EnvGen.ar(Env.new([0, 1, 0],[0.1, 5], -4), gate:1, doneAction:2);
	signal = SinOsc.ar(freq) * env * amp;
	Out.ar(0, signal.dup);
}).store;
);

~sine = Synth("ShoggothTestSine");

(
SynthDef.new("ShoggothPerc",{
	|amp=0.125, x=0, y=0, z=0, island=0, gate=1, t_trig=0|
	var env, signal, mod, gateEnv;
	gateEnv = EnvGen.ar(Env.asr(0, 1, 1, -4), gate:gate, doneAction:2);
	env = EnvGen.ar(Env.new([0, 1, 0],[0.0001, 0.1], -4), gate:t_trig, doneAction:0);
	mod = z.linexp(1, 430, 0.1, 1000);
	signal = SinOsc.ar(55 * y.linexp(-200, 200, 1, 4).round(1)).clip2(Saw.ar(x.linexp(1, 430, 20, 80), z/860/2, z/860/2));
	signal = Pan2.ar(signal, island.linlin(0, 3, -1 , 1)) * env * amp;
	Out.ar(0, signal);
}).store;
);

~sine = Synth("ShoggothPerc");
~sine.set(\t_trig, 1, \x, rrand(1, 430), \y, rrand(-200, 200), \z, rrand(1, 430));
~sine.set(\gate, 0);


(
SynthDef.new("PlatedGeopede",{
	|amp=0.5, x=0, y=0, z=0, island=0, gate=1, t_trig=0|
	var env, signal, mod, feedIn, feedOut, spring, damp, springs, sel, modX, modY, modZ, sawFreq;
	var sel2, scale, matrix, matrixFreq, env3, gateEnv;
	gateEnv = EnvGen.ar(Env.asr(0, 1, 4, -4), gate:gate, doneAction:2);
	env = EnvGen.ar(Env.new([0, 1, 0],[0.1, 4], -4), gate:t_trig, doneAction:0);
	env3 = EnvGen.ar(Env.new([0, 1, 0],[1.5, 2.6], -4), gate:t_trig, doneAction:0);
	modX = x.linlin(1, 430, 0, 1);
	modY = y.linlin(-200, 200, 0, 1);
	modZ = z.linlin(1, 430, 0, 1);
	spring = (0.107421875).dup(10);
	damp = (0.0537109375).dup(10);
	scale = [9, 12, 14, 16, 19, 21, 24, 26, 28, 31, 33].midicps * 2;
	matrix = Array.fill2D(430 / 5, 430 / 5, { |x, y| scale[(x + y) % scale.size] * 2.pow(y % 3) });
	matrixFreq = Select.kr(z / 5, Select.kr(x / 5, matrix));

	feedIn = LPF.ar(LocalIn.ar(1), matrixFreq)
		+ LPF.ar(Saw.ar(matrixFreq, env / 2) + WhiteNoise.ar(env3 * 0.1), matrixFreq * 2.pow(modY.linexp(0, 1, 1, 5).round(1)));
	feedIn = HPF.ar(feedIn, 20);
	feedOut = feedIn;

	springs = spring.collect{ |spr, i|
		feedOut = Spring.ar(feedOut, spr, damp[i]);
		// feedOut = CombC.ar(feedOut, spr, spr, damp[i]);
	};

	LocalOut.ar(feedOut);

	sel = LFTri.ar(matrixFreq, 0, 0.5, 0.5) * spring.size;
	//sel2 = Slew.ar(Saw.ar(matrixFreq * 2, 0.5, 0.5), SampleRate.ir / 10, SampleRate.ir) * spring.size;
	signal = Splay.ar(SelectX.ar(sel, springs), 1);
	signal = Limiter.ar(signal);
	signal = Pan2.ar(signal, island.linlin(0, 3, -1 , 1)) * env * amp * gateEnv;
	Out.ar(0, signal);
}).store;
);

~plate = Synth("PlatedGeopede", [\x, rrand(1, 430), \y, rrand(-200, 200), \z, rrand(1, 430)]);
~plate.set(\t_trig, 1, \x, rrand(1, 430), \y, rrand(-200, 200), \z, rrand(1, 430));
~plate.set(\gate, 0);

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
	}).store;
)

~snare = Synth("ShogSnare", [\x, rrand(1, 430), \y, rrand(-200, 200), \z, rrand(1, 430)]);
~snare.set(\t_trig, 1, \x, rrand(1, 430), \y, rrand(-200, 200), \z, rrand(1, 430));
~snare.set(\gate, 0);

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
	}).store;
)

~bassdrum = Synth("ShoggothBassDrum", [\x, rrand(1, 430), \y, rrand(-200, 200), \z, rrand(1, 430)]);
~bassdrum.set(\t_trig, 1, \x, rrand(1, 430), \y, rrand(-200, 200), \z, rrand(1, 430));
~bassdrum.set(\gate, 0);

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
	}).store;
)

~hihat = Synth("ShogHiHat", [\x, rrand(1, 430), \y, rrand(-200, 200), \z, rrand(1, 430)]);
~hihat.set(\t_trig, 1, \x, rrand(1, 430), \y, rrand(-200, 200), \z, rrand(1, 430));
~hihat.set(\gate, 0);

( // Create the buffer for testing only
~wasteland = Buffer.new(s, 5184, 1, 1);
~wasteland.alloc();
~wasteland.sendCollection(Array.fill(5184, { rrand(-1, 1) }), 0, 0);
~wasteland.plot;
)

(
SynthDef.new("BlastedWasteland",{
	|amp=0.125, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0|
	var env, signal, modY, gateEnv, phase;
	gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
	env = EnvGen.ar(Env.new([0, 1, 0],[0.0001, 0.3], -4), gate:t_trig, doneAction:0);
	modY = y.linlin(-200, 200, 0, 0.999);

	phase = [
		Saw.ar(x.linexp(1, 430, 0.1, SampleRate.ir), 0.5, 0.5) * 72,
		Saw.ar(z.linexp(1, 430, 0.1, SampleRate.ir), 0.5, 0.5) * 72
	];

	signal = WaveTerrain.ar(
				bufnum,
				phase[0],
				phase[1],
				72,
				72
	);

	// signal = LeakDC.ar(signal);
	signal = BufCombC.ar(LocalBuf(SampleRate.ir), signal, modY.linexp(0, 1, 1, 80).reciprocal, 0.1 * env);
	signal = signal.dup * amp * gateEnv;
	// signal = Pan2.ar(signal, island.linlin(0, 3, -1 , 1)) * amp * gateEnv;
	Out.ar(0, signal);
}).store.add;
);

~blasted = Synth("BlastedWasteland", [\bufnum, ~wasteland.bufnum]);
~blasted.set(\t_trig, 1, \x, rrand(1, 430), \y, rrand(-200, 200), \z, rrand(1, 430));
~blasted.set(\gate, 0);

(
SynthDef.new("SkyrimBelongsToTheNords",{
	|amp=0.125, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0|
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

	// signal = BufCombC.ar(LocalBuf(SampleRate.ir), signal, modY.linexp(0, 1, 1, 80).reciprocal, 0.1 * env);
	signal = signal * amp * gateEnv;

	signal = Select.ar(
		Rand(0, 2),
		[
			[
				signal,
				BufCombC.ar(LocalBuf(SampleRate.ir), signal, modY.linexp(0, 1, 1, 20).reciprocal, 0.1 * env)
			],

			[
				signal,
				signal
			]/*,

			[
				BufCombC.ar(LocalBuf(SampleRate.ir), signal, x.linexp(1, 430, 1, 80).reciprocal, 0.1 * env),
				BufCombC.ar(LocalBuf(SampleRate.ir), signal, z.linexp(1, 430, 1, 80).reciprocal, 0.1 * env)
			],

			[
				LPF.ar(signal, modY.linexp(0, 1, 20, 20000)),
				LPF.ar(signal, modY.linexp(0, 1, 20, 20000))
			],*/
		]
	);

	Out.ar(0, signal);

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
}).store.add;
);

~skyrim = Synth("SkyrimBelongsToTheNords", [\bufnum, ~wasteland.bufnum]);
~skyrim.set(\t_trig, 1, \x, rrand(1, 430), \y, rrand(-200, 200), \z, rrand(1, 430));
~skyrim.set(\gate, 0);


(
SynthDef.new("LunchBoxMonster",{
	|amp=0.125, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0|
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

	Out.ar(0, signal * amp);
	LocalOut.ar(
		BufDelayC.ar(
			LocalBuf(SampleRate.ir),
			(signal * feedAmp).reverse.reciprocal,
			[x / 430, z / 430].linlin(0, 1, 1, 2000) / SampleRate.ir
		)
	);

}).store.add;
);

~lunchbox = Synth("LunchBoxMonster", [\bufnum, ~wasteland.bufnum]);
~lunchbox.set(\t_trig, 1, \x, rrand(1, 430), \y, rrand(-200, 200), \z, rrand(1, 430));
~lunchbox.set(\gate, 0);

(
SynthDef.new("LunchBoxMonster",{
	|amp=0.125, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0|
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

	Out.ar(0, signal * amp);
	LocalOut.ar(
		BufDelayC.ar(
			LocalBuf(SampleRate.ir),
			(signal * feedAmp).reverse.reciprocal,
			[x / 430, z / 430].linlin(0, 1, 1, 2000) / SampleRate.ir
		)
	);

}).store.add;
);

~lunchbox = Synth("LunchBoxMonster", [\bufnum, ~wasteland.bufnum]);
~lunchbox.set(\t_trig, 1, \x, rrand(1, 430), \y, rrand(-200, 200), \z, rrand(1, 430));
~lunchbox.set(\gate, 0);

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

	Out.ar(0, Limiter.ar(LeakDC.ar(signal * 0.9), 1, 0.001));

	LocalOut.ar(
		BufDelayC.ar(
			LocalBuf(SampleRate.ir),
			signal.reverse,
			[x / 430, z / 430].linlin(0, 1, 1, 2000) / SampleRate.ir
		)
	);

}).store.add;
);

~lunchbox = Synth("StalagmiteFight", [\bufnum, ~wasteland.bufnum]);
~lunchbox.set(\t_trig, 1, \x, rrand(1, 430), \y, rrand(-200, 200), \z, rrand(1, 430));
~lunchbox.set(\gate, 0);


(
SynthDef.new("AllMyFriendsAreAquatic",{
	|amp=0.1, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0|
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

	Out.ar(0, Limiter.ar(LeakDC.ar(signal + wave * 4) * amp * gateEnv, 1, 0.001));

	LocalOut.ar(
		Ringz.ar(Latch.ar(t_trig, wave) + signal, Decay.ar(wave, 5 / SampleRate.ir).linexp(-1, 1, 20, 20000), 0.05 * modY)
	);

}).store.add;
);

~aquatic = Synth("AllMyFriendsAreAquatic", [\bufnum, ~wasteland.bufnum]);
~aquatic.set(\t_trig, 1, \x, rrand(1, 430), \y, rrand(-200, 200), \z, rrand(1, 430));
~aquatic.set(\gate, 0);


