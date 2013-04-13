//////////////////////////////////////////////////////////////////////////////////////////////////////////
// GeneratedSynthDefs--Sat-Apr-13-16:19:29-2013
//////////////////////////////////////////////////////////////////////////////////////////////////////////



/////////////////////////////////////////////////////////
// Austr_Parasite.2541
/////////////////////////////////////////////////////////

SynthDef.new("Austr_Parasite.2541", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, varAustr_Parasite2548, varAustr_Parasite2549, varAustr_Parasite254110, varAustr_Parasite254111;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = varAustr_Parasite2548 = varAustr_Parasite2549 = varAustr_Parasite254110 = varAustr_Parasite254111 = K2A.ar(t_trig).dup;
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
varAustr_Parasite2548 = Median.ar(y, varAustr_Parasite254110 * wave, TExpRand.ar(env * env, EnvGen.ar(varAustr_Parasite254111, 927.58036408332 * signal, AverageOutput.ar(gateEnv * varAustr_Parasite2548, signal, LinXFade2.ar(modY, signal * modZ, 36.553644078362 * OSWrap8.ar(env, island, varAustr_Parasite2548), wave * modX), 0), gateEnv, varAustr_Parasite2548, t_trig), DecodeB2.ar(2, gate, varAustr_Parasite254111 * env, z, x)), 0);
varAustr_Parasite2549 = LPF18.ar(bufnum, WrapIndex.ar(Array.fill(2.pow(18), { |i| rrand(-1, 1) }).as(LocalBuf), island, 0.99995034606482 * modZ * modX, 0).exprange(1, SampleRate.ir), varAustr_Parasite254111, PanX2D.ar(2, 2, env, env, modY * varAustr_Parasite254110, varAustr_Parasite2548 * varAustr_Parasite254110, varAustr_Parasite2548 * modY, gateEnv * wave));
varAustr_Parasite2548 = LinCongN.ar(modX * env, wave, bufnum, varAustr_Parasite254110 * modY, modY * modY, 0.99994635065189 * BPZ2.ar(modZ, SkipNeedle.ar(amp, FMGrain.ar(gateEnv * varAustr_Parasite254110, island, env, signal * signal, wave, env, 0), gateEnv), 0), 0);
varAustr_Parasite2549 = InFeedback.ar(2.2072737186528 * modZ * gateEnv, 2);
// Variation test code
varAustr_Parasite254110 = LFNoise2.ar(modZ, modZ, 0);
varAustr_Parasite254111 = LPF1.ar(wave * modY, wave * modY);

signal = varAustr_Parasite254111;
signal = SanityCheck2.ar(signal);
			Out.ar(50, Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001));
}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// W97M.Ethan.BI
/////////////////////////////////////////////////////////

SynthDef.new("W97M.Ethan.BI", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, varW97MEthanBI8, varW97MEthanBI9, varW97MEthanBI10, varW97MEthanBI11, varW97MEthanBI12, varW97MEthanBI13;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = varW97MEthanBI8 = varW97MEthanBI9 = varW97MEthanBI10 = varW97MEthanBI11 = varW97MEthanBI12 = varW97MEthanBI13 = K2A.ar(t_trig).dup;
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
varW97MEthanBI8 = Convolution3.ar(env, varW97MEthanBI10 * gateEnv, signal * wave, gate, 0.99995044642587 * modX * varW97MEthanBI11, FMGrainBBF.ar(varW97MEthanBI13 * varW97MEthanBI9, 5.617449379893 * Convolution3.ar(gateEnv * varW97MEthanBI8, modX * varW97MEthanBI10, modZ * varW97MEthanBI10, varW97MEthanBI13 * modY, 0.99977536239351 * varW97MEthanBI8 * env, CuspL.ar(varW97MEthanBI8 * modY, 478.26016728386 * varW97MEthanBI12 * varW97MEthanBI8, Gbman2DL.ar(varW97MEthanBI12, modY * varW97MEthanBI12, amp, 5.3983749355583 * varW97MEthanBI8 * varW97MEthanBI13, 0.99668234996741 * wave * varW97MEthanBI13, 0), ScopeOut2.ar(BufAllpassN.ar(Array.fill(2.pow(20), { |i| rrand(-1, 1) }).as(LocalBuf), y, env * env, wave * gateEnv, 0.92334479065227 * Timer.ar(signal * varW97MEthanBI8), 0), modX * wave, signal, varW97MEthanBI12), 0.99994700130896 * varW97MEthanBI8 * varW97MEthanBI12, FoaProximity.ar(modZ * varW97MEthanBI12, modX, varW97MEthanBI11, 0))), varW97MEthanBI10 * env, varW97MEthanBI12 * signal, signal * varW97MEthanBI11, bufnum, z, signal * modY, z, modY * env, TwoPole.ar(signal, varW97MEthanBI12 * varW97MEthanBI12, bufnum, 0.99996234698614 * InGrainB.ar(varW97MEthanBI13 * wave, varW97MEthanBI12 * varW97MEthanBI11, signal, bufnum, 0.99995976995198 * wave * modZ, 0), 0), 0));
varW97MEthanBI9 = Slub.ar(varW97MEthanBI13 * varW97MEthanBI10, varW97MEthanBI11);
varW97MEthanBI10 = DelayC.ar(wave * env, wave * wave, 5.0656077874702 * varW97MEthanBI12 * varW97MEthanBI10, modY, 0);
varW97MEthanBI11 = BiPanB2.ar(bufnum, 50.524797514934 * varW97MEthanBI11 * env, SID6581f.ar(env * gateEnv, env * varW97MEthanBI9, wave, varW97MEthanBI8 * gateEnv, y, gateEnv * env, island, varW97MEthanBI8 * varW97MEthanBI11, varW97MEthanBI12 * env, wave * env, varW97MEthanBI10 * gateEnv, 153.83104780809 * varW97MEthanBI9 * varW97MEthanBI9, wave * modX, 59.692273610979 * YigCliffordN.ar(wave * varW97MEthanBI11, varW97MEthanBI9 * varW97MEthanBI11, gate, signal * varW97MEthanBI13, wave * varW97MEthanBI9, 228.08918267251 * varW97MEthanBI10 * varW97MEthanBI10, 37.163101926718 * gateEnv * modX, 0.99978287789381 * modX * varW97MEthanBI12, 0), AtsNoise.ar(Array.fill(2.pow(19), { |i| rrand(-1, 1) }).as(LocalBuf), z, wave, 0.99987971200021 * varW97MEthanBI10, 0).exprange(1, SampleRate.ir), StkMandolin.ar(signal * varW97MEthanBI8, RHPF.ar(varW97MEthanBI11 * wave, MoogLadder.ar(modX * varW97MEthanBI13, modX * varW97MEthanBI10, gateEnv * varW97MEthanBI13, OnePole.ar(modZ * varW97MEthanBI13, varW97MEthanBI12 * varW97MEthanBI13, CombC.ar(varW97MEthanBI13 * gateEnv, modY, signal * varW97MEthanBI8, 111.51188248029 * varW97MEthanBI9, gateEnv, 0), 0), 0).exprange(1, SampleRate.ir), XLine.ar(AtsSynth.ar(Array.fill(2.pow(18), { |i| rrand(-1, 1) }).as(LocalBuf), varW97MEthanBI9, amp, varW97MEthanBI10 * varW97MEthanBI10, varW97MEthanBI12, LinPan2.ar(wave, EnvDetect.ar(env, varW97MEthanBI10 * varW97MEthanBI8, 134.77866641268 * RMAFoodChainL.ar(varW97MEthanBI8 * varW97MEthanBI9, env * modX, z, Ringz.ar(varW97MEthanBI10, DC.ar(gateEnv * modX).exprange(1, SampleRate.ir), gate, 0.99975794230077 * gateEnv * env, 0), 6.434985113802 * varW97MEthanBI11 * modZ, varW97MEthanBI11, modZ * modX, 218.13318416906 * varW97MEthanBI8 * env, varW97MEthanBI13 * varW97MEthanBI13, varW97MEthanBI13, varW97MEthanBI11, gateEnv * varW97MEthanBI11, amp, Blip.ar(varW97MEthanBI12 * gateEnv, varW97MEthanBI11, 0.99089620191969 * varW97MEthanBI13 * varW97MEthanBI11, 0), 0)), modZ * varW97MEthanBI10).exprange(1, SampleRate.ir), modX * modY, 0.74217980466284 * modX * signal, 0), gateEnv, gateEnv * modZ, StkBandedWG.ar(wave * modX, wave, varW97MEthanBI10 * varW97MEthanBI11, 17.81006504456 * gateEnv * gateEnv, RHPF.ar(GaussTrig.ar(varW97MEthanBI13, amp, 0.93555073602603 * modZ * modZ, 0), modZ * varW97MEthanBI10, Dust2.ar(varW97MEthanBI10 * modY, 0.99993981462895 * Limiter.ar(varW97MEthanBI12, t_trig, varW97MEthanBI12 * env), 0), 0.99989467404873 * BFManipulate.ar(varW97MEthanBI12 * wave, modZ, signal, modX * modZ, varW97MEthanBI9, modX, varW97MEthanBI13 * varW97MEthanBI12), ArrayMax.ar([BufCombL.ar(Array.fill(2.pow(13), { |i| rrand(-1, 1) }).as(LocalBuf), 203.14154871751 * gateEnv, y, varW97MEthanBI13 * gateEnv, Impulse.ar(varW97MEthanBI9 * gateEnv, RunningMax.ar(wave * varW97MEthanBI9, modZ * signal), 0.99647835906791 * signal * wave, 0), 0), MostChange.ar(signal, varW97MEthanBI11)])), LinCongN.ar(varW97MEthanBI9 * env, wave * varW97MEthanBI9, signal * varW97MEthanBI12, signal * varW97MEthanBI8, wave, 0.99886599196301 * varW97MEthanBI9 * varW97MEthanBI9, 0), varW97MEthanBI10, varW97MEthanBI10, varW97MEthanBI12 * gateEnv, 0.99929744802599 * varW97MEthanBI12, 0), 0, varW97MEthanBI8), 0.99344975355966 * wave * varW97MEthanBI9, 0), amp, modZ * varW97MEthanBI9, 1.2032907125783 * varW97MEthanBI10, varW97MEthanBI11 * varW97MEthanBI13, varW97MEthanBI10, 0.99987153778621 * gateEnv * varW97MEthanBI11, 0).exprange(1, SampleRate.ir), FoaAsymmetry.ar(varW97MEthanBI10, varW97MEthanBI10 * varW97MEthanBI12, wave, 0), modY, amp, island, varW97MEthanBI12 * varW97MEthanBI9, varW97MEthanBI11, x, varW97MEthanBI13, y, varW97MEthanBI12 * modY), gateEnv * modZ);
varW97MEthanBI12 = Warp1.ar(2, Array.fill(2.pow(12), { |i| rrand(-1, 1) }).as(LocalBuf), 15.207327786291 * wave * env, varW97MEthanBI8, 317.96098906085 * varW97MEthanBI11 * gateEnv, bufnum, wave, gateEnv, varW97MEthanBI13 * varW97MEthanBI13, 0.9999760635996 * varW97MEthanBI11 * varW97MEthanBI10, 0);
varW97MEthanBI13 = TTendency.ar(modY * modY, varW97MEthanBI11, island, modZ * env, z, 156.30369032808 * modX * signal);
varW97MEthanBI8 = MonoGrain.ar(modX * gateEnv, t_trig, island, y, 0.98073940021377 * varW97MEthanBI13 * modZ, 0);
varW97MEthanBI9 = DetectSilence.ar(z, modZ * env, 31.990491582858 * varW97MEthanBI12 * gateEnv, 60.537419945584 * varW97MEthanBI8 * varW97MEthanBI10);
varW97MEthanBI10 = Pan4.ar(signal * varW97MEthanBI11, varW97MEthanBI11 * varW97MEthanBI13, bufnum, env * gateEnv);
varW97MEthanBI11 = Dust2.ar(modY, varW97MEthanBI9, 0);
varW97MEthanBI12 = Rotate.ar(env, varW97MEthanBI11 * varW97MEthanBI11, 22.303769595611 * BufGrainB.ar(varW97MEthanBI10 * wave, varW97MEthanBI9 * varW97MEthanBI13, bufnum, varW97MEthanBI8 * gateEnv, modY * modY, bufnum, 29.88951249128 * varW97MEthanBI12 * modX, 0.99954450858194 * varW97MEthanBI12 * varW97MEthanBI11, 0), signal, modX);
varW97MEthanBI13 = Compander.ar(t_trig, LinCongC.ar(BFDecode1.ar(gateEnv * modZ, VDiskIn.ar(2, Array.fill(2.pow(16), { |i| rrand(-1, 1) }).as(LocalBuf), varW97MEthanBI13 * wave, island, varW97MEthanBI11 * wave), amp, varW97MEthanBI13 * varW97MEthanBI12, varW97MEthanBI10 * signal, varW97MEthanBI8 * signal, modX * env, varW97MEthanBI11, SinGrainI.ar(varW97MEthanBI12 * varW97MEthanBI11, varW97MEthanBI11 * env, varW97MEthanBI13 * varW97MEthanBI13, bufnum, bufnum, varW97MEthanBI8 * modX, OSTrunc4.ar(wave * gateEnv, 1068.9503429584 * Clip.ar(164.70763472806 * varW97MEthanBI11 * modY, 2423.8437940687 * varW97MEthanBI10 * varW97MEthanBI12, t_trig)), 0)).exprange(1, SampleRate.ir), bufnum, varW97MEthanBI11, varW97MEthanBI10 * env, wave * varW97MEthanBI8, Tap.ar(Array.fill(2.pow(19), { |i| rrand(-1, 1) }).as(LocalBuf), 2, 149.29846783749 * OSFold4.ar(modX * gateEnv, varW97MEthanBI11, MeanTriggered.ar(modZ * varW97MEthanBI13, wave * varW97MEthanBI8, env * wave, 0.99997782359539 * modX * varW97MEthanBI8, 0))), 0), 12.589583088194 * varW97MEthanBI8, gateEnv, wave * env, varW97MEthanBI13, env * varW97MEthanBI10, 0.99800976925228 * varW97MEthanBI12 * modX, 0);

signal = varW97MEthanBI13;
signal = SanityCheck2.ar(signal);
			Out.ar(50, Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001));
}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// W97M.Ethan.BI1
/////////////////////////////////////////////////////////

SynthDef.new("W97M.Ethan.BI1", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, varW97MEthanBI8, varW97MEthanBI9, varW97MEthanBI10, varW97MEthanBI11, varW97MEthanBI12, varW97MEthanBI13, varW97MEthanBI114, varW97MEthanBI115, varW97MEthanBI116, varW97MEthanBI117;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = varW97MEthanBI8 = varW97MEthanBI9 = varW97MEthanBI10 = varW97MEthanBI11 = varW97MEthanBI12 = varW97MEthanBI13 = varW97MEthanBI114 = varW97MEthanBI115 = varW97MEthanBI116 = varW97MEthanBI117 = K2A.ar(t_trig).dup;
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
varW97MEthanBI8 = Dust.ar(wave * varW97MEthanBI13, 0.99993478238419 * varW97MEthanBI9 * modX, 0);
varW97MEthanBI9 = OSWrap4.ar(varW97MEthanBI13 * wave, varW97MEthanBI11 * modX, varW97MEthanBI116 * gateEnv);
varW97MEthanBI10 = LatoocarfianC.ar(varW97MEthanBI8, varW97MEthanBI13 * varW97MEthanBI13, env * varW97MEthanBI9, z, varW97MEthanBI13, varW97MEthanBI11 * varW97MEthanBI114, 7.2695783081334 * modZ * varW97MEthanBI13, varW97MEthanBI115, 0);
varW97MEthanBI11 = Ramp.ar(varW97MEthanBI9, 77.980897898131 * modY * varW97MEthanBI10, 0.99600924967579 * varW97MEthanBI116 * modY, 0);
varW97MEthanBI12 = IndexL.ar(Array.fill(2.pow(19), { |i| rrand(-1, 1) }).as(LocalBuf), wave * varW97MEthanBI9, varW97MEthanBI9, 0);
varW97MEthanBI13 = StkClarinet.ar(varW97MEthanBI116 * signal, varW97MEthanBI12 * varW97MEthanBI12, varW97MEthanBI114 * varW97MEthanBI114, varW97MEthanBI12 * env, 14.327556225726 * varW97MEthanBI11 * gateEnv, varW97MEthanBI117, FincoSprottL.ar(varW97MEthanBI8 * varW97MEthanBI114, wave * varW97MEthanBI116, modX * varW97MEthanBI114, varW97MEthanBI115 * varW97MEthanBI117, varW97MEthanBI11 * varW97MEthanBI117, varW97MEthanBI8 * varW97MEthanBI9, 0.99881096589586 * varW97MEthanBI9 * varW97MEthanBI117, CircleRamp.ar(x, bufnum, varW97MEthanBI8, varW97MEthanBI13, BBandStop.ar(bufnum, varW97MEthanBI11 * varW97MEthanBI13, gateEnv, varW97MEthanBI115, 0), 0)), 0.91462415131478 * SwitchDelay.ar(env * varW97MEthanBI114, varW97MEthanBI12, z, modX, varW97MEthanBI13 * modZ, modZ * modZ, DetectIndex.ar(Array.fill(2.pow(14), { |i| rrand(-1, 1) }).as(LocalBuf), varW97MEthanBI116 * varW97MEthanBI8, LinExp.ar(signal, BLowPass.ar(varW97MEthanBI8 * varW97MEthanBI116, NestedAllpassC.ar(modY * varW97MEthanBI116, gate, Hasher.ar(4.1230552334017 * env * env, varW97MEthanBI8, 0), varW97MEthanBI115 * varW97MEthanBI11, env * modZ, bufnum, env, 0.99854135449176 * wave * varW97MEthanBI10, 0).exprange(1, SampleRate.ir), 568.07160148948 * varW97MEthanBI117, 0.94653884705254 * varW97MEthanBI9 * env, 0), Rotate2.ar(x, gate, varW97MEthanBI114 * gateEnv), env * gateEnv, varW97MEthanBI10 * modX), Perlin3.ar(amp, wave, gate)), 0), 0);
varW97MEthanBI8 = Timer.ar(LFClipNoise.ar(varW97MEthanBI12, 0.68619968886221 * varW97MEthanBI117 * wave, 0));
varW97MEthanBI9 = Trig1.ar(modY * varW97MEthanBI8, varW97MEthanBI12);
varW97MEthanBI10 = LatoocarfianN.ar(signal * varW97MEthanBI12, varW97MEthanBI117, modX, modZ * varW97MEthanBI8, gateEnv * varW97MEthanBI115, 8.0011539035296 * varW97MEthanBI11 * modZ, modZ, CombN.ar(amp, FMGrainB.ar(varW97MEthanBI9 * varW97MEthanBI11, modX, varW97MEthanBI11, modX, varW97MEthanBI13 * env, bufnum, COsc.ar(Array.fill(2.pow(17), { |i| rrand(-1, 1) }).as(LocalBuf), wave, varW97MEthanBI114 * varW97MEthanBI8, 0.89273818764363 * varW97MEthanBI8 * varW97MEthanBI114, 0), 0), varW97MEthanBI116 * varW97MEthanBI8, varW97MEthanBI116 * varW97MEthanBI114, 0.02891842685132 * varW97MEthanBI8 * varW97MEthanBI13, 0), 0);
varW97MEthanBI11 = AllpassC.ar(t_trig, z, gateEnv, amp, MarkovSynth.ar(varW97MEthanBI115, varW97MEthanBI10 * env, z, varW97MEthanBI9), 0);
varW97MEthanBI12 = BufGrainIBF.ar(BinData.ar(Array.fill(2.pow(19), { |i| rrand(-1, 1) }).as(LocalBuf), bufnum, wave * varW97MEthanBI9), modZ * modX, bufnum, modY * varW97MEthanBI8, y, bufnum, bufnum, varW97MEthanBI11, z, env * varW97MEthanBI9, varW97MEthanBI11, gate, y, modY, 0);
varW97MEthanBI13 = BufAllpassN.ar(Array.fill(2.pow(14), { |i| rrand(-1, 1) }).as(LocalBuf), 31.797843976835 * varW97MEthanBI13 * varW97MEthanBI12, varW97MEthanBI9 * varW97MEthanBI8, signal * varW97MEthanBI114, 0.99779135340604 * varW97MEthanBI9 * env, 0);
// Variation test code
varW97MEthanBI114 = EnvGen.ar(signal * env, varW97MEthanBI12 * varW97MEthanBI9, modY * gateEnv, 315.29776802594 * gateEnv * varW97MEthanBI12, varW97MEthanBI9 * modZ, varW97MEthanBI115 * wave);
varW97MEthanBI115 = GaussTrig.ar(signal, gate, 0.95614614420059 * varW97MEthanBI117 * modZ, 0);
varW97MEthanBI116 = LPFVS6.ar(island, varW97MEthanBI9 * varW97MEthanBI11, z);
varW97MEthanBI117 = FoaProximity.ar(varW97MEthanBI114 * varW97MEthanBI8, varW97MEthanBI11, modZ, 0);

signal = varW97MEthanBI117;
signal = SanityCheck2.ar(signal);
			Out.ar(50, Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001));
}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




