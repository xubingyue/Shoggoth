//////////////////////////////////////////////////////////////////////////////////////////////////////////
// GeneratedSynthDefs--Fri-Nov-22-23:30:33-2013
//////////////////////////////////////////////////////////////////////////////////////////////////////////

(

/////////////////////////////////////////////////////////
// Trojan.Fixed2329131
/////////////////////////////////////////////////////////

SynthDef.new("Trojan.Fixed2329131", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varTrojanFixed2329139, varTrojanFixed23291310, varTrojanFixed23291311, varTrojanFixed232913112, varTrojanFixed232913113, varTrojanFixed232913114, varTrojanFixed232913115;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varTrojanFixed2329139 = varTrojanFixed23291310 = varTrojanFixed23291311 = varTrojanFixed232913112 = varTrojanFixed232913113 = varTrojanFixed232913114 = varTrojanFixed232913115 = K2A.ar(t_trig).dup;
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
varTrojanFixed2329139 = Median.ar(varTrojanFixed232913112 * varTrojanFixed2329139, gate, wave, CombFormlet.ar(wave * DC.ar(0.79862558841705), wave * DC.ar(0.9336838722229), wave * DC.ar(0.16714227199554), wave * DC.ar(0.48582434654236), wave * DC.ar(0.23395645618439), wave * DC.ar(0.97505724430084), wave * DC.ar(0.32645273208618)));
varTrojanFixed23291310 = Gendy2.ar(varTrojanFixed232913112 * varTrojanFixed232913112, 0.6427196264267 * wave * signal, varTrojanFixed232913115, env, in * varTrojanFixed232913112, Disintegrator.ar(wave * DC.ar(0.84186697006226), wave * DC.ar(0.5062392950058), wave * DC.ar(0.27448117733002), wave * DC.ar(0.99990212917328), wave * DC.ar(0.18899035453796)).exprange(1, SampleRate.ir), varTrojanFixed232913112, 0.47168803215027 * varTrojanFixed2329139 * wave, 0.35779988765717 * wave, varTrojanFixed2329139 * wave, z, varTrojanFixed232913114 * gateEnv, 0.99953431196596 * varTrojanFixed2329139 * modZ, Silent.ar());
varTrojanFixed23291311 = SID6581f.ar(in * in, varTrojanFixed232913112 * modY, env, varTrojanFixed23291310 * varTrojanFixed23291311, varTrojanFixed23291311 * wave, 0.036266326904297 * env * wave, env * in, varTrojanFixed232913112, signal, modY * varTrojanFixed232913112, gateEnv * varTrojanFixed232913112, env, modY, modZ, varTrojanFixed232913113, modY * modX, modY, varTrojanFixed232913115 * varTrojanFixed232913112, varTrojanFixed232913112, 0.8010413646698 * modZ * gateEnv, 0.62138307094574 * varTrojanFixed232913113 * varTrojanFixed232913114, varTrojanFixed232913113, varTrojanFixed23291311 * varTrojanFixed23291310, modX, gateEnv, x);
varTrojanFixed2329139 = Phasor.ar(wave * DC.ar(0.26759719848633), wave * DC.ar(0.51237154006958), wave * DC.ar(0.64767146110535), wave * DC.ar(0.60437905788422), wave * DC.ar(0.046896696090698));
varTrojanFixed23291310 = BinData.ar(Array.fill(2.pow(11), { |i| rrand(-1, 1) }).as(LocalBuf), in * varTrojanFixed232913112.lag3ud(wave * DC.ar(0.65770173072815), wave * DC.ar(0.35198664665222)), varTrojanFixed232913115 * varTrojanFixed2329139);
varTrojanFixed23291311 = FoaPressX.ar(varTrojanFixed23291310, FoaTilt.ar(varTrojanFixed2329139 * varTrojanFixed232913115, 0.025725364685059 * in, 0.99965730488352 * gateEnv * signal, Silent.ar()), 0.98721090237737 * varTrojanFixed23291311 * modY, Silent.ar());
// Variation test code
varTrojanFixed232913112 = EnvGen.ar(varTrojanFixed232913113 * gateEnv, 0.97150921821594 * modX * modZ.blend(varTrojanFixed23291311 * DC.ar(0.1918523311615), varTrojanFixed2329139 * DC.ar(0.27404463291168)), varTrojanFixed232913113, varTrojanFixed232913112 * modY, 0.54481780529022 * varTrojanFixed232913114 * varTrojanFixed23291311, varTrojanFixed232913113 * modZ);
varTrojanFixed232913113 = FreeVerb.ar(varTrojanFixed232913115, PeakEQ4.ar(modY * modZ, modZ, modZ * varTrojanFixed232913112, 0.36808729171753 * gateEnv * varTrojanFixed232913115), 0.28994596004486 * varTrojanFixed232913113 * wave, env * modZ, modZ, Silent.ar());
varTrojanFixed232913114 = T2A.ar(varTrojanFixed232913113 * gateEnv.unipolar(varTrojanFixed2329139 * DC.ar(0.042109370231628)), wave * gateEnv);
varTrojanFixed232913115 = FoaNFC.ar(varTrojanFixed23291311, in, 0.97607513882099 * signal * signal, Silent.ar());
varTrojanFixed232913112 = IIRFilter.ar(env * varTrojanFixed23291310, varTrojanFixed232913114, varTrojanFixed232913115 * modZ, 0.99469885158303 * varTrojanFixed23291310, Silent.ar());
varTrojanFixed232913113 = LFNoise1.ar(varTrojanFixed232913113 * signal, varTrojanFixed2329139, Silent.ar());
varTrojanFixed232913114 = LFDNoise3.ar(in, SinGrainI.ar(varTrojanFixed2329139 * DC.ar(0.34274804592133), varTrojanFixed23291311 * DC.ar(0.036516666412354), varTrojanFixed2329139 * DC.ar(0.26964008808136), varTrojanFixed23291311 * DC.ar(0.95624673366547), varTrojanFixed23291310 * DC.ar(0.20340871810913), varTrojanFixed23291311 * DC.ar(0.030667543411255), varTrojanFixed23291311 * DC.ar(0.60934460163116), varTrojanFixed2329139 * DC.ar(0.75392830371857)), Silent.ar());
varTrojanFixed232913115 = LatoocarfianN.ar(in * varTrojanFixed232913115.clip(varTrojanFixed23291310 * DC.ar(0.84591603279114), varTrojanFixed2329139 * DC.ar(0.60283005237579)), amp, varTrojanFixed232913115 * wave, varTrojanFixed232913114, modZ * varTrojanFixed232913112, varTrojanFixed23291311 * varTrojanFixed232913114, wave, 0.93949623032991 * varTrojanFixed23291311 * modY, Silent.ar());
varTrojanFixed232913112 = Shaper.ar(Array.fill(2.pow(13), { |i| rrand(-1, 1) }).as(LocalBuf), varTrojanFixed232913113, 0.99998076040249 * varTrojanFixed232913113 * modZ, Silent.ar());
varTrojanFixed232913113 = LPCVals.ar(Array.fill(2.pow(11), { |i| rrand(-1, 1) }).as(LocalBuf), x);
varTrojanFixed232913114 = Integrator.ar(varTrojanFixed232913112, varTrojanFixed232913112 * env, TDelay.ar(varTrojanFixed23291311 * DC.ar(0.13371694087982), varTrojanFixed23291310 * DC.ar(0.3264434337616)), Silent.ar());
varTrojanFixed232913115 = DemandEnvGen.ar(varTrojanFixed23291311 * modY, modZ, varTrojanFixed232913112 * wave, in * varTrojanFixed2329139, gateEnv * varTrojanFixed232913114, modZ * env, t_trig, varTrojanFixed23291310 * varTrojanFixed232913114, signal * signal, varTrojanFixed232913112 * modY);

signal = varTrojanFixed232913115;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Barr.12222329131
/////////////////////////////////////////////////////////

SynthDef.new("Barr.12222329131", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varBarr12222329139, varBarr1222232913110, varBarr1222232913111;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varBarr12222329139 = varBarr1222232913110 = varBarr1222232913111 = K2A.ar(t_trig).dup;
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
varBarr12222329139 = Lag3.ar(DoubleNestedAllpassN.ar(gate.lag2(wave * DC.ar(0.89981651306152), wave * DC.ar(0.24395561218262)), modY * varBarr1222232913111, 0.4374303817749 * varBarr1222232913110 * env, varBarr1222232913111 * modY, bufnum, 0.4072437286377 * gateEnv * in, gateEnv * varBarr1222232913110, gate, varBarr12222329139, y, 0.70589449686396 * gateEnv, Silent.ar()), island, gateEnv, Silent.ar());
varBarr12222329139 = EnvDetect.ar(varBarr1222232913111 * modY, varBarr12222329139 * modX, Fold.ar(in * varBarr1222232913111, 0.6044774055481 * in * varBarr12222329139, in * modY));
// Variation test code
varBarr1222232913110 = AtsNoiSynth.ar(Array.fill(2.pow(16), { |i| rrand(-1, 1) }).as(LocalBuf), varBarr12222329139 * signal, wave * in, env * varBarr1222232913110, t_trig, signal * gateEnv, gateEnv * signal, in, gateEnv, signal * modX, x, y, 0.91435553669192 * modZ * env, Silent.ar().fold(varBarr12222329139 * DC.ar(0.65301096439362), varBarr12222329139 * DC.ar(0.39123690128326)));
varBarr1222232913111 = StandardN.ar(Lorenz2DN.ar(varBarr12222329139 * DC.ar(0.20254182815552), varBarr12222329139 * DC.ar(0.80256402492523), varBarr12222329139 * DC.ar(0.62925970554352), varBarr12222329139 * DC.ar(0.77988708019257), varBarr12222329139 * DC.ar(0.55883717536926), varBarr12222329139 * DC.ar(0.1020565032959), varBarr12222329139 * DC.ar(0.17564558982849), varBarr12222329139 * DC.ar(0.77357828617096), varBarr12222329139 * DC.ar(0.48208820819855), varBarr12222329139 * DC.ar(0.67302942276001), varBarr12222329139 * DC.ar(0.91890013217926)).exprange(1, SampleRate.ir), t_trig, modX, varBarr12222329139, 0.98790328770293 * TPV.ar(varBarr12222329139 * DC.ar(0.23365771770477), varBarr12222329139 * DC.ar(0.83635795116425), varBarr12222329139 * DC.ar(0.96840691566467), varBarr12222329139 * DC.ar(0.79383230209351), varBarr12222329139 * DC.ar(0.33139896392822), varBarr12222329139 * DC.ar(0.20242130756378), varBarr12222329139 * DC.ar(0.14909279346466), varBarr12222329139 * DC.ar(0.031870365142822), varBarr12222329139 * DC.ar(0.062393546104431), varBarr12222329139 * DC.ar(0.50498366355896)), Silent.ar());
varBarr1222232913110 = BufCombN.ar(Array.fill(2.pow(11), { |i| rrand(-1, 1) }).as(LocalBuf), gateEnv * varBarr1222232913111, varBarr1222232913110 * modY, gateEnv * signal, 0.80904174343761 * in * varBarr12222329139, Silent.ar());
varBarr1222232913111 = Lag2.ar(gateEnv, modY, 0.98530301004949 * MdaPiano.ar(varBarr12222329139 * DC.ar(0.16482865810394), varBarr12222329139 * DC.ar(0.59070909023285), varBarr12222329139 * DC.ar(0.24324703216553), varBarr12222329139 * DC.ar(0.80632221698761), varBarr12222329139 * DC.ar(0.73635816574097), varBarr12222329139 * DC.ar(0.67705190181732), varBarr12222329139 * DC.ar(0.6634840965271), varBarr12222329139 * DC.ar(0.14866244792938), varBarr12222329139 * DC.ar(0.73430061340332), varBarr12222329139 * DC.ar(0.7088303565979), varBarr12222329139 * DC.ar(0.63300406932831), varBarr12222329139 * DC.ar(0.16916728019714), varBarr12222329139 * DC.ar(0.11489522457123), varBarr12222329139 * DC.ar(0.6712007522583), varBarr12222329139 * DC.ar(0.31360769271851), varBarr12222329139 * DC.ar(0.38481903076172), varBarr12222329139 * DC.ar(0.88045883178711)), Silent.ar());
varBarr1222232913110 = FBSineC.ar(signal * modZ, amp, signal * modX, gateEnv, 0.47047543525696 * signal * varBarr12222329139, gateEnv, modX * modZ, MoogVCF.ar(varBarr12222329139 * DC.ar(0.59022855758667), varBarr12222329139 * DC.ar(0.49387979507446), varBarr12222329139 * DC.ar(0.51483297348022), varBarr12222329139 * DC.ar(0.61331272125244), varBarr12222329139 * DC.ar(0.51866912841797)), Silent.ar());
varBarr1222232913111 = Select.ar(wave * modZ, [WaveletDaub.ar(varBarr12222329139 * DC.ar(0.33532524108887), varBarr12222329139 * DC.ar(0.47578644752502), varBarr12222329139 * DC.ar(0.88885104656219), varBarr12222329139 * DC.ar(0.59236311912537), varBarr12222329139 * DC.ar(0.65334808826447)), AtsParInfo.ar(varBarr12222329139 * DC.ar(0.93352830410004), varBarr12222329139 * DC.ar(0.42596328258514), varBarr12222329139 * DC.ar(0.23878335952759), varBarr12222329139 * DC.ar(0.50356590747833), varBarr12222329139 * DC.ar(0.24502384662628))]);

signal = varBarr1222232913111;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// VBS.European.A@mm232913
/////////////////////////////////////////////////////////

SynthDef.new("VBS.European.A@mm232913", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varVBSEuropeanAmm2329139, varVBSEuropeanAmm23291310;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varVBSEuropeanAmm2329139 = varVBSEuropeanAmm23291310 = K2A.ar(t_trig).dup;
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
varVBSEuropeanAmm2329139 = LocalIn.ar(2, modZ);
varVBSEuropeanAmm23291310 = DelayN.ar(env * wave, varVBSEuropeanAmm2329139 * varVBSEuropeanAmm23291310, gate, 0.99998053272711 * in * modX, Silent.ar());
varVBSEuropeanAmm2329139 = FoaZoomZ.ar(0.29173398017883 * env * gateEnv, varVBSEuropeanAmm23291310, 0.99993569865978 * env * wave, Gbman2DN.ar(wave * DC.ar(0.89540612697601), wave * DC.ar(0.07412314414978), wave * DC.ar(0.04020094871521), wave * DC.ar(0.073963642120361), wave * DC.ar(0.018983721733093), wave * DC.ar(0.85431861877441)));
varVBSEuropeanAmm23291310 = LFNoise2.ar(in * varVBSEuropeanAmm23291310, RedLbyl.ar(wave * DC.ar(0.49217510223389), wave * DC.ar(0.42524099349976), wave * DC.ar(0.57013344764709)), Silent.ar());

signal = varVBSEuropeanAmm23291310;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// SymbOS.Skulls.BO232914
/////////////////////////////////////////////////////////

SynthDef.new("SymbOS.Skulls.BO232914", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varSymbOSSkullsBO2329149, varSymbOSSkullsBO23291410, varSymbOSSkullsBO23291411, varSymbOSSkullsBO23291412, varSymbOSSkullsBO23291413, varSymbOSSkullsBO23291414;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varSymbOSSkullsBO2329149 = varSymbOSSkullsBO23291410 = varSymbOSSkullsBO23291411 = varSymbOSSkullsBO23291412 = varSymbOSSkullsBO23291413 = varSymbOSSkullsBO23291414 = K2A.ar(t_trig).dup;
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
varSymbOSSkullsBO2329149 = BLBufRd.ar(Array.fill(2.pow(11), { |i| rrand(-1, 1) }).as(LocalBuf), SinGrainI.ar(LPFVS6.ar(wave * DC.ar(0.7565643787384), wave * DC.ar(0.92325520515442), wave * DC.ar(0.36812484264374)), varSymbOSSkullsBO2329149 * env, modY * varSymbOSSkullsBO23291411, bufnum, bufnum, gate, varSymbOSSkullsBO23291412, LatoocarfianC.ar(wave * DC.ar(0.97119295597076), wave * DC.ar(0.58994746208191), wave * DC.ar(0.68490195274353), wave * DC.ar(0.54735732078552), wave * DC.ar(0.68935310840607), wave * DC.ar(0.083839535713196), wave * DC.ar(0.93635642528534), wave * DC.ar(0.82671654224396), wave * DC.ar(0.52408742904663))), gate);
varSymbOSSkullsBO23291410 = CuspN.ar(modY, varSymbOSSkullsBO23291411, 0.038950800895691 * signal * in, varSymbOSSkullsBO23291414 * varSymbOSSkullsBO2329149, wave, Silent.ar());
varSymbOSSkullsBO23291411 = HPF.ar(gateEnv, in * varSymbOSSkullsBO23291414, 0.89173498669038 * Slub.ar(wave * DC.ar(0.68358135223389), wave * DC.ar(0.44890999794006)), Silent.ar());
varSymbOSSkullsBO23291412 = GbmanN.ar(modX * varSymbOSSkullsBO23291412, varSymbOSSkullsBO2329149 * env, env * env, varSymbOSSkullsBO23291414, T2A.ar(wave * DC.ar(0.50140774250031), wave * DC.ar(0.40703618526459)));
varSymbOSSkullsBO23291413 = Gbman2DC.ar(env * varSymbOSSkullsBO23291414, wave * env, t_trig, gateEnv * in, RHPF.ar(wave * DC.ar(0.77579140663147), wave * DC.ar(0.4293806552887), wave * DC.ar(0.89503479003906), wave * DC.ar(0.65494000911713), wave * DC.ar(0.54671192169189)), Silent.ar());
varSymbOSSkullsBO23291414 = PV_JensenAndersen.ar(Array.fill(2.pow(13), { |i| rrand(-1, 1) }).as(LocalBuf), Osc.ar(Array.fill(2.pow(13), { |i| rrand(-1, 1) }).as(LocalBuf), wave * varSymbOSSkullsBO2329149, y, 0.99906976211824 * varSymbOSSkullsBO23291414 * modY, Silent.ar()), varSymbOSSkullsBO2329149, varSymbOSSkullsBO23291411, signal, varSymbOSSkullsBO2329149, varSymbOSSkullsBO23291411 * modZ);
varSymbOSSkullsBO2329149 = GaussTrig.ar(wave * DC.ar(0.86418461799622), wave * DC.ar(0.62509989738464), wave * DC.ar(0.79381215572357), wave * DC.ar(0.8993536233902));
varSymbOSSkullsBO23291410 = AtsPartial.ar(wave * DC.ar(0.44958817958832), wave * DC.ar(0.17078900337219), wave * DC.ar(0.9404149055481), wave * DC.ar(0.70058441162109), wave * DC.ar(0.4147469997406), wave * DC.ar(0.63130903244019), wave * DC.ar(0.35388171672821));
varSymbOSSkullsBO23291411 = BeatWarper.ar(2, Array.fill(2.pow(16), { |i| rrand(-1, 1) }).as(LocalBuf).madd(wave * DC.ar(0.89264917373657), wave * DC.ar(0.43054497241974)), wave * varSymbOSSkullsBO23291411, modZ * modY, gateEnv * gateEnv, 0.0052586793899536 * varSymbOSSkullsBO23291412 * modX, gate, varSymbOSSkullsBO23291414 * modX, varSymbOSSkullsBO23291413, Silent.ar());
varSymbOSSkullsBO23291412 = XOut.ar((80 + (island * 2)), modZ, [CuspL.ar(wave * DC.ar(0.71123659610748), wave * DC.ar(0.02651035785675), wave * DC.ar(0.86204648017883), wave * DC.ar(0.77813673019409), wave * DC.ar(0.65021741390228), wave * DC.ar(0.66337025165558)), GlitchRHPF.ar(wave * DC.ar(0.71580195426941), wave * DC.ar(0.56267547607422), wave * DC.ar(0.35697710514069), wave * DC.ar(0.21909666061401), wave * DC.ar(0.12240040302277))]);
varSymbOSSkullsBO23291413 = TGaussRand.ar(signal * wave, varSymbOSSkullsBO23291410, modX * wave.wrap2(Dust2.ar(wave * DC.ar(0.93602395057678), wave * DC.ar(0.99784791469574), wave * DC.ar(0.67492818832397))), NestedAllpassL.ar(wave * DC.ar(0.86428022384644), wave * DC.ar(0.32062709331512), wave * DC.ar(0.079712629318237), wave * DC.ar(0.050418019294739), wave * DC.ar(0.93738090991974), wave * DC.ar(0.11493623256683), wave * DC.ar(0.10008478164673), wave * DC.ar(0.9509584903717), wave * DC.ar(0.60420107841492)), Silent.ar());
varSymbOSSkullsBO23291414 = SoftClipper8.ar(wave * DC.ar(0.24212694168091));

signal = varSymbOSSkullsBO23291414;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Ungame.B.1053232915
/////////////////////////////////////////////////////////

SynthDef.new("Ungame.B.1053232915", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varUngameB10532329159, varUngameB105323291510;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varUngameB10532329159 = varUngameB105323291510 = K2A.ar(t_trig).dup;
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
varUngameB10532329159 = PanAz.ar(2, 0.52013385295868 * modY * wave, YigCliffordL.ar(wave * DC.ar(0.69485878944397), wave * DC.ar(0.60356914997101), wave * DC.ar(0.42830109596252), wave * DC.ar(0.81475794315338), wave * DC.ar(0.18810296058655), wave * DC.ar(0.176873087883), wave * DC.ar(0.18982267379761), wave * DC.ar(0.65312731266022), wave * DC.ar(0.65731000900269)), 0.79880881309509 * wave * signal, wave * varUngameB105323291510, modY);
varUngameB105323291510 = CoinGate.ar(gateEnv * varUngameB105323291510, modZ);
varUngameB10532329159 = FreeVerb2.ar(modX, modX, modX * modZ, wave, varUngameB105323291510 * modZ, 0.99942809751292 * signal * modZ, Silent.ar());
varUngameB105323291510 = MeanTriggered.ar(wave * DC.ar(0.49350428581238), wave * DC.ar(0.7138580083847), wave * DC.ar(0.76673173904419), wave * DC.ar(0.14112710952759), wave * DC.ar(0.043751955032349));

signal = varUngameB105323291510;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Sailor.785232915
/////////////////////////////////////////////////////////

SynthDef.new("Sailor.785232915", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varSailor7852329159, varSailor78523291510, varSailor78523291511, varSailor78523291512, varSailor78523291513, varSailor78523291514, varSailor78523291515;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varSailor7852329159 = varSailor78523291510 = varSailor78523291511 = varSailor78523291512 = varSailor78523291513 = varSailor78523291514 = varSailor78523291515 = K2A.ar(t_trig).dup;
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
varSailor7852329159 = Rotate2.ar(modY, 0.061092138290405 * varSailor78523291511 * varSailor7852329159, y);
varSailor78523291510 = BufDelayC.ar(Array.fill(2.pow(13), { |i| rrand(-1, 1) }).as(LocalBuf), amp, gate, YigCliffordC.ar(wave * DC.ar(0.34683549404144), wave * DC.ar(0.41355323791504), wave * DC.ar(0.35980570316315), wave * DC.ar(0.61761236190796), wave * DC.ar(0.071915864944458), wave * DC.ar(0.2918461561203), wave * DC.ar(0.077271938323975), wave * DC.ar(0.45547962188721), wave * DC.ar(0.085933089256287)), Silent.ar());
varSailor78523291511 = Gendy1.ar(z, env, varSailor78523291512, varSailor78523291513, varSailor78523291511, varSailor78523291513 * modY, gateEnv * varSailor78523291513, env * env, y, bufnum, TRand.ar(wave * DC.ar(0.8019050359726), wave * DC.ar(0.061380624771118), wave * DC.ar(0.63257825374603)), Silent.ar());
varSailor78523291512 = RLPFD.ar(varSailor78523291515 * signal, gateEnv * modZ, varSailor7852329159 * varSailor78523291510, varSailor7852329159, 0.99997142171968 * env * env, Silent.ar());
varSailor78523291513 = AtsSynth.ar(Array.fill(2.pow(15), { |i| rrand(-1, 1) }).as(LocalBuf), in * varSailor78523291513, varSailor78523291514 * varSailor78523291515, in * varSailor78523291510, wave * varSailor78523291515, varSailor78523291512, varSailor78523291511 * varSailor78523291510, 0.99493361731743 * varSailor78523291512 * gateEnv, Silent.ar());
varSailor78523291514 = LPCAnalyzer.ar(env, QuadC.ar(wave * DC.ar(0.28867018222809), wave * DC.ar(0.25234973430634), wave * DC.ar(0.77567267417908), wave * DC.ar(0.8361793756485), wave * DC.ar(0.099589467048645), wave * DC.ar(0.15352237224579), wave * DC.ar(0.70274496078491)), modY, modZ * varSailor78523291515, PeakFollower.ar(wave * DC.ar(0.11857044696808), wave * DC.ar(0.068856835365295)), gateEnv * varSailor7852329159, island, 0.99976902997376 * modY * varSailor78523291515, FoaPushX.ar(wave * DC.ar(0.93739664554596), wave * DC.ar(0.55003392696381), wave * DC.ar(0.35985243320465), wave * DC.ar(0.16479194164276)));
varSailor78523291515 = Lag3.ar(varSailor7852329159, varSailor78523291512, 0.31191122380338 * env * in, Silent.ar());
varSailor7852329159 = PanX.ar(2, modX, varSailor78523291513 * modX, modY * varSailor7852329159, x);
varSailor78523291510 = SmoothDecimator.ar(wave * modX, varSailor78523291512 * varSailor78523291513, SN76489.ar(wave * DC.ar(0.59078478813171), wave * DC.ar(0.67810881137848), wave * DC.ar(0.50991523265839), wave * DC.ar(0.16003108024597), wave * DC.ar(0.17795038223267), wave * DC.ar(0.52369105815887), wave * DC.ar(0.90523087978363), wave * DC.ar(0.50906908512115), wave * DC.ar(0.61907243728638)), varSailor78523291513, Silent.ar());
varSailor78523291511 = Ringz.ar(modX * varSailor78523291510, varSailor78523291515 * signal, 0.40589809417725 * Delay2.ar(wave * DC.ar(0.84329164028168), wave * DC.ar(0.21346938610077), wave * DC.ar(0.0049068927764893)), LinXFade2.ar(wave * DC.ar(0.60258781909943), wave * DC.ar(0.31578540802002), wave * DC.ar(0.57119309902191), wave * DC.ar(0.25486707687378)), Silent.ar());
varSailor78523291512 = Blip.ar(in, modY * in, StkPluck.ar(wave * DC.ar(0.53417658805847), wave * DC.ar(0.14524602890015), wave * DC.ar(0.84323871135712), wave * DC.ar(0.71771347522736)), Silent.ar());
varSailor78523291513 = FoaDirectZ.ar(wave, varSailor78523291511, 0.2595254673517 * in * varSailor78523291513, Silent.ar());
varSailor78523291514 = NLFiltN.ar(varSailor78523291512 * in, x, varSailor7852329159 * varSailor7852329159, varSailor78523291512 * gateEnv, 0.079959750175476 * varSailor78523291515 * varSailor78523291513, varSailor7852329159 * varSailor78523291511, varSailor78523291511, Silent.ar());
varSailor78523291515 = TwoPole.ar(island, varSailor78523291513 * modZ, t_trig, varSailor78523291513, Silent.ar());

signal = varSailor78523291515;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Sailor.7852329151
/////////////////////////////////////////////////////////

SynthDef.new("Sailor.7852329151", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varSailor7852329159, varSailor78523291510, varSailor78523291511, varSailor78523291512, varSailor78523291513, varSailor78523291514, varSailor78523291515, varSailor785232915116;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varSailor7852329159 = varSailor78523291510 = varSailor78523291511 = varSailor78523291512 = varSailor78523291513 = varSailor78523291514 = varSailor78523291515 = varSailor785232915116 = K2A.ar(t_trig).dup;
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
varSailor7852329159 = RegaliaMitraEQ.ar(bufnum, signal * varSailor78523291511, varSailor78523291511, env * varSailor78523291515, 0.9999732951854 * XFade2.ar(wave * DC.ar(0.572429895401), wave * DC.ar(0.99788975715637), wave * DC.ar(0.28482127189636), wave * DC.ar(0.79967260360718)), Silent.ar());
varSailor78523291510 = Fold.ar(island, island, x);
varSailor78523291511 = SpruceBudworm.ar(0.073342204093933 * FMGrain.ar(wave * DC.ar(0.069328427314758), wave * DC.ar(0.87434673309326), wave * DC.ar(0.86384809017181), wave * DC.ar(0.37240564823151), wave * DC.ar(0.70125114917755), wave * DC.ar(0.7872873544693), wave * DC.ar(0.55500209331512)), 0.07634699344635 * gateEnv * varSailor78523291513, varSailor7852329159, bufnum, varSailor785232915116 * modY, varSailor785232915116 * varSailor78523291510, varSailor78523291511, varSailor7852329159, amp, varSailor78523291514 * varSailor78523291515, SinOsc.ar(wave * DC.ar(0.66446077823639), wave * DC.ar(0.96394562721252), wave * DC.ar(0.7929208278656), wave * DC.ar(0.61163508892059)), Silent.ar());
varSailor78523291512 = Slub.ar(YigClifford3DC.ar(wave * DC.ar(0.71628046035767), wave * DC.ar(0.89471280574799), wave * DC.ar(0.60894381999969), wave * DC.ar(0.057102203369141), wave * DC.ar(0.057662487030029), wave * DC.ar(0.61665344238281), wave * DC.ar(0.49441623687744), wave * DC.ar(0.84954977035522), wave * DC.ar(0.093769907951355), wave * DC.ar(0.43684661388397)), y);
varSailor78523291513 = Hilbert.ar(0.66259610652924 * in * signal, 0.99997027283622 * varSailor78523291515 * varSailor7852329159, Silent.ar());
varSailor78523291514 = XFade2.ar(varSailor78523291512 * env, varSailor78523291513 * varSailor7852329159, varSailor78523291514 * signal, in * varSailor78523291511);
varSailor78523291515 = SpruceBudworm.ar(varSailor78523291515, in * env, amp, gateEnv, z, varSailor78523291514 * modZ, in * varSailor785232915116, modZ * modZ, y, y, varSailor78523291510, Silent.ar());
varSailor7852329159 = SoftClipAmp4.ar(varSailor78523291511 * varSailor785232915116, varSailor78523291515 * varSailor78523291511, Tilt.ar(wave * DC.ar(0.098240971565247), wave * DC.ar(0.56003642082214), wave * DC.ar(0.1480907201767), wave * DC.ar(0.10256814956665), wave * DC.ar(0.30754351615906)), Silent.ar());
varSailor78523291510 = MidEQ.ar(gate, varSailor7852329159, 0.59712207317352 * modX * varSailor78523291515, FMGrainBF.ar(wave * DC.ar(0.44289481639862), wave * DC.ar(0.14966130256653), wave * DC.ar(0.8717166185379), wave * DC.ar(0.91283917427063), wave * DC.ar(0.30724227428436), wave * DC.ar(0.095319747924805), wave * DC.ar(0.46018719673157), wave * DC.ar(0.9375057220459), wave * DC.ar(0.60192608833313), wave * DC.ar(0.9513852596283), wave * DC.ar(0.941237449646)), varSailor78523291512, Silent.ar());
varSailor78523291511 = EnvFollow.ar(varSailor78523291513 * wave, varSailor785232915116 * varSailor78523291510, 0.99997569693253 * modY * varSailor78523291510, Silent.ar());
varSailor78523291512 = RMShelf2.ar(signal * modX, varSailor78523291514 * varSailor7852329159, varSailor78523291510 * varSailor78523291511, YigMandelbulbN.ar(wave * DC.ar(0.6853494644165), wave * DC.ar(0.0069694519042969), wave * DC.ar(0.16300547122955), wave * DC.ar(0.1890469789505), wave * DC.ar(0.68493330478668), wave * DC.ar(0.99543070793152), wave * DC.ar(0.054058909416199)), Silent.ar());
varSailor78523291513 = FhnTrig.ar(varSailor78523291510 * in, wave * in, modY * env, varSailor78523291511 * varSailor78523291515.fold2(FoaPressZ.ar(wave * DC.ar(0.49333989620209), wave * DC.ar(0.14156532287598), wave * DC.ar(0.84566354751587), wave * DC.ar(0.91124653816223))), modX, in * env, 0.74788880348206 * varSailor78523291510 * varSailor785232915116, varSailor78523291515 * modX, varSailor78523291513 * wave, modX, Silent.ar());
varSailor78523291514 = AtsNoise.ar(Array.fill(2.pow(11), { |i| rrand(-1, 1) }).as(LocalBuf), modX * varSailor7852329159, modZ, 0.99995874231071 * varSailor78523291512 * in, Silent.ar());
varSailor78523291515 = Changed.ar(wave * DC.ar(0.70359313488007), wave * DC.ar(0.48107600212097));
// Variation test code
varSailor785232915116 = RedLbyl.ar(modZ * modZ, varSailor78523291513, varSailor78523291511);
varSailor785232915116 = StandardN.ar(modX, varSailor7852329159 * varSailor78523291512.clip(varSailor78523291510 * DC.ar(0.42935299873352), varSailor78523291512 * DC.ar(0.74077725410461)), varSailor78523291512 * varSailor78523291515, signal, 0.98344937956161 * varSailor78523291511 * in, Silent.ar());
varSailor785232915116 = DemandEnvGen.ar(varSailor78523291510 * varSailor78523291514, varSailor78523291511 * gateEnv, modZ * varSailor785232915116, varSailor78523291512 * modX, bufnum, varSailor7852329159, varSailor7852329159 * varSailor78523291513, signal * varSailor78523291512, varSailor785232915116, varSailor78523291510 * modX);

signal = varSailor785232915116;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Jeru.1244232916
/////////////////////////////////////////////////////////

SynthDef.new("Jeru.1244232916", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varJeru12442329169, varJeru124423291610, varJeru124423291611, varJeru124423291612, varJeru124423291613, varJeru124423291614;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varJeru12442329169 = varJeru124423291610 = varJeru124423291611 = varJeru124423291612 = varJeru124423291613 = varJeru124423291614 = K2A.ar(t_trig).dup;
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
varJeru12442329169 = Metro.ar(x, varJeru124423291614 * modY, DoubleWell.ar(wave * DC.ar(0.22734653949738), wave * DC.ar(0.52197432518005), wave * DC.ar(0.53834557533264), wave * DC.ar(0.50688278675079), wave * DC.ar(0.26344430446625), wave * DC.ar(0.94518673419952), wave * DC.ar(0.84274208545685), wave * DC.ar(0.81943809986115), wave * DC.ar(0.33816778659821), wave * DC.ar(0.88671147823334)), Silent.ar());
varJeru124423291610 = DecodeB2.ar(2, wave * varJeru124423291613, bufnum, varJeru124423291614 * varJeru124423291614, 0.46943783760071 * env * varJeru124423291612);
varJeru124423291611 = FoaFocusX.ar(varJeru124423291612 * varJeru124423291613, z, 0.99998380687395 * varJeru124423291614 * varJeru124423291613, Silent.ar());
varJeru124423291612 = TBrownRand.ar(amp, modZ * wave, varJeru12442329169 * varJeru12442329169, signal * varJeru124423291613, varJeru124423291612 * varJeru124423291610, 0.9162031247508 * gateEnv * modY, Silent.ar());
varJeru124423291613 = KmeansToBPSet1.ar(signal * varJeru124423291611, BufCombL.ar(Array.fill(2.pow(14), { |i| rrand(-1, 1) }).as(LocalBuf), bufnum, varJeru12442329169, in * signal, 0.99978919276473 * QuadC.ar(wave * DC.ar(0.38345611095428), wave * DC.ar(0.55846452713013), wave * DC.ar(0.9871963262558), wave * DC.ar(0.96583604812622), wave * DC.ar(0.15028989315033), wave * DC.ar(0.8007560968399), wave * DC.ar(0.51231718063354)), Silent.ar()), modY, gateEnv, modX, modX * varJeru124423291610, island, Array.fill(2.pow(11), { |i| rrand(-1, 1) }).as(LocalBuf), LFCub.ar(wave * DC.ar(0.090604901313782), wave * DC.ar(0.68683087825775), wave * DC.ar(0.063644528388977), wave * DC.ar(0.48650527000427)), LFTri.ar(wave * DC.ar(0.47118318080902), wave * DC.ar(0.33480036258698), wave * DC.ar(0.35123729705811), wave * DC.ar(0.63592517375946)));
varJeru124423291614 = Summer.ar(varJeru12442329169, modZ * varJeru12442329169, z, x);
varJeru12442329169 = GravityGrid.ar(wave * DC.ar(0.44630193710327), wave * DC.ar(0.78833997249603), wave * DC.ar(0.4676970243454), wave * DC.ar(0.82645964622498), wave * DC.ar(0.37213838100433), wave * DC.ar(0.60132944583893), wave * DC.ar(0.86252558231354));
varJeru124423291610 = InFeedback.ar((80 + (island * 2)), 2);
varJeru124423291611 = FoaTumble.ar(wave * DC.ar(0.0404212474823), wave * DC.ar(0.0030233860015869), wave * DC.ar(0.94193434715271), wave * DC.ar(0.019356846809387));
varJeru124423291612 = Gendy5.ar(wave * DC.ar(0.90293550491333), wave * DC.ar(0.99587512016296), wave * DC.ar(0.53410375118256), wave * DC.ar(0.93547427654266), wave * DC.ar(0.43487346172333), wave * DC.ar(0.70408821105957), wave * DC.ar(0.15750014781952), wave * DC.ar(0.30906701087952), wave * DC.ar(0.83426415920258), wave * DC.ar(0.5367739200592), wave * DC.ar(0.67215085029602), wave * DC.ar(0.29834914207458));
varJeru124423291613 = BFEncode2.ar(env, modZ * varJeru124423291612, gateEnv * modX, env * wave, modY, gateEnv * in);
varJeru124423291614 = HilbertFIR.ar(modZ * env.ring1(InsideOut.ar(wave * DC.ar(0.3621392250061), wave * DC.ar(0.14657056331635), wave * DC.ar(0.096675276756287))), Array.fill(2.pow(10), { |i| rrand(-1, 1) }).as(LocalBuf));

signal = varJeru124423291614;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Win.Zorm232917
/////////////////////////////////////////////////////////

SynthDef.new("Win.Zorm232917", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varWinZorm2329179, varWinZorm23291710;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varWinZorm2329179 = varWinZorm23291710 = K2A.ar(t_trig).dup;
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
varWinZorm2329179 = BufGrain.ar(modY * in, modZ * env, bufnum, varWinZorm23291710 * varWinZorm23291710, MonoGrainBF.ar(0.70036995410919 * gateEnv, gateEnv * modX, modZ, TDelay.ar(wave * DC.ar(0.43482279777527), wave * DC.ar(0.11101162433624)), env * modZ, varWinZorm23291710 * gateEnv, modZ * modX, t_trig.exprange(wave * DC.ar(0.99724340438843), wave * DC.ar(0.004162073135376)), modY * in, 0.98392818030705 * gateEnv * modX, Silent.ar()), varWinZorm2329179 * varWinZorm2329179, wave, Convolution2L.ar(wave * DC.ar(0.99066960811615), wave * DC.ar(0.71524631977081), wave * DC.ar(0.58148837089539), wave * DC.ar(0.50603342056274), wave * DC.ar(0.90671527385712), wave * DC.ar(0.045498251914978), wave * DC.ar(0.016282439231873)));
varWinZorm23291710 = WaveTerrain.ar(Array.fill(2.pow(16), { |i| rrand(-1, 1) }).as(LocalBuf), LatoocarfianTrig.ar(varWinZorm2329179 * in, wave * modY, signal, 0.94841873645782 * BiPanB2.ar(wave * DC.ar(0.59980511665344), wave * DC.ar(0.40001058578491), wave * DC.ar(0.3349632024765), wave * DC.ar(0.28883600234985)), bufnum, signal * varWinZorm23291710, gate, in, varWinZorm2329179, Silent.ar()), Rotate.ar(signal * modZ, 0.33183288574219 * VOSIM.ar(wave * DC.ar(0.66705393791199), wave * DC.ar(0.77744901180267), wave * DC.ar(0.42596054077148), wave * DC.ar(0.17373073101044), wave * DC.ar(0.2212849855423), wave * DC.ar(0.2301070690155)), modY, wave * wave, gateEnv), signal, wave * env, 0.99766042531279 * varWinZorm23291710 * modZ, Silent.ar());
varWinZorm2329179 = Astrocade.ar(signal * in, modY * varWinZorm23291710, in * wave, varWinZorm2329179 * signal, wave * env, t_trig, wave * signal, modX * env);
varWinZorm23291710 = LFBrownNoise1.ar(wave * DC.ar(0.19044280052185), wave * DC.ar(0.77828657627106), wave * DC.ar(0.73521780967712), wave * DC.ar(0.50933837890625), wave * DC.ar(0.38464438915253));

signal = varWinZorm23291710;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// XM.Laroux.KN2329171
/////////////////////////////////////////////////////////

SynthDef.new("XM.Laroux.KN2329171", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varXMLarouxKN2329179, varXMLarouxKN232917110;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varXMLarouxKN2329179 = varXMLarouxKN232917110 = K2A.ar(t_trig).dup;
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
varXMLarouxKN2329179 = AtsNoiSynth.ar(Array.fill(2.pow(11), { |i| rrand(-1, 1) }).as(LocalBuf), bufnum, t_trig, 0.91991889476776 * FreeVerb.ar(wave * DC.ar(0.34425616264343), wave * DC.ar(0.63499391078949), wave * DC.ar(0.037538170814514), wave * DC.ar(0.84489774703979), wave * DC.ar(0.89639067649841), wave * DC.ar(0.29153954982758)), varXMLarouxKN232917110, gateEnv * wave, varXMLarouxKN232917110 * wave, gateEnv * varXMLarouxKN232917110, gateEnv, bufnum, env * wave, z, 0.99146511409356 * modZ * wave, Silent.ar());
varXMLarouxKN2329179 = NeedleRect.ar(wave * DC.ar(0.19780337810516), wave * DC.ar(0.1706405878067), wave * DC.ar(0.60157489776611), wave * DC.ar(0.20207297801971), wave * DC.ar(0.75710844993591), wave * DC.ar(0.20617234706879), wave * DC.ar(0.10789465904236));
// Variation test code
varXMLarouxKN232917110 = HenonC.ar(modX * varXMLarouxKN2329179, in * gateEnv, modZ, gate, signal * varXMLarouxKN232917110, varXMLarouxKN2329179, Select.ar(varXMLarouxKN2329179 * DC.ar(0.93498158454895), varXMLarouxKN2329179 * DC.ar(0.93902575969696)));
varXMLarouxKN232917110 = GaussTrig.ar(modX * varXMLarouxKN232917110, env * gateEnv, 0.599740805871 * modX * modZ, Silent.ar());
varXMLarouxKN232917110 = GlitchRHPF.ar(island, BBandPass.ar(varXMLarouxKN2329179 * DC.ar(0.52607250213623), varXMLarouxKN2329179 * DC.ar(0.91211700439453), varXMLarouxKN2329179 * DC.ar(0.44715237617493), varXMLarouxKN2329179 * DC.ar(0.55998456478119), varXMLarouxKN2329179 * DC.ar(0.29507803916931)).exprange(1, SampleRate.ir), modZ * varXMLarouxKN2329179, 0.99982734705124 * varXMLarouxKN232917110 * env, Silent.ar());

signal = varXMLarouxKN232917110;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Taek.1847232917
/////////////////////////////////////////////////////////

SynthDef.new("Taek.1847232917", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varTaek18472329179;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varTaek18472329179 = K2A.ar(t_trig).dup;
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
varTaek18472329179 = InGrainIBF.ar(varTaek18472329179 * in, gateEnv, in * wave, bufnum.lincurve(wave * DC.ar(0.14545440673828), wave * DC.ar(0.98586988449097), wave * DC.ar(0.9106742143631), wave * DC.ar(0.7626953125), wave * DC.ar(0.2851015329361), wave * DC.ar(0.80269706249237)), bufnum.clip(wave * DC.ar(0.70337319374084), wave * DC.ar(0.43489623069763)), in, gateEnv * env.expexp(wave * DC.ar(0.12678718566895), wave * DC.ar(0.43170773983002), wave * DC.ar(0.20279657840729), wave * DC.ar(0.28455150127411), wave * DC.ar(0.36149632930756)), varTaek18472329179 * varTaek18472329179, signal, wave, 0.9909338922707 * wave * modZ, Silent.ar());
varTaek18472329179 = Standard2DC.ar(PosRatio.ar(wave * DC.ar(0.041974902153015), wave * DC.ar(0.7036315202713), wave * DC.ar(0.72562670707703)).exprange(1, SampleRate.ir), modY, varTaek18472329179, modZ, in, wave, B2UHJ.ar(wave * DC.ar(0.6629136800766), wave * DC.ar(0.93674802780151), wave * DC.ar(0.51098382472992)));

signal = varTaek18472329179;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// HLL.12304232920
/////////////////////////////////////////////////////////

SynthDef.new("HLL.12304232920", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varHLL123042329209, varHLL1230423292010, varHLL1230423292011, varHLL1230423292012, varHLL1230423292013;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varHLL123042329209 = varHLL1230423292010 = varHLL1230423292011 = varHLL1230423292012 = varHLL1230423292013 = K2A.ar(t_trig).dup;
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
varHLL123042329209 = LagUD.ar(0.41017019748688 * modZ * varHLL1230423292012, amp, signal, 0.95045307544551 * StkModalBar.ar(wave * DC.ar(0.15864598751068), wave * DC.ar(0.41259634494781), wave * DC.ar(0.3120311498642), wave * DC.ar(0.5381932258606), wave * DC.ar(0.30275046825409), wave * DC.ar(0.10045039653778), wave * DC.ar(0.7067414522171), wave * DC.ar(0.50495445728302), wave * DC.ar(0.01727294921875), wave * DC.ar(0.38184785842896), wave * DC.ar(0.45461642742157)), UHJ2B.ar(wave * DC.ar(0.65620291233063), wave * DC.ar(0.91827917098999)));
varHLL1230423292010 = Schmidt.ar(varHLL1230423292013.lagud(wave * DC.ar(0.3394740819931), wave * DC.ar(0.5342218875885)), env * modY, wave * modZ);
varHLL1230423292011 = FMGrainBF.ar(varHLL123042329209 * varHLL1230423292011, signal * modY, varHLL123042329209 * varHLL1230423292013, modX, modX, 0.25894856452942 * varHLL1230423292010 * modX, varHLL1230423292010 * modZ, 0.01017439365387 * varHLL1230423292013 * varHLL123042329209, 0.15434968471527 * signal * env, 0.99617182306629 * modY * modY, Silent.ar());
varHLL1230423292012 = PVSynth.ar(Array.fill(2.pow(16), { |i| rrand(-1, 1) }).as(LocalBuf), bufnum, modX * env, LatoocarfianC.ar(wave * DC.ar(0.87050080299377), wave * DC.ar(0.3505779504776), wave * DC.ar(0.75371110439301), wave * DC.ar(0.22631216049194), wave * DC.ar(0.22383761405945), wave * DC.ar(0.92850136756897), wave * DC.ar(0.90666782855988), wave * DC.ar(0.5297931432724), wave * DC.ar(0.039880156517029)), gate, modZ * wave.absdif(SkipNeedle.ar(wave * DC.ar(0.093167304992676), wave * DC.ar(0.61689734458923), wave * DC.ar(0.53335130214691))), BRF.ar(wave * DC.ar(0.76764047145844), wave * DC.ar(0.96138393878937), wave * DC.ar(0.74061179161072), wave * DC.ar(0.89399385452271), wave * DC.ar(0.24643075466156)).exprange(1, SampleRate.ir), 0.99989632515355 * modX * in, Silent.ar());
varHLL1230423292013 = HyperTerrain.ar(Array.fill(2.pow(16), { |i| rrand(-1, 1) }).as(LocalBuf), varHLL1230423292013 * env, varHLL1230423292012 * modZ, bufnum, 0.89637334322674 * wave, Lag2.ar(wave * DC.ar(0.71495461463928), wave * DC.ar(0.67542707920074), wave * DC.ar(0.49516952037811), wave * DC.ar(0.84027934074402)));
varHLL123042329209 = DelayL.ar(y, gateEnv * signal, gate, 0.99560683803195 * modX * env, Silent.ar());
varHLL1230423292010 = PeakFollower.ar(varHLL123042329209 * wave, signal * modX);
varHLL1230423292011 = SoftClipAmp8.ar(varHLL1230423292011, gate, 0.99990894643553 * varHLL1230423292012 * modX, Silent.ar());
varHLL1230423292012 = RMAFoodChainL.ar(DelTapWr.ar(wave * DC.ar(0.89722001552582), wave * DC.ar(0.39148426055908)).exprange(1, SampleRate.ir), island, varHLL1230423292012 * modX, varHLL1230423292011, varHLL1230423292012, varHLL1230423292012.curvelin(wave * DC.ar(0.24500489234924), wave * DC.ar(0.80727601051331), wave * DC.ar(0.10321867465973), wave * DC.ar(0.42280614376068), wave * DC.ar(0.79912507534027), wave * DC.ar(0.31857466697693)), signal * modY, in * modX, modZ * signal, modZ, varHLL1230423292013 * gateEnv.expexp(wave * DC.ar(0.14572072029114), wave * DC.ar(0.51705014705658), wave * DC.ar(0.94456660747528), wave * DC.ar(0.79731845855713), wave * DC.ar(0.52380573749542)), 0.35522997379303 * signal * modX, island, 0.99903955696315 * LPFVS6.ar(wave * DC.ar(0.65945553779602), wave * DC.ar(0.68551886081696), wave * DC.ar(0.52077805995941)), Silent.ar());
varHLL1230423292013 = Gendy3.ar(TGaussRand.ar(gateEnv * varHLL1230423292011, modZ, signal * varHLL1230423292012, modY, Silent.ar()), FOS.ar(x, wave * varHLL123042329209, t_trig, gateEnv, modX, Silent.ar()), signal * modY, signal, varHLL1230423292012 * varHLL1230423292011, env * modY, modX * env, signal, amp, 0.99998971290357 * modY * modX, Silent.ar());

signal = varHLL1230423292013;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// HLL.123042329201
/////////////////////////////////////////////////////////

SynthDef.new("HLL.123042329201", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varHLL123042329209, varHLL1230423292010, varHLL1230423292011, varHLL1230423292012, varHLL1230423292013, varHLL12304232920114;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varHLL123042329209 = varHLL1230423292010 = varHLL1230423292011 = varHLL1230423292012 = varHLL1230423292013 = varHLL12304232920114 = K2A.ar(t_trig).dup;
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
varHLL123042329209 = RedLbyl.ar(0.22197222709656 * modZ * modZ, island, varHLL1230423292012 * modZ);
varHLL1230423292010 = FMGrainB.ar(varHLL1230423292013 * modZ, env * varHLL1230423292013, YigClifford3DC.ar(wave * DC.ar(0.61125695705414), wave * DC.ar(0.1757116317749), wave * DC.ar(0.33196306228638), wave * DC.ar(0.80519759654999), wave * DC.ar(0.89078330993652), wave * DC.ar(0.39715981483459), wave * DC.ar(0.16752207279205), wave * DC.ar(0.78314638137817), wave * DC.ar(0.69740462303162), wave * DC.ar(0.72711586952209)).exprange(1, SampleRate.ir), modZ * varHLL12304232920114, varHLL1230423292012, bufnum, signal, Silent.ar().fold2(PV_HainsworthFoote.ar(wave * DC.ar(0.33151745796204), wave * DC.ar(0.62610745429993), wave * DC.ar(0.038275003433228), wave * DC.ar(0.33159208297729), wave * DC.ar(0.3621141910553))));
varHLL1230423292011 = Select.ar(y, [WaveletDaub.ar(wave * DC.ar(0.47132301330566), wave * DC.ar(0.19041657447815), wave * DC.ar(0.57398319244385), wave * DC.ar(0.12257325649261), wave * DC.ar(0.68292927742004)), Trig1.ar(wave * DC.ar(0.46535956859589), wave * DC.ar(0.4661146402359))]);
varHLL1230423292012 = AtsParInfo.ar(Array.fill(2.pow(13), { |i| rrand(-1, 1) }).as(LocalBuf), y, InGrainI.ar(wave * DC.ar(0.54663634300232), wave * DC.ar(0.81617486476898), wave * DC.ar(0.39197528362274), wave * DC.ar(0.57101428508759), wave * DC.ar(0.9192419052124), wave * DC.ar(0.98758089542389), wave * DC.ar(0.83893442153931), wave * DC.ar(0.90552723407745)), signal, Silent.ar());
varHLL1230423292013 = TextVU.ar(modX * in, varHLL12304232920114, 0.37548434734344 * varHLL1230423292012 * varHLL1230423292010, x, x, modZ);
varHLL123042329209 = CheckBadValues.ar(varHLL1230423292011, in * env, in);
varHLL1230423292010 = TBrownRand.ar(gateEnv, varHLL1230423292011 * varHLL1230423292010, signal * varHLL1230423292011, Disintegrator.ar(signal * wave, varHLL12304232920114 * wave, 0.99977929862491 * modZ * varHLL1230423292011, 0.90377636530018 * varHLL1230423292010 * varHLL12304232920114, Silent.ar()), modX * varHLL1230423292011, 0.99675918639628 * signal * wave, ReplaceOut.ar(wave * DC.ar(0.32271492481232), wave * DC.ar(0.92819905281067)));
varHLL1230423292011 = CuspL.ar(modY, varHLL1230423292013, modZ * in, modX * modY, varHLL12304232920114, AmplitudeMod.ar(wave * DC.ar(0.3283463716507), wave * DC.ar(0.11070573329926), wave * DC.ar(0.11645913124084), wave * DC.ar(0.3061181306839), wave * DC.ar(0.34540927410126)));
varHLL1230423292012 = PV_HainsworthFoote.ar(wave * DC.ar(0.6456857919693), wave * DC.ar(0.061117172241211), wave * DC.ar(0.19018578529358), wave * DC.ar(0.89493358135223), wave * DC.ar(0.92940068244934));
varHLL1230423292013 = BufGrainBBF.ar(StkBowed.ar(wave * DC.ar(0.66856372356415), wave * DC.ar(0.97478377819061), wave * DC.ar(0.75372803211212), wave * DC.ar(0.32916104793549), wave * DC.ar(0.73112571239471), wave * DC.ar(0.54362952709198), wave * DC.ar(0.47847080230713), wave * DC.ar(0.48929297924042), wave * DC.ar(0.35976099967957), wave * DC.ar(0.36026620864868), wave * DC.ar(0.12507772445679)), amp, bufnum, varHLL12304232920114, island, bufnum, varHLL1230423292012 * gateEnv, amp, varHLL12304232920114 * gateEnv, modX * modX, varHLL1230423292010, wave, Silent.ar());
// Variation test code
varHLL12304232920114 = FoaDirectO.ar(varHLL123042329209 * signal, modZ * varHLL123042329209, 0.9999074977295 * in * varHLL1230423292012, Silent.ar());
varHLL12304232920114 = FoaFocusZ.ar(bufnum, varHLL1230423292010 * varHLL1230423292013, 0.98990641075468 * varHLL12304232920114 * varHLL123042329209, Silent.ar().lincurve(varHLL1230423292013 * DC.ar(0.037614464759827), varHLL1230423292013 * DC.ar(0.098996520042419), varHLL1230423292012 * DC.ar(0.9764256477356), varHLL1230423292011 * DC.ar(0.92177498340607), varHLL1230423292011 * DC.ar(0.44561195373535), varHLL1230423292010 * DC.ar(0.77226519584656)));
varHLL12304232920114 = Saw.ar(varHLL123042329209 * env, 0.93733162511182 * varHLL123042329209 * varHLL1230423292013, Silent.ar());

signal = varHLL12304232920114;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// HLP.4793.U232920
/////////////////////////////////////////////////////////

SynthDef.new("HLP.4793.U232920", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varHLP4793U2329209;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varHLP4793U2329209 = K2A.ar(t_trig).dup;
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
varHLP4793U2329209 = NLFiltC.ar(NeedleRect.ar(wave * DC.ar(0.538853764534), wave * DC.ar(0.57524883747101), wave * DC.ar(0.81575846672058), wave * DC.ar(0.83422541618347), wave * DC.ar(0.3818998336792), wave * DC.ar(0.49962997436523), wave * DC.ar(0.49577951431274)), z, amp, gateEnv * in, bufnum, y, 0.99982147884544 * wave * gateEnv, Silent.ar());
varHLP4793U2329209 = PVInfo.ar(wave * DC.ar(0.60276687145233), wave * DC.ar(0.82688045501709), wave * DC.ar(0.49726176261902), wave * DC.ar(0.24420952796936), wave * DC.ar(0.89100933074951));

signal = varHLP4793U2329209;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Boot.Mebratix.B232923
/////////////////////////////////////////////////////////

SynthDef.new("Boot.Mebratix.B232923", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varBootMebratixB2329239;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varBootMebratixB2329239 = K2A.ar(t_trig).dup;
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
varBootMebratixB2329239 = FoaProximity.ar(modZ, 0.67662167549133 * modX * signal, 0.64358493091465 * DelayN.ar(wave * DC.ar(0.93522655963898), wave * DC.ar(0.33057928085327), wave * DC.ar(0.35837984085083), wave * DC.ar(0.068234324455261), wave * DC.ar(0.24976003170013)), Silent.ar());
varBootMebratixB2329239 = OnePole.ar(env, wave * in, AnalyseEvents2.ar(wave * DC.ar(0.75864601135254), wave * DC.ar(0.62376153469086), wave * DC.ar(0.78831553459167), wave * DC.ar(0.66630375385284), wave * DC.ar(0.70919942855835), wave * DC.ar(0.1629581451416)), Silent.ar().lagud(wave * DC.ar(0.10407197475433), wave * DC.ar(0.14256954193115)));

signal = varBootMebratixB2329239;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Boot.Mebratix.B2329231
/////////////////////////////////////////////////////////

SynthDef.new("Boot.Mebratix.B2329231", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varBootMebratixB2329239, varBootMebratixB232923110;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varBootMebratixB2329239 = varBootMebratixB232923110 = K2A.ar(t_trig).dup;
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
varBootMebratixB2329239 = Stepper.ar(varBootMebratixB232923110 * modY.unipolar(wave * DC.ar(0.15284633636475)), 0.69486391544342 * BufAllpassL.ar(wave * DC.ar(0.56653892993927), wave * DC.ar(0.5787341594696), wave * DC.ar(0.57129192352295), wave * DC.ar(0.1239994764328), wave * DC.ar(0.88112187385559), wave * DC.ar(0.27774965763092)), in * varBootMebratixB232923110, in, wave * varBootMebratixB2329239, modX);
varBootMebratixB2329239 = Gendy3.ar(env * modZ, env * varBootMebratixB2329239, modX * varBootMebratixB232923110, 0.21804940700531 * varBootMebratixB232923110 * varBootMebratixB232923110, gateEnv, varBootMebratixB2329239, modY * varBootMebratixB232923110, Fhn2DC.ar(wave * DC.ar(0.069605827331543), wave * DC.ar(0.2851710319519), wave * DC.ar(0.086580753326416), wave * DC.ar(0.87713873386383), wave * DC.ar(0.4745579957962), wave * DC.ar(0.33226382732391), wave * DC.ar(0.0092606544494629), wave * DC.ar(0.090516805648804), wave * DC.ar(0.3536673784256), wave * DC.ar(0.98287415504456), wave * DC.ar(0.84278249740601)), gate, 0.99979350903045 * Friction.ar(wave * DC.ar(0.35798490047455), wave * DC.ar(0.81550240516663), wave * DC.ar(0.23809742927551), wave * DC.ar(0.69509589672089), wave * DC.ar(0.42217695713043), wave * DC.ar(0.25628054141998), wave * DC.ar(0.20625531673431), wave * DC.ar(0.35508477687836)), Silent.ar());
// Variation test code
varBootMebratixB232923110 = LorenzTrig.ar(varBootMebratixB232923110, modX * modY, modZ * varBootMebratixB232923110, modZ * in, 0.44238114356995 * modX * in, wave * wave, varBootMebratixB232923110 * env, y, wave * varBootMebratixB2329239, TermanWang.ar(varBootMebratixB2329239 * DC.ar(0.79090118408203), varBootMebratixB2329239 * DC.ar(0.69333648681641), varBootMebratixB2329239 * DC.ar(0.83632159233093), varBootMebratixB2329239 * DC.ar(0.20732116699219), varBootMebratixB2329239 * DC.ar(0.6858229637146), varBootMebratixB2329239 * DC.ar(0.37614560127258), varBootMebratixB2329239 * DC.ar(0.60591208934784), varBootMebratixB2329239 * DC.ar(0.3201664686203), varBootMebratixB2329239 * DC.ar(0.47122061252594), varBootMebratixB2329239 * DC.ar(0.32400870323181), varBootMebratixB2329239 * DC.ar(0.9539008140564)), Silent.ar());
varBootMebratixB232923110 = FincoSprottS.ar(FhnTrig.ar(varBootMebratixB2329239 * DC.ar(0.19129145145416), varBootMebratixB2329239 * DC.ar(0.0073651075363159), varBootMebratixB2329239 * DC.ar(0.76179802417755), varBootMebratixB2329239 * DC.ar(0.70954132080078), varBootMebratixB2329239 * DC.ar(0.43911826610565), varBootMebratixB2329239 * DC.ar(0.24886786937714), varBootMebratixB2329239 * DC.ar(0.62077021598816), varBootMebratixB2329239 * DC.ar(0.8251039981842), varBootMebratixB2329239 * DC.ar(0.91910135746002), varBootMebratixB2329239 * DC.ar(0.22812855243683), varBootMebratixB2329239 * DC.ar(0.10650849342346)).exprange(1, SampleRate.ir), 0.22210919857025 * LagUD.ar(varBootMebratixB2329239 * DC.ar(0.79965817928314), varBootMebratixB2329239 * DC.ar(0.054020643234253), varBootMebratixB2329239 * DC.ar(0.16766738891602), varBootMebratixB2329239 * DC.ar(0.61223936080933), varBootMebratixB2329239 * DC.ar(0.58783853054047)), modZ * varBootMebratixB232923110, in, StkVoicForm.ar(modY * modZ, z, modX * signal, InGrain.ar(varBootMebratixB2329239 * DC.ar(0.19351398944855), varBootMebratixB2329239 * DC.ar(0.10075533390045), varBootMebratixB2329239 * DC.ar(0.55527138710022), varBootMebratixB2329239 * DC.ar(0.87571048736572), varBootMebratixB2329239 * DC.ar(0.5116263628006)).exprange(1, SampleRate.ir), x, island, env * modX.lag2(varBootMebratixB2329239 * DC.ar(0.068953156471252), varBootMebratixB2329239 * DC.ar(0.67827701568604)).difsqr(Henon2DL.ar(varBootMebratixB2329239 * DC.ar(0.75791895389557), varBootMebratixB2329239 * DC.ar(0.92737817764282), varBootMebratixB2329239 * DC.ar(0.054588913917542), varBootMebratixB2329239 * DC.ar(0.51220774650574), varBootMebratixB2329239 * DC.ar(0.098782062530518), varBootMebratixB2329239 * DC.ar(0.39898407459259), varBootMebratixB2329239 * DC.ar(0.11178553104401), varBootMebratixB2329239 * DC.ar(0.48664879798889))), Gendy4.ar(varBootMebratixB2329239 * DC.ar(0.99101841449738), varBootMebratixB2329239 * DC.ar(0.98853719234467), varBootMebratixB2329239 * DC.ar(0.70314037799835), varBootMebratixB2329239 * DC.ar(0.84972393512726), varBootMebratixB2329239 * DC.ar(0.094631791114807), varBootMebratixB2329239 * DC.ar(0.10850417613983), varBootMebratixB2329239 * DC.ar(0.34463572502136), varBootMebratixB2329239 * DC.ar(0.36865448951721), varBootMebratixB2329239 * DC.ar(0.11402475833893), varBootMebratixB2329239 * DC.ar(0.94900357723236), varBootMebratixB2329239 * DC.ar(0.90507054328918), varBootMebratixB2329239 * DC.ar(0.44085597991943)), Silent.ar()), island, OnePole.ar(varBootMebratixB232923110 * in, modY * modY, FMGrainI.ar(varBootMebratixB2329239 * DC.ar(0.8392893075943), varBootMebratixB2329239 * DC.ar(0.91925776004791), varBootMebratixB2329239 * DC.ar(0.95971667766571), varBootMebratixB2329239 * DC.ar(0.083314657211304), varBootMebratixB2329239 * DC.ar(0.61157393455505), varBootMebratixB2329239 * DC.ar(0.24820375442505), varBootMebratixB2329239 * DC.ar(0.11102116107941), varBootMebratixB2329239 * DC.ar(0.71843159198761), varBootMebratixB2329239 * DC.ar(0.10711705684662), varBootMebratixB2329239 * DC.ar(0.99170088768005)), Silent.ar()), signal, Silent.ar());
varBootMebratixB232923110 = InGrainB.ar(YigClifford3DC.ar(varBootMebratixB2329239 * DC.ar(0.87118744850159), varBootMebratixB2329239 * DC.ar(0.6505298614502), varBootMebratixB2329239 * DC.ar(0.54091000556946), varBootMebratixB2329239 * DC.ar(0.26488065719604), varBootMebratixB2329239 * DC.ar(0.06014609336853), varBootMebratixB2329239 * DC.ar(0.6367415189743), varBootMebratixB2329239 * DC.ar(0.14623653888702), varBootMebratixB2329239 * DC.ar(0.68536424636841), varBootMebratixB2329239 * DC.ar(0.35770845413208), varBootMebratixB2329239 * DC.ar(0.98799467086792)), gateEnv * varBootMebratixB2329239, PeakEQ4.ar(signal, in, x, 0.14712274074554 * env * modY).min(Streson.ar(varBootMebratixB2329239 * DC.ar(0.76646566390991), varBootMebratixB2329239 * DC.ar(0.21407270431519), varBootMebratixB2329239 * DC.ar(0.67075526714325), varBootMebratixB2329239 * DC.ar(0.10111844539642), varBootMebratixB2329239 * DC.ar(0.096935033798218))), bufnum, 0.89771509822341 * signal * modY, Silent.ar());

signal = varBootMebratixB232923110;
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
// HLLO.42132329241
/////////////////////////////////////////////////////////

SynthDef.new("HLLO.42132329241", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varHLLO42132329249, varHLLO421323292410, varHLLO421323292411, varHLLO421323292412, varHLLO4213232924113, varHLLO4213232924114, varHLLO4213232924115, varHLLO4213232924116, varHLLO4213232924117;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varHLLO42132329249 = varHLLO421323292410 = varHLLO421323292411 = varHLLO421323292412 = varHLLO4213232924113 = varHLLO4213232924114 = varHLLO4213232924115 = varHLLO4213232924116 = varHLLO4213232924117 = K2A.ar(t_trig).dup;
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
varHLLO42132329249 = Friction.ar(0.85429894924164 * MdaPiano.ar(wave * DC.ar(0.033251285552979), wave * DC.ar(0.43743574619293), wave * DC.ar(0.93951797485352), wave * DC.ar(0.63893127441406), wave * DC.ar(0.52596402168274), wave * DC.ar(0.61191916465759), wave * DC.ar(0.084655404090881), wave * DC.ar(0.6660567522049), wave * DC.ar(0.50791323184967), wave * DC.ar(0.17726862430573), wave * DC.ar(0.15854287147522), wave * DC.ar(0.37691402435303), wave * DC.ar(0.69340765476227), wave * DC.ar(0.13488638401031), wave * DC.ar(0.14330339431763), wave * DC.ar(0.38133227825165), wave * DC.ar(0.92144846916199)), 0.30269575119019 * Wrap.ar(wave * DC.ar(0.81359052658081), wave * DC.ar(0.32842922210693), wave * DC.ar(0.27684998512268)), bufnum, 0.98956835269928 * AtsAmp.ar(wave * DC.ar(0.67007386684418), wave * DC.ar(0.43441295623779), wave * DC.ar(0.56018698215485), wave * DC.ar(0.32617425918579), wave * DC.ar(0.94457757472992)), env, modZ * varHLLO4213232924113, varHLLO4213232924114, Silent.ar());
varHLLO421323292410 = StkMandolin.ar(varHLLO4213232924113, varHLLO4213232924117 * gateEnv, varHLLO4213232924117 * modY, wave, varHLLO421323292412 * modZ, varHLLO42132329249 * wave, varHLLO4213232924114, BufWr.ar(wave * DC.ar(0.58571529388428), wave * DC.ar(0.62580227851868), wave * DC.ar(0.39013004302979), wave * DC.ar(0.31116604804993)), Silent.ar());
varHLLO421323292411 = Out.ar((80 + (island * 2)), [Friction.ar(wave * DC.ar(0.37819910049438), wave * DC.ar(0.9692474603653), wave * DC.ar(0.080499172210693), wave * DC.ar(0.61928832530975), wave * DC.ar(0.90996611118317), wave * DC.ar(0.0091395378112793), wave * DC.ar(0.55166137218475), wave * DC.ar(0.40707349777222)), Dust.ar(wave * DC.ar(0.13476431369781), wave * DC.ar(0.023223996162415), wave * DC.ar(0.0036262273788452))]);
varHLLO421323292412 = RMShelf2.ar(wave, varHLLO4213232924116 * varHLLO4213232924117, modY * in, RegaliaMitraEQ.ar(wave * DC.ar(0.68800008296967), wave * DC.ar(0.069769978523254), wave * DC.ar(0.0055911540985107), wave * DC.ar(0.90895164012909), wave * DC.ar(0.28826534748077), wave * DC.ar(0.45495343208313)), Silent.ar());
varHLLO42132329249 = FoaFocusY.ar(wave * DC.ar(0.53219628334045), wave * DC.ar(0.60359859466553), wave * DC.ar(0.45326542854309), wave * DC.ar(0.61556565761566));
varHLLO421323292410 = RMShelf.ar(gate, varHLLO42132329249, t_trig, 0.99994213889914 * Ramp.ar(wave * DC.ar(0.91875171661377), wave * DC.ar(0.88446891307831), wave * DC.ar(0.98605871200562), wave * DC.ar(0.085708379745483)), Silent.ar());
varHLLO421323292411 = HPF.ar(varHLLO421323292410 * varHLLO4213232924114, gateEnv, Decimator.ar(wave * DC.ar(0.18964540958405), wave * DC.ar(0.01864767074585), wave * DC.ar(0.19843745231628), wave * DC.ar(0.92806601524353), wave * DC.ar(0.2358238697052)), Silent.ar());
varHLLO421323292412 = LinCongN.ar(wave * DC.ar(0.28507840633392), wave * DC.ar(0.074507474899292), wave * DC.ar(0.29433166980743), wave * DC.ar(0.86061680316925), wave * DC.ar(0.27327728271484), wave * DC.ar(0.88593876361847), wave * DC.ar(0.39285147190094));
// Variation test code
varHLLO4213232924113 = LPF18.ar(amp, varHLLO4213232924115 * signal, varHLLO421323292410, varHLLO4213232924113 * varHLLO421323292411);
varHLLO4213232924114 = PeakEQ2.ar(amp, signal, 0.61618840694427 * env * varHLLO421323292411, 0.93310809135437 * env * wave);
varHLLO4213232924115 = SVF.ar(env * varHLLO4213232924117, modX * varHLLO4213232924117, varHLLO421323292412 * modY, in * modY, modX * modX, wave * varHLLO4213232924114, 0.91992509365082 * in * modX, varHLLO42132329249, 0.99994422341265 * varHLLO42132329249 * varHLLO421323292411, Silent.ar());
varHLLO4213232924116 = AmpCompA.ar(varHLLO421323292412.lagud(varHLLO421323292411 * DC.ar(0.24835729598999), varHLLO421323292411 * DC.ar(0.85430657863617)), varHLLO421323292412 * env, 0.3342809677124 * varHLLO421323292412 * gateEnv, amp);
varHLLO4213232924117 = CombL.ar(varHLLO4213232924117, x, y, env * varHLLO4213232924116, varHLLO4213232924113, Silent.ar());
varHLLO4213232924113 = B2Ster.ar(varHLLO42132329249, 0.15629041194916 * modY * modX, 0.87137615680695 * modY * varHLLO4213232924114, VOsc3.ar(varHLLO421323292412 * DC.ar(0.64840996265411), varHLLO421323292412 * DC.ar(0.79272162914276), varHLLO421323292411 * DC.ar(0.59038090705872), varHLLO42132329249 * DC.ar(0.55961728096008), varHLLO42132329249 * DC.ar(0.35102832317352), varHLLO421323292412 * DC.ar(0.9541916847229)), Silent.ar());
varHLLO4213232924114 = DoubleNestedAllpassL.ar(signal, amp, modX * varHLLO4213232924114, in.lagud(varHLLO421323292410 * DC.ar(0.62844443321228), varHLLO421323292410 * DC.ar(0.47406899929047)), wave * varHLLO4213232924117, varHLLO421323292410 * signal, in * varHLLO4213232924115, gate, varHLLO4213232924114 * varHLLO4213232924113, Spreader.ar(env * varHLLO42132329249, 0.52734768390656 * wave * varHLLO421323292410, bufnum, 0.99976672763329 * RMShelf2.ar(varHLLO421323292410 * DC.ar(0.95865702629089), varHLLO421323292411 * DC.ar(0.2885879278183), varHLLO421323292410 * DC.ar(0.66162633895874), varHLLO421323292410 * DC.ar(0.22556853294373), varHLLO421323292411 * DC.ar(0.90783596038818)), NLFiltC.ar(varHLLO42132329249 * DC.ar(0.063756108283997), varHLLO42132329249 * DC.ar(0.54456961154938), varHLLO421323292410 * DC.ar(0.75451767444611), varHLLO42132329249 * DC.ar(0.77422618865967), varHLLO421323292412 * DC.ar(0.21574795246124), varHLLO42132329249 * DC.ar(0.22818243503571), varHLLO42132329249 * DC.ar(0.56539261341095), varHLLO42132329249 * DC.ar(0.0015140771865845))), 0.99992423375963 * MoogLadder.ar(varHLLO42132329249 * DC.ar(0.59905481338501), varHLLO421323292411 * DC.ar(0.74647998809814), varHLLO421323292411 * DC.ar(0.13235759735107), varHLLO421323292411 * DC.ar(0.65907514095306), varHLLO421323292411 * DC.ar(0.30968534946442)), Silent.ar());
varHLLO4213232924115 = FitzHughNagumo.ar(in, gateEnv * modY, modX * gateEnv, 0.26904153823853 * AllpassN.ar(varHLLO421323292411 * DC.ar(0.49036777019501), varHLLO421323292410 * DC.ar(0.98873960971832), varHLLO421323292410 * DC.ar(0.80503594875336), varHLLO421323292410 * DC.ar(0.12246143817902), varHLLO42132329249 * DC.ar(0.49921345710754), varHLLO421323292411 * DC.ar(0.52684855461121)), varHLLO4213232924113 * modZ, Sieve1.ar(Array.fill(2.pow(15), { |i| rrand(-1, 1) }).as(LocalBuf), varHLLO421323292412 * varHLLO421323292410, bufnum, 0.99839701424289 * varHLLO421323292412 * modZ, Silent.ar()), env, GaussTrig.ar(varHLLO42132329249 * DC.ar(0.91662836074829), varHLLO42132329249 * DC.ar(0.32805347442627), varHLLO421323292410 * DC.ar(0.31285715103149), varHLLO421323292410 * DC.ar(0.62760758399963)).sqrsum(RunningMax.ar(varHLLO42132329249 * DC.ar(0.70162010192871), varHLLO42132329249 * DC.ar(0.77893555164337))), Silent.ar().lag2(varHLLO421323292410 * DC.ar(0.059624075889587), varHLLO421323292412 * DC.ar(0.81256496906281)));
varHLLO4213232924116 = Blip.ar(gateEnv * gateEnv, varHLLO421323292412, 0.98666109991322 * gateEnv, Silent.ar());
varHLLO4213232924117 = LocalIn.ar(2, signal * varHLLO421323292410);
varHLLO4213232924113 = Phasor.ar(varHLLO4213232924114 * varHLLO4213232924113, varHLLO421323292411, 0.42191469669342 * DoubleWell.ar(varHLLO421323292410 * DC.ar(0.67757368087769), varHLLO421323292412 * DC.ar(0.63188874721527), varHLLO421323292412 * DC.ar(0.24846589565277), varHLLO421323292410 * DC.ar(0.054544806480408), varHLLO421323292412 * DC.ar(0.89452767372131), varHLLO42132329249 * DC.ar(0.20957267284393), varHLLO42132329249 * DC.ar(0.1439882516861), varHLLO421323292412 * DC.ar(0.027022838592529), varHLLO42132329249 * DC.ar(0.31359243392944), varHLLO421323292411 * DC.ar(0.88494002819061)), gateEnv * varHLLO421323292410, gateEnv * varHLLO4213232924114);
varHLLO4213232924114 = SOS.ar(y, env, varHLLO4213232924116, varHLLO421323292411 * in, signal * gateEnv, 0.9783251285553 * signal * varHLLO42132329249.exprange(varHLLO421323292412 * DC.ar(0.047801733016968), varHLLO421323292410 * DC.ar(0.3467104434967)), 0.85328274368524 * varHLLO421323292412 * modY, Silent.ar());
varHLLO4213232924115 = Clipper32.ar(varHLLO42132329249, varHLLO42132329249 * varHLLO421323292412, varHLLO42132329249);
varHLLO4213232924116 = Osc.ar(Array.fill(2.pow(16), { |i| rrand(-1, 1) }).as(LocalBuf), varHLLO4213232924113 * varHLLO421323292411, wave, varHLLO421323292411, Silent.ar().bipolar(varHLLO421323292411 * DC.ar(0.44863533973694)));
varHLLO4213232924117 = BufGrainB.ar(SmoothDecimator.ar(varHLLO421323292411 * DC.ar(0.89704942703247), varHLLO421323292411 * DC.ar(0.56703913211823), varHLLO421323292412 * DC.ar(0.90389394760132), varHLLO421323292412 * DC.ar(0.59865486621857), varHLLO421323292412 * DC.ar(0.50789201259613)), varHLLO4213232924113 * varHLLO421323292412, bufnum, modY * varHLLO4213232924116, island, bufnum, HenonTrig.ar(varHLLO4213232924113, GrayNoise.ar(varHLLO421323292410 * DC.ar(0.47137129306793), varHLLO421323292412 * DC.ar(0.33893990516663)).exprange(1, SampleRate.ir), z, Pan2.ar(varHLLO421323292410 * DC.ar(0.018046975135803), varHLLO421323292412 * DC.ar(0.76686108112335), varHLLO421323292410 * DC.ar(0.69426906108856)), in, gate, 0.999979459684 * varHLLO4213232924113 * varHLLO4213232924115, Silent.ar()), 0.99660658644025 * modZ * signal, Silent.ar());

signal = varHLLO4213232924117;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Mammoth.mp.4893.a232925
/////////////////////////////////////////////////////////

SynthDef.new("Mammoth.mp.4893.a232925", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varMammothmp4893a2329259, varMammothmp4893a23292510, varMammothmp4893a23292511, varMammothmp4893a23292512, varMammothmp4893a23292513;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varMammothmp4893a2329259 = varMammothmp4893a23292510 = varMammothmp4893a23292511 = varMammothmp4893a23292512 = varMammothmp4893a23292513 = K2A.ar(t_trig).dup;
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
varMammothmp4893a2329259 = ToggleFF.ar(varMammothmp4893a2329259 * varMammothmp4893a2329259);
varMammothmp4893a23292510 = FoaZoomY.ar(varMammothmp4893a23292512.ring3(Clipper8.ar(wave * DC.ar(0.023818016052246), wave * DC.ar(0.83276879787445), wave * DC.ar(0.30051231384277))), 0.52197849750519 * modY * signal, 0.99901651017239 * varMammothmp4893a23292510 * varMammothmp4893a23292510, Silent.ar());
varMammothmp4893a23292511 = FoaDominateY.ar(bufnum, 0.015508651733398 * varMammothmp4893a23292512 * varMammothmp4893a2329259, 0.99997513446983 * Dust2.ar(wave * DC.ar(0.59663105010986), wave * DC.ar(0.78961777687073), wave * DC.ar(0.68079566955566)), Silent.ar());
varMammothmp4893a23292512 = LPZ1.ar(varMammothmp4893a23292511 * modZ, varMammothmp4893a23292513, Silent.ar());
varMammothmp4893a23292513 = RMShelf.ar(modX * modZ, varMammothmp4893a23292513, modY * varMammothmp4893a23292512, 0.99522419370917 * gateEnv * signal, Silent.ar());
varMammothmp4893a2329259 = FoaPushZ.ar(island, y, 0.99995540567763 * gateEnv * signal, Silent.ar());
varMammothmp4893a23292510 = MoogLadder.ar(wave * DC.ar(0.22336101531982), wave * DC.ar(0.64278852939606), wave * DC.ar(0.68647432327271), wave * DC.ar(0.1925710439682), wave * DC.ar(0.67211639881134));
varMammothmp4893a23292511 = AtsNoiSynth.ar(Array.fill(2.pow(11), { |i| rrand(-1, 1) }).as(LocalBuf), t_trig, varMammothmp4893a23292510 * varMammothmp4893a23292512, signal * wave, wave, signal * varMammothmp4893a2329259, t_trig, env * env, varMammothmp4893a23292510 * modY, varMammothmp4893a23292513 * signal, in, wave * varMammothmp4893a23292512, varMammothmp4893a23292512, Silent.ar());
varMammothmp4893a23292512 = BBandPass.ar(varMammothmp4893a2329259, LFDNoise1.ar(wave * DC.ar(0.97522699832916), wave * DC.ar(0.81413006782532), wave * DC.ar(0.29514980316162)).exprange(1, SampleRate.ir), varMammothmp4893a2329259 * env, gateEnv, Silent.ar());
varMammothmp4893a23292513 = LinPan2.ar(wave * DC.ar(0.009770393371582), wave * DC.ar(0.56256353855133), wave * DC.ar(0.90341758728027));

signal = varMammothmp4893a23292513;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Bin.Auto.AZM232928
/////////////////////////////////////////////////////////

SynthDef.new("Bin.Auto.AZM232928", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varBinAutoAZM2329289, varBinAutoAZM23292810, varBinAutoAZM23292811, varBinAutoAZM23292812;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varBinAutoAZM2329289 = varBinAutoAZM23292810 = varBinAutoAZM23292811 = varBinAutoAZM23292812 = K2A.ar(t_trig).dup;
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
varBinAutoAZM2329289 = DynKlank.ar(`[[EnvGen.ar(wave * DC.ar(0.37790155410767), wave * DC.ar(0.18793678283691), wave * DC.ar(0.17116367816925), wave * DC.ar(0.51092433929443), wave * DC.ar(0.34664869308472), wave * DC.ar(0.046677708625793)), Nes2.ar(wave * DC.ar(0.48145592212677), wave * DC.ar(0.66206848621368), wave * DC.ar(0.4281085729599), wave * DC.ar(0.88305377960205), wave * DC.ar(0.35601758956909), wave * DC.ar(0.20063841342926), wave * DC.ar(0.42201018333435), wave * DC.ar(0.27130651473999), wave * DC.ar(0.16589260101318), wave * DC.ar(0.61753332614899), wave * DC.ar(0.64665079116821), wave * DC.ar(0.50762164592743), wave * DC.ar(0.87468647956848), wave * DC.ar(0.14729630947113), wave * DC.ar(0.32852923870087), wave * DC.ar(0.086139798164368), wave * DC.ar(0.9373254776001), wave * DC.ar(0.66538405418396), wave * DC.ar(0.60668194293976), wave * DC.ar(0.54065227508545))], [AtsFreq.ar(wave * DC.ar(0.20057785511017), wave * DC.ar(0.67268788814545), wave * DC.ar(0.98054218292236), wave * DC.ar(0.95470607280731), wave * DC.ar(0.78592252731323)), BufGrain.ar(wave * DC.ar(0.59337818622589), wave * DC.ar(0.40191316604614), wave * DC.ar(0.8739777803421), wave * DC.ar(0.76883494853973), wave * DC.ar(0.10953712463379), wave * DC.ar(0.71965205669403), wave * DC.ar(0.30786466598511), wave * DC.ar(0.72119724750519))], [BufGrain.ar(wave * DC.ar(0.92025709152222), wave * DC.ar(0.60214531421661), wave * DC.ar(0.4607789516449), wave * DC.ar(0.71664476394653), wave * DC.ar(0.91727447509766), wave * DC.ar(0.33596837520599), wave * DC.ar(0.73498773574829), wave * DC.ar(0.24077701568604)), FMGrain.ar(wave * DC.ar(0.62229609489441), wave * DC.ar(0.13818621635437), wave * DC.ar(0.11882519721985), wave * DC.ar(0.62406623363495), wave * DC.ar(0.69426167011261), wave * DC.ar(0.39707398414612), wave * DC.ar(0.95792663097382))]], AllpassC.ar(wave * DC.ar(0.080095052719116), wave * DC.ar(0.13338994979858), wave * DC.ar(0.12849366664886), wave * DC.ar(0.82181072235107), wave * DC.ar(0.81280493736267), wave * DC.ar(0.94088554382324)), signal * env, Standard2DL.ar(wave * DC.ar(0.082462906837463), wave * DC.ar(0.91552805900574), wave * DC.ar(0.99131333827972), wave * DC.ar(0.56521809101105), wave * DC.ar(0.30217456817627), wave * DC.ar(0.56419539451599), wave * DC.ar(0.54964447021484)).exprange(1, SampleRate.ir), x.wrap2(NL2.ar(wave * DC.ar(0.33850157260895), wave * DC.ar(0.3639132976532), wave * DC.ar(0.01345694065094), wave * DC.ar(0.6171338558197), wave * DC.ar(0.83282351493835), wave * DC.ar(0.69383215904236), wave * DC.ar(0.33359432220459), wave * DC.ar(0.26979088783264))));
varBinAutoAZM23292810 = DriveNoise.ar(varBinAutoAZM23292810, varBinAutoAZM23292811 * varBinAutoAZM23292811, 0.85785621271835 * modX * modY);
varBinAutoAZM23292811 = LoopBuf.ar(2, Array.fill(2.pow(14), { |i| rrand(-1, 1) }).as(LocalBuf), env, y, varBinAutoAZM2329289, 0.18452143669128 * signal * varBinAutoAZM23292810, env * wave, varBinAutoAZM23292812);
varBinAutoAZM23292812 = LFBrownNoise0.ar(SanityCheck.ar(wave * DC.ar(0.97694623470306)).exprange(1, SampleRate.ir).blend(wave * DC.ar(0.26317656040192), wave * DC.ar(0.54607045650482)), env * varBinAutoAZM23292811, signal, Hilbert.ar(wave * DC.ar(0.96973395347595), wave * DC.ar(0.20947313308716), wave * DC.ar(0.64430630207062)), Silent.ar());
varBinAutoAZM2329289 = Pokey.ar(varBinAutoAZM2329289 * varBinAutoAZM23292811, varBinAutoAZM23292812, wave * env, varBinAutoAZM2329289.expexp(wave * DC.ar(0.90095889568329), wave * DC.ar(0.38407135009766), wave * DC.ar(0.93583047389984), wave * DC.ar(0.35752236843109), wave * DC.ar(0.18019807338715)), 0.55897688865662 * env * signal, RosslerL.ar(wave * DC.ar(0.057527422904968), wave * DC.ar(0.35917246341705), wave * DC.ar(0.56915855407715), wave * DC.ar(0.84308505058289), wave * DC.ar(0.62007069587708), wave * DC.ar(0.005030632019043), wave * DC.ar(0.045689940452576), wave * DC.ar(0.96019041538239), wave * DC.ar(0.22285294532776), wave * DC.ar(0.109055519104)), varBinAutoAZM2329289 * varBinAutoAZM2329289, in, z);
varBinAutoAZM23292810 = LFDNoise0.ar(wave * DC.ar(0.65170180797577), wave * DC.ar(0.27540457248688), wave * DC.ar(0.87673318386078));
varBinAutoAZM23292811 = HPZ1.ar(varBinAutoAZM23292810 * in, varBinAutoAZM2329289, Silent.ar());
varBinAutoAZM23292812 = EnvDetect.ar(wave * DC.ar(0.75250220298767), wave * DC.ar(0.16295671463013), wave * DC.ar(0.23961913585663));

signal = varBinAutoAZM23292812;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Bin.Auto.AZM2329281
/////////////////////////////////////////////////////////

SynthDef.new("Bin.Auto.AZM2329281", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varBinAutoAZM2329289, varBinAutoAZM23292810, varBinAutoAZM23292811, varBinAutoAZM23292812, varBinAutoAZM232928113, varBinAutoAZM232928114, varBinAutoAZM232928115, varBinAutoAZM232928116, varBinAutoAZM232928117;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varBinAutoAZM2329289 = varBinAutoAZM23292810 = varBinAutoAZM23292811 = varBinAutoAZM23292812 = varBinAutoAZM232928113 = varBinAutoAZM232928114 = varBinAutoAZM232928115 = varBinAutoAZM232928116 = varBinAutoAZM232928117 = K2A.ar(t_trig).dup;
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
varBinAutoAZM2329289 = IndexL.ar(Array.fill(2.pow(15), { |i| rrand(-1, 1) }).as(LocalBuf), gateEnv * varBinAutoAZM23292811, DelTapWr.ar(wave * DC.ar(0.95021450519562), wave * DC.ar(0.59231352806091)), Silent.ar());
varBinAutoAZM23292810 = AY.ar(varBinAutoAZM232928113, FoaPressY.ar(Dust.ar(wave * DC.ar(0.29864978790283), wave * DC.ar(0.56532692909241), wave * DC.ar(0.059430122375488)), varBinAutoAZM23292812 * modY, env, Silent.ar()), env * varBinAutoAZM23292811, bufnum, env * varBinAutoAZM23292812, varBinAutoAZM23292812 * varBinAutoAZM232928117, x, varBinAutoAZM232928116 * modX, gateEnv * in, modY * varBinAutoAZM23292811, signal * varBinAutoAZM232928116, 0.69301854756457 * modZ * varBinAutoAZM232928115, Silent.ar());
varBinAutoAZM23292811 = FoaPressX.ar(varBinAutoAZM232928114 * varBinAutoAZM23292812, env, 0.99996010857774 * varBinAutoAZM232928113 * varBinAutoAZM23292812, Silent.ar());
varBinAutoAZM23292812 = SoftClipAmp8.ar(varBinAutoAZM232928117 * modY, t_trig.sumsqr(YigMandelbulbN.ar(wave * DC.ar(0.26158249378204), wave * DC.ar(0.56024467945099), wave * DC.ar(0.13517391681671), wave * DC.ar(0.53998923301697), wave * DC.ar(0.71813929080963), wave * DC.ar(0.34238874912262), wave * DC.ar(0.61893570423126))), varBinAutoAZM232928114, Silent.ar());
varBinAutoAZM2329289 = Dust.ar(gateEnv, Beep.ar(wave * DC.ar(0.73280131816864), wave * DC.ar(0.44988608360291)), CombLP.ar(wave * DC.ar(0.45805203914642), wave * DC.ar(0.61573731899261), wave * DC.ar(0.85368859767914), wave * DC.ar(0.29297947883606), wave * DC.ar(0.21900510787964), wave * DC.ar(0.047699213027954), wave * DC.ar(0.98967945575714), wave * DC.ar(0.51049602031708)));
varBinAutoAZM23292810 = Allpass2.ar(wave * DC.ar(0.6745879650116), wave * DC.ar(0.27403247356415), wave * DC.ar(0.12394666671753), wave * DC.ar(0.39626014232635), wave * DC.ar(0.56884062290192));
varBinAutoAZM23292811 = Breakcore.ar(wave * DC.ar(0.39585494995117), wave * DC.ar(0.52507412433624), wave * DC.ar(0.99801671504974), wave * DC.ar(0.49876439571381), wave * DC.ar(0.7626256942749));
varBinAutoAZM23292812 = DegreeToKey.ar(wave * DC.ar(0.64371013641357), wave * DC.ar(0.13942694664001), wave * DC.ar(0.073487162590027), wave * DC.ar(0.78461837768555), wave * DC.ar(0.37985038757324));
// Variation test code
varBinAutoAZM232928113 = BHiPass.ar(gate, varBinAutoAZM232928113 * varBinAutoAZM232928114, varBinAutoAZM232928115 * varBinAutoAZM232928115, 0.99998685275938 * wave * modY, OSWrap4.ar(varBinAutoAZM23292811 * DC.ar(0.75131690502167), varBinAutoAZM23292812 * DC.ar(0.11667907238007), varBinAutoAZM23292811 * DC.ar(0.037152409553528)));
varBinAutoAZM232928114 = HPZ2.ar(x, 0.89176466076724 * varBinAutoAZM232928113 * varBinAutoAZM23292810, GlitchRHPF.ar(varBinAutoAZM23292812 * DC.ar(0.30550372600555), varBinAutoAZM23292810 * DC.ar(0.74425554275513), varBinAutoAZM23292812 * DC.ar(0.67367124557495), varBinAutoAZM23292810 * DC.ar(0.6102466583252), varBinAutoAZM23292812 * DC.ar(0.79212605953217)));
varBinAutoAZM232928115 = LFPar.ar(modY, t_trig, in.expexp(varBinAutoAZM23292812 * DC.ar(0.72117650508881), varBinAutoAZM23292810 * DC.ar(0.55546247959137), varBinAutoAZM23292812 * DC.ar(0.75505757331848), varBinAutoAZM23292810 * DC.ar(0.12458145618439), varBinAutoAZM23292811 * DC.ar(0.63205206394196)), Silent.ar());
varBinAutoAZM232928116 = RunningMin.ar(BFEncode2.ar(gate, y, modY * wave, varBinAutoAZM2329289 * varBinAutoAZM232928116, amp, wave * varBinAutoAZM23292810), varBinAutoAZM23292812 * varBinAutoAZM232928117);
varBinAutoAZM232928117 = LFBrownNoise2.ar(Lorenz2DN.ar(varBinAutoAZM23292811 * DC.ar(0.93679928779602), varBinAutoAZM2329289 * DC.ar(0.34227621555328), varBinAutoAZM2329289 * DC.ar(0.99314677715302), varBinAutoAZM23292810 * DC.ar(0.7035676240921), varBinAutoAZM23292811 * DC.ar(0.0011440515518188), varBinAutoAZM23292810 * DC.ar(0.84999930858612), varBinAutoAZM2329289 * DC.ar(0.96643233299255), varBinAutoAZM2329289 * DC.ar(0.15513825416565), varBinAutoAZM23292812 * DC.ar(0.67945837974548), varBinAutoAZM23292812 * DC.ar(0.99877405166626), varBinAutoAZM23292810 * DC.ar(0.25421166419983)).exprange(1, SampleRate.ir), varBinAutoAZM23292810 * wave, modZ * in, 0.97346449921235 * Sweep.ar(varBinAutoAZM23292812 * DC.ar(0.21013689041138), varBinAutoAZM2329289 * DC.ar(0.016387462615967)), Silent.ar());
varBinAutoAZM232928113 = SelectL.ar(varBinAutoAZM2329289 * varBinAutoAZM232928117, [SinGrainIBF.ar(varBinAutoAZM23292810 * DC.ar(0.62205374240875), varBinAutoAZM2329289 * DC.ar(0.039490580558777), varBinAutoAZM23292812 * DC.ar(0.98291802406311), varBinAutoAZM23292811 * DC.ar(0.54366171360016), varBinAutoAZM23292811 * DC.ar(0.27494394779205), varBinAutoAZM23292810 * DC.ar(0.037691593170166), varBinAutoAZM23292811 * DC.ar(0.80043303966522), varBinAutoAZM23292811 * DC.ar(0.23013079166412), varBinAutoAZM23292812 * DC.ar(0.33820021152496), varBinAutoAZM23292812 * DC.ar(0.45058107376099), varBinAutoAZM23292812 * DC.ar(0.19081175327301), varBinAutoAZM23292810 * DC.ar(0.080011010169983)), BufWr.ar(varBinAutoAZM23292810 * DC.ar(0.73583936691284), varBinAutoAZM23292812 * DC.ar(0.34573793411255), varBinAutoAZM23292810 * DC.ar(0.34773814678192), varBinAutoAZM23292812 * DC.ar(0.84480905532837))]);
varBinAutoAZM232928114 = CoinGate.ar(x, gateEnv);
varBinAutoAZM232928115 = VDiskIn.ar(2, Array.fill(2.pow(10), { |i| rrand(-1, 1) }).as(LocalBuf), wave * signal, varBinAutoAZM2329289.linexp(varBinAutoAZM23292811 * DC.ar(0.66608202457428), varBinAutoAZM2329289 * DC.ar(0.77092492580414), varBinAutoAZM23292810 * DC.ar(0.79017841815948), varBinAutoAZM23292812 * DC.ar(0.60730266571045), varBinAutoAZM23292810 * DC.ar(0.73783314228058)), signal * signal);
varBinAutoAZM232928116 = TDuty.ar(modZ * gateEnv, amp, x.slew(varBinAutoAZM23292812 * DC.ar(0.79524910449982), varBinAutoAZM23292810 * DC.ar(0.82293796539307)), varBinAutoAZM232928115 * env, varBinAutoAZM23292810);
varBinAutoAZM232928117 = Ramp.ar(island, bufnum, 0.99996827522028 * varBinAutoAZM232928117 * varBinAutoAZM23292811, Silent.ar());
varBinAutoAZM232928113 = LFDNoise1.ar(gateEnv * wave, 0.99654593865701 * gateEnv * varBinAutoAZM232928116, Silent.ar());
varBinAutoAZM232928114 = ReplaceOut.ar((80 + (island * 2)), [Delay2.ar(varBinAutoAZM23292810 * DC.ar(0.34931600093842), varBinAutoAZM23292811 * DC.ar(0.51653826236725), varBinAutoAZM23292811 * DC.ar(0.21277260780334)), LPCVals.ar(varBinAutoAZM23292812 * DC.ar(0.35276973247528), varBinAutoAZM2329289 * DC.ar(0.79379379749298))]);
varBinAutoAZM232928115 = SoftClipAmp.ar(amp, 0.76145434379578 * modY * in, env, Silent.ar());
varBinAutoAZM232928116 = FoaPsychoShelf.ar(varBinAutoAZM23292810 * modZ, varBinAutoAZM23292812 * varBinAutoAZM232928116, env, 0.49759900569916 * varBinAutoAZM232928116 * varBinAutoAZM2329289, 0.99944143809249 * wave * wave, Silent.ar());
varBinAutoAZM232928117 = LPF18.ar(varBinAutoAZM232928115 * modZ, RedDPCMencode.ar(varBinAutoAZM23292811 * DC.ar(0.95017564296722), varBinAutoAZM23292811 * DC.ar(0.42015790939331)).exprange(1, SampleRate.ir), modY * signal, varBinAutoAZM23292811 * varBinAutoAZM232928113);

signal = varBinAutoAZM232928117;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// HLLP.IC.8942232929
/////////////////////////////////////////////////////////

SynthDef.new("HLLP.IC.8942232929", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varHLLPIC89422329299, varHLLPIC894223292910, varHLLPIC894223292911, varHLLPIC894223292912, varHLLPIC894223292913, varHLLPIC894223292914, varHLLPIC894223292915;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varHLLPIC89422329299 = varHLLPIC894223292910 = varHLLPIC894223292911 = varHLLPIC894223292912 = varHLLPIC894223292913 = varHLLPIC894223292914 = varHLLPIC894223292915 = K2A.ar(t_trig).dup;
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
varHLLPIC89422329299 = SN76489.ar(in * varHLLPIC89422329299, env * modZ, wave * gateEnv, varHLLPIC894223292914 * wave, varHLLPIC894223292912 * varHLLPIC894223292910, 0.81514835357666 * gateEnv * signal, 0.43040800094604 * in * env, varHLLPIC894223292910 * varHLLPIC894223292915, signal);
varHLLPIC894223292910 = FMHEncode1.ar(modZ * modZ, gate, signal.wrap2(LocalOut.ar(wave * DC.ar(0.57660937309265))), varHLLPIC89422329299, amp.lag2ud(wave * DC.ar(0.10266304016113), wave * DC.ar(0.36117541790009)), y);
varHLLPIC894223292911 = CompanderD.ar(gateEnv * modY, modY * in, bufnum.clip2(FOS.ar(wave * DC.ar(0.42024409770966), wave * DC.ar(0.78944408893585), wave * DC.ar(0.26553750038147), wave * DC.ar(0.40997004508972), wave * DC.ar(0.5265052318573), wave * DC.ar(0.62870395183563))), signal * env, env * varHLLPIC894223292911, modY, 0.99735531542905 * varHLLPIC894223292915 * wave, Silent.ar());
varHLLPIC894223292912 = RegaliaMitraEQ.ar(y, gateEnv * varHLLPIC894223292912, gate, z, varHLLPIC894223292913, Silent.ar());
varHLLPIC894223292913 = Peak.ar(0.2377473115921 * signal * modX, env * modX.exprange(wave * DC.ar(0.7382755279541), wave * DC.ar(0.19034647941589)));
varHLLPIC894223292914 = VarSaw.ar(RedDPCMdecode.ar(wave * DC.ar(0.84634876251221)).exprange(1, SampleRate.ir), varHLLPIC894223292912 * varHLLPIC894223292915, env, PitchShift.ar(wave * DC.ar(0.50597715377808), wave * DC.ar(0.97962701320648), wave * DC.ar(0.75592434406281), wave * DC.ar(0.97839951515198), wave * DC.ar(0.82484412193298), wave * DC.ar(0.49686682224274), wave * DC.ar(0.070689558982849)), Silent.ar());
varHLLPIC894223292915 = Pluck.ar(varHLLPIC894223292911 * varHLLPIC894223292913, env, signal, modZ * varHLLPIC894223292912, TPV.ar(0.77712094783783 * modZ * gateEnv, modY.lag(wave * DC.ar(0.79432702064514), wave * DC.ar(0.72028458118439)), varHLLPIC894223292915, modY * in, varHLLPIC894223292914, FoaDominateY.ar(wave * DC.ar(0.38437592983246), wave * DC.ar(0.14083170890808), wave * DC.ar(0.92300081253052), wave * DC.ar(0.34054934978485)), varHLLPIC894223292910 * wave, modY * varHLLPIC89422329299, LocalOut.ar(wave * DC.ar(0.74407756328583)), Silent.ar()), DynKlank.ar(`[[Oregonator.ar(wave * DC.ar(0.78509616851807), wave * DC.ar(0.30848181247711), wave * DC.ar(0.96674978733063), wave * DC.ar(0.25429725646973), wave * DC.ar(0.67082643508911), wave * DC.ar(0.16626644134521), wave * DC.ar(0.93721449375153), wave * DC.ar(0.17412543296814), wave * DC.ar(0.1251345872879), wave * DC.ar(0.71789193153381)), RandSeed.ar(wave * DC.ar(0.45501947402954), wave * DC.ar(0.50537192821503))], [SineShaper.ar(wave * DC.ar(0.71434140205383), wave * DC.ar(0.32363831996918), wave * DC.ar(0.44655525684357), wave * DC.ar(0.34049534797668)), WaveletDaub.ar(wave * DC.ar(0.39542508125305), wave * DC.ar(0.72205293178558), wave * DC.ar(0.53861796855927), wave * DC.ar(0.097035765647888), wave * DC.ar(0.91093146800995))], [AtsAmp.ar(wave * DC.ar(0.53342735767365), wave * DC.ar(0.35916292667389), wave * DC.ar(0.5014796257019), wave * DC.ar(0.60010898113251), wave * DC.ar(0.53193879127502)), Gendy5.ar(wave * DC.ar(0.90451073646545), wave * DC.ar(0.56017768383026), wave * DC.ar(0.9619312286377), wave * DC.ar(0.98539817333221), wave * DC.ar(0.44469153881073), wave * DC.ar(0.67197954654694), wave * DC.ar(0.83367908000946), wave * DC.ar(0.79551100730896), wave * DC.ar(0.13902246952057), wave * DC.ar(0.85871946811676), wave * DC.ar(0.7892963886261), wave * DC.ar(0.62207138538361))]], env * varHLLPIC894223292914, varHLLPIC894223292914 * env, varHLLPIC894223292913 * varHLLPIC894223292910, modX), 0.48018354423919 * TTendency.ar(wave * DC.ar(0.56975400447845), wave * DC.ar(0.16075325012207), wave * DC.ar(0.78610813617706), wave * DC.ar(0.99069809913635), wave * DC.ar(0.63376319408417), wave * DC.ar(0.82329857349396)), Silent.ar());
varHLLPIC89422329299 = Pulse.ar(NestedAllpassC.ar(wave * DC.ar(0.67553198337555), wave * DC.ar(0.76934564113617), wave * DC.ar(0.63992619514465), wave * DC.ar(0.46894633769989), wave * DC.ar(0.99031686782837), wave * DC.ar(0.68436026573181), wave * DC.ar(0.43800818920135), wave * DC.ar(0.4446622133255), wave * DC.ar(0.82845294475555)).exprange(1, SampleRate.ir), gateEnv, varHLLPIC894223292910, Silent.ar());
varHLLPIC894223292910 = Dust2.ar(wave * DC.ar(0.15619909763336), wave * DC.ar(0.15134060382843), wave * DC.ar(0.83121812343597));
varHLLPIC894223292911 = Latoocarfian2DL.ar(modY * varHLLPIC894223292911, in, 0.15326762199402 * modX * signal, bufnum, varHLLPIC894223292913 * gateEnv, varHLLPIC89422329299 * modX, varHLLPIC894223292911, signal * varHLLPIC894223292910, signal, Silent.ar());
varHLLPIC894223292912 = NLFiltC.ar(wave * DC.ar(0.68344926834106), wave * DC.ar(0.53387975692749), wave * DC.ar(0.57904207706451), wave * DC.ar(0.40599894523621), wave * DC.ar(0.57573711872101), wave * DC.ar(0.6363205909729), wave * DC.ar(0.055612087249756), wave * DC.ar(0.76876163482666));
varHLLPIC894223292913 = GlitchRHPF.ar(varHLLPIC894223292911 * varHLLPIC894223292912.blend(wave * DC.ar(0.27640724182129), wave * DC.ar(0.057855606079102)), signal * varHLLPIC894223292911, varHLLPIC894223292914 * varHLLPIC894223292915, env, Clipper4.ar(wave * DC.ar(0.58728981018066), wave * DC.ar(0.15082514286041), wave * DC.ar(0.62342965602875)));
varHLLPIC894223292914 = FoaZoomZ.ar(wave * varHLLPIC894223292915, 0.28646004199982 * gateEnv, 0.99998924113883 * WaveletDaub.ar(wave * DC.ar(0.56739830970764), wave * DC.ar(0.54803121089935), wave * DC.ar(0.59096086025238), wave * DC.ar(0.84096157550812), wave * DC.ar(0.49880266189575)).madd(wave * DC.ar(0.065812349319458), wave * DC.ar(0.24337530136108)), BufDelayN.ar(wave * DC.ar(0.047675728797913), wave * DC.ar(0.15735363960266), wave * DC.ar(0.34453344345093), wave * DC.ar(0.44214510917664), wave * DC.ar(0.39403760433197)));
varHLLPIC894223292915 = Henon2DL.ar(gateEnv * modY, Clip.ar(wave * DC.ar(0.95626664161682), wave * DC.ar(0.47177016735077), wave * DC.ar(0.75959205627441)).exprange(1, SampleRate.ir), amp, varHLLPIC894223292914, varHLLPIC894223292914 * env, varHLLPIC894223292914 * wave, 0.99995874881311 * in * varHLLPIC894223292910, Silent.ar());

signal = varHLLPIC894223292915;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// XM.Laroux.CE232931
/////////////////////////////////////////////////////////

SynthDef.new("XM.Laroux.CE232931", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varXMLarouxCE2329319, varXMLarouxCE23293110, varXMLarouxCE23293111, varXMLarouxCE23293112;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varXMLarouxCE2329319 = varXMLarouxCE23293110 = varXMLarouxCE23293111 = varXMLarouxCE23293112 = K2A.ar(t_trig).dup;
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
varXMLarouxCE2329319 = FSinOsc.ar(env, env, modX, LFDNoise1.ar(wave * DC.ar(0.4488377571106), wave * DC.ar(0.48842358589172), wave * DC.ar(0.33477258682251)));
varXMLarouxCE23293110 = FoaDirectZ.ar(varXMLarouxCE23293111, in * varXMLarouxCE23293110, 0.99995332446553 * varXMLarouxCE23293112 * modY, Silent.ar());
varXMLarouxCE23293111 = YigCliffordC.ar(signal * gateEnv, modZ * gateEnv, wave * modZ, MembraneHexagon.ar(env, wave * varXMLarouxCE23293112, varXMLarouxCE23293110 * modY, StkMandolin.ar(wave * DC.ar(0.45778465270996), wave * DC.ar(0.55314433574677), wave * DC.ar(0.56118059158325), wave * DC.ar(0.75916302204132), wave * DC.ar(0.50095903873444), wave * DC.ar(0.29843282699585), wave * DC.ar(0.38805949687958), wave * DC.ar(0.22846436500549), wave * DC.ar(0.35273694992065)), Silent.ar()).curvelin(wave * DC.ar(0.43969285488129), wave * DC.ar(0.60268819332123), wave * DC.ar(0.72663354873657), wave * DC.ar(0.85695934295654), wave * DC.ar(0.072794556617737), wave * DC.ar(0.27008891105652)), varXMLarouxCE2329319 * env, varXMLarouxCE23293110 * modY, in * signal, 0.41890047195926 * modX * wave, Silent.ar());
varXMLarouxCE23293112 = GbmanN.ar(env * varXMLarouxCE23293110, y, modY, gateEnv, Silent.ar());
varXMLarouxCE2329319 = FoaDominateY.ar(z, modZ * wave, 0.94750331925466 * modX * varXMLarouxCE23293112, Silent.ar());
varXMLarouxCE23293110 = Friction.ar(wave * DC.ar(0.99403393268585), wave * DC.ar(0.49643206596375), wave * DC.ar(0.90019011497498), wave * DC.ar(0.34022259712219), wave * DC.ar(0.6594785451889), wave * DC.ar(0.52467262744904), wave * DC.ar(0.77967035770416), wave * DC.ar(0.47661805152893));
varXMLarouxCE23293111 = Lag3.ar(0.34711885452271 * varXMLarouxCE23293112, modY * varXMLarouxCE2329319, in, Silent.ar());
varXMLarouxCE23293112 = Concat.ar(modX, env * modZ, varXMLarouxCE23293110, modY * wave, modZ * env.lincurve(wave * DC.ar(0.83148729801178), wave * DC.ar(0.55904161930084), wave * DC.ar(0.96798419952393), wave * DC.ar(0.15360260009766), wave * DC.ar(0.58429849147797), wave * DC.ar(0.00085878372192383)), wave * modY, env * modZ, wave * in, varXMLarouxCE23293111 * varXMLarouxCE23293112, varXMLarouxCE23293112, env * varXMLarouxCE23293110, varXMLarouxCE23293110 * gateEnv, 0.94757926099556 * modX, Silent.ar());

signal = varXMLarouxCE23293112;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// HLLC.cmp.6240232932
/////////////////////////////////////////////////////////

SynthDef.new("HLLC.cmp.6240232932", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varHLLCcmp62402329329, varHLLCcmp624023293210, varHLLCcmp624023293211, varHLLCcmp624023293212, varHLLCcmp624023293213, varHLLCcmp624023293214;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varHLLCcmp62402329329 = varHLLCcmp624023293210 = varHLLCcmp624023293211 = varHLLCcmp624023293212 = varHLLCcmp624023293213 = varHLLCcmp624023293214 = K2A.ar(t_trig).dup;
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
varHLLCcmp62402329329 = WaveTerrain.ar(Array.fill(2.pow(15), { |i| rrand(-1, 1) }).as(LocalBuf), varHLLCcmp624023293213 * varHLLCcmp62402329329, varHLLCcmp624023293211 * varHLLCcmp62402329329, varHLLCcmp624023293213, varHLLCcmp624023293213 * varHLLCcmp624023293210, 0.89494968393783 * varHLLCcmp624023293214 * env, Silent.ar());
varHLLCcmp624023293210 = Hasher.ar(gateEnv * varHLLCcmp624023293213, 0.99994263881047 * modZ * varHLLCcmp624023293212, Silent.ar());
varHLLCcmp624023293211 = DiskIn.ar(2, Array.fill(2.pow(11), { |i| rrand(-1, 1) }).as(LocalBuf), wave * in.difsqr(DC.ar(wave * DC.ar(0.89666521549225))));
varHLLCcmp624023293212 = AtsSynth.ar(Array.fill(2.pow(13), { |i| rrand(-1, 1) }).as(LocalBuf), varHLLCcmp624023293214, modZ, modZ * wave, wave * modY, env * modZ, Gendy3.ar(wave * DC.ar(0.73953950405121), wave * DC.ar(0.28698134422302), wave * DC.ar(0.49046576023102), wave * DC.ar(0.34535896778107), wave * DC.ar(0.32038021087646), wave * DC.ar(0.1041374206543), wave * DC.ar(0.079495787620544), wave * DC.ar(0.93687331676483), wave * DC.ar(0.9353586435318), wave * DC.ar(0.69434666633606), wave * DC.ar(0.49837791919708)).exprange(1, SampleRate.ir), wave.minNyquist(), Silent.ar());
varHLLCcmp624023293213 = NLFiltC.ar(amp, z, signal, z, varHLLCcmp624023293212 * varHLLCcmp624023293214, 0.84061074256897 * gateEnv * modX, 0.99907703890085 * env * varHLLCcmp624023293213, Silent.ar());
varHLLCcmp624023293214 = GbmanL.ar(in * gateEnv, in, y, env, Silent.ar());
varHLLCcmp62402329329 = LFDNoise3.ar(env * gateEnv, varHLLCcmp624023293211, Silent.ar());
varHLLCcmp624023293210 = UHJ2B.ar(z, wave * gateEnv);
varHLLCcmp624023293211 = PeakFollower.ar(wave * DC.ar(0.31382358074188), wave * DC.ar(0.77742528915405));
varHLLCcmp624023293212 = WaveLoss.ar(wave * DC.ar(0.79964661598206), wave * DC.ar(0.47420644760132), wave * DC.ar(0.4882744550705), wave * DC.ar(0.88196659088135), wave * DC.ar(0.8615175485611), wave * DC.ar(0.14439928531647));
varHLLCcmp624023293213 = Summer.ar(wave * DC.ar(0.96630966663361), wave * DC.ar(0.75372803211212), wave * DC.ar(0.22873711585999), wave * DC.ar(0.30114090442657));
varHLLCcmp624023293214 = Select.ar(modX, [MidEQ.ar(wave * DC.ar(0.53114581108093), wave * DC.ar(0.42007839679718), wave * DC.ar(0.71000134944916), wave * DC.ar(0.81003212928772), wave * DC.ar(0.85926175117493), wave * DC.ar(0.18276047706604)), StkSaxofony.ar(wave * DC.ar(0.16086149215698), wave * DC.ar(0.61311936378479), wave * DC.ar(0.61059415340424), wave * DC.ar(0.2931467294693), wave * DC.ar(0.94869184494019), wave * DC.ar(0.42292547225952), wave * DC.ar(0.8104110956192), wave * DC.ar(0.43090522289276), wave * DC.ar(0.26055896282196), wave * DC.ar(0.044097065925598), wave * DC.ar(0.46101677417755))]);

signal = varHLLCcmp624023293214;
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
// HLLP.vircod.4255232933
/////////////////////////////////////////////////////////

SynthDef.new("HLLP.vircod.4255232933", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varHLLPvircod42552329339;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varHLLPvircod42552329339 = K2A.ar(t_trig).dup;
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
varHLLPvircod42552329339 = Decay2.ar(signal * modY.lag3ud(wave * DC.ar(0.2554178237915), wave * DC.ar(0.38937139511108)), signal, SinGrainBBF.ar(wave * DC.ar(0.27155923843384), wave * DC.ar(0.32851982116699), wave * DC.ar(0.50678288936615), wave * DC.ar(0.63510823249817), wave * DC.ar(0.81516659259796), wave * DC.ar(0.53496325016022), wave * DC.ar(0.54645895957947), wave * DC.ar(0.1990681886673), wave * DC.ar(0.051078081130981), wave * DC.ar(0.090940475463867)), LagUD.ar(wave * DC.ar(0.10608375072479), wave * DC.ar(0.49201333522797), wave * DC.ar(0.50220251083374), wave * DC.ar(0.086054444313049), wave * DC.ar(0.3390007019043)), Silent.ar());
varHLLPvircod42552329339 = WaveLoss.ar(z, in * wave, PanAz.ar(2, BLowShelf.ar(wave * DC.ar(0.96337795257568), wave * DC.ar(0.35156190395355), wave * DC.ar(0.80092716217041), wave * DC.ar(0.45693671703339), wave * DC.ar(0.21916317939758), wave * DC.ar(0.76078116893768)), modZ * modY, SelectL.ar(wave * DC.ar(0.50254547595978), wave * DC.ar(0.90342402458191)), modX * modZ, LatoocarfianL.ar(wave * DC.ar(0.39600372314453), wave * DC.ar(0.97219455242157), wave * DC.ar(0.65293920040131), wave * DC.ar(0.18545699119568), wave * DC.ar(0.11905467510223), wave * DC.ar(0.00043404102325439), wave * DC.ar(0.72240436077118), wave * DC.ar(0.28499639034271), wave * DC.ar(0.34354472160339))), gateEnv * modZ, 0.97747486896311 * modZ * modY, Silent.ar());

signal = varHLLPvircod42552329339;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Malatinec.3737(x)232934
/////////////////////////////////////////////////////////

SynthDef.new("Malatinec.3737(x)232934", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varMalatinec3737x2329349, varMalatinec3737x23293410, varMalatinec3737x23293411, varMalatinec3737x23293412, varMalatinec3737x23293413, varMalatinec3737x23293414, varMalatinec3737x23293415;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varMalatinec3737x2329349 = varMalatinec3737x23293410 = varMalatinec3737x23293411 = varMalatinec3737x23293412 = varMalatinec3737x23293413 = varMalatinec3737x23293414 = varMalatinec3737x23293415 = K2A.ar(t_trig).dup;
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
varMalatinec3737x2329349 = DelTapRd.ar(Array.fill(2.pow(10), { |i| rrand(-1, 1) }).as(LocalBuf), z, modY, varMalatinec3737x23293415 * gateEnv, 0.94815805007038 * varMalatinec3737x23293412 * varMalatinec3737x23293414, Silent.ar());
varMalatinec3737x23293410 = TIRand.ar(z, varMalatinec3737x23293415, signal * wave);
varMalatinec3737x23293411 = DoubleNestedAllpassC.ar(x, z, 0.38851237297058 * wave * varMalatinec3737x23293415, in, z, gateEnv * varMalatinec3737x23293412, varMalatinec3737x23293412 * varMalatinec3737x23293414, modX, modX, wave * varMalatinec3737x23293411, BufDelayL.ar(wave * DC.ar(0.55277895927429), wave * DC.ar(0.79294061660767), wave * DC.ar(0.65293955802917), wave * DC.ar(0.61625754833221), wave * DC.ar(0.64616429805756)), Silent.ar());
varMalatinec3737x23293412 = AtsParInfo.ar(Array.fill(2.pow(16), { |i| rrand(-1, 1) }).as(LocalBuf), gate, amp, WalshHadamard.ar(wave * DC.ar(0.046667575836182), wave * DC.ar(0.55400013923645), wave * DC.ar(0.60579657554626), wave * DC.ar(0.67009818553925)), Silent.ar());
varMalatinec3737x23293413 = BufGrainIBF.ar(wave * in, in * env, bufnum, modZ, island, bufnum, bufnum, wave * modX, modX * gateEnv, gate, 0.17637038230896 * modX * modY, varMalatinec3737x23293411 * wave, modZ * varMalatinec3737x23293413, 0.9994727944742 * varMalatinec3737x23293415, Silent.ar());
varMalatinec3737x23293414 = RunningSum.ar(gateEnv, varMalatinec3737x23293413 * wave);
varMalatinec3737x23293415 = Schmidt.ar(t_trig, modY * varMalatinec3737x23293414, SpruceBudworm.ar(varMalatinec3737x2329349, in, varMalatinec3737x23293411 * signal, varMalatinec3737x23293412 * varMalatinec3737x23293413, y, varMalatinec3737x23293410, varMalatinec3737x23293414 * varMalatinec3737x23293411, modY * varMalatinec3737x23293415, wave, varMalatinec3737x23293410, Latch.ar(wave * DC.ar(0.69201374053955), wave * DC.ar(0.99035453796387)), Silent.ar()));
varMalatinec3737x2329349 = BLowShelf.ar(wave * DC.ar(0.64347541332245), wave * DC.ar(0.69366550445557), wave * DC.ar(0.37198305130005), wave * DC.ar(0.54561352729797), wave * DC.ar(0.53468012809753), wave * DC.ar(0.010806441307068));
varMalatinec3737x23293410 = FoaPressY.ar(y, OSTrunc8.ar(wave * DC.ar(0.99262821674347), wave * DC.ar(0.24707961082458)), 0.99976507032883 * varMalatinec3737x23293411 * wave, Silent.ar());
varMalatinec3737x23293411 = SyncSaw.ar(gate.ring1(LPZ2.ar(wave * DC.ar(0.019626498222351), wave * DC.ar(0.32977712154388), wave * DC.ar(0.93051338195801))), DynKlang.ar(`[[FoaFocusY.ar(wave * DC.ar(0.1756135225296), wave * DC.ar(0.28290784358978), wave * DC.ar(0.50874030590057), wave * DC.ar(0.42409992218018)), MembraneHexagon.ar(wave * DC.ar(0.77858197689056), wave * DC.ar(0.1939013004303), wave * DC.ar(0.36580741405487), wave * DC.ar(0.3517153263092), wave * DC.ar(0.63421273231506))], [Duty.ar(wave * DC.ar(0.40767776966095), wave * DC.ar(0.12222564220428), wave * DC.ar(0.46242916584015), wave * DC.ar(0.46960604190826)), Dust2.ar(wave * DC.ar(0.83768606185913), wave * DC.ar(0.53201138973236), wave * DC.ar(0.62228274345398))], [LatoocarfianC.ar(wave * DC.ar(0.25854790210724), wave * DC.ar(0.90678715705872), wave * DC.ar(0.057830095291138), wave * DC.ar(0.24037480354309), wave * DC.ar(0.70087313652039), wave * DC.ar(0.4846738576889), wave * DC.ar(0.19419920444489), wave * DC.ar(0.69508874416351), wave * DC.ar(0.60608386993408)), WaveletDaub.ar(wave * DC.ar(0.4867650270462), wave * DC.ar(0.42292249202728), wave * DC.ar(0.68062376976013), wave * DC.ar(0.18855082988739), wave * DC.ar(0.065536260604858))]], gateEnv, gateEnv * varMalatinec3737x23293413), modX, Silent.ar());
varMalatinec3737x23293412 = BBlockerBuf.ar(wave * DC.ar(0.59751725196838), wave * DC.ar(0.64424526691437), wave * DC.ar(0.57993531227112));
varMalatinec3737x23293413 = Atari2600.ar(wave * DC.ar(0.38074910640717), wave * DC.ar(0.37193405628204), wave * DC.ar(0.18468761444092), wave * DC.ar(0.39935791492462), wave * DC.ar(0.0019298791885376), wave * DC.ar(0.16776478290558), wave * DC.ar(0.97999918460846));
varMalatinec3737x23293414 = Out.ar(wave * DC.ar(0.51157426834106), wave * DC.ar(0.27573561668396));
varMalatinec3737x23293415 = COsc.ar(wave * DC.ar(0.74583685398102), wave * DC.ar(0.98741018772125), wave * DC.ar(0.29427707195282), wave * DC.ar(0.21883261203766), wave * DC.ar(0.87115585803986));

signal = varMalatinec3737x23293415;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// WM.ShowOff.X232934
/////////////////////////////////////////////////////////

SynthDef.new("WM.ShowOff.X232934", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varWMShowOffX2329349;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varWMShowOffX2329349 = K2A.ar(t_trig).dup;
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
varWMShowOffX2329349 = BufAllpassL.ar(Array.fill(2.pow(15), { |i| rrand(-1, 1) }).as(LocalBuf), signal * modZ, varWMShowOffX2329349 * in, env * gateEnv, env, Silent.ar());
varWMShowOffX2329349 = In.ar((80 + (island * 2)), 2);

signal = varWMShowOffX2329349;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Polonaise.24022329341
/////////////////////////////////////////////////////////

SynthDef.new("Polonaise.24022329341", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varPolonaise24022329349, varPolonaise240223293410, varPolonaise240223293411, varPolonaise240223293412, varPolonaise2402232934113;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varPolonaise24022329349 = varPolonaise240223293410 = varPolonaise240223293411 = varPolonaise240223293412 = varPolonaise2402232934113 = K2A.ar(t_trig).dup;
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
varPolonaise24022329349 = InGrainI.ar(varPolonaise240223293411, modZ * in, varPolonaise24022329349.lag2ud(wave * DC.ar(0.82875716686249), wave * DC.ar(0.48640131950378)), bufnum, bufnum, 0.52737081050873 * modZ * gateEnv, 0.99856257734751 * env * varPolonaise2402232934113, Silent.ar());
varPolonaise240223293410 = DynKlang.ar(`[[CuspL.ar(wave * DC.ar(0.49258625507355), wave * DC.ar(0.46912682056427), wave * DC.ar(0.480872631073), wave * DC.ar(0.17760539054871), wave * DC.ar(0.67577886581421), wave * DC.ar(0.68248474597931)), SanityCheck.ar(wave * DC.ar(0.7514089345932))], [AmplitudeMod.ar(wave * DC.ar(0.83219087123871), wave * DC.ar(0.22858953475952), wave * DC.ar(0.33085250854492), wave * DC.ar(0.53737342357635), wave * DC.ar(0.024204015731812)), FoaPressZ.ar(wave * DC.ar(0.49771571159363), wave * DC.ar(0.89590966701508), wave * DC.ar(0.46392905712128), wave * DC.ar(0.32486748695374))], [Timer.ar(wave * DC.ar(0.88783466815948)), LorenzL.ar(wave * DC.ar(0.80142259597778), wave * DC.ar(0.43532991409302), wave * DC.ar(0.35717058181763), wave * DC.ar(0.031760811805725), wave * DC.ar(0.92985272407532), wave * DC.ar(0.012017965316772), wave * DC.ar(0.83779394626617), wave * DC.ar(0.59329867362976), wave * DC.ar(0.43124043941498), wave * DC.ar(0.53978478908539))]], varPolonaise24022329349, varPolonaise24022329349);
varPolonaise240223293411 = Spring.ar(t_trig, x, gateEnv * varPolonaise240223293412);
varPolonaise240223293412 = FoaPsychoShelf.ar(env * gateEnv, modX * modZ, varPolonaise240223293411, DoubleWell2.ar(varPolonaise240223293410 * varPolonaise240223293412, varPolonaise240223293411 * modX, modX * varPolonaise240223293410, x, modZ * modZ, modY * env, t_trig, y, modX, Silent.ar()), LFTri.ar(wave * DC.ar(0.98819279670715), wave * DC.ar(0.59671580791473), wave * DC.ar(0.45282340049744), wave * DC.ar(0.86165547370911)), Silent.ar());
varPolonaise24022329349 = FMGrainIBF.ar(wave * DC.ar(0.84580230712891), wave * DC.ar(0.50558638572693), wave * DC.ar(0.33498883247375), wave * DC.ar(0.85866796970367), wave * DC.ar(0.42389249801636), wave * DC.ar(0.53281199932098), wave * DC.ar(0.79910385608673), wave * DC.ar(0.54694354534149), wave * DC.ar(0.62838625907898), wave * DC.ar(0.32650375366211), wave * DC.ar(0.55595779418945), wave * DC.ar(0.36116063594818), wave * DC.ar(0.94234454631805), wave * DC.ar(0.75342965126038));
varPolonaise240223293410 = DoubleNestedAllpassN.ar(z, varPolonaise240223293412, signal * in, wave * env, varPolonaise240223293411 * wave, gateEnv * varPolonaise24022329349, signal * varPolonaise2402232934113, in * varPolonaise240223293412, FBSineL.ar(wave * DC.ar(0.65160000324249), wave * DC.ar(0.44612634181976), wave * DC.ar(0.86068487167358), wave * DC.ar(0.91090512275696), wave * DC.ar(0.14083218574524), wave * DC.ar(0.056521654129028), wave * DC.ar(0.76100587844849), wave * DC.ar(0.85898435115814), wave * DC.ar(0.66021513938904)), varPolonaise240223293410 * modY, varPolonaise240223293412, Silent.ar());
varPolonaise240223293411 = Delay1.ar(varPolonaise240223293412 * varPolonaise240223293410, DelayC.ar(wave * DC.ar(0.14518404006958), wave * DC.ar(0.30518329143524), wave * DC.ar(0.77594399452209), wave * DC.ar(0.87286925315857), wave * DC.ar(0.12090623378754)), Silent.ar());
varPolonaise240223293412 = LFClipNoise.ar(wave * DC.ar(0.63779699802399), wave * DC.ar(0.90679430961609), wave * DC.ar(0.79444944858551));
// Variation test code
varPolonaise2402232934113 = FoaFocusZ.ar(varPolonaise240223293412 * signal, in, 0.99996785220382 * modX * varPolonaise24022329349, Silent.ar());
varPolonaise2402232934113 = WaveTerrain.ar(Array.fill(2.pow(10), { |i| rrand(-1, 1) }).as(LocalBuf), 0.31907141208649 * Rotate2.ar(varPolonaise240223293411 * DC.ar(0.95394456386566), varPolonaise240223293411 * DC.ar(0.073205232620239), varPolonaise240223293410 * DC.ar(0.78489077091217)), modX * env, varPolonaise240223293411 * modZ, 0.5206903219223 * varPolonaise24022329349 * env, Latoocarfian2DC.ar(varPolonaise240223293411 * DC.ar(0.73888254165649), varPolonaise24022329349 * DC.ar(0.90724647045135), varPolonaise240223293412 * DC.ar(0.94158351421356), varPolonaise240223293410 * DC.ar(0.99977350234985), varPolonaise240223293410 * DC.ar(0.58707821369171), varPolonaise240223293411 * DC.ar(0.12455558776855), varPolonaise240223293411 * DC.ar(0.28086459636688), varPolonaise24022329349 * DC.ar(0.78137314319611), varPolonaise240223293410 * DC.ar(0.95913434028625), varPolonaise24022329349 * DC.ar(0.73629927635193)).lag3ud(varPolonaise240223293410 * DC.ar(0.30453705787659), varPolonaise240223293412 * DC.ar(0.31840252876282)), Silent.ar());
varPolonaise2402232934113 = HyperTerrain.ar(Array.fill(2.pow(12), { |i| rrand(-1, 1) }).as(LocalBuf), 0.43163657188416 * varPolonaise24022329349 * varPolonaise2402232934113, varPolonaise24022329349 * varPolonaise240223293412, signal, gateEnv, Gendy2.ar(varPolonaise240223293412 * DC.ar(0.18334352970123), varPolonaise240223293412 * DC.ar(0.91974925994873), varPolonaise240223293412 * DC.ar(0.67134022712708), varPolonaise240223293410 * DC.ar(0.026506662368774), varPolonaise240223293412 * DC.ar(0.50720238685608), varPolonaise240223293410 * DC.ar(0.63369250297546), varPolonaise24022329349 * DC.ar(0.081577777862549), varPolonaise24022329349 * DC.ar(0.57800853252411), varPolonaise240223293410 * DC.ar(0.71582651138306), varPolonaise240223293411 * DC.ar(0.47818195819855), varPolonaise240223293412 * DC.ar(0.78198611736298), varPolonaise24022329349 * DC.ar(0.55818343162537), varPolonaise24022329349 * DC.ar(0.87020027637482), varPolonaise240223293410 * DC.ar(0.93865811824799)));

signal = varPolonaise2402232934113;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// W97M.Fabi.9608232935
/////////////////////////////////////////////////////////

SynthDef.new("W97M.Fabi.9608232935", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varW97MFabi96082329359, varW97MFabi960823293510, varW97MFabi960823293511, varW97MFabi960823293512, varW97MFabi960823293513, varW97MFabi960823293514;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varW97MFabi96082329359 = varW97MFabi960823293510 = varW97MFabi960823293511 = varW97MFabi960823293512 = varW97MFabi960823293513 = varW97MFabi960823293514 = K2A.ar(t_trig).dup;
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
varW97MFabi96082329359 = LorenzL.ar(varW97MFabi96082329359 * varW97MFabi960823293514, signal * wave, wave * varW97MFabi960823293512, signal * modZ, bufnum, env, gateEnv * varW97MFabi96082329359, island, env, Silent.ar());
varW97MFabi960823293510 = WeaklyNonlinear2.ar(modY * varW97MFabi960823293514, modZ * signal, varW97MFabi960823293513 * env, 0.26246738433838 * Gendy5.ar(wave * DC.ar(0.046034216880798), wave * DC.ar(0.33163118362427), wave * DC.ar(0.019421577453613), wave * DC.ar(0.45690929889679), wave * DC.ar(0.19481909275055), wave * DC.ar(0.98956513404846), wave * DC.ar(0.95134389400482), wave * DC.ar(0.6257575750351), wave * DC.ar(0.27332329750061), wave * DC.ar(0.62087559700012), wave * DC.ar(0.64080333709717), wave * DC.ar(0.8263031244278)).explin(wave * DC.ar(0.22203397750854), wave * DC.ar(0.027600169181824), wave * DC.ar(0.23888432979584), wave * DC.ar(0.39481008052826), wave * DC.ar(0.046038627624512)), wave * modY, varW97MFabi960823293510 * modZ, signal, varW97MFabi960823293512, z, env, gateEnv, 0.99998194808721 * in * varW97MFabi960823293512, Silent.ar());
varW97MFabi960823293511 = LFDNoise1.ar(signal * env, modY, Silent.ar());
varW97MFabi960823293512 = MedianTriggered.ar(varW97MFabi96082329359 * varW97MFabi960823293513, modY * varW97MFabi960823293512, gateEnv * gateEnv, 0.95241662943881 * gateEnv * signal, Silent.ar());
varW97MFabi960823293513 = FMHEncode2.ar(varW97MFabi960823293510 * signal, varW97MFabi960823293512 * varW97MFabi96082329359, varW97MFabi960823293511 * varW97MFabi960823293511, 0.23323309421539 * in, varW97MFabi960823293513, varW97MFabi960823293510);
varW97MFabi960823293514 = SoftClipper8.ar(bufnum);
varW97MFabi96082329359 = Metro.ar(varW97MFabi960823293513 * modY, 0.31493103504181 * in * varW97MFabi960823293511, modY, Silent.ar());
varW97MFabi960823293510 = Compander.ar(wave * DC.ar(0.30378890037537), wave * DC.ar(0.57428431510925), wave * DC.ar(0.44868171215057), wave * DC.ar(0.42783331871033), wave * DC.ar(0.69569182395935), wave * DC.ar(0.199915766716), wave * DC.ar(0.47351121902466), wave * DC.ar(0.60242223739624), wave * DC.ar(0.056669354438782));
varW97MFabi960823293511 = MonoGrain.ar(wave * varW97MFabi960823293514, varW97MFabi960823293510 * wave, in, varW97MFabi960823293513 * varW97MFabi960823293514, 0.97538089145059 * varW97MFabi96082329359 * varW97MFabi96082329359.lag2(wave * DC.ar(0.63737761974335), wave * DC.ar(0.19389629364014)), Silent.ar());
varW97MFabi960823293512 = ScopeOut2.ar([SinGrainB.ar(wave * DC.ar(0.61231672763824), wave * DC.ar(0.67319214344025), wave * DC.ar(0.87585127353668), wave * DC.ar(0.0331951379776), wave * DC.ar(0.38905990123749), wave * DC.ar(0.3599328994751)), Blip.ar(wave * DC.ar(0.33007156848907), wave * DC.ar(0.45253527164459), wave * DC.ar(0.56092584133148), wave * DC.ar(0.72799932956696))], modY * modY, varW97MFabi96082329359 * varW97MFabi96082329359, modZ * signal);
varW97MFabi960823293513 = VOSIM.ar(wave * DC.ar(0.65646958351135), wave * DC.ar(0.30603611469269), wave * DC.ar(0.69396984577179), wave * DC.ar(0.11699342727661), wave * DC.ar(0.77890634536743), wave * DC.ar(0.71980404853821));
varW97MFabi960823293514 = Gendy2.ar(wave * DC.ar(0.59017419815063), wave * DC.ar(0.28267359733582), wave * DC.ar(0.85055017471313), wave * DC.ar(0.60605561733246), wave * DC.ar(0.36961078643799), wave * DC.ar(0.46474385261536), wave * DC.ar(0.82455039024353), wave * DC.ar(0.7852498292923), wave * DC.ar(0.20230519771576), wave * DC.ar(0.49633347988129), wave * DC.ar(0.22248578071594), wave * DC.ar(0.22634148597717), wave * DC.ar(0.8425315618515), wave * DC.ar(0.83610570430756));

signal = varW97MFabi960823293514;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// WM.Attach.A232935
/////////////////////////////////////////////////////////

SynthDef.new("WM.Attach.A232935", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varWMAttachA2329359, varWMAttachA23293510, varWMAttachA23293511;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varWMAttachA2329359 = varWMAttachA23293510 = varWMAttachA23293511 = K2A.ar(t_trig).dup;
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
varWMAttachA2329359 = LPCSynth.ar(Array.fill(2.pow(13), { |i| rrand(-1, 1) }).as(LocalBuf), modX * in, modY * varWMAttachA23293511, FoaNFC.ar(wave * DC.ar(0.025574207305908), wave * DC.ar(0.3860274553299), wave * DC.ar(0.32113265991211), wave * DC.ar(0.79767918586731)), DemandEnvGen.ar(wave * DC.ar(0.72607934474945), wave * DC.ar(0.079061508178711), wave * DC.ar(0.22680258750916), wave * DC.ar(0.77584743499756), wave * DC.ar(0.31174337863922), wave * DC.ar(0.99383795261383), wave * DC.ar(0.61238670349121), wave * DC.ar(0.96762454509735), wave * DC.ar(0.12815880775452), wave * DC.ar(0.43928837776184)));
varWMAttachA23293510 = MedianTriggered.ar(gateEnv, varWMAttachA23293511 * in, varWMAttachA23293511 * in, SanityCheck.ar(wave * DC.ar(0.84327447414398)), Silent.ar());
varWMAttachA23293511 = Changed.ar(y, signal);
varWMAttachA2329359 = MZPokey.ar(0.74171388149261 * signal * varWMAttachA23293511, BufCombC.ar(wave * DC.ar(0.78169548511505), wave * DC.ar(0.97516715526581), wave * DC.ar(0.44081234931946), wave * DC.ar(0.67744171619415), wave * DC.ar(0.50352811813354), wave * DC.ar(0.36633408069611)), varWMAttachA2329359 * modZ, varWMAttachA23293510 * signal, env, modX * varWMAttachA2329359, LatoocarfianN.ar(wave * DC.ar(0.2399240732193), wave * DC.ar(0.44526624679565), wave * DC.ar(0.92867970466614), wave * DC.ar(0.4498245716095), wave * DC.ar(0.10923910140991), wave * DC.ar(0.6319272518158), wave * DC.ar(0.47898960113525), wave * DC.ar(0.74097764492035), wave * DC.ar(0.10317146778107)).lag3ud(wave * DC.ar(0.93220543861389), wave * DC.ar(0.88511216640472)), 0.64743673801422 * BufWr.ar(wave * DC.ar(0.082091450691223), wave * DC.ar(0.98336470127106), wave * DC.ar(0.50479662418365), wave * DC.ar(0.87440359592438)), varWMAttachA23293510 * modZ);
varWMAttachA23293510 = GaussTrig.ar(modY, wave * modY, in, Silent.ar());
varWMAttachA23293511 = AudioMSG.ar(varWMAttachA2329359 * signal, modX * modX, LinCongC.ar(wave * DC.ar(0.49057924747467), wave * DC.ar(0.26259541511536), wave * DC.ar(0.81761348247528), wave * DC.ar(0.63557839393616), wave * DC.ar(0.89969885349274), wave * DC.ar(0.86306202411652), wave * DC.ar(0.58731424808502)), Silent.ar());

signal = varWMAttachA23293511;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Backdoor.Freddy2329361
/////////////////////////////////////////////////////////

SynthDef.new("Backdoor.Freddy2329361", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varBackdoorFreddy2329369, varBackdoorFreddy23293610, varBackdoorFreddy23293611, varBackdoorFreddy23293612, varBackdoorFreddy23293613, varBackdoorFreddy23293614, varBackdoorFreddy23293615, varBackdoorFreddy232936116, varBackdoorFreddy232936117;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varBackdoorFreddy2329369 = varBackdoorFreddy23293610 = varBackdoorFreddy23293611 = varBackdoorFreddy23293612 = varBackdoorFreddy23293613 = varBackdoorFreddy23293614 = varBackdoorFreddy23293615 = varBackdoorFreddy232936116 = varBackdoorFreddy232936117 = K2A.ar(t_trig).dup;
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
varBackdoorFreddy2329369 = Henon2DN.ar(Pokey.ar(wave * DC.ar(0.87595045566559), wave * DC.ar(0.66864264011383), wave * DC.ar(0.28656435012817), wave * DC.ar(0.023946523666382), wave * DC.ar(0.2789021730423), wave * DC.ar(0.062249064445496), wave * DC.ar(0.10247480869293), wave * DC.ar(0.053166151046753), wave * DC.ar(0.10036396980286)).exprange(1, SampleRate.ir), modZ, varBackdoorFreddy23293610, 0.52010381221771 * env * varBackdoorFreddy232936117, 0.34425282478333 * varBackdoorFreddy23293615 * varBackdoorFreddy2329369, in * modZ, 0.93763028354164 * varBackdoorFreddy23293613 * varBackdoorFreddy23293610, Silent.ar());
varBackdoorFreddy23293610 = BFManipulate.ar(env * varBackdoorFreddy23293615, WhiteNoise.ar(0.99987483765316 * varBackdoorFreddy23293611 * signal.round(Pokey.ar(wave * DC.ar(0.59031939506531), wave * DC.ar(0.13033306598663), wave * DC.ar(0.72064828872681), wave * DC.ar(0.19716429710388), wave * DC.ar(0.89194011688232), wave * DC.ar(0.81288754940033), wave * DC.ar(0.59003436565399), wave * DC.ar(0.5654923915863), wave * DC.ar(0.077841401100159))), Silent.ar()).max(TWindex.ar(wave * DC.ar(0.25470328330994), wave * DC.ar(0.26606094837189), wave * DC.ar(0.3316365480423))), varBackdoorFreddy23293612, env * varBackdoorFreddy232936117, in * varBackdoorFreddy23293614, varBackdoorFreddy23293612 * signal, Timer.ar(gateEnv * varBackdoorFreddy23293614).blend(wave * DC.ar(0.29323720932007), wave * DC.ar(0.81114268302917)));
varBackdoorFreddy23293611 = LPFVS6.ar(island, VMScan2D.ar(wave * DC.ar(0.96934604644775), wave * DC.ar(0.53507459163666), wave * DC.ar(0.18500137329102)).exprange(1, SampleRate.ir), LFBrownNoise2.ar(env * signal, modX * modX.unipolar(wave * DC.ar(0.55061554908752)), varBackdoorFreddy2329369 * varBackdoorFreddy23293612, 0.99877879475645 * in * wave, Silent.ar()));
varBackdoorFreddy23293612 = AmpComp.ar(wave * in, varBackdoorFreddy23293612 * varBackdoorFreddy23293613, 0.50847256183624 * modX * varBackdoorFreddy23293612);
varBackdoorFreddy23293613 = DelayN.ar(varBackdoorFreddy23293611, varBackdoorFreddy23293613, signal * modZ, SkipNeedle.ar(wave * DC.ar(0.20855259895325), wave * DC.ar(0.063069820404053), wave * DC.ar(0.68465197086334)), Silent.ar().slew(wave * DC.ar(0.46420776844025), wave * DC.ar(0.58824384212494)));
varBackdoorFreddy23293614 = Limiter.ar(varBackdoorFreddy23293615, varBackdoorFreddy23293613, 0.16381239891052 * varBackdoorFreddy23293611);
varBackdoorFreddy23293615 = BFEncodeSter.ar(varBackdoorFreddy23293615 * varBackdoorFreddy23293615, t_trig, in * env, env * gateEnv, varBackdoorFreddy232936116 * env, modZ * modX, varBackdoorFreddy23293610 * varBackdoorFreddy23293615, varBackdoorFreddy23293613 * varBackdoorFreddy23293613);
varBackdoorFreddy2329369 = Index.ar(wave * DC.ar(0.0048127174377441), wave * DC.ar(0.12256956100464), wave * DC.ar(0.93792462348938), wave * DC.ar(0.15584945678711));
varBackdoorFreddy23293610 = FreeVerb2.ar(amp, varBackdoorFreddy23293612 * modY, varBackdoorFreddy2329369 * varBackdoorFreddy2329369, varBackdoorFreddy2329369, LPF.ar(wave * DC.ar(0.28201603889465), wave * DC.ar(0.33031976222992), wave * DC.ar(0.2293004989624), wave * DC.ar(0.54873359203339)), gateEnv, Silent.ar());
varBackdoorFreddy23293611 = BRF.ar(wave * DC.ar(0.59141790866852), wave * DC.ar(0.6520973443985), wave * DC.ar(0.74387454986572), wave * DC.ar(0.84725368022919), wave * DC.ar(0.95580077171326));
varBackdoorFreddy23293612 = FoaRotate.ar(modX * in, 0.39677309989929 * varBackdoorFreddy232936117, 0.6286497171282 * varBackdoorFreddy23293615 * modY, Silent.ar());
varBackdoorFreddy23293613 = Oregonator.ar(varBackdoorFreddy23293610 * varBackdoorFreddy23293614, varBackdoorFreddy23293613 * varBackdoorFreddy2329369, wave * varBackdoorFreddy232936116, modY * modZ, modX, FoaFocusX.ar(in * varBackdoorFreddy23293613, 0.24031603336334 * varBackdoorFreddy232936117, 0.9428342471375 * LPCSynth.ar(wave * DC.ar(0.19864451885223), wave * DC.ar(0.48466801643372), wave * DC.ar(0.82881295681), wave * DC.ar(0.35520279407501), wave * DC.ar(0.11203134059906)), Silent.ar()), modX * signal, x, 0.99941591888054 * varBackdoorFreddy23293610, Silent.ar());
varBackdoorFreddy23293614 = FMGrainI.ar(varBackdoorFreddy23293611 * gateEnv, island, varBackdoorFreddy23293614, varBackdoorFreddy2329369 * varBackdoorFreddy23293613, varBackdoorFreddy23293612, bufnum, bufnum, varBackdoorFreddy23293614, 0.91081705150496 * BPeakEQ.ar(wave * DC.ar(0.13654839992523), wave * DC.ar(0.65169739723206), wave * DC.ar(0.65525817871094), wave * DC.ar(0.17479562759399), wave * DC.ar(0.31366777420044), wave * DC.ar(0.025426983833313)), Silent.ar());
varBackdoorFreddy23293615 = Gendy4.ar(t_trig, varBackdoorFreddy23293613 * modZ, z, t_trig, BLowShelf.ar(wave * DC.ar(0.8398312330246), wave * DC.ar(0.89885544776917), wave * DC.ar(0.83290338516235), wave * DC.ar(0.81473231315613), wave * DC.ar(0.3288836479187), wave * DC.ar(0.18931603431702)).exprange(1, SampleRate.ir), varBackdoorFreddy232936116, modZ * varBackdoorFreddy23293614, modY * modY, wave * modX, gateEnv * modZ, 0.96829496154631 * varBackdoorFreddy23293615 * modY, Silent.ar());
// Variation test code
varBackdoorFreddy232936116 = BFEncodeSter.ar(gateEnv * signal, modX * modY, varBackdoorFreddy23293612, 0.34657824039459 * signal * modZ, amp, Streson.ar(0.76970636844635 * LFDNoise0.ar(varBackdoorFreddy23293613 * DC.ar(0.2939624786377), varBackdoorFreddy2329369 * DC.ar(0.95177280902863), varBackdoorFreddy23293611 * DC.ar(0.27934694290161)), 0.015269875526428 * varBackdoorFreddy23293612 * env, gateEnv, env, Silent.ar()), varBackdoorFreddy23293614, Delay2.ar(0.4894562959671 * varBackdoorFreddy23293614, 0.78182545648926 * varBackdoorFreddy2329369 * modX, Silent.ar()));
varBackdoorFreddy232936117 = ScopeOut.ar([RedPhasor.ar(varBackdoorFreddy23293615 * DC.ar(0.60422956943512), varBackdoorFreddy23293612 * DC.ar(0.29038512706757), varBackdoorFreddy23293613 * DC.ar(0.52071762084961), varBackdoorFreddy23293613 * DC.ar(0.26208508014679), varBackdoorFreddy2329369 * DC.ar(0.33077645301819), varBackdoorFreddy23293615 * DC.ar(0.14249432086945), varBackdoorFreddy23293613 * DC.ar(0.58908641338348)), GlitchRHPF.ar(varBackdoorFreddy23293610 * DC.ar(0.66398143768311), varBackdoorFreddy23293612 * DC.ar(0.70488703250885), varBackdoorFreddy2329369 * DC.ar(0.077177047729492), varBackdoorFreddy23293611 * DC.ar(0.31285381317139), varBackdoorFreddy23293610 * DC.ar(0.26016628742218))], Array.fill(2.pow(13), { |i| rrand(-1, 1) }).as(LocalBuf));
varBackdoorFreddy232936116 = BufGrainB.ar(modZ * varBackdoorFreddy23293612, x, bufnum, z, amp, bufnum, signal * varBackdoorFreddy23293613, 0.95738960525468 * wave * varBackdoorFreddy23293615, Silent.ar());
varBackdoorFreddy232936117 = AtsNoise.ar(Array.fill(2.pow(14), { |i| rrand(-1, 1) }).as(LocalBuf), 0.98220956325531 * varBackdoorFreddy2329369 * varBackdoorFreddy23293614, varBackdoorFreddy232936116, 0.99981044252275 * Lag3.ar(varBackdoorFreddy23293610 * DC.ar(0.27365553379059), varBackdoorFreddy23293615 * DC.ar(0.68848645687103), varBackdoorFreddy23293613 * DC.ar(0.89604496955872), varBackdoorFreddy23293614 * DC.ar(0.12279117107391)), Silent.ar());
varBackdoorFreddy232936116 = VOSIM.ar(varBackdoorFreddy232936116 * modX, varBackdoorFreddy23293614 * wave, 0.75185406208038 * varBackdoorFreddy23293612 * modZ, modZ * gateEnv, 0.99788327883294 * varBackdoorFreddy23293613 * wave, Silent.ar());
varBackdoorFreddy232936117 = Amplitude.ar(0.21645414829254 * varBackdoorFreddy23293612 * env, InFeedback.ar((80 + (island * 2)), 2), varBackdoorFreddy23293610 * varBackdoorFreddy232936117, 0.99903861433215 * modX * modZ, Silent.ar());

signal = varBackdoorFreddy232936117;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Voronezh.1536.C2329371
/////////////////////////////////////////////////////////

SynthDef.new("Voronezh.1536.C2329371", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varVoronezh1536C2329379, varVoronezh1536C23293710, varVoronezh1536C23293711, varVoronezh1536C23293712, varVoronezh1536C23293713, varVoronezh1536C23293714, varVoronezh1536C232937115;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varVoronezh1536C2329379 = varVoronezh1536C23293710 = varVoronezh1536C23293711 = varVoronezh1536C23293712 = varVoronezh1536C23293713 = varVoronezh1536C23293714 = varVoronezh1536C232937115 = K2A.ar(t_trig).dup;
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
varVoronezh1536C2329379 = Gendy5.ar(in * varVoronezh1536C23293710, z, wave, wave, varVoronezh1536C23293714 * varVoronezh1536C23293713, varVoronezh1536C23293712 * varVoronezh1536C23293711, varVoronezh1536C23293713 * wave, env * gateEnv, 0.1076672077179 * Metro.ar(wave * DC.ar(0.37853610515594), wave * DC.ar(0.58042907714844), wave * DC.ar(0.7762885093689), wave * DC.ar(0.10125780105591)), varVoronezh1536C2329379 * varVoronezh1536C23293714, gateEnv, Silent.ar());
varVoronezh1536C23293710 = LFPar.ar(modY, varVoronezh1536C23293713, varVoronezh1536C23293710, Silent.ar());
varVoronezh1536C23293711 = CombL.ar(varVoronezh1536C23293712, ArrayMin.ar(wave * DC.ar(0.58697187900543)), signal * varVoronezh1536C232937115, env * varVoronezh1536C23293712, FMGrain.ar(wave * DC.ar(0.86160957813263), wave * DC.ar(0.033324837684631), wave * DC.ar(0.73653364181519), wave * DC.ar(0.12190496921539), wave * DC.ar(0.23158061504364), wave * DC.ar(0.0701504945755), wave * DC.ar(0.41885077953339)), Silent.ar());
varVoronezh1536C23293712 = Impulse.ar(varVoronezh1536C2329379 * varVoronezh1536C232937115, gateEnv * gateEnv.lag2ud(wave * DC.ar(0.14135611057281), wave * DC.ar(0.066091537475586)), FoaZoomX.ar(wave * DC.ar(0.72378051280975), wave * DC.ar(0.084198474884033), wave * DC.ar(0.90613996982574), wave * DC.ar(0.21634554862976)), Silent.ar());
varVoronezh1536C23293713 = GlitchHPF.ar(varVoronezh1536C23293712, PSinGrain.ar(wave * DC.ar(0.52599716186523), wave * DC.ar(0.43562424182892), wave * DC.ar(0.23027038574219)).exprange(1, SampleRate.ir).madd(wave * DC.ar(0.74842262268066), wave * DC.ar(0.32387161254883)), 0.91799489720242 * varVoronezh1536C2329379 * varVoronezh1536C23293710, Silent.ar());
varVoronezh1536C23293714 = OscN.ar(Array.fill(2.pow(14), { |i| rrand(-1, 1) }).as(LocalBuf), varVoronezh1536C23293713 * varVoronezh1536C23293710, 0.40644192695618 * varVoronezh1536C23293710 * modZ, 0.12903582975639 * modZ * signal, Silent.ar().lag3ud(wave * DC.ar(0.14543271064758), wave * DC.ar(0.83979070186615)));
varVoronezh1536C2329379 = QuadC.ar(K2A.ar(wave * DC.ar(0.9234459400177)).exprange(1, SampleRate.ir), x, varVoronezh1536C23293713 * varVoronezh1536C232937115, varVoronezh1536C232937115 * modZ, modZ * env, YigClifford3DN.ar(wave * DC.ar(0.21396934986115), wave * DC.ar(0.0059925317764282), wave * DC.ar(0.66029512882233), wave * DC.ar(0.8971631526947), wave * DC.ar(0.97106909751892), wave * DC.ar(0.74135553836823), wave * DC.ar(0.65850651264191), wave * DC.ar(0.89723646640778), wave * DC.ar(0.34398019313812), wave * DC.ar(0.19853544235229)), Silent.ar());
varVoronezh1536C23293710 = Lag2.ar(wave * DC.ar(0.017492532730103), wave * DC.ar(0.46075809001923), wave * DC.ar(0.41660630702972), wave * DC.ar(0.36261534690857));
varVoronezh1536C23293711 = HenonL.ar(varVoronezh1536C2329379, gate, DoubleNestedAllpassL.ar(wave * DC.ar(0.32875597476959), wave * DC.ar(0.012838244438171), wave * DC.ar(0.51015138626099), wave * DC.ar(0.063570141792297), wave * DC.ar(0.26030993461609), wave * DC.ar(0.52452147006989), wave * DC.ar(0.82159960269928), wave * DC.ar(0.44370257854462), wave * DC.ar(0.95535266399384), wave * DC.ar(0.66999459266663), wave * DC.ar(0.87509191036224), wave * DC.ar(0.47190737724304)), bufnum, wave * varVoronezh1536C23293714, varVoronezh1536C23293710, Silent.ar());
varVoronezh1536C23293712 = FoaFocusY.ar(modZ * varVoronezh1536C232937115, varVoronezh1536C23293714 * signal, varVoronezh1536C23293710, Silent.ar());
varVoronezh1536C23293713 = StkBeeThree.ar(signal * in, gateEnv, y, in * varVoronezh1536C232937115, varVoronezh1536C23293713 * varVoronezh1536C232937115, x, modX * varVoronezh1536C23293712, varVoronezh1536C23293713, AllpassL.ar(wave * DC.ar(0.23982954025269), wave * DC.ar(0.15889298915863), wave * DC.ar(0.38445353507996), wave * DC.ar(0.89878737926483), wave * DC.ar(0.26839113235474), wave * DC.ar(0.65862393379211)));
varVoronezh1536C23293714 = Latch.ar(gate, modY);
// Variation test code
varVoronezh1536C232937115 = FBSineC.ar(gateEnv, signal, 0.52616798877716 * modX * varVoronezh1536C232937115, modX, gateEnv * modZ, modX, modX * varVoronezh1536C23293711, signal, Silent.ar());
varVoronezh1536C232937115 = LFDClipNoise.ar(gateEnv * signal, varVoronezh1536C2329379, Silent.ar());
varVoronezh1536C232937115 = Gendy1.ar(varVoronezh1536C23293713 * varVoronezh1536C23293710, varVoronezh1536C23293711 * signal.lagud(varVoronezh1536C23293711 * DC.ar(0.12030518054962), varVoronezh1536C23293713 * DC.ar(0.94328606128693)), y, signal * gateEnv, FMGrainI.ar(varVoronezh1536C23293711 * DC.ar(0.52777004241943), varVoronezh1536C23293711 * DC.ar(0.90379667282104), varVoronezh1536C23293713 * DC.ar(0.094421982765198), varVoronezh1536C23293713 * DC.ar(0.32304084300995), varVoronezh1536C23293711 * DC.ar(0.2042464017868), varVoronezh1536C23293710 * DC.ar(0.13266491889954), varVoronezh1536C2329379 * DC.ar(0.58277690410614), varVoronezh1536C23293710 * DC.ar(0.035817384719849), varVoronezh1536C23293713 * DC.ar(0.19363975524902), varVoronezh1536C23293712 * DC.ar(0.4149934053421)).exprange(1, SampleRate.ir), varVoronezh1536C23293710, bufnum, modZ * varVoronezh1536C23293711, amp, signal, 0.99996131881406 * modZ, Silent.ar());

signal = varVoronezh1536C232937115;
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
varTrivial1092329379 = FBSineC.ar(varTrivial1092329379, modY * wave, wave * gateEnv, 0.46606075763702 * gateEnv * wave, 0.61137568950653 * modX * gateEnv, island, 0.24469077587128 * env, modZ, Silent.ar());
varTrivial1092329379 = DoubleNestedAllpassL.ar(wave * DC.ar(0.50801396369934), wave * DC.ar(0.95548057556152), wave * DC.ar(0.93277490139008), wave * DC.ar(0.47076463699341), wave * DC.ar(0.98754227161407), wave * DC.ar(0.24920034408569), wave * DC.ar(0.49644124507904), wave * DC.ar(0.026647329330444), wave * DC.ar(0.55956339836121), wave * DC.ar(0.088456749916077), wave * DC.ar(0.26985049247742), wave * DC.ar(0.9791921377182));

signal = varTrivial1092329379;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Kyokushinkai.2056232938
/////////////////////////////////////////////////////////

SynthDef.new("Kyokushinkai.2056232938", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varKyokushinkai20562329389, varKyokushinkai205623293810, varKyokushinkai205623293811;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varKyokushinkai20562329389 = varKyokushinkai205623293810 = varKyokushinkai205623293811 = K2A.ar(t_trig).dup;
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
varKyokushinkai20562329389 = ScopeOut.ar([Concat.ar(wave * DC.ar(0.3747752904892), wave * DC.ar(0.95402503013611), wave * DC.ar(0.43819236755371), wave * DC.ar(0.50939786434174), wave * DC.ar(0.55686664581299), wave * DC.ar(0.49303317070007), wave * DC.ar(0.16358458995819), wave * DC.ar(0.32238376140594), wave * DC.ar(0.43412089347839), wave * DC.ar(0.52775132656097), wave * DC.ar(0.62428271770477), wave * DC.ar(0.59637629985809), wave * DC.ar(0.093508839607239), wave * DC.ar(0.35646641254425)), LFNoise2.ar(wave * DC.ar(0.316086769104), wave * DC.ar(0.01973021030426), wave * DC.ar(0.53137671947479))], Array.fill(2.pow(14), { |i| rrand(-1, 1) }).as(LocalBuf));
varKyokushinkai205623293810 = BMoog.ar(signal * modX, varKyokushinkai205623293810.wrap2(HPZ2.ar(wave * DC.ar(0.85834836959839), wave * DC.ar(0.55815589427948), wave * DC.ar(0.73250925540924))), varKyokushinkai205623293811 * varKyokushinkai20562329389, varKyokushinkai205623293811 * signal, modX, MidEQ.ar(wave * DC.ar(0.82052505016327), wave * DC.ar(0.89346873760223), wave * DC.ar(0.97337257862091), wave * DC.ar(0.45711982250214), wave * DC.ar(0.31993412971497), wave * DC.ar(0.14937329292297)), GbmanN.ar(wave * DC.ar(0.82933866977692), wave * DC.ar(0.24167025089264), wave * DC.ar(0.26735806465149), wave * DC.ar(0.062961459159851), wave * DC.ar(0.79694008827209)));
varKyokushinkai205623293811 = WarpZ.ar(2, Array.fill(2.pow(11), { |i| rrand(-1, 1) }).as(LocalBuf), y, LPF18.ar(wave * DC.ar(0.12947916984558), wave * DC.ar(0.39563632011414), wave * DC.ar(0.56373846530914), wave * DC.ar(0.29624271392822)).exprange(1, SampleRate.ir), in * env, bufnum, varKyokushinkai20562329389 * modZ, gate, modY * modY, gateEnv * env, t_trig, modY, Silent.ar());
varKyokushinkai20562329389 = AtsPartial.ar(wave * DC.ar(0.74715447425842), wave * DC.ar(0.67917203903198), wave * DC.ar(0.40994107723236), wave * DC.ar(0.80891788005829), wave * DC.ar(0.84401488304138), wave * DC.ar(0.48692297935486), wave * DC.ar(0.65247344970703));
varKyokushinkai205623293810 = GlitchHPF.ar(wave * DC.ar(0.76874816417694), wave * DC.ar(0.2559517621994), wave * DC.ar(0.6162097454071), wave * DC.ar(0.12168335914612));
varKyokushinkai205623293811 = FincoSprottL.ar(signal * gateEnv, modY, gate, modX * varKyokushinkai205623293811, in, amp, 0.99782692422696 * signal * in, Silent.ar());

signal = varKyokushinkai205623293811;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// HLLP.4288232938
/////////////////////////////////////////////////////////

SynthDef.new("HLLP.4288232938", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varHLLP42882329389;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varHLLP42882329389 = K2A.ar(t_trig).dup;
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
varHLLP42882329389 = InRange.ar(modY * in, gateEnv, signal);
varHLLP42882329389 = Limiter.ar(wave * DC.ar(0.81545579433441), wave * DC.ar(0.16562044620514), wave * DC.ar(0.89071822166443));

signal = varHLLP42882329389;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// HLLP.42882329381
/////////////////////////////////////////////////////////

SynthDef.new("HLLP.42882329381", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varHLLP42882329389, varHLLP4288232938110, varHLLP4288232938111;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varHLLP42882329389 = varHLLP4288232938110 = varHLLP4288232938111 = K2A.ar(t_trig).dup;
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
varHLLP42882329389 = Stepper.ar(Instruction.ar(wave * DC.ar(0.71379709243774), wave * DC.ar(0.39332318305969), wave * DC.ar(0.37539207935333)), x, varHLLP42882329389 * gateEnv, varHLLP4288232938111 * varHLLP42882329389, gateEnv * signal, env * gateEnv);
varHLLP42882329389 = LFPar.ar(modX, VarSaw.ar(wave * DC.ar(0.52505207061768), wave * DC.ar(0.69909608364105), wave * DC.ar(0.99918758869171), wave * DC.ar(0.17952311038971), wave * DC.ar(0.48808073997498)), 0.99987407524055 * modZ * wave, Silent.ar());
// Variation test code
varHLLP4288232938110 = Gbman2DC.ar(env * gateEnv, modZ, Gendy2.ar(varHLLP4288232938110, varHLLP4288232938111, varHLLP4288232938111, t_trig, signal * varHLLP42882329389, Decay2.ar(varHLLP42882329389 * DC.ar(0.068314671516418), varHLLP42882329389 * DC.ar(0.44088470935822), varHLLP42882329389 * DC.ar(0.29502356052399), varHLLP42882329389 * DC.ar(0.87237071990967), varHLLP42882329389 * DC.ar(0.089504957199097)).exprange(1, SampleRate.ir), varHLLP4288232938110, signal * varHLLP4288232938111, in * varHLLP4288232938111, 0.40923166275024 * gateEnv * in, modY * varHLLP4288232938110, env * varHLLP42882329389, wave, Silent.ar()), signal * signal.max(MantissaMask.ar(varHLLP42882329389 * DC.ar(0.78341948986053), varHLLP42882329389 * DC.ar(0.54519879817963), varHLLP42882329389 * DC.ar(0.80048632621765), varHLLP42882329389 * DC.ar(0.27382779121399))), 0.78924968203146 * B2Ster.ar(varHLLP42882329389 * DC.ar(0.34211885929108), varHLLP42882329389 * DC.ar(0.62771105766296), varHLLP42882329389 * DC.ar(0.50645101070404), varHLLP42882329389 * DC.ar(0.41147077083588), varHLLP42882329389 * DC.ar(0.62820661067963)), Silent.ar());
varHLLP4288232938111 = B2Ster.ar(env * modX, modX * gateEnv, z, LatoocarfianL.ar(varHLLP42882329389 * DC.ar(0.48722279071808), varHLLP42882329389 * DC.ar(0.87694823741913), varHLLP42882329389 * DC.ar(0.26901960372925), varHLLP42882329389 * DC.ar(0.97174203395844), varHLLP42882329389 * DC.ar(0.30854034423828), varHLLP42882329389 * DC.ar(0.35237276554108), varHLLP42882329389 * DC.ar(0.89536118507385), varHLLP42882329389 * DC.ar(0.53517365455627), varHLLP42882329389 * DC.ar(0.34674048423767)), Silent.ar());
varHLLP4288232938110 = SoftClipper8.ar(varHLLP4288232938110 * varHLLP4288232938110);
varHLLP4288232938111 = RunningMax.ar(varHLLP4288232938111, env);
varHLLP4288232938110 = FoaPressY.ar(modX, x, FoaTilt.ar(varHLLP42882329389 * DC.ar(0.78400146961212), varHLLP42882329389 * DC.ar(0.70577204227448), varHLLP42882329389 * DC.ar(0.9608371257782), varHLLP42882329389 * DC.ar(0.7333128452301)), Silent.ar());
varHLLP4288232938111 = RosslerL.ar(wave, 0.025698781013489 * in * varHLLP4288232938110, varHLLP4288232938110 * varHLLP42882329389, t_trig, wave * varHLLP42882329389, varHLLP4288232938111, z, signal * in, in, Silent.ar());

signal = varHLLP4288232938111;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// HLLO.3520.b232938
/////////////////////////////////////////////////////////

SynthDef.new("HLLO.3520.b232938", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varHLLO3520b2329389, varHLLO3520b23293810, varHLLO3520b23293811, varHLLO3520b23293812, varHLLO3520b23293813, varHLLO3520b23293814;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varHLLO3520b2329389 = varHLLO3520b23293810 = varHLLO3520b23293811 = varHLLO3520b23293812 = varHLLO3520b23293813 = varHLLO3520b23293814 = K2A.ar(t_trig).dup;
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
varHLLO3520b2329389 = PulseDivider.ar(XOut.ar(wave * DC.ar(0.53900682926178), wave * DC.ar(0.16711151599884), wave * DC.ar(0.32072365283966)), in * modX, varHLLO3520b23293813 * varHLLO3520b23293810);
varHLLO3520b23293810 = SanityCheck.ar(bufnum);
varHLLO3520b23293811 = LoopBuf.ar(2, Array.fill(2.pow(13), { |i| rrand(-1, 1) }).as(LocalBuf), varHLLO3520b23293813 * varHLLO3520b23293811.lag3(wave * DC.ar(0.70943880081177), wave * DC.ar(0.88020920753479)), modY, z, t_trig, env * varHLLO3520b23293811, varHLLO3520b23293813);
varHLLO3520b23293812 = SinGrain.ar(signal * modZ, FBSineC.ar(wave * DC.ar(0.22195899486542), wave * DC.ar(0.80253887176514), wave * DC.ar(0.010807633399963), wave * DC.ar(0.72780442237854), wave * DC.ar(0.46752870082855), wave * DC.ar(0.99819898605347), wave * DC.ar(0.85256886482239), wave * DC.ar(0.39358341693878), wave * DC.ar(0.8098840713501)), BufDelayL.ar(wave * DC.ar(0.9481748342514), wave * DC.ar(0.68737733364105), wave * DC.ar(0.25643599033356), wave * DC.ar(0.68282687664032), wave * DC.ar(0.22864460945129)).exprange(1, SampleRate.ir), 0.99991979706424 * in * in, Silent.ar());
varHLLO3520b23293813 = TGrains.ar(2, modX * varHLLO3520b23293811, Array.fill(2.pow(11), { |i| rrand(-1, 1) }).as(LocalBuf), wave * signal.wrap2(StkBowed.ar(wave * DC.ar(0.68960607051849), wave * DC.ar(0.026715159416199), wave * DC.ar(0.1005254983902), wave * DC.ar(0.4145884513855), wave * DC.ar(0.75898098945618), wave * DC.ar(0.23625886440277), wave * DC.ar(0.81245279312134), wave * DC.ar(0.26784181594849), wave * DC.ar(0.087084293365479), wave * DC.ar(0.8702085018158), wave * DC.ar(0.29668831825256))), 0.1391681432724 * varHLLO3520b23293813 * varHLLO3520b23293813, varHLLO3520b23293812, in * varHLLO3520b2329389, BLBufRd.ar(wave * DC.ar(0.67989873886108), wave * DC.ar(0.42454195022583), wave * DC.ar(0.54582941532135)), wave * varHLLO3520b2329389);
varHLLO3520b23293814 = Klang.ar(`[[GVerb.ar(wave * DC.ar(0.31115341186523), wave * DC.ar(0.59119367599487), wave * DC.ar(0.69428265094757), wave * DC.ar(0.62776577472687), wave * DC.ar(0.54738163948059), wave * DC.ar(0.77622485160828), wave * DC.ar(0.39997529983521), wave * DC.ar(0.32163166999817), wave * DC.ar(0.1065434217453), wave * DC.ar(0.67809367179871), wave * DC.ar(0.042620658874512), wave * DC.ar(0.98975682258606)), LorenzTrig.ar(wave * DC.ar(0.072445869445801), wave * DC.ar(0.72727251052856), wave * DC.ar(0.77415561676025), wave * DC.ar(0.39589262008667), wave * DC.ar(0.84530317783356), wave * DC.ar(0.40302109718323), wave * DC.ar(0.25788831710815), wave * DC.ar(0.045336484909058), wave * DC.ar(0.84842145442963), wave * DC.ar(0.91957116127014), wave * DC.ar(0.62284815311432))], [PitchShift.ar(wave * DC.ar(0.8273708820343), wave * DC.ar(0.15685284137726), wave * DC.ar(0.96314167976379), wave * DC.ar(0.58711838722229), wave * DC.ar(0.29185390472412), wave * DC.ar(0.393026471138), wave * DC.ar(0.61665439605713)), AudioMSG.ar(wave * DC.ar(0.96874415874481), wave * DC.ar(0.13460958003998), wave * DC.ar(0.34795475006104), wave * DC.ar(0.33966672420502))], [OffsetOut.ar(wave * DC.ar(0.57708609104156), wave * DC.ar(0.95986688137054)), BPeakEQ.ar(wave * DC.ar(0.010292410850525), wave * DC.ar(0.91485726833344), wave * DC.ar(0.79244554042816), wave * DC.ar(0.10521829128265), wave * DC.ar(0.13633549213409), wave * DC.ar(0.078571319580078))]], env, varHLLO3520b23293813 * gateEnv);
varHLLO3520b2329389 = Concat2.ar(wave * DC.ar(0.59850203990936), wave * DC.ar(0.015406250953674), wave * DC.ar(0.66126120090485), wave * DC.ar(0.26965737342834), wave * DC.ar(0.11742901802063), wave * DC.ar(0.15584063529968), wave * DC.ar(0.3630782365799), wave * DC.ar(0.34246063232422), wave * DC.ar(0.99449038505554), wave * DC.ar(0.20260000228882), wave * DC.ar(0.11699783802032), wave * DC.ar(0.37830352783203), wave * DC.ar(0.40595781803131), wave * DC.ar(0.12987172603607), wave * DC.ar(0.92909014225006));
varHLLO3520b23293810 = LPZ1.ar(varHLLO3520b23293813, PosRatio.ar(wave * DC.ar(0.83217930793762), wave * DC.ar(0.61474788188934), wave * DC.ar(0.43126606941223)), Silent.ar());
varHLLO3520b23293811 = Blip.ar(modZ, modZ, 0.99993031252056 * env * modY, Silent.ar());
varHLLO3520b23293812 = FincoSprottS.ar(Blip.ar(wave * DC.ar(0.8422863483429), wave * DC.ar(0.88576900959015), wave * DC.ar(0.42026889324188), wave * DC.ar(0.31523787975311)).exprange(1, SampleRate.ir), gateEnv, varHLLO3520b23293810 * varHLLO3520b23293814, signal, varHLLO3520b23293813 * varHLLO3520b2329389, varHLLO3520b23293811 * varHLLO3520b2329389, signal, 0.95655527105313 * varHLLO3520b23293812 * varHLLO3520b23293810, Silent.ar());
varHLLO3520b23293813 = Ramp.ar(wave * DC.ar(0.53466069698334), wave * DC.ar(0.71361744403839), wave * DC.ar(0.15529823303223), wave * DC.ar(0.964959025383));
varHLLO3520b23293814 = LinPan2.ar(gateEnv * wave, modZ, varHLLO3520b23293814);

signal = varHLLO3520b23293814;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Cascade.1701.L232939
/////////////////////////////////////////////////////////

SynthDef.new("Cascade.1701.L232939", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varCascade1701L2329399, varCascade1701L23293910, varCascade1701L23293911;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varCascade1701L2329399 = varCascade1701L23293910 = varCascade1701L23293911 = K2A.ar(t_trig).dup;
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
varCascade1701L2329399 = GbmanL.ar(modX * modX, modZ * modZ, 0.96386992931366 * Convolution3.ar(wave * DC.ar(0.99472081661224), wave * DC.ar(0.13312447071075), wave * DC.ar(0.72572100162506), wave * DC.ar(0.31367874145508), wave * DC.ar(0.61632573604584), wave * DC.ar(0.37760388851166)), SetResetFF.ar(wave * DC.ar(0.054529786109924), wave * DC.ar(0.94996428489685)), Silent.ar());
	varCascade1701L23293910 = Blip.ar(FBSineL.ar(wave * DC.ar(0.058715224266052), wave * DC.ar(0.26932215690613), wave * DC.ar(0.44560718536377), wave * DC.ar(0.53203392028809), wave * DC.ar(0.49979019165039), wave * DC.ar(0.40747773647308), wave * DC.ar(0.3738796710968), wave * DC.ar(0.75502145290375), wave * DC.ar(0.99001216888428)).exprange(1, SampleRate.ir), env * varCascade1701L2329399, StkClarinet.ar(wave.abs * DC.ar(0.94067072868347) + 1, wave.abs.max(1).min(128) * DC.ar(0.42639017105103), wave.abs.max(1).min(128), wave.abs.max(1).min(128), wave.abs.max(1).min(128) * DC.ar(0.11553108692169), wave.abs.max(1).min(128) * DC.ar(0.39443671703339), wave.abs.max(1).min(128) * DC.ar(0.38655292987823), wave.abs.max(1).min(128) * DC.ar(0.18756020069122), wave.abs.max(1).min(128) * DC.ar(0.17108821868896), Silent.ar()));
varCascade1701L23293911 = HPZ1.ar(varCascade1701L2329399, varCascade1701L23293910, Silent.ar());
varCascade1701L2329399 = IIRFilter.ar(0.42697894573212 * varCascade1701L23293910 * varCascade1701L2329399, BinData.ar(wave * DC.ar(0.66629588603973), wave * DC.ar(0.22773802280426), wave * DC.ar(0.026260137557983)).exprange(1, SampleRate.ir), modY, 0.84761976916836 * env * in.lag2ud(wave * DC.ar(0.55802392959595), wave * DC.ar(0.77530777454376)), Silent.ar());
varCascade1701L23293910 = PeakFollower.ar(wave * DC.ar(0.41079127788544), wave * DC.ar(0.87219202518463));
varCascade1701L23293911 = Lorenz2DN.ar(Atari2600.ar(wave * DC.ar(0.5407989025116), wave * DC.ar(0.17930364608765), wave * DC.ar(0.55312180519104), wave * DC.ar(0.64291036128998), wave * DC.ar(0.78935897350311), wave * DC.ar(0.14095556735992), wave * DC.ar(0.19584214687347)).exprange(1, SampleRate.ir), RedDPCMencode.ar(wave * DC.ar(0.84881675243378), wave * DC.ar(0.82615864276886)).exprange(1, SampleRate.ir), t_trig, amp, island, varCascade1701L23293911, varCascade1701L23293910, wave * varCascade1701L23293911, 0.16631555557251 * signal * wave, 0.97190800536385 * env * modZ, Silent.ar());

signal = varCascade1701L23293911;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Multiplex.815232941
/////////////////////////////////////////////////////////

SynthDef.new("Multiplex.815232941", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varMultiplex8152329419, varMultiplex81523294110, varMultiplex81523294111, varMultiplex81523294112;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varMultiplex8152329419 = varMultiplex81523294110 = varMultiplex81523294111 = varMultiplex81523294112 = K2A.ar(t_trig).dup;
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
varMultiplex8152329419 = YigCliffordN.ar(SN76489.ar(wave * DC.ar(0.89105045795441), wave * DC.ar(0.63419961929321), wave * DC.ar(0.58969688415527), wave * DC.ar(0.050642371177673), wave * DC.ar(0.69560241699219), wave * DC.ar(0.79316282272339), wave * DC.ar(0.81071698665619), wave * DC.ar(0.62792432308197), wave * DC.ar(0.03741466999054)).exprange(1, SampleRate.ir), varMultiplex81523294110 * signal, varMultiplex8152329419 * env, t_trig, 0.047922372817993 * env * gateEnv, t_trig, in * wave, BufGrainIBF.ar(wave * DC.ar(0.4964793920517), wave * DC.ar(0.18701469898224), wave * DC.ar(0.46576023101807), wave * DC.ar(0.78768289089203), wave * DC.ar(0.76063346862793), wave * DC.ar(0.81621527671814), wave * DC.ar(0.64581453800201), wave * DC.ar(0.28263485431671), wave * DC.ar(0.28007566928864), wave * DC.ar(0.24905943870544), wave * DC.ar(0.17021882534027), wave * DC.ar(0.40500748157501), wave * DC.ar(0.59154450893402), wave * DC.ar(0.4797443151474), wave * DC.ar(0.30482876300812)), Silent.ar());
varMultiplex81523294110 = BRF.ar(varMultiplex8152329419 * in, varMultiplex81523294110, 0.94695127010345 * wave * gateEnv, modX, Silent.ar());
varMultiplex81523294111 = RedDPCMencode.ar(varMultiplex81523294112 * varMultiplex81523294110, 0.48186349868774 * modZ * varMultiplex81523294112);
varMultiplex81523294112 = Ringz.ar(varMultiplex8152329419 * in, signal, modY * varMultiplex8152329419, 0.99973624548545 * varMultiplex81523294112 * varMultiplex8152329419, Silent.ar());
varMultiplex8152329419 = XFade2.ar(wave * DC.ar(0.14186918735504), wave * DC.ar(0.22766470909119), wave * DC.ar(0.86226201057434), wave * DC.ar(0.29910719394684));
varMultiplex81523294110 = AllpassC.ar(wave * DC.ar(0.19934177398682), wave * DC.ar(0.79155361652374), wave * DC.ar(0.36314213275909), wave * DC.ar(0.28014206886292), wave * DC.ar(0.6417064666748), wave * DC.ar(0.21166861057281));
varMultiplex81523294111 = LPF.ar(wave * DC.ar(0.92908465862274), wave * DC.ar(0.52195382118225), wave * DC.ar(0.85317480564117), wave * DC.ar(0.99501860141754));
varMultiplex81523294112 = Ball.ar(wave * DC.ar(0.27598822116852), wave * DC.ar(0.2183381319046), wave * DC.ar(0.84440398216248), wave * DC.ar(0.65643525123596));

signal = varMultiplex81523294112;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// W97M.MBug.A232941
/////////////////////////////////////////////////////////

SynthDef.new("W97M.MBug.A232941", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varW97MMBugA2329419, varW97MMBugA23294110, varW97MMBugA23294111;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varW97MMBugA2329419 = varW97MMBugA23294110 = varW97MMBugA23294111 = K2A.ar(t_trig).dup;
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
varW97MMBugA2329419 = StkMoog.ar(modX, modX.minNyquist(), 0.97926771640778 * varW97MMBugA23294110 * varW97MMBugA2329419, modZ, varW97MMBugA23294110 * modY, varW97MMBugA23294110 * varW97MMBugA23294111, varW97MMBugA23294111 * in, 0.9999270149395 * env * modX, Silent.ar());
varW97MMBugA23294110 = StkMandolin.ar(varW97MMBugA23294110 * varW97MMBugA23294110, wave * varW97MMBugA23294110, gateEnv * gateEnv, modX, amp, varW97MMBugA23294110 * signal, signal * varW97MMBugA23294111, LFNoise2.ar(wave * DC.ar(0.96605980396271), wave * DC.ar(0.96572577953339), wave * DC.ar(0.43225657939911)), Silent.ar());
varW97MMBugA23294111 = BufGrainB.ar(LPZ2.ar(wave * DC.ar(0.80753135681152), wave * DC.ar(0.49916255474091), wave * DC.ar(0.22790372371674)), signal * signal, bufnum, varW97MMBugA23294110, island, bufnum, wave * modY, varW97MMBugA23294111, Silent.ar().absdif(PeakFollower.ar(wave * DC.ar(0.81669771671295), wave * DC.ar(0.27184212207794))));
varW97MMBugA2329419 = Pulse.ar(signal, signal * varW97MMBugA2329419, Blip.ar(wave * DC.ar(0.050518155097961), wave * DC.ar(0.92557811737061), wave * DC.ar(0.77729141712189), wave * DC.ar(0.53462672233582)), Silent.ar());
varW97MMBugA23294110 = K2A.ar(varW97MMBugA23294111);
varW97MMBugA23294111 = WhiteNoise.ar(0.96930858123416 * NeedleRect.ar(wave * DC.ar(0.952223777771), wave * DC.ar(0.011442422866821), wave * DC.ar(0.67554020881653), wave * DC.ar(0.24313318729401), wave * DC.ar(0.5411788225174), wave * DC.ar(0.069609642028809), wave * DC.ar(0.82620000839233)), Silent.ar());

signal = varW97MMBugA23294111;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// XM.Laroux.CL232942
/////////////////////////////////////////////////////////

SynthDef.new("XM.Laroux.CL232942", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varXMLarouxCL2329429;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varXMLarouxCL2329429 = K2A.ar(t_trig).dup;
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
varXMLarouxCL2329429 = PVInfo.ar(Array.fill(2.pow(15), { |i| rrand(-1, 1) }).as(LocalBuf), modZ * signal, gate, 0.95798610415435 * modZ * modZ, Silent.ar());
varXMLarouxCL2329429 = LFGauss.ar(wave * DC.ar(0.30371451377869), wave * DC.ar(0.099042296409607), wave * DC.ar(0.29773497581482), wave * DC.ar(0.83086693286896), wave * DC.ar(0.67990279197693));

signal = varXMLarouxCL2329429;
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
varLinuxOrig23294210 = LinPan2.ar(varLinuxOrig23294210 * gateEnv, z, island);
varLinuxOrig23294211 = RandSeed.ar(wave * modX, signal * in);
varLinuxOrig23294212 = AllpassC.ar(modZ * varLinuxOrig2329429, varLinuxOrig23294213, t_trig, 0.8884584903717 * varLinuxOrig23294211 * env, 0.98119820162967 * modY * env, Silent.ar());
varLinuxOrig23294213 = AverageOutput.ar(bufnum, env * varLinuxOrig23294212, 0.17915171879355 * modX * varLinuxOrig2329429, VOsc.ar(wave * DC.ar(0.50895535945892), wave * DC.ar(0.40540087223053), wave * DC.ar(0.48595428466797), wave * DC.ar(0.84983468055725), wave * DC.ar(0.19734537601471)));
varLinuxOrig2329429 = LatoocarfianC.ar(env * varLinuxOrig23294211, varLinuxOrig23294211 * signal, varLinuxOrig23294211, wave * varLinuxOrig23294210, y, varLinuxOrig23294212, modZ * varLinuxOrig23294212, modX, Silent.ar());
varLinuxOrig23294210 = SanityCheck.ar(modZ);
varLinuxOrig23294211 = LFSaw.ar(wave * DC.ar(0.64873445034027), wave * DC.ar(0.17079305648804), wave * DC.ar(0.57484710216522), wave * DC.ar(0.57509315013885));
varLinuxOrig23294212 = RMShelf.ar(x, StkBowed.ar(wave * DC.ar(0.01585853099823), wave * DC.ar(0.77348446846008), wave * DC.ar(0.49366295337677), wave * DC.ar(0.25429272651672), wave * DC.ar(0.13019263744354), wave * DC.ar(0.41565001010895), wave * DC.ar(0.8952032327652), wave * DC.ar(0.46842968463898), wave * DC.ar(0.02053165435791), wave * DC.ar(0.55144560337067), wave * DC.ar(0.73965907096863)).exprange(1, SampleRate.ir), modX, 0.99998972054384 * env, Silent.ar());
varLinuxOrig23294213 = AtsAmp.ar(wave * DC.ar(0.55147457122803), wave * DC.ar(0.12432789802551), wave * DC.ar(0.53744232654572), wave * DC.ar(0.6227400302887), wave * DC.ar(0.020526170730591));

signal = varLinuxOrig23294213;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Datacrime.B.1514A232943
/////////////////////////////////////////////////////////

SynthDef.new("Datacrime.B.1514A232943", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varDatacrimeB1514A2329439;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varDatacrimeB1514A2329439 = K2A.ar(t_trig).dup;
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
varDatacrimeB1514A2329439 = SinGrainIBF.ar(modX * modX, island, env * signal, bufnum, bufnum, gateEnv, varDatacrimeB1514A2329439 * in, signal * modX, gate, signal * modY, CuspN.ar(wave * DC.ar(0.90705835819244), wave * DC.ar(0.92716121673584), wave * DC.ar(0.34728801250458), wave * DC.ar(0.28487348556519), wave * DC.ar(0.51012122631073), wave * DC.ar(0.22837555408478)), Silent.ar());
varDatacrimeB1514A2329439 = Convolution.ar(DelayL.ar(bufnum, in * env, Convolution2.ar(wave * DC.ar(0.49771571159363), wave * DC.ar(0.52121412754059), wave * DC.ar(0.28537964820862), wave * DC.ar(0.489386677742), wave * DC.ar(0.82199001312256), wave * DC.ar(0.967609167099)), 0.99995893804077 * modZ * signal, Silent.ar()), modZ, TermanWang.ar(z, modY * gateEnv, env, gateEnv * varDatacrimeB1514A2329439, varDatacrimeB1514A2329439 * modX, 0.66484081745148 * env * varDatacrimeB1514A2329439, t_trig, varDatacrimeB1514A2329439, gateEnv * wave, modY, Silent.ar()), 0.99575804839579 * modY * varDatacrimeB1514A2329439, Silent.ar());

signal = varDatacrimeB1514A2329439;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Rajaat.287232944
/////////////////////////////////////////////////////////

SynthDef.new("Rajaat.287232944", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varRajaat2872329449, varRajaat28723294410, varRajaat28723294411;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varRajaat2872329449 = varRajaat28723294410 = varRajaat28723294411 = K2A.ar(t_trig).dup;
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
varRajaat2872329449 = FoaDirectY.ar(varRajaat2872329449 * varRajaat2872329449, Instruction.ar(Array.fill(2.pow(10), { |i| rrand(-1, 1) }).as(LocalBuf), 0.99991415818494 * signal * modY, Silent.ar()), signal, Silent.ar());
varRajaat28723294410 = CrossoverDistortion.ar(varRajaat28723294410 * env, modY, StandardL.ar(wave * DC.ar(0.82624268531799), wave * DC.ar(0.032630801200867), wave * DC.ar(0.38033306598663), wave * DC.ar(0.94146728515625), wave * DC.ar(0.080136775970459), wave * DC.ar(0.79253590106964)), 0.93369531121778 * Gate.ar(wave * DC.ar(0.16705667972565), wave * DC.ar(0.70440936088562)), Silent.ar());
varRajaat28723294411 = Hilbert.ar(gateEnv, 0.9946214588218 * wave * env, Concat2.ar(wave * DC.ar(0.92665958404541), wave * DC.ar(0.58260345458984), wave * DC.ar(0.43030226230621), wave * DC.ar(0.98574542999268), wave * DC.ar(0.68576562404633), wave * DC.ar(0.43896126747131), wave * DC.ar(0.14272558689117), wave * DC.ar(0.089862465858459), wave * DC.ar(0.37213945388794), wave * DC.ar(0.0037802457809448), wave * DC.ar(0.6732702255249), wave * DC.ar(0.26762771606445), wave * DC.ar(0.0068756341934204), wave * DC.ar(0.26582884788513), wave * DC.ar(0.59751808643341)));
varRajaat2872329449 = Fhn2DN.ar(varRajaat2872329449 * wave, gateEnv * wave, varRajaat28723294411 * in, wave * modX, amp, modZ * varRajaat2872329449, varRajaat28723294411 * varRajaat28723294411, gateEnv * varRajaat28723294411, gateEnv * varRajaat2872329449, LPCAnalyzer.ar(wave * DC.ar(0.060884952545166), wave * DC.ar(0.93117332458496), wave * DC.ar(0.69541311264038), wave * DC.ar(0.17221653461456), wave * DC.ar(0.31477785110474), wave * DC.ar(0.49496448040009), wave * DC.ar(0.73934531211853), wave * DC.ar(0.50059902667999), wave * DC.ar(0.87312126159668)).wrap(wave * DC.ar(0.26350557804108), wave * DC.ar(0.45964467525482)), Silent.ar().wrap(wave * DC.ar(0.020903706550598), wave * DC.ar(0.72228848934174)));
varRajaat28723294410 = MembraneCircle.ar(wave * DC.ar(0.45279407501221), wave * DC.ar(0.17096710205078), wave * DC.ar(0.41867697238922), wave * DC.ar(0.55287313461304), wave * DC.ar(0.88475120067596));
varRajaat28723294411 = WeaklyNonlinear.ar(wave * DC.ar(0.44084310531616), wave * DC.ar(0.16818726062775), wave * DC.ar(0.40729868412018), wave * DC.ar(0.47383558750153), wave * DC.ar(0.93811559677124), wave * DC.ar(0.10601580142975), wave * DC.ar(0.2350537776947), wave * DC.ar(0.022814631462097), wave * DC.ar(0.801682472229), wave * DC.ar(0.75700008869171), wave * DC.ar(0.85812556743622), wave * DC.ar(0.22778248786926), wave * DC.ar(0.43232762813568));

signal = varRajaat28723294411;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Champagne.815232945
/////////////////////////////////////////////////////////

SynthDef.new("Champagne.815232945", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varChampagne8152329459, varChampagne81523294510, varChampagne81523294511, varChampagne81523294512, varChampagne81523294513;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varChampagne8152329459 = varChampagne81523294510 = varChampagne81523294511 = varChampagne81523294512 = varChampagne81523294513 = K2A.ar(t_trig).dup;
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
varChampagne8152329459 = AtsNoise.ar(Array.fill(2.pow(12), { |i| rrand(-1, 1) }).as(LocalBuf), modZ * modX, wave * env, varChampagne81523294510, Silent.ar());
varChampagne81523294510 = Lag2UD.ar(x, varChampagne8152329459, modX, 0.88247688146049 * modY * gateEnv.lag3(wave * DC.ar(0.27518582344055), wave * DC.ar(0.90210938453674)).amclip(FoaDominateX.ar(wave * DC.ar(0.54369938373566), wave * DC.ar(0.40040361881256), wave * DC.ar(0.16591441631317), wave * DC.ar(0.23202168941498))), Silent.ar());
varChampagne81523294511 = PulseCount.ar(varChampagne81523294512 * varChampagne81523294510, 0.99329173564911 * signal * signal);
varChampagne81523294512 = FBSineL.ar(varChampagne8152329459 * varChampagne8152329459, varChampagne81523294513 * varChampagne8152329459, varChampagne81523294511, signal, modY * varChampagne81523294511, amp, varChampagne81523294513 * modX, FoaFocusZ.ar(wave * DC.ar(0.15275764465332), wave * DC.ar(0.52674877643585), wave * DC.ar(0.59678244590759), wave * DC.ar(0.73300671577454)), Silent.ar());
varChampagne81523294513 = CuspN.ar(modZ, modZ * modY, bufnum, in, 0.99426562033994 * varChampagne81523294510 * env, Silent.ar());
varChampagne8152329459 = Henon2DN.ar(varChampagne81523294511 * varChampagne81523294513, varChampagne81523294510 * signal.minNyquist(), modZ * signal, 0.23371708393097 * env * modX, modX * varChampagne81523294512, modX, wave, Silent.ar());
varChampagne81523294510 = WhiteNoise.ar(wave * DC.ar(0.37241113185883), wave * DC.ar(0.51130890846252));
varChampagne81523294511 = AmpComp.ar(RLPF.ar(wave * DC.ar(0.49435937404633), wave * DC.ar(0.29670429229736), wave * DC.ar(0.44050145149231), wave * DC.ar(0.24866247177124), wave * DC.ar(0.83196806907654)).exprange(1, SampleRate.ir), env, varChampagne81523294512);
varChampagne81523294512 = LFBrownNoise0.ar(wave * DC.ar(0.79511404037476), wave * DC.ar(0.6050671339035), wave * DC.ar(0.51520884037018), wave * DC.ar(0.097064852714539), wave * DC.ar(0.93348431587219));
varChampagne81523294513 = CompanderD.ar(FoaDirectY.ar(wave * DC.ar(0.15936231613159), wave * DC.ar(0.87859523296356), wave * DC.ar(0.25417029857635), wave * DC.ar(0.39305698871613)), gateEnv, varChampagne81523294513 * varChampagne81523294511, 0.19966518878937 * gateEnv * gateEnv, modZ, bufnum, in, Silent.ar());

signal = varChampagne81523294513;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Dakuma.1976232945
/////////////////////////////////////////////////////////

SynthDef.new("Dakuma.1976232945", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varDakuma19762329459, varDakuma197623294510, varDakuma197623294511, varDakuma197623294512, varDakuma197623294513, varDakuma197623294514, varDakuma197623294515;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varDakuma19762329459 = varDakuma197623294510 = varDakuma197623294511 = varDakuma197623294512 = varDakuma197623294513 = varDakuma197623294514 = varDakuma197623294515 = K2A.ar(t_trig).dup;
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
varDakuma19762329459 = DecodeB2.ar(2, varDakuma197623294510 * modZ, OSWrap4.ar(amp, varDakuma197623294512, modX * env), 0.12776017189026 * PVSynth.ar(wave * DC.ar(0.90020942687988), wave * DC.ar(0.70847344398499), wave * DC.ar(0.29733049869537), wave * DC.ar(0.37075865268707), wave * DC.ar(0.34325468540192), wave * DC.ar(0.86697196960449), wave * DC.ar(0.87542712688446), wave * DC.ar(0.85638642311096), wave * DC.ar(0.22140836715698)), 0.11908102035522 * varDakuma197623294513 * varDakuma197623294514);
varDakuma197623294510 = MarkovSynth.ar(RMShelf2.ar(wave * DC.ar(0.87878656387329), wave * DC.ar(0.9693409204483), wave * DC.ar(0.92314553260803), wave * DC.ar(0.58225321769714), wave * DC.ar(0.54377388954163)), Pan2.ar(wave * DC.ar(0.38718008995056), wave * DC.ar(0.10124957561493), wave * DC.ar(0.58801448345184)), 0.22569608688354 * varDakuma197623294511 * varDakuma197623294512, gateEnv * modX);
varDakuma197623294511 = Brusselator.ar(varDakuma197623294513 * env, t_trig, gate.bitXor(HenonL.ar(wave * DC.ar(0.74696576595306), wave * DC.ar(0.91763865947723), wave * DC.ar(0.17527604103088), wave * DC.ar(0.16767549514771), wave * DC.ar(0.41505587100983), wave * DC.ar(0.88155376911163), wave * DC.ar(0.30929756164551))), y, env, modZ, 0.95983087434329 * NeedleRect.ar(wave * DC.ar(0.96529281139374), wave * DC.ar(0.8349711894989), wave * DC.ar(0.7009836435318), wave * DC.ar(0.23986840248108), wave * DC.ar(0.26961493492126), wave * DC.ar(0.38395392894745), wave * DC.ar(0.55145812034607)), Silent.ar());
varDakuma197623294512 = RunningMin.ar(varDakuma197623294515 * env, varDakuma197623294510 * in);
varDakuma197623294513 = TextVU.ar(ZeroCrossing.ar(wave * DC.ar(0.72795271873474)), z.madd(wave * DC.ar(0.41260874271393), wave * DC.ar(0.65864682197571)), z, varDakuma197623294511 * varDakuma197623294510, varDakuma197623294513, x);
varDakuma197623294514 = CoinGate.ar(signal * in, env);
varDakuma197623294515 = FincoSprottM.ar(signal * modZ, 0.005592942237854 * varDakuma197623294515 * varDakuma197623294514, varDakuma197623294515, varDakuma197623294514, gateEnv * env, gate, varDakuma197623294515, wave, LatoocarfianN.ar(wave * DC.ar(0.46474468708038), wave * DC.ar(0.24804043769836), wave * DC.ar(0.64860081672668), wave * DC.ar(0.18633460998535), wave * DC.ar(0.39777314662933), wave * DC.ar(0.88346230983734), wave * DC.ar(0.42033219337463), wave * DC.ar(0.94869077205658), wave * DC.ar(0.8936573266983)));
varDakuma19762329459 = ToggleFF.ar(wave * DC.ar(0.76921665668488));
varDakuma197623294510 = LPF18.ar(modX * gateEnv, varDakuma197623294514, modX * varDakuma197623294511, varDakuma197623294514);
varDakuma197623294511 = DetectSilence.ar(wave * DC.ar(0.38750326633453), wave * DC.ar(0.50205707550049), wave * DC.ar(0.48072457313538), wave * DC.ar(0.66826963424683));
varDakuma197623294512 = SinTone.ar(wave * DC.ar(0.004483699798584), wave * DC.ar(0.4092743396759), wave * DC.ar(0.98312830924988), wave * DC.ar(0.32538604736328));
varDakuma197623294513 = VMScan2D.ar(Array.fill(2.pow(13), { |i| rrand(-1, 1) }).as(LocalBuf), 0.97802661125246 * varDakuma197623294513 * gateEnv, Silent.ar());
varDakuma197623294514 = Pokey.ar(gateEnv * varDakuma197623294515, varDakuma19762329459, z, signal * modY, varDakuma197623294514, modX * gateEnv, varDakuma197623294513, PeakFollower.ar(wave * DC.ar(0.44884562492371), wave * DC.ar(0.90167641639709)), signal);
varDakuma197623294515 = B2Ster.ar(wave * DC.ar(0.64956367015839), wave * DC.ar(0.69479501247406), wave * DC.ar(0.79756271839142), wave * DC.ar(0.39291858673096), wave * DC.ar(0.47798204421997));

signal = varDakuma197623294515;
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
varW95Epipm23294711 = RMShelf2.ar(wave * DC.ar(0.020031452178955), wave * DC.ar(0.52678346633911), wave * DC.ar(0.19608008861542), wave * DC.ar(0.77292716503143), wave * DC.ar(0.14653587341309));
	varW95Epipm23294712 = StkShakers.ar((varW95Epipm23294711 * env).abs.min(128), varW95Epipm23294711.abs.min(128), wave.abs.min(128), varW95Epipm2329479.abs.min(128), signal.abs.min(128), LinXFade2.ar(wave * DC.ar(0.1555814743042).abs.min(128), wave.abs.min(128) * DC.ar(0.59236800670624), wave.abs.min(128) * DC.ar(0.715247631073), wave.abs.min(128) * DC.ar(0.14977765083313)), Silent.ar());
varW95Epipm23294713 = BHiPass.ar(wave * DC.ar(0.94175016880035), wave * DC.ar(0.88314640522003), wave * DC.ar(0.66867923736572), wave * DC.ar(0.61407375335693), wave * DC.ar(0.21796238422394));

signal = varW95Epipm23294713;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// W95.Epip@m2329471
/////////////////////////////////////////////////////////

SynthDef.new("W95.Epip@m2329471", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varW95Epipm2329479, varW95Epipm23294710, varW95Epipm23294711, varW95Epipm23294712, varW95Epipm23294713, varW95Epipm232947114, varW95Epipm232947115;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varW95Epipm2329479 = varW95Epipm23294710 = varW95Epipm23294711 = varW95Epipm23294712 = varW95Epipm23294713 = varW95Epipm232947114 = varW95Epipm232947115 = K2A.ar(t_trig).dup;
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
varW95Epipm2329479 = BBandStop.ar(0.1789379119873 * DemandEnvGen.ar(wave * DC.ar(0.63352143764496), wave * DC.ar(0.44101476669312), wave * DC.ar(0.76588308811188), wave * DC.ar(0.055316209793091), wave * DC.ar(0.73294961452484), wave * DC.ar(0.70379674434662), wave * DC.ar(0.86452102661133), wave * DC.ar(0.58561098575592), wave * DC.ar(0.54133152961731), wave * DC.ar(0.59817743301392)).madd(wave * DC.ar(0.14275777339935), wave * DC.ar(0.58354496955872)), BufDelayN.ar(wave * DC.ar(0.218390583992), wave * DC.ar(0.8869800567627), wave * DC.ar(0.76080310344696), wave * DC.ar(0.77043390274048), wave * DC.ar(0.91956579685211)).exprange(1, SampleRate.ir), wave, 0.7810108181558 * varW95Epipm232947115 * varW95Epipm23294713, Silent.ar());
varW95Epipm23294710 = DiskOut.ar(Array.fill(2.pow(13), { |i| rrand(-1, 1) }).as(LocalBuf), [LastValue.ar(wave * DC.ar(0.90523409843445), wave * DC.ar(0.087120175361633)), Standard2DC.ar(wave * DC.ar(0.28645706176758), wave * DC.ar(0.79434943199158), wave * DC.ar(0.72436761856079), wave * DC.ar(0.33538866043091), wave * DC.ar(0.3626172542572), wave * DC.ar(0.71751821041107), wave * DC.ar(0.62239384651184))]);
varW95Epipm23294711 = BFEncodeSter.ar(modZ * varW95Epipm232947114, varW95Epipm23294712 * varW95Epipm23294710, wave * varW95Epipm232947115, varW95Epipm23294713 * varW95Epipm23294710.mod(RunningSum.ar(wave * DC.ar(0.7846587896347), wave * DC.ar(0.72761142253876))), modZ, modY, varW95Epipm232947115 * varW95Epipm232947114, 0.82912456989288 * varW95Epipm232947115 * signal);
varW95Epipm23294712 = NTube.ar(gateEnv * varW95Epipm23294711, [PeakEQ2.ar(wave * DC.ar(0.91131591796875), wave * DC.ar(0.73082780838013), wave * DC.ar(0.38670384883881), wave * DC.ar(0.29969787597656)), SinOscFB.ar(wave * DC.ar(0.34840738773346), wave * DC.ar(0.81574821472168), wave * DC.ar(0.13725018501282), wave * DC.ar(0.50642371177673))], [PSinGrain.ar(wave * DC.ar(0.888392329216), wave * DC.ar(0.5051931142807), wave * DC.ar(0.19955039024353)), SoftClipper8.ar(wave * DC.ar(0.59199845790863))], [BPZ2.ar(wave * DC.ar(0.93411409854889), wave * DC.ar(0.069284439086914), wave * DC.ar(0.88868618011475)), Demand.ar(wave * DC.ar(0.80349636077881), wave * DC.ar(0.77349936962128), wave * DC.ar(0.71448218822479))], EnvGen.ar(wave * DC.ar(0.64163482189178), wave * DC.ar(0.36896467208862), wave * DC.ar(0.43469536304474), wave * DC.ar(0.92903590202332), wave * DC.ar(0.87548923492432), wave * DC.ar(0.074054718017578)), Silent.ar());
varW95Epipm23294713 = LADSPA.ar(2, 0.28827118873596 * varW95Epipm232947114 * in, varW95Epipm232947114 * varW95Epipm23294710);
varW95Epipm2329479 = Hasher.ar(varW95Epipm2329479 * varW95Epipm232947114, 0.99849994733468 * varW95Epipm232947114 * signal, Silent.ar());
varW95Epipm23294710 = BBandPass.ar(wave * DC.ar(0.74838769435883), wave * DC.ar(0.93011200428009), wave * DC.ar(0.069314956665039), wave * DC.ar(0.71737468242645), wave * DC.ar(0.35783445835114));
varW95Epipm23294711 = NestedAllpassC.ar(varW95Epipm232947114 * signal, signal, AtsAmp.ar(wave * DC.ar(0.095185995101929), wave * DC.ar(0.33310914039612), wave * DC.ar(0.05401086807251), wave * DC.ar(0.32832157611847), wave * DC.ar(0.34436225891113)), gateEnv, Dust2.ar(wave * DC.ar(0.3597252368927), wave * DC.ar(0.8351274728775), wave * DC.ar(0.95836305618286)), varW95Epipm23294713, wave, 0.96883802928225 * modY * modY, Silent.ar());
varW95Epipm23294712 = LPCError.ar(wave * DC.ar(0.45039212703705), wave * DC.ar(0.98662030696869), wave * DC.ar(0.23564779758453), wave * DC.ar(0.61464130878448));
varW95Epipm23294713 = APF.ar(wave * DC.ar(0.26683914661407), wave * DC.ar(0.57119011878967), wave * DC.ar(0.99360477924347), wave * DC.ar(0.37220776081085), wave * DC.ar(0.085129380226135));
// Variation test code
varW95Epipm232947114 = SinGrainBF.ar(modZ * modZ, gate, env, varW95Epipm23294711, modX * signal, varW95Epipm23294711 * varW95Epipm2329479, varW95Epipm232947114, in, Silent.ar());
varW95Epipm232947115 = GrainBuf.ar(2, gateEnv, PlayBuf.ar(2, Array.fill(2.pow(14), { |i| rrand(-1, 1) }).as(LocalBuf), modY, varW95Epipm23294712 * varW95Epipm23294713, varW95Epipm23294710 * modZ.lag(varW95Epipm23294713 * DC.ar(0.90679919719696), varW95Epipm23294711 * DC.ar(0.0017433166503906)), t_trig, in * signal.blend(varW95Epipm2329479 * DC.ar(0.88053023815155), varW95Epipm23294711 * DC.ar(0.52163827419281))), bufnum, 0.85961675643921 * varW95Epipm232947114 * modX, gate, varW95Epipm23294712 * varW95Epipm23294710, signal * modZ, bufnum, in, LFNoise1.ar(varW95Epipm23294710 * DC.ar(0.34144520759583), varW95Epipm23294713 * DC.ar(0.017479300498962), varW95Epipm23294710 * DC.ar(0.24704742431641)), Silent.ar());
varW95Epipm232947114 = MdaPiano.ar(env * modY, varW95Epipm232947115 * varW95Epipm23294712, varW95Epipm23294710, 0.19872343540192 * varW95Epipm23294712 * wave, varW95Epipm23294713, modX, varW95Epipm23294713 * env, modY, signal.fold(varW95Epipm23294710 * DC.ar(0.32973873615265), varW95Epipm23294713 * DC.ar(0.3960599899292)), varW95Epipm232947115 * in, varW95Epipm23294713 * modY, 0.98276817798615 * varW95Epipm232947115 * varW95Epipm2329479, island, island, signal * varW95Epipm23294711, 0.89956259111715 * Henon2DC.ar(varW95Epipm23294711 * DC.ar(0.47662472724915), varW95Epipm2329479 * DC.ar(0.79149723052979), varW95Epipm23294711 * DC.ar(0.87090313434601), varW95Epipm23294710 * DC.ar(0.43504464626312), varW95Epipm23294710 * DC.ar(0.27063381671906), varW95Epipm23294710 * DC.ar(0.68909120559692), varW95Epipm2329479 * DC.ar(0.69692432880402), varW95Epipm23294711 * DC.ar(0.66046285629272)), Silent.ar());
varW95Epipm232947115 = DelTapRd.ar(Array.fill(2.pow(12), { |i| rrand(-1, 1) }).as(LocalBuf), env * env, gateEnv, 0.31510484218597 * in * env, DC.ar(varW95Epipm23294712 * DC.ar(0.86508309841156)), Silent.ar());
varW95Epipm232947114 = Spring.ar(Latoocarfian2DL.ar(varW95Epipm232947115 * modY, varW95Epipm232947114 * wave, modY, varW95Epipm23294712, island, env * wave, varW95Epipm23294713.range(varW95Epipm23294712 * DC.ar(0.86952710151672), varW95Epipm23294712 * DC.ar(0.38698875904083)), 0.87840759754181 * varW95Epipm23294712, 0.9997452854041 * SinTone.ar(varW95Epipm23294713 * DC.ar(0.032798528671265), varW95Epipm23294710 * DC.ar(0.5306624174118), varW95Epipm23294711 * DC.ar(0.59964346885681), varW95Epipm23294711 * DC.ar(0.42516791820526)), Silent.ar()), varW95Epipm2329479, in * modY);
varW95Epipm232947115 = FoaDominateY.ar(bufnum, varW95Epipm23294711 * modY, 0.99332958812386 * env, Silent.ar());

signal = varW95Epipm232947115;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Unashamed.b2329471
/////////////////////////////////////////////////////////

SynthDef.new("Unashamed.b2329471", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varUnashamedb2329479, varUnashamedb23294710, varUnashamedb23294711, varUnashamedb23294712, varUnashamedb232947113, varUnashamedb232947114, varUnashamedb232947115;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varUnashamedb2329479 = varUnashamedb23294710 = varUnashamedb23294711 = varUnashamedb23294712 = varUnashamedb232947113 = varUnashamedb232947114 = varUnashamedb232947115 = K2A.ar(t_trig).dup;
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
varUnashamedb2329479 = APF.ar(island.bipolar(wave * DC.ar(0.43786680698395)), varUnashamedb232947114, 0.36713576316833 * varUnashamedb23294712 * env, varUnashamedb2329479, Silent.ar());
varUnashamedb23294710 = FoaZoomZ.ar(z, gate, 0.99998904089504 * gateEnv * varUnashamedb232947113, Silent.ar());
varUnashamedb23294711 = YigCliffordL.ar(env, gate, varUnashamedb23294711 * modY, gateEnv * modY, env * varUnashamedb232947113, island, t_trig, in, Silent.ar());
varUnashamedb23294712 = PeakEQ4.ar(varUnashamedb23294711 * varUnashamedb23294711, varUnashamedb232947114 * varUnashamedb232947113, varUnashamedb23294711 * modZ, varUnashamedb2329479 * varUnashamedb232947115);
varUnashamedb2329479 = DynKlank.ar(`[[LinCongL.ar(wave * DC.ar(0.62206888198853), wave * DC.ar(0.34067928791046), wave * DC.ar(0.89736080169678), wave * DC.ar(0.62085211277008), wave * DC.ar(0.29070687294006), wave * DC.ar(0.63954055309296), wave * DC.ar(0.59123420715332)), Concat.ar(wave * DC.ar(0.66080331802368), wave * DC.ar(0.17826986312866), wave * DC.ar(0.83087205886841), wave * DC.ar(0.2506343126297), wave * DC.ar(0.68824744224548), wave * DC.ar(0.15519905090332), wave * DC.ar(0.70387899875641), wave * DC.ar(0.030632615089417), wave * DC.ar(0.74423718452454), wave * DC.ar(0.26199460029602), wave * DC.ar(0.87254989147186), wave * DC.ar(0.25787663459778), wave * DC.ar(0.84666121006012), wave * DC.ar(0.76470565795898))], [StkBeeThree.ar(wave * DC.ar(0.9618467092514), wave * DC.ar(0.52771592140198), wave * DC.ar(0.8831981420517), wave * DC.ar(0.26273083686829), wave * DC.ar(0.10204136371613), wave * DC.ar(0.34969556331635), wave * DC.ar(0.62264692783356), wave * DC.ar(0.79822838306427), wave * DC.ar(0.91779375076294)), Astrocade.ar(wave * DC.ar(0.049628615379333), wave * DC.ar(0.94654309749603), wave * DC.ar(0.66693115234375), wave * DC.ar(0.86897790431976), wave * DC.ar(0.5125150680542), wave * DC.ar(0.66645491123199), wave * DC.ar(0.50907552242279), wave * DC.ar(0.84321141242981))], [DriveNoise.ar(wave * DC.ar(0.42560911178589), wave * DC.ar(0.79259300231934), wave * DC.ar(0.057464003562927)), TDuty.ar(wave * DC.ar(0.66518712043762), wave * DC.ar(0.68535697460175), wave * DC.ar(0.67201781272888), wave * DC.ar(0.28532600402832), wave * DC.ar(0.7405446767807))]], in * varUnashamedb232947113, modX, varUnashamedb23294711 * varUnashamedb232947114, modY);
varUnashamedb23294710 = StandardTrig.ar(env * in, varUnashamedb23294712, varUnashamedb232947113 * varUnashamedb23294710, in, island, Fhn2DC.ar(wave * DC.ar(0.38008534908295), wave * DC.ar(0.59793639183044), wave * DC.ar(0.27897024154663), wave * DC.ar(0.35819792747498), wave * DC.ar(0.57170939445496), wave * DC.ar(0.97002387046814), wave * DC.ar(0.45898509025574), wave * DC.ar(0.65424132347107), wave * DC.ar(0.6809995174408), wave * DC.ar(0.16973173618317), wave * DC.ar(0.45582437515259)).excess(PeakEQ2.ar(wave * DC.ar(0.74115061759949), wave * DC.ar(0.95230686664581), wave * DC.ar(0.83109927177429), wave * DC.ar(0.12007164955139))), Silent.ar());
varUnashamedb23294711 = PSinGrain.ar(in * varUnashamedb23294711, varUnashamedb2329479 * in, modZ);
varUnashamedb23294712 = AtsPartial.ar(Array.fill(2.pow(13), { |i| rrand(-1, 1) }).as(LocalBuf), in, StkBowed.ar(wave * DC.ar(0.92929136753082), wave * DC.ar(0.65448582172394), wave * DC.ar(0.94279634952545), wave * DC.ar(0.75986611843109), wave * DC.ar(0.55574429035187), wave * DC.ar(0.64390456676483), wave * DC.ar(0.80377519130707), wave * DC.ar(0.93196153640747), wave * DC.ar(0.57595300674438), wave * DC.ar(0.55810022354126), wave * DC.ar(0.74077773094177)), wave, signal * varUnashamedb23294712, varUnashamedb23294711, Silent.ar());
// Variation test code
varUnashamedb232947113 = LinCongC.ar(gateEnv * varUnashamedb232947114, varUnashamedb2329479 * varUnashamedb23294710, varUnashamedb232947113 * modX, varUnashamedb23294712 * varUnashamedb232947113, modY * env, 0.99570672493347 * modX * varUnashamedb232947113, Silent.ar());
varUnashamedb232947114 = BPF.ar(modX, in * varUnashamedb23294712, 0.077073454856873 * in * varUnashamedb232947114, BRF.ar(varUnashamedb23294711 * DC.ar(0.57666599750519), varUnashamedb23294712 * DC.ar(0.75907468795776), varUnashamedb23294711 * DC.ar(0.78564953804016), varUnashamedb2329479 * DC.ar(0.17930614948273), varUnashamedb2329479 * DC.ar(0.90138101577759)), Silent.ar());
varUnashamedb232947115 = DelayN.ar(island, in * varUnashamedb2329479, z, 0.99972475986194 * gateEnv * varUnashamedb232947114.wrap2(SinOsc.ar(varUnashamedb23294710 * DC.ar(0.34235036373138), varUnashamedb23294711 * DC.ar(0.26931357383728), varUnashamedb23294711 * DC.ar(0.91775584220886), varUnashamedb23294711 * DC.ar(0.24614775180817))), Silent.ar());
varUnashamedb232947113 = InGrainIBF.ar(env * modZ, t_trig, varUnashamedb232947113.lagud(varUnashamedb23294712 * DC.ar(0.79088020324707), varUnashamedb23294712 * DC.ar(0.29335725307465)), bufnum, bufnum, island, modX * wave, varUnashamedb232947113 * modY, x, x, 0.99973905190562 * signal * in, Silent.ar());
varUnashamedb232947114 = Select.ar(BPZ2.ar(in * modY, YigClifford3DL.ar(varUnashamedb2329479 * DC.ar(0.36816334724426), varUnashamedb23294710 * DC.ar(0.88299918174744), varUnashamedb23294711 * DC.ar(0.044590473175049), varUnashamedb23294712 * DC.ar(0.69141852855682), varUnashamedb23294710 * DC.ar(0.7171276807785), varUnashamedb2329479 * DC.ar(0.35780048370361), varUnashamedb23294711 * DC.ar(0.1143571138382), varUnashamedb2329479 * DC.ar(0.44339895248413), varUnashamedb2329479 * DC.ar(0.64581370353699), varUnashamedb23294711 * DC.ar(0.39092421531677)).curvelin(varUnashamedb23294711 * DC.ar(0.13838624954224), varUnashamedb2329479 * DC.ar(0.18122386932373), varUnashamedb23294712 * DC.ar(0.70487105846405), varUnashamedb23294711 * DC.ar(0.73473680019379), varUnashamedb23294710 * DC.ar(0.94355201721191), varUnashamedb23294711 * DC.ar(0.041438937187195)), Silent.ar()), [DC.ar(varUnashamedb23294712 * DC.ar(0.53563296794891)), StkSaxofony.ar(varUnashamedb23294710 * DC.ar(0.43782150745392), varUnashamedb23294711 * DC.ar(0.55430924892426), varUnashamedb23294711 * DC.ar(0.7029801607132), varUnashamedb23294711 * DC.ar(0.3506965637207), varUnashamedb2329479 * DC.ar(0.87711977958679), varUnashamedb2329479 * DC.ar(0.29920470714569), varUnashamedb23294711 * DC.ar(0.2082793712616), varUnashamedb2329479 * DC.ar(0.32896018028259), varUnashamedb23294712 * DC.ar(0.98733043670654), varUnashamedb23294710 * DC.ar(0.78688955307007), varUnashamedb23294712 * DC.ar(0.5541844367981))]);
varUnashamedb232947115 = FoaDirectX.ar(0.36893975734711 * varUnashamedb232947114 * modZ, 0.59332919120789 * YigCliffordL.ar(varUnashamedb23294712 * DC.ar(0.9021852016449), varUnashamedb23294711 * DC.ar(0.24241018295288), varUnashamedb2329479 * DC.ar(0.0090101957321167), varUnashamedb2329479 * DC.ar(0.63398385047913), varUnashamedb23294711 * DC.ar(0.5519540309906), varUnashamedb23294712 * DC.ar(0.047550559043884), varUnashamedb23294711 * DC.ar(0.55074965953827), varUnashamedb23294712 * DC.ar(0.3260053396225), varUnashamedb2329479 * DC.ar(0.20230686664581)), 0.99955764934016 * modZ * varUnashamedb23294710, Silent.ar());
varUnashamedb232947113 = Klank.ar(`[[LFPar.ar(varUnashamedb23294712 * DC.ar(0.95138382911682), varUnashamedb23294711 * DC.ar(0.085171699523926), varUnashamedb23294710 * DC.ar(0.88884127140045), varUnashamedb2329479 * DC.ar(0.3425407409668)), LFTri.ar(varUnashamedb23294712 * DC.ar(0.88804125785828), varUnashamedb23294711 * DC.ar(0.23381340503693), varUnashamedb23294712 * DC.ar(0.54815518856049), varUnashamedb23294712 * DC.ar(0.051202774047852))], [PanB2.ar(varUnashamedb2329479 * DC.ar(0.27374982833862), varUnashamedb23294710 * DC.ar(0.79805970191956), varUnashamedb23294711 * DC.ar(0.30771839618683)), Dust.ar(varUnashamedb2329479 * DC.ar(0.93340051174164), varUnashamedb23294710 * DC.ar(0.072602510452271), varUnashamedb2329479 * DC.ar(0.45800840854645))], [PeakEQ2.ar(varUnashamedb23294710 * DC.ar(0.46191048622131), varUnashamedb23294712 * DC.ar(0.037067651748657), varUnashamedb23294710 * DC.ar(0.074196934700012), varUnashamedb23294711 * DC.ar(0.25640904903412)), Slope.ar(varUnashamedb23294710 * DC.ar(0.6488538980484), varUnashamedb2329479 * DC.ar(0.86171054840088), varUnashamedb23294711 * DC.ar(0.48550534248352))]], modX, varUnashamedb232947114 * gateEnv, varUnashamedb23294710, varUnashamedb232947115 * varUnashamedb23294710);
varUnashamedb232947114 = DiskIn.ar(2, Array.fill(2.pow(14), { |i| rrand(-1, 1) }).as(LocalBuf), in * in);
varUnashamedb232947115 = Peak.ar(modZ, in * modZ);

signal = varUnashamedb232947115;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// PDP.1564232947
/////////////////////////////////////////////////////////

SynthDef.new("PDP.1564232947", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varPDP15642329479, varPDP156423294710, varPDP156423294711;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varPDP15642329479 = varPDP156423294710 = varPDP156423294711 = K2A.ar(t_trig).dup;
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
varPDP15642329479 = RedDPCMdecode.ar(x);
varPDP156423294710 = SinTone.ar(env * in, modX * in, Convolution2L.ar(wave * DC.ar(0.99291360378265), wave * DC.ar(0.55140733718872), wave * DC.ar(0.87790465354919), wave * DC.ar(0.35337436199188), wave * DC.ar(0.91078901290894), wave * DC.ar(0.016762495040894), wave * DC.ar(0.93812322616577)), Silent.ar());
varPDP156423294711 = TExpRand.ar(varPDP156423294710 * wave, varPDP15642329479 * modX, modZ);
varPDP15642329479 = FOS.ar(wave * DC.ar(0.64321625232697), wave * DC.ar(0.34768056869507), wave * DC.ar(0.4062727689743), wave * DC.ar(0.38950002193451), wave * DC.ar(0.61666214466095), wave * DC.ar(0.36755561828613));
varPDP156423294710 = DoubleWell3.ar(wave * DC.ar(0.75678551197052), wave * DC.ar(0.81781888008118), wave * DC.ar(0.92234349250793), wave * DC.ar(0.22041630744934), wave * DC.ar(0.38554859161377), wave * DC.ar(0.87094736099243), wave * DC.ar(0.95350253582001), wave * DC.ar(0.80986285209656));
varPDP156423294711 = FMGrainIBF.ar(RedLbyl.ar(wave * DC.ar(0.41918587684631), wave * DC.ar(0.54773283004761), wave * DC.ar(0.82635223865509)), gate, modY * modY, signal * env, varPDP156423294710, bufnum, bufnum, wave, varPDP156423294711 * varPDP15642329479, gateEnv, gateEnv * varPDP15642329479, varPDP15642329479, 0.99997488863513 * modY * env, Silent.ar());

signal = varPDP156423294711;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// W97M.Futonik.A232949
/////////////////////////////////////////////////////////

SynthDef.new("W97M.Futonik.A232949", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varW97MFutonikA2329499, varW97MFutonikA23294910, varW97MFutonikA23294911, varW97MFutonikA23294912, varW97MFutonikA23294913, varW97MFutonikA23294914;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varW97MFutonikA2329499 = varW97MFutonikA23294910 = varW97MFutonikA23294911 = varW97MFutonikA23294912 = varW97MFutonikA23294913 = varW97MFutonikA23294914 = K2A.ar(t_trig).dup;
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
varW97MFutonikA2329499 = RecordBuf.ar([SinGrainBF.ar(wave * DC.ar(0.97490227222443), wave * DC.ar(0.4930567741394), wave * DC.ar(0.76631832122803), wave * DC.ar(0.37620329856873), wave * DC.ar(0.87509608268738), wave * DC.ar(0.97383952140808), wave * DC.ar(0.012677669525146), wave * DC.ar(0.87960660457611), wave * DC.ar(0.032570838928223)), FoaDominateY.ar(wave * DC.ar(0.033671975135803), wave * DC.ar(0.56665408611298), wave * DC.ar(0.79962456226349), wave * DC.ar(0.28955233097076))], Array.fill(2.pow(13), { |i| rrand(-1, 1) }).as(LocalBuf), y, in, modZ * modX, varW97MFutonikA23294911 * varW97MFutonikA23294911, varW97MFutonikA2329499, SinGrain.ar(wave * DC.ar(0.70867002010345), wave * DC.ar(0.13641476631165), wave * DC.ar(0.78701794147491), wave * DC.ar(0.208948969841), wave * DC.ar(0.078160166740417)), t_trig);
varW97MFutonikA23294910 = Pluck.ar(varW97MFutonikA23294911 * varW97MFutonikA23294914, in * varW97MFutonikA23294913, in * varW97MFutonikA2329499, 0.65866935253143 * varW97MFutonikA23294914 * varW97MFutonikA23294910, z, varW97MFutonikA2329499 * signal, 0.97860101077247 * Ringz.ar(wave * DC.ar(0.64267778396606), wave * DC.ar(0.007026195526123), wave * DC.ar(0.38500106334686), wave * DC.ar(0.88943994045258), wave * DC.ar(0.15492594242096)), Silent.ar());
varW97MFutonikA23294911 = TBall.ar(varW97MFutonikA2329499 * varW97MFutonikA23294912, varW97MFutonikA23294911, varW97MFutonikA23294910, in * env);
varW97MFutonikA23294912 = SortBuf.ar(Array.fill(2.pow(10), { |i| rrand(-1, 1) }).as(LocalBuf), varW97MFutonikA23294910, StkBeeThree.ar(wave * DC.ar(0.13460505008698), wave * DC.ar(0.53042697906494), wave * DC.ar(0.042278528213501), wave * DC.ar(0.77435660362244), wave * DC.ar(0.65528428554535), wave * DC.ar(0.32654047012329), wave * DC.ar(0.86316800117493), wave * DC.ar(0.099526882171631), wave * DC.ar(0.56447398662567)));
varW97MFutonikA23294913 = PVSynth.ar(Array.fill(2.pow(11), { |i| rrand(-1, 1) }).as(LocalBuf), varW97MFutonikA23294914 * modY, env * wave, in * gateEnv, in, varW97MFutonikA23294914, FoaPushZ.ar(wave * DC.ar(0.12178266048431), wave * DC.ar(0.96403896808624), wave * DC.ar(0.86522471904755), wave * DC.ar(0.30602633953094)).exprange(1, SampleRate.ir), signal, Silent.ar());
varW97MFutonikA23294914 = XOut.ar((80 + (island * 2)), varW97MFutonikA23294913, [Lag2.ar(wave * DC.ar(0.62713241577148), wave * DC.ar(0.99483668804169), wave * DC.ar(0.15470004081726), wave * DC.ar(0.53688490390778)), InGrainBF.ar(wave * DC.ar(0.50849592685699), wave * DC.ar(0.30020499229431), wave * DC.ar(0.45938014984131), wave * DC.ar(0.6157054901123), wave * DC.ar(0.54745423793793), wave * DC.ar(0.14531934261322), wave * DC.ar(0.92888915538788), wave * DC.ar(0.20418989658356), wave * DC.ar(0.35448586940765))]);
varW97MFutonikA2329499 = LFNoise0.ar(in, 0.99985371162707 * varW97MFutonikA23294914 * modZ, Silent.ar());
varW97MFutonikA23294910 = SinOsc.ar(wave * DC.ar(0.70032143592834), wave * DC.ar(0.81657552719116), wave * DC.ar(0.81859648227692), wave * DC.ar(0.63714778423309));
varW97MFutonikA23294911 = Tilt.ar(varW97MFutonikA23294910, 0.18554663658142 * in * modX, gateEnv * in, modX, StkBlowHole.ar(InsideOut.ar(wave * DC.ar(0.6761999130249), wave * DC.ar(0.89732730388641), wave * DC.ar(0.3798360824585)).exprange(1, SampleRate.ir), varW97MFutonikA23294912 * gateEnv, amp, modZ, env * modX, 0.14404261112213 * modZ * varW97MFutonikA23294914, 0.99997595570119 * varW97MFutonikA23294914 * varW97MFutonikA23294913, Silent.ar()));
varW97MFutonikA23294912 = YigClifford3DL.ar(wave * DC.ar(0.20014369487762), wave * DC.ar(0.51601791381836), wave * DC.ar(0.5380243062973), wave * DC.ar(0.38525950908661), wave * DC.ar(0.14518213272095), wave * DC.ar(0.59023761749268), wave * DC.ar(0.13517391681671), wave * DC.ar(0.47457098960876), wave * DC.ar(0.15222418308258), wave * DC.ar(0.57538461685181));
varW97MFutonikA23294913 = Perlin3.ar(modY * varW97MFutonikA23294911, signal * varW97MFutonikA23294910, env * wave);
varW97MFutonikA23294914 = Slew.ar(varW97MFutonikA23294913 * varW97MFutonikA2329499, varW97MFutonikA23294912 * wave, amp, FoaPressX.ar(wave * DC.ar(0.67292332649231), wave * DC.ar(0.78885209560394), wave * DC.ar(0.50541150569916), wave * DC.ar(0.34848189353943)), Silent.ar());

signal = varW97MFutonikA23294914;
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
varBinAutoBRQ23294910 = Latoocarfian2DL.ar(FMGrainBF.ar(wave * DC.ar(0.54249978065491), wave * DC.ar(0.68839383125305), wave * DC.ar(0.51304841041565), wave * DC.ar(0.59182190895081), wave * DC.ar(0.93306839466095), wave * DC.ar(0.78067719936371), wave * DC.ar(0.0040508508682251), wave * DC.ar(0.77929067611694), wave * DC.ar(0.069395661354065), wave * DC.ar(0.35326969623566), wave * DC.ar(0.60659158229828)).exprange(1, SampleRate.ir), signal * signal, modZ, varBinAutoBRQ23294910, modY, gateEnv * modX, modZ * modY, signal * modY, 0.93889962049224 * varBinAutoBRQ23294911 * modX, SanityCheck.ar(wave * DC.ar(0.77679884433746)));
varBinAutoBRQ23294911 = Maxamp.ar(varBinAutoBRQ23294911, varBinAutoBRQ23294910 * modY);
varBinAutoBRQ2329499 = HenonN.ar(Line.ar(wave * DC.ar(0.47685539722443), wave * DC.ar(0.058790564537048), wave * DC.ar(0.85671842098236), wave * DC.ar(0.4223804473877), wave * DC.ar(0.22239184379578), wave * DC.ar(0.32613170146942)).exprange(1, SampleRate.ir), modX * in, modX, amp, wave * signal, 0.8714394689937 * modZ * env, Silent.ar());
varBinAutoBRQ23294910 = SOS.ar(wave * DC.ar(0.32780337333679), wave * DC.ar(0.67689740657806), wave * DC.ar(0.61939382553101), wave * DC.ar(0.23377513885498), wave * DC.ar(0.97255158424377), wave * DC.ar(0.39438605308533), wave * DC.ar(0.083172559738159), wave * DC.ar(0.36830198764801));
varBinAutoBRQ23294911 = SinGrain.ar(gateEnv * env, 0.76202583312988 * modZ * wave, LatoocarfianTrig.ar(wave * DC.ar(0.70537555217743), wave * DC.ar(0.063812017440796), wave * DC.ar(0.6259514093399), wave * DC.ar(0.25372636318207), wave * DC.ar(0.85723674297333), wave * DC.ar(0.62165057659149), wave * DC.ar(0.46120047569275), wave * DC.ar(0.54658997058868), wave * DC.ar(0.021997094154358), wave * DC.ar(0.30188977718353)).exprange(1, SampleRate.ir), 0.94407044515321 * varBinAutoBRQ2329499 * signal, Silent.ar());

signal = varBinAutoBRQ23294911;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Bin.Auto.BRQ2329491
/////////////////////////////////////////////////////////

SynthDef.new("Bin.Auto.BRQ2329491", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varBinAutoBRQ2329499, varBinAutoBRQ23294910, varBinAutoBRQ23294911, varBinAutoBRQ232949112;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varBinAutoBRQ2329499 = varBinAutoBRQ23294910 = varBinAutoBRQ23294911 = varBinAutoBRQ232949112 = K2A.ar(t_trig).dup;
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
varBinAutoBRQ2329499 = WaveTerrain.ar(Array.fill(2.pow(15), { |i| rrand(-1, 1) }).as(LocalBuf), y, y, bufnum, amp, 0.99612164357011 * env * in, Silent.ar());
varBinAutoBRQ23294910 = PeakEQ4.ar(varBinAutoBRQ23294911, modZ * modZ, varBinAutoBRQ23294911, varBinAutoBRQ232949112 * varBinAutoBRQ232949112);
varBinAutoBRQ23294911 = LPCAnalyzer.ar(modY * modY, 0.49695801734924 * modZ * wave, varBinAutoBRQ232949112 * env, y, wave * modZ, FMHEncode2.ar(wave * DC.ar(0.59037482738495), wave * DC.ar(0.86592519283295), wave * DC.ar(0.010336637496948), wave * DC.ar(0.50396072864532), wave * DC.ar(0.74516820907593), wave * DC.ar(0.086968898773193)).lagud(wave * DC.ar(0.54666221141815), wave * DC.ar(0.97286474704742)), env, 0.99890440963656 * signal * varBinAutoBRQ23294910, Silent.ar());
varBinAutoBRQ2329499 = Gbman2DN.ar(in * wave, in, Astrocade.ar(gate, y, modZ * signal, in * varBinAutoBRQ232949112, varBinAutoBRQ23294910 * env, bufnum, env.explin(wave * DC.ar(0.09596061706543), wave * DC.ar(0.3211977481842), wave * DC.ar(0.61353182792664), wave * DC.ar(0.57102465629578), wave * DC.ar(0.31643283367157)), gateEnv * modX), HilbertFIR.ar(varBinAutoBRQ23294910, Array.fill(2.pow(11), { |i| rrand(-1, 1) }).as(LocalBuf)), 0.99035341257602 * in, Silent.ar());
varBinAutoBRQ23294910 = FMGrainBF.ar(varBinAutoBRQ23294910 * env, in, varBinAutoBRQ23294911 * gateEnv, gateEnv * modZ, varBinAutoBRQ2329499, modY * modY, varBinAutoBRQ2329499 * varBinAutoBRQ2329499, varBinAutoBRQ232949112 * in, in, 0.9999301776856 * modY * varBinAutoBRQ23294910, Silent.ar());
varBinAutoBRQ23294911 = TBetaRand.ar(x, island, varBinAutoBRQ2329499 * in, 0.47178995609283 * varBinAutoBRQ232949112 * varBinAutoBRQ2329499, in * varBinAutoBRQ232949112, AllpassL.ar(wave * DC.ar(0.4478611946106), wave * DC.ar(0.9025022983551), wave * DC.ar(0.44109010696411), wave * DC.ar(0.20290887355804), wave * DC.ar(0.049888253211975), wave * DC.ar(0.079002261161804)), Silent.ar());
// Variation test code
varBinAutoBRQ232949112 = TGrains.ar(2, signal * modY, Array.fill(2.pow(13), { |i| rrand(-1, 1) }).as(LocalBuf), in, 0.061231732368469 * SID6581f.ar(varBinAutoBRQ23294911 * DC.ar(0.21145021915436), varBinAutoBRQ2329499 * DC.ar(0.65937626361847), varBinAutoBRQ2329499 * DC.ar(0.52975177764893), varBinAutoBRQ2329499 * DC.ar(0.061194062232971), varBinAutoBRQ23294910 * DC.ar(0.082975387573242), varBinAutoBRQ2329499 * DC.ar(0.34876704216003), varBinAutoBRQ2329499 * DC.ar(0.18756914138794), varBinAutoBRQ23294910 * DC.ar(0.3568389415741), varBinAutoBRQ23294910 * DC.ar(0.72900807857513), varBinAutoBRQ23294910 * DC.ar(0.11495161056519), varBinAutoBRQ23294911 * DC.ar(0.24253582954407), varBinAutoBRQ23294911 * DC.ar(0.90581870079041), varBinAutoBRQ2329499 * DC.ar(0.51043224334717), varBinAutoBRQ23294911 * DC.ar(0.64774537086487), varBinAutoBRQ23294911 * DC.ar(0.12811982631683), varBinAutoBRQ2329499 * DC.ar(0.75352561473846), varBinAutoBRQ23294911 * DC.ar(0.1716148853302), varBinAutoBRQ23294910 * DC.ar(0.30501055717468), varBinAutoBRQ23294910 * DC.ar(0.92321705818176), varBinAutoBRQ23294910 * DC.ar(0.42822468280792), varBinAutoBRQ23294911 * DC.ar(0.50189530849457), varBinAutoBRQ2329499 * DC.ar(0.67071390151978), varBinAutoBRQ23294910 * DC.ar(0.55538618564606), varBinAutoBRQ2329499 * DC.ar(0.97870016098022), varBinAutoBRQ23294911 * DC.ar(0.08116626739502), varBinAutoBRQ23294910 * DC.ar(0.53448927402496)), varBinAutoBRQ232949112, varBinAutoBRQ23294911 * modZ, island, in * varBinAutoBRQ232949112);
varBinAutoBRQ232949112 = Tap.ar(Array.fill(2.pow(11), { |i| rrand(-1, 1) }).as(LocalBuf), 2, signal);
varBinAutoBRQ232949112 = BinData.ar(Array.fill(2.pow(14), { |i| rrand(-1, 1) }).as(LocalBuf), in, modY * in);

signal = varBinAutoBRQ232949112;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Bloodhound.Exploit.472232950
/////////////////////////////////////////////////////////

SynthDef.new("Bloodhound.Exploit.472232950", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varBloodhoundExploit4722329509, varBloodhoundExploit47223295010, varBloodhoundExploit47223295011, varBloodhoundExploit47223295012;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varBloodhoundExploit4722329509 = varBloodhoundExploit47223295010 = varBloodhoundExploit47223295011 = varBloodhoundExploit47223295012 = K2A.ar(t_trig).dup;
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
varBloodhoundExploit4722329509 = XFadeRotate.ar(0.14674949645996 * in * env, t_trig);
varBloodhoundExploit47223295010 = Decay.ar(varBloodhoundExploit47223295011 * modX, z, 0.77200216486518 * gateEnv * wave, Silent.ar());
varBloodhoundExploit47223295011 = OneZero.ar(wave * signal, modY * wave, modX, IEnvGen.ar(wave * DC.ar(0.69094800949097), wave * DC.ar(0.41316699981689), wave * DC.ar(0.73749482631683), wave * DC.ar(0.27488541603088)));
varBloodhoundExploit47223295012 = LFBrownNoise0.ar(modX * modX, signal * env, modY * env, 0.8745601889375 * Blip.ar(wave * DC.ar(0.26817560195923), wave * DC.ar(0.29779326915741), wave * DC.ar(0.8583836555481), wave * DC.ar(0.5415997505188)), Silent.ar());
varBloodhoundExploit4722329509 = Gate.ar(z, MedianTriggered.ar(wave * DC.ar(0.41892504692078), wave * DC.ar(0.76414394378662), wave * DC.ar(0.11939454078674), wave * DC.ar(0.034094452857971), wave * DC.ar(0.85439431667328)));
varBloodhoundExploit47223295010 = FoaDominateZ.ar(y, gateEnv * modY, wave, Silent.ar());
varBloodhoundExploit47223295011 = Clipper4.ar(in, modZ * wave, varBloodhoundExploit47223295012);
varBloodhoundExploit47223295012 = FSinOsc.ar(wave * DC.ar(0.096548318862915), wave * DC.ar(0.14573037624359), wave * DC.ar(0.17920708656311), wave * DC.ar(0.89334464073181));

signal = varBloodhoundExploit47223295012;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Backdoor.Trojan.dr(14)232951
/////////////////////////////////////////////////////////

SynthDef.new("Backdoor.Trojan.dr(14)232951", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varBackdoorTrojandr142329519, varBackdoorTrojandr1423295110;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varBackdoorTrojandr142329519 = varBackdoorTrojandr1423295110 = K2A.ar(t_trig).dup;
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
varBackdoorTrojandr142329519 = BrownNoise.ar(modY, Silent.ar());
varBackdoorTrojandr1423295110 = Delay2.ar(signal * signal, 0.99196697305355 * modY * modX.lincurve(wave * DC.ar(0.109503865242), wave * DC.ar(0.45061457157135), wave * DC.ar(0.86020398139954), wave * DC.ar(0.57277476787567), wave * DC.ar(0.016454458236694), wave * DC.ar(0.48948264122009)), Silent.ar());
varBackdoorTrojandr142329519 = Fhn2DL.ar(SinGrainB.ar(wave * DC.ar(0.77259731292725), wave * DC.ar(0.58159375190735), wave * DC.ar(0.28272020816803), wave * DC.ar(0.32118988037109), wave * DC.ar(0.72123098373413), wave * DC.ar(0.808274269104)).exprange(1, SampleRate.ir), varBackdoorTrojandr142329519 * env, varBackdoorTrojandr1423295110 * env, gateEnv, modX * modX, modY * in, varBackdoorTrojandr1423295110.curvelin(wave * DC.ar(0.50765597820282), wave * DC.ar(0.50056302547455), wave * DC.ar(0.91830265522003), wave * DC.ar(0.74160921573639), wave * DC.ar(0.33297419548035), wave * DC.ar(0.47977602481842)), varBackdoorTrojandr142329519 * in, varBackdoorTrojandr1423295110.slew(wave * DC.ar(0.42399179935455), wave * DC.ar(0.21532332897186)), 0.99979522880723 * varBackdoorTrojandr1423295110 * gateEnv, Silent.ar());
varBackdoorTrojandr1423295110 = BPeakEQ.ar(wave * DC.ar(0.4280070066452), wave * DC.ar(0.066532731056213), wave * DC.ar(0.24219191074371), wave * DC.ar(0.30056190490723), wave * DC.ar(0.010099053382874), wave * DC.ar(0.14329314231873));

signal = varBackdoorTrojandr1423295110;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// HLLT.8297232952
/////////////////////////////////////////////////////////

SynthDef.new("HLLT.8297232952", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varHLLT82972329529, varHLLT829723295210, varHLLT829723295211, varHLLT829723295212, varHLLT829723295213, varHLLT829723295214;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varHLLT82972329529 = varHLLT829723295210 = varHLLT829723295211 = varHLLT829723295212 = varHLLT829723295213 = varHLLT829723295214 = K2A.ar(t_trig).dup;
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
varHLLT82972329529 = RedDPCMdecode.ar(in * varHLLT829723295210);
varHLLT829723295210 = FMGrainI.ar(wave * wave, gateEnv, modY, modY * varHLLT829723295213, signal, bufnum, bufnum.thresh(LFClipNoise.ar(wave * DC.ar(0.7105348110199), wave * DC.ar(0.10356223583221), wave * DC.ar(0.34761476516724))), t_trig, FoaPanB.ar(wave * DC.ar(0.26075100898743), wave * DC.ar(0.30538260936737), wave * DC.ar(0.46691513061523), wave * DC.ar(0.10340988636017), wave * DC.ar(0.14186215400696)), Silent.ar().lag(wave * DC.ar(0.98276972770691), wave * DC.ar(0.5655882358551)));
varHLLT829723295211 = FBSineL.ar(gateEnv, varHLLT829723295213, varHLLT829723295211, varHLLT829723295212, wave * wave, bufnum, island, 0.99997314214626 * modY * varHLLT829723295210, Silent.ar());
varHLLT829723295212 = TermanWang.ar(amp, amp, modZ * env, wave * signal, env * signal, YigClifford3DN.ar(wave * DC.ar(0.76128327846527), wave * DC.ar(0.94111573696136), wave * DC.ar(0.39240205287933), wave * DC.ar(0.58460867404938), wave * DC.ar(0.58498954772949), wave * DC.ar(0.29918956756592), wave * DC.ar(0.10026609897614), wave * DC.ar(0.28782510757446), wave * DC.ar(0.32332170009613), wave * DC.ar(0.89956092834473)), gateEnv * modZ, modY * in, 0.3019791841507 * gateEnv * modZ, 0.96422750489753 * in * varHLLT829723295212, Silent.ar());
varHLLT829723295213 = SOS.ar(0.95536696910858 * varHLLT829723295210 * varHLLT829723295210, 0.028595805168152 * varHLLT82972329529 * varHLLT82972329529, wave * signal, NestedAllpassN.ar(wave * DC.ar(0.80560314655304), wave * DC.ar(0.53306066989899), wave * DC.ar(0.20350205898285), wave * DC.ar(0.46024453639984), wave * DC.ar(0.92587006092072), wave * DC.ar(0.16673839092255), wave * DC.ar(0.79145228862762), wave * DC.ar(0.11545789241791), wave * DC.ar(0.67936325073242)).clip(wave * DC.ar(0.27530229091644), wave * DC.ar(0.41505444049835)), varHLLT829723295214 * in, signal * varHLLT829723295214.leftShift(VarSaw.ar(wave * DC.ar(0.65481674671173), wave * DC.ar(0.37786471843719), wave * DC.ar(0.99129807949066), wave * DC.ar(0.5165867805481), wave * DC.ar(0.36636292934418))), 0.9957916217204 * gateEnv * modZ, Silent.ar());
varHLLT829723295214 = DelayL.ar(Latoocarfian2DC.ar(wave * DC.ar(0.6473137140274), wave * DC.ar(0.44739830493927), wave * DC.ar(0.85003542900085), wave * DC.ar(0.58152890205383), wave * DC.ar(0.76827645301819), wave * DC.ar(0.70470285415649), wave * DC.ar(0.82970857620239), wave * DC.ar(0.52870905399323), wave * DC.ar(0.60592520236969), wave * DC.ar(0.74875044822693)), varHLLT829723295212 * varHLLT829723295210, varHLLT829723295211, 0.99365071572754 * in * varHLLT829723295214, Silent.ar());
varHLLT82972329529 = Pokey.ar(wave * DC.ar(0.51308083534241), wave * DC.ar(0.20543694496155), wave * DC.ar(0.56119501590729), wave * DC.ar(0.51668643951416), wave * DC.ar(0.48550081253052), wave * DC.ar(0.70570254325867), wave * DC.ar(0.96830940246582), wave * DC.ar(0.16101062297821), wave * DC.ar(0.51236593723297));
varHLLT829723295210 = LFDNoise3.ar(wave * DC.ar(0.040591597557068), wave * DC.ar(0.16914010047913), wave * DC.ar(0.93137454986572));
varHLLT829723295211 = Astrocade.ar(varHLLT829723295211 * signal, 0.637659907341 * InGrainBF.ar(wave * DC.ar(0.35920989513397), wave * DC.ar(0.85009157657623), wave * DC.ar(0.77792549133301), wave * DC.ar(0.089946508407593), wave * DC.ar(0.87621986865997), wave * DC.ar(0.98325252532959), wave * DC.ar(0.62865650653839), wave * DC.ar(0.079049110412598), wave * DC.ar(0.49550807476044)), varHLLT829723295210 * env, modX * wave, signal, modZ * modZ, varHLLT82972329529 * signal.explin(wave * DC.ar(0.11213207244873), wave * DC.ar(0.085024476051331), wave * DC.ar(0.36653316020966), wave * DC.ar(0.40161919593811), wave * DC.ar(0.071122169494629)), modX * gateEnv);
varHLLT829723295212 = Disintegrator.ar(wave * DC.ar(0.4212908744812), wave * DC.ar(0.27966248989105), wave * DC.ar(0.88040804862976), wave * DC.ar(0.012130260467529), wave * DC.ar(0.51314449310303));
varHLLT829723295213 = BinData.ar(wave * DC.ar(0.80318260192871), wave * DC.ar(0.48049581050873), wave * DC.ar(0.88011121749878));
varHLLT829723295214 = TwoZero.ar(gateEnv, varHLLT829723295213, y, modZ, Silent.ar());

signal = varHLLT829723295214;
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
	varBackdoorBlackD2329529 = StkShakers.ar((wave * DC.ar(0.1245813369751)).abs, (wave * DC.ar(0.99678194522858)).abs, (wave * DC.ar(0.4988226890564)).abs, (wave * DC.ar(0.10387480258942)).abs, (wave * DC.ar(0.95112609863281)).abs, (wave * DC.ar(0.33699798583984)).abs, (wave * DC.ar(0.51101422309875)).abs);

signal = varBackdoorBlackD2329529;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// SymbOS.Skulls.019232952
/////////////////////////////////////////////////////////

SynthDef.new("SymbOS.Skulls.019232952", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varSymbOSSkulls0192329529, varSymbOSSkulls01923295210;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varSymbOSSkulls0192329529 = varSymbOSSkulls01923295210 = K2A.ar(t_trig).dup;
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
varSymbOSSkulls0192329529 = PeakEQ2.ar(wave * wave, wave * varSymbOSSkulls01923295210.lag(wave * DC.ar(0.606121301651), wave * DC.ar(0.71681666374207)), gate.wrap(wave * DC.ar(0.38060963153839), wave * DC.ar(0.13041436672211)), modY);
varSymbOSSkulls01923295210 = LPCVals.ar(Array.fill(2.pow(13), { |i| rrand(-1, 1) }).as(LocalBuf), 0.085228085517883 * wave);
varSymbOSSkulls0192329529 = BBandStop.ar(wave * DC.ar(0.22906970977783), wave * DC.ar(0.98453414440155), wave * DC.ar(0.44700038433075), wave * DC.ar(0.96137809753418), wave * DC.ar(0.12560069561005));
varSymbOSSkulls01923295210 = FreeVerb.ar(0.30409443378448 * modY, in * modZ, in, modX * gateEnv, modX, Silent.ar());

signal = varSymbOSSkulls01923295210;
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
varDeadly163823295311 = DoubleNestedAllpassN.ar(in * wave, modY, in * gateEnv, z, gateEnv, gateEnv, env * modY, varDeadly163823295311, wave * in, wave * gateEnv, wave.excess(SoftClipAmp4.ar(wave * DC.ar(0.73694026470184), wave * DC.ar(0.15589916706085), wave * DC.ar(0.87450397014618), wave * DC.ar(0.84585630893707))), DelayC.ar(wave * DC.ar(0.79266905784607), wave * DC.ar(0.38169884681702), wave * DC.ar(0.88195765018463), wave * DC.ar(0.57875692844391), wave * DC.ar(0.12637662887573)));
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
// HLLC.Energy.Family232955
/////////////////////////////////////////////////////////

SynthDef.new("HLLC.Energy.Family232955", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varHLLCEnergyFamily2329559, varHLLCEnergyFamily23295510, varHLLCEnergyFamily23295511;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varHLLCEnergyFamily2329559 = varHLLCEnergyFamily23295510 = varHLLCEnergyFamily23295511 = K2A.ar(t_trig).dup;
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
varHLLCEnergyFamily2329559 = MoogVCF.ar(PVInfo.ar(Array.fill(2.pow(11), { |i| rrand(-1, 1) }).as(LocalBuf), 0.27890980243683 * wave * varHLLCEnergyFamily23295511, env * varHLLCEnergyFamily23295511, env, Silent.ar()), t_trig, x, 0.99813711552673 * modX * modX, Silent.ar());
varHLLCEnergyFamily23295510 = LinXFade2.ar(MembraneHexagon.ar(wave * DC.ar(0.40865278244019), wave * DC.ar(0.43312788009644), wave * DC.ar(0.02132523059845), wave * DC.ar(0.65371346473694), wave * DC.ar(0.11963331699371)), z, varHLLCEnergyFamily23295510 * modY, 0.80881881713867 * gateEnv * varHLLCEnergyFamily2329559);
varHLLCEnergyFamily23295511 = Latoocarfian2DC.ar(env * modX, FoaDominateX.ar(wave * DC.ar(0.5719176530838), wave * DC.ar(0.65654361248016), wave * DC.ar(0.93025803565979), wave * DC.ar(0.060704588890076)).exprange(1, SampleRate.ir), varHLLCEnergyFamily23295510 * gateEnv, 0.54828274250031 * AnalyseEvents2.ar(wave * DC.ar(0.63338041305542), wave * DC.ar(0.22749137878418), wave * DC.ar(0.18197238445282), wave * DC.ar(0.58801770210266), wave * DC.ar(0.40239942073822), wave * DC.ar(0.52308809757233)), in * varHLLCEnergyFamily23295511, varHLLCEnergyFamily2329559 * varHLLCEnergyFamily2329559, modX * modZ, x, modY, Silent.ar());
varHLLCEnergyFamily2329559 = FMGrain.ar(wave * DC.ar(0.76241660118103), wave * DC.ar(0.78248047828674), wave * DC.ar(0.16173279285431), wave * DC.ar(0.8445907831192), wave * DC.ar(0.56016671657562), wave * DC.ar(0.7885502576828), wave * DC.ar(0.97202181816101));
varHLLCEnergyFamily23295510 = NestedAllpassN.ar(wave * signal, env, varHLLCEnergyFamily23295510 * varHLLCEnergyFamily2329559, gateEnv, t_trig, signal * modY, modY, 0.91156425817293 * wave * modX, Latoocarfian2DL.ar(wave * DC.ar(0.0060956478118896), wave * DC.ar(0.033329367637634), wave * DC.ar(0.45478641986847), wave * DC.ar(0.60202312469482), wave * DC.ar(0.22725903987885), wave * DC.ar(0.63373196125031), wave * DC.ar(0.47860729694366), wave * DC.ar(0.82775056362152), wave * DC.ar(0.93587231636047), wave * DC.ar(0.47340631484985)));
varHLLCEnergyFamily23295511 = Hasher.ar(signal * modZ, modY, Silent.ar());

signal = varHLLCEnergyFamily23295511;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// HLLC.Energy.Family2329551
/////////////////////////////////////////////////////////

SynthDef.new("HLLC.Energy.Family2329551", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varHLLCEnergyFamily2329559, varHLLCEnergyFamily23295510, varHLLCEnergyFamily23295511, varHLLCEnergyFamily232955112, varHLLCEnergyFamily232955113, varHLLCEnergyFamily232955114;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varHLLCEnergyFamily2329559 = varHLLCEnergyFamily23295510 = varHLLCEnergyFamily23295511 = varHLLCEnergyFamily232955112 = varHLLCEnergyFamily232955113 = varHLLCEnergyFamily232955114 = K2A.ar(t_trig).dup;
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
varHLLCEnergyFamily2329559 = DelTapWr.ar(Array.fill(2.pow(10), { |i| rrand(-1, 1) }).as(LocalBuf), varHLLCEnergyFamily2329559 * varHLLCEnergyFamily232955114);
varHLLCEnergyFamily23295510 = RandSeed.ar(wave, modX);
varHLLCEnergyFamily23295511 = InGrain.ar(modY * modY, 0.48800373077393 * varHLLCEnergyFamily232955114 * wave, 0.13740253448486 * Hasher.ar(wave * DC.ar(0.39320039749146), wave * DC.ar(0.22200059890747), wave * DC.ar(0.16019201278687)), 0.98781018054014 * modX * wave.clip(wave * DC.ar(0.79060518741608), wave * DC.ar(0.97417819499969)), Silent.ar());
varHLLCEnergyFamily2329559 = BufCombC.ar(wave * DC.ar(0.25554060935974), wave * DC.ar(0.086189985275269), wave * DC.ar(0.29767382144928), wave * DC.ar(0.79622435569763), wave * DC.ar(0.64169418811798), wave * DC.ar(0.75989389419556));
varHLLCEnergyFamily23295510 = Changed.ar(wave * DC.ar(0.33168876171112), wave * DC.ar(0.90354478359222));
varHLLCEnergyFamily23295511 = StkBandedWG.ar(wave * DC.ar(0.87278842926025), wave * DC.ar(0.57605063915253), wave * DC.ar(0.36482346057892), wave * DC.ar(0.63745653629303), wave * DC.ar(0.20025682449341), wave * DC.ar(0.71137142181396), wave * DC.ar(0.7328132390976), wave * DC.ar(0.81901133060455), wave * DC.ar(0.73965430259705), wave * DC.ar(0.44479739665985), wave * DC.ar(0.065979599952698));
// Variation test code
varHLLCEnergyFamily232955112 = Impulse.ar(env * modY, varHLLCEnergyFamily232955113, 0.90203014440438 * DFM1.ar(varHLLCEnergyFamily2329559 * DC.ar(0.058253765106201), varHLLCEnergyFamily23295511 * DC.ar(0.46495711803436), varHLLCEnergyFamily2329559 * DC.ar(0.43804907798767), varHLLCEnergyFamily23295510 * DC.ar(0.22329545021057), varHLLCEnergyFamily23295511 * DC.ar(0.12762880325317), varHLLCEnergyFamily2329559 * DC.ar(0.85649251937866), varHLLCEnergyFamily2329559 * DC.ar(0.67089128494263), varHLLCEnergyFamily23295510 * DC.ar(0.026746273040771)), Silent.ar());
varHLLCEnergyFamily232955113 = BufGrainB.ar(varHLLCEnergyFamily232955112 * varHLLCEnergyFamily232955112, varHLLCEnergyFamily232955113 * varHLLCEnergyFamily23295511, bufnum, modX * varHLLCEnergyFamily232955112, modY * varHLLCEnergyFamily23295511, bufnum, varHLLCEnergyFamily232955114 * modX, 0.99997545653445 * varHLLCEnergyFamily232955113 * signal, BufCombL.ar(varHLLCEnergyFamily23295510 * DC.ar(0.84407770633698), varHLLCEnergyFamily23295511 * DC.ar(0.73215293884277), varHLLCEnergyFamily23295511 * DC.ar(0.25327980518341), varHLLCEnergyFamily23295511 * DC.ar(0.13051080703735), varHLLCEnergyFamily23295510 * DC.ar(0.34175848960876), varHLLCEnergyFamily23295511 * DC.ar(0.60483705997467)));
varHLLCEnergyFamily232955114 = DelTapRd.ar(Array.fill(2.pow(12), { |i| rrand(-1, 1) }).as(LocalBuf), wave * varHLLCEnergyFamily232955114, modZ * varHLLCEnergyFamily23295510, varHLLCEnergyFamily232955114, 0.97102689371236 * signal * modX, Silent.ar());
varHLLCEnergyFamily232955112 = AverageOutput.ar(0.3688622713089 * EnvFollow.ar(varHLLCEnergyFamily23295510 * DC.ar(0.48868775367737), varHLLCEnergyFamily2329559 * DC.ar(0.11156272888184), varHLLCEnergyFamily23295510 * DC.ar(0.19981265068054), varHLLCEnergyFamily23295511 * DC.ar(0.23017370700836)), signal * modZ, Gate.ar(varHLLCEnergyFamily2329559 * DC.ar(0.37736093997955), varHLLCEnergyFamily23295510 * DC.ar(0.72896647453308)), Silent.ar());
varHLLCEnergyFamily232955113 = FMGrainBF.ar(wave * env, varHLLCEnergyFamily23295511, signal * gateEnv, modY * varHLLCEnergyFamily23295511, FMHEncode0.ar(in * varHLLCEnergyFamily232955113, modY * varHLLCEnergyFamily232955113, t_trig, wave * varHLLCEnergyFamily23295510), modY * varHLLCEnergyFamily23295511, varHLLCEnergyFamily2329559, 0.76271212100983 * varHLLCEnergyFamily232955114 * varHLLCEnergyFamily2329559, modX * wave, 0.99571171585413 * signal * wave, Silent.ar());
varHLLCEnergyFamily232955114 = ArrayMin.ar([BHiPass.ar(varHLLCEnergyFamily23295510 * DC.ar(0.47956621646881), varHLLCEnergyFamily2329559 * DC.ar(0.43116569519043), varHLLCEnergyFamily23295511 * DC.ar(0.50586593151093), varHLLCEnergyFamily23295510 * DC.ar(0.82436549663544), varHLLCEnergyFamily23295510 * DC.ar(0.65986323356628)), MonoGrainBF.ar(varHLLCEnergyFamily2329559 * DC.ar(0.758469581604), varHLLCEnergyFamily23295511 * DC.ar(0.70708084106445), varHLLCEnergyFamily2329559 * DC.ar(0.15521967411041), varHLLCEnergyFamily2329559 * DC.ar(0.28272652626038), varHLLCEnergyFamily23295511 * DC.ar(0.78312802314758), varHLLCEnergyFamily23295511 * DC.ar(0.82216989994049), varHLLCEnergyFamily23295510 * DC.ar(0.14702558517456), varHLLCEnergyFamily2329559 * DC.ar(0.96610140800476), varHLLCEnergyFamily2329559 * DC.ar(0.14577555656433), varHLLCEnergyFamily2329559 * DC.ar(0.69883155822754), varHLLCEnergyFamily23295511 * DC.ar(0.52582848072052))]);
varHLLCEnergyFamily232955112 = Concat.ar(0.60315179824829 * in * varHLLCEnergyFamily23295510, 0.44570076465607 * env * varHLLCEnergyFamily2329559, x, varHLLCEnergyFamily232955112 * gateEnv, modZ, gateEnv * varHLLCEnergyFamily232955112, modZ * modZ, y, signal * varHLLCEnergyFamily23295510, 0.4404114484787 * varHLLCEnergyFamily2329559 * in, island, 0.10989356040955 * Pan4.ar(varHLLCEnergyFamily23295511 * DC.ar(0.98643708229065), varHLLCEnergyFamily23295511 * DC.ar(0.90023064613342), varHLLCEnergyFamily23295510 * DC.ar(0.71471178531647), varHLLCEnergyFamily23295511 * DC.ar(0.055197238922119)), DelTapWr.ar(varHLLCEnergyFamily23295510 * DC.ar(0.0097832679748535), varHLLCEnergyFamily23295510 * DC.ar(0.95456635951996)).clip(varHLLCEnergyFamily23295510 * DC.ar(0.004677414894104), varHLLCEnergyFamily2329559 * DC.ar(0.61606502532959)), Silent.ar());
varHLLCEnergyFamily232955113 = Streson.ar(z, gateEnv, varHLLCEnergyFamily23295511, 0.45493968261416 * modX * env, HyperTerrain.ar(varHLLCEnergyFamily23295510 * DC.ar(0.86306512355804), varHLLCEnergyFamily23295511 * DC.ar(0.158163189888), varHLLCEnergyFamily2329559 * DC.ar(0.050897121429443), varHLLCEnergyFamily2329559 * DC.ar(0.85953903198242), varHLLCEnergyFamily23295511 * DC.ar(0.34690880775452), varHLLCEnergyFamily2329559 * DC.ar(0.29778373241425)));
varHLLCEnergyFamily232955114 = RMShelf2.ar(varHLLCEnergyFamily23295511, signal * varHLLCEnergyFamily232955112, env.linexp(varHLLCEnergyFamily23295511 * DC.ar(0.40301120281219), varHLLCEnergyFamily2329559 * DC.ar(0.10672032833099), varHLLCEnergyFamily23295510 * DC.ar(0.78072738647461), varHLLCEnergyFamily23295511 * DC.ar(0.18331360816956), varHLLCEnergyFamily23295511 * DC.ar(0.044616103172302)), 0.9500813299145 * modX * modZ, NLFiltC.ar(varHLLCEnergyFamily23295510 * DC.ar(0.18254911899567), varHLLCEnergyFamily2329559 * DC.ar(0.99254930019379), varHLLCEnergyFamily23295511 * DC.ar(0.49961125850677), varHLLCEnergyFamily23295511 * DC.ar(0.29252529144287), varHLLCEnergyFamily23295511 * DC.ar(0.76662695407867), varHLLCEnergyFamily23295511 * DC.ar(0.42242801189423), varHLLCEnergyFamily23295511 * DC.ar(0.021878123283386), varHLLCEnergyFamily2329559 * DC.ar(0.9715029001236)));

signal = varHLLCEnergyFamily232955114;
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
varAtas2329559 = Fhn2DC.ar(varAtas2329559, varAtas2329559 * env, modZ * varAtas232955111, z, env * in, y, in, z, y, 0.99987637976867 * wave * modZ, Silent.ar());
varAtas2329559 = Rotate2.ar(in, amp, amp);
// Variation test code
varAtas232955110 = AnalyseEvents2.ar(gateEnv * varAtas2329559, Array.fill(2.pow(14), { |i| rrand(-1, 1) }).as(LocalBuf), signal * modY, wave * modX, modY * in.expexp(varAtas2329559 * DC.ar(0.11817455291748), varAtas2329559 * DC.ar(0.36922192573547), varAtas2329559 * DC.ar(0.13828206062317), varAtas2329559 * DC.ar(0.61664164066315), varAtas2329559 * DC.ar(0.62803375720978)), modZ * modX);
varAtas232955111 = YigMandelbulbN.ar(in * signal, modX * varAtas232955110, 0.11650204658508 * modY * modZ, varAtas232955111 * in, gateEnv * varAtas2329559, 0.98027328512162 * FincoSprottL.ar(varAtas2329559 * DC.ar(0.96644735336304), varAtas2329559 * DC.ar(0.8574492931366), varAtas2329559 * DC.ar(0.31543946266174), varAtas2329559 * DC.ar(0.30822384357452), varAtas2329559 * DC.ar(0.40010726451874), varAtas2329559 * DC.ar(0.16839563846588), varAtas2329559 * DC.ar(0.55595552921295), varAtas2329559 * DC.ar(0.66608929634094)), Silent.ar());
varAtas232955110 = OSFold8.ar(z, varAtas232955111, modX);
varAtas232955111 = Sweep.ar(modZ * env.minNyquist(), varAtas232955111 * wave);
varAtas232955110 = TRand.ar(0.52973282337189 * Spring.ar(varAtas2329559 * DC.ar(0.73199069499969), varAtas2329559 * DC.ar(0.41127192974091), varAtas2329559 * DC.ar(0.36657345294952)), 0.080885291099548 * CuspL.ar(varAtas2329559 * DC.ar(0.53728008270264), varAtas2329559 * DC.ar(0.30438256263733), varAtas2329559 * DC.ar(0.28666949272156), varAtas2329559 * DC.ar(0.8818883895874), varAtas2329559 * DC.ar(0.48487687110901), varAtas2329559 * DC.ar(0.57841145992279)), varAtas2329559 * modZ);
varAtas232955111 = WarpZ.ar(2, Array.fill(2.pow(11), { |i| rrand(-1, 1) }).as(LocalBuf), in * signal, env, 0.041017055511475 * env * env, bufnum, y, modX * varAtas2329559, 0.67159402370453 * modY * in, modZ * varAtas232955111, bufnum, 0.99568486853593 * T2A.ar(varAtas2329559 * DC.ar(0.39321327209473), varAtas2329559 * DC.ar(0.35252153873444)), SoftClipper8.ar(varAtas2329559 * DC.ar(0.55459940433502)));

signal = varAtas232955111;
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
varWMAntiWazzuA2329559 = CombFormlet.ar(wave * DC.ar(0.010276913642883), wave * DC.ar(0.19187748432159), wave * DC.ar(0.90240716934204), wave * DC.ar(0.022828578948975), wave * DC.ar(0.405482172966), wave * DC.ar(0.33277189731598), wave * DC.ar(0.42270088195801));

signal = varWMAntiWazzuA2329559;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// WM.CVCK1.I2329561
/////////////////////////////////////////////////////////

SynthDef.new("WM.CVCK1.I2329561", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varWMCVCK1I2329569, varWMCVCK1I232956110, varWMCVCK1I232956111;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varWMCVCK1I2329569 = varWMCVCK1I232956110 = varWMCVCK1I232956111 = K2A.ar(t_trig).dup;
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
varWMCVCK1I2329569 = BRZ2.ar(y, Henon2DL.ar(wave * DC.ar(0.45428442955017), wave * DC.ar(0.84906613826752), wave * DC.ar(0.17800414562225), wave * DC.ar(0.069977760314941), wave * DC.ar(0.8301967382431), wave * DC.ar(0.61557757854462), wave * DC.ar(0.58546531200409), wave * DC.ar(0.2719132900238)), Silent.ar());
varWMCVCK1I2329569 = SinGrainIBF.ar(modZ, env, varWMCVCK1I232956110, bufnum, bufnum, modX, 0.6095769405365 * modZ.max(InRange.ar(wave * DC.ar(0.24262344837189), wave * DC.ar(0.35300207138062), wave * DC.ar(0.52197802066803))), modX * signal, Metro.ar(y, modZ * modX, LatoocarfianL.ar(wave * DC.ar(0.43914818763733), wave * DC.ar(0.21046411991119), wave * DC.ar(0.61214172840118), wave * DC.ar(0.88727617263794), wave * DC.ar(0.39973938465118), wave * DC.ar(0.37421548366547), wave * DC.ar(0.42362117767334), wave * DC.ar(0.36972343921661), wave * DC.ar(0.079296112060547)), Silent.ar()), AtsPartial.ar(Array.fill(2.pow(13), { |i| rrand(-1, 1) }).as(LocalBuf), signal * varWMCVCK1I232956110, amp, signal * varWMCVCK1I2329569, modY * varWMCVCK1I2329569, 0.99984880877873 * FSinOsc.ar(wave * DC.ar(0.33483231067657), wave * DC.ar(0.91646289825439), wave * DC.ar(0.56893539428711), wave * DC.ar(0.14932429790497)), Silent.ar()), 0.99893469893493 * wave * varWMCVCK1I2329569, Silent.ar());
// Variation test code
varWMCVCK1I232956110 = Breakcore.ar(Array.fill(2.pow(16), { |i| rrand(-1, 1) }).as(LocalBuf), signal * wave, varWMCVCK1I2329569, 0.65444600582123 * Rotate2.ar(varWMCVCK1I2329569 * DC.ar(0.83945560455322), varWMCVCK1I2329569 * DC.ar(0.36435770988464), varWMCVCK1I2329569 * DC.ar(0.15005147457123)), varWMCVCK1I232956111 * varWMCVCK1I232956111);
varWMCVCK1I232956111 = MoogVCF.ar(bufnum, env * varWMCVCK1I2329569, 0.27862620353699 * env * signal, 0.99182938513558 * env * gateEnv, Lorenz2DL.ar(varWMCVCK1I2329569 * DC.ar(0.03376841545105), varWMCVCK1I2329569 * DC.ar(0.41317319869995), varWMCVCK1I2329569 * DC.ar(0.60144996643066), varWMCVCK1I2329569 * DC.ar(0.17171990871429), varWMCVCK1I2329569 * DC.ar(0.36017417907715), varWMCVCK1I2329569 * DC.ar(0.79637444019318), varWMCVCK1I2329569 * DC.ar(0.56805348396301), varWMCVCK1I2329569 * DC.ar(0.4652624130249), varWMCVCK1I2329569 * DC.ar(0.54041504859924), varWMCVCK1I2329569 * DC.ar(0.51158821582794), varWMCVCK1I2329569 * DC.ar(0.66687572002411)));
varWMCVCK1I232956110 = FincoSprottM.ar(varWMCVCK1I232956110, 0.30394864082336 * signal * varWMCVCK1I232956111, gateEnv * modX, modX, amp, gateEnv, varWMCVCK1I232956111, in, Silent.ar());
varWMCVCK1I232956111 = RHPF.ar(amp, in * modY, modY, 0.99876750808002 * modZ, Silent.ar());
varWMCVCK1I232956110 = BLBufRd.ar(Array.fill(2.pow(10), { |i| rrand(-1, 1) }).as(LocalBuf), modZ * modY.excess(ScopeOut.ar(varWMCVCK1I2329569 * DC.ar(0.45355594158173), varWMCVCK1I2329569 * DC.ar(0.8201721906662))), in);
varWMCVCK1I232956111 = BufGrainB.ar(varWMCVCK1I2329569 * modZ, in * in, bufnum, y, varWMCVCK1I2329569 * env, bufnum, 0.99552035331726 * modZ * varWMCVCK1I2329569, signal.unsignedRightShift(LPCSynth.ar(varWMCVCK1I2329569 * DC.ar(0.11512565612793), varWMCVCK1I2329569 * DC.ar(0.78545701503754), varWMCVCK1I2329569 * DC.ar(0.47616672515869), varWMCVCK1I2329569 * DC.ar(0.1474632024765), varWMCVCK1I2329569 * DC.ar(0.88669884204865))), Silent.ar());

signal = varWMCVCK1I232956111;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Pada.Trojan232956
/////////////////////////////////////////////////////////

SynthDef.new("Pada.Trojan232956", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varPadaTrojan2329569, varPadaTrojan23295610, varPadaTrojan23295611, varPadaTrojan23295612, varPadaTrojan23295613, varPadaTrojan23295614;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varPadaTrojan2329569 = varPadaTrojan23295610 = varPadaTrojan23295611 = varPadaTrojan23295612 = varPadaTrojan23295613 = varPadaTrojan23295614 = K2A.ar(t_trig).dup;
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
varPadaTrojan2329569 = OSFold4.ar(modZ, env, TDelay.ar(modZ * modY, varPadaTrojan23295613 * varPadaTrojan23295611));
varPadaTrojan23295610 = VOSIM.ar(gateEnv * varPadaTrojan23295610, varPadaTrojan23295614 * modX, LatoocarfianN.ar(wave * DC.ar(0.89861679077148), wave * DC.ar(0.17616093158722), wave * DC.ar(0.26022481918335), wave * DC.ar(0.0028312206268311), wave * DC.ar(0.98649895191193), wave * DC.ar(0.51126778125763), wave * DC.ar(0.79736125469208), wave * DC.ar(0.20792305469513), wave * DC.ar(0.8806813955307)), varPadaTrojan23295610, 0.99997192246853 * varPadaTrojan23295613 * modZ, Silent.ar());
varPadaTrojan23295611 = FoaFocusZ.ar(0.50407123565674 * varPadaTrojan23295611 * in, island, LFCub.ar(wave * DC.ar(0.96544063091278), wave * DC.ar(0.87665796279907), wave * DC.ar(0.024822592735291), wave * DC.ar(0.22844076156616)), Silent.ar());
varPadaTrojan23295612 = InFeedback.ar((80 + (island * 2)), 2);
varPadaTrojan23295613 = FSinOsc.ar(RegaliaMitraEQ.ar(wave * DC.ar(0.24586653709412), wave * DC.ar(0.3788480758667), wave * DC.ar(0.49421584606171), wave * DC.ar(0.59292471408844), wave * DC.ar(0.13946306705475), wave * DC.ar(0.44513237476349)).exprange(1, SampleRate.ir), varPadaTrojan23295612 * varPadaTrojan2329569, modZ, Silent.ar());
varPadaTrojan23295614 = FoaTumble.ar(modZ, modY * varPadaTrojan23295610, 0.96899739318301 * modZ * varPadaTrojan23295612, Silent.ar());
varPadaTrojan2329569 = AllpassC.ar(gateEnv, modX * wave, bufnum, wave, 0.99725174275761 * env * varPadaTrojan23295611, Silent.ar());
varPadaTrojan23295610 = FoaDirectX.ar(0.77493596076965 * MoogVCF.ar(wave * DC.ar(0.86122632026672), wave * DC.ar(0.51312875747681), wave * DC.ar(0.49885082244873), wave * DC.ar(0.38929915428162), wave * DC.ar(0.31899809837341)), bufnum, modX, Ringz.ar(wave * DC.ar(0.87163603305817), wave * DC.ar(0.89791512489319), wave * DC.ar(0.68068277835846), wave * DC.ar(0.33651149272919), wave * DC.ar(0.88851404190063)));
varPadaTrojan23295611 = Fhn2DL.ar(DoubleWell3.ar(wave * DC.ar(0.13147163391113), wave * DC.ar(0.59683406352997), wave * DC.ar(0.050035834312439), wave * DC.ar(0.78160500526428), wave * DC.ar(0.23278081417084), wave * DC.ar(0.10617291927338), wave * DC.ar(0.84955489635468), wave * DC.ar(0.18127071857452)).exprange(1, SampleRate.ir), RedPhasor2.ar(wave * DC.ar(0.99395847320557), wave * DC.ar(0.35381293296814), wave * DC.ar(0.8830817937851), wave * DC.ar(0.63462364673615), wave * DC.ar(0.7229505777359), wave * DC.ar(0.83917570114136), wave * DC.ar(0.31784093379974)).exprange(1, SampleRate.ir), y, varPadaTrojan23295614 * wave, in, gate, varPadaTrojan23295614 * modZ, varPadaTrojan23295613 * modY, 0.7582072019577 * varPadaTrojan23295611, BBandStop.ar(wave * DC.ar(0.90405702590942), wave * DC.ar(0.64223003387451), wave * DC.ar(0.65904808044434), wave * DC.ar(0.82689237594604), wave * DC.ar(0.089248299598694)).ring4(RunningMin.ar(wave * DC.ar(0.54644429683685), wave * DC.ar(0.71318423748016))), Silent.ar());
varPadaTrojan23295612 = ScopeOut.ar(wave * DC.ar(0.92226493358612), wave * DC.ar(0.67611134052277));
varPadaTrojan23295613 = ArrayMin.ar(wave * DC.ar(0.62239909172058));
varPadaTrojan23295614 = Select.ar(z, [AtsSynth.ar(wave * DC.ar(0.11798691749573), wave * DC.ar(0.68581056594849), wave * DC.ar(0.17970848083496), wave * DC.ar(0.40472805500031), wave * DC.ar(0.13420164585114), wave * DC.ar(0.24258053302765), wave * DC.ar(0.22062921524048), wave * DC.ar(0.27953672409058), wave * DC.ar(0.41983067989349)), AverageOutput.ar(wave * DC.ar(0.63461971282959), wave * DC.ar(0.97092652320862), wave * DC.ar(0.84101021289825), wave * DC.ar(0.87068164348602))]);

signal = varPadaTrojan23295614;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Pada.Trojan2329561
/////////////////////////////////////////////////////////

SynthDef.new("Pada.Trojan2329561", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varPadaTrojan2329569, varPadaTrojan23295610, varPadaTrojan23295611, varPadaTrojan23295612, varPadaTrojan23295613, varPadaTrojan23295614, varPadaTrojan232956115, varPadaTrojan232956116, varPadaTrojan232956117;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varPadaTrojan2329569 = varPadaTrojan23295610 = varPadaTrojan23295611 = varPadaTrojan23295612 = varPadaTrojan23295613 = varPadaTrojan23295614 = varPadaTrojan232956115 = varPadaTrojan232956116 = varPadaTrojan232956117 = K2A.ar(t_trig).dup;
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
varPadaTrojan2329569 = CompanderD.ar(modZ, varPadaTrojan23295614 * varPadaTrojan23295613, gate, bufnum, in * in, SortBuf.ar(Array.fill(2.pow(15), { |i| rrand(-1, 1) }).as(LocalBuf).range(wave * DC.ar(0.67624390125275), wave * DC.ar(0.050298571586609)), InGrain.ar(wave * DC.ar(0.63065803050995), wave * DC.ar(0.11545395851135), wave * DC.ar(0.18402135372162), wave * DC.ar(0.41657412052155), wave * DC.ar(0.88510918617249)), 0.28923618793488 * env * modZ.lag3(wave * DC.ar(0.18100166320801), wave * DC.ar(0.26531839370728))), 0.99968525773899 * varPadaTrojan23295610 * wave, Silent.ar());
varPadaTrojan23295610 = SoftClipAmp4.ar(varPadaTrojan23295611 * env, modZ * gateEnv, AmpCompA.ar(wave * DC.ar(0.43796801567078), wave * DC.ar(0.38592994213104), wave * DC.ar(0.017585515975952), wave * DC.ar(0.47267830371857)), Silent.ar());
varPadaTrojan23295611 = FBSineL.ar(AllpassN.ar(wave * DC.ar(0.63898241519928), wave * DC.ar(0.55158972740173), wave * DC.ar(0.9846807718277), wave * DC.ar(0.57187724113464), wave * DC.ar(0.16351568698883), wave * DC.ar(0.38037610054016)).exprange(1, SampleRate.ir), varPadaTrojan23295610, varPadaTrojan232956115, gateEnv * varPadaTrojan23295610, varPadaTrojan23295611, varPadaTrojan23295614 * varPadaTrojan2329569, gate, 0.99611329052475 * PV_JensenAndersen.ar(wave * DC.ar(0.77890157699585), wave * DC.ar(0.10205662250519), wave * DC.ar(0.5181645154953), wave * DC.ar(0.88809466362), wave * DC.ar(0.57588946819305), wave * DC.ar(0.90629327297211), wave * DC.ar(0.5882180929184)), Silent.ar());
varPadaTrojan23295612 = Lag3.ar(modY * modY, modY, 0.022866985288234 * varPadaTrojan23295612 * varPadaTrojan23295612, Silent.ar());
varPadaTrojan23295613 = SOS.ar(varPadaTrojan232956116, varPadaTrojan2329569, varPadaTrojan23295612, varPadaTrojan23295611, varPadaTrojan23295614 * varPadaTrojan23295613, signal * modY, varPadaTrojan2329569, Silent.ar());
varPadaTrojan23295614 = HilbertFIR.ar(varPadaTrojan23295612 * modZ, Array.fill(2.pow(15), { |i| rrand(-1, 1) }).as(LocalBuf));
varPadaTrojan2329569 = Amplitude.ar(modX * modZ, varPadaTrojan232956116 * env, varPadaTrojan23295613, 0.99195714027211 * gateEnv * varPadaTrojan232956115, Silent.ar());
varPadaTrojan23295610 = HenonN.ar(varPadaTrojan23295612, varPadaTrojan232956117 * varPadaTrojan232956117, in * varPadaTrojan23295614, modZ * varPadaTrojan23295610, amp, 0.99998317269677 * TExpRand.ar(wave * DC.ar(0.75983572006226), wave * DC.ar(0.30074238777161), wave * DC.ar(0.7980455160141)), Silent.ar());
varPadaTrojan23295611 = CoinGate.ar(FreeVerb.ar(in, wave * varPadaTrojan232956115, modY * gateEnv, varPadaTrojan232956116 * varPadaTrojan232956117, 0.99908022623581 * signal * env, Silent.ar()), varPadaTrojan232956116 * env);
varPadaTrojan23295612 = FoaDirectZ.ar(varPadaTrojan23295612 * varPadaTrojan2329569, varPadaTrojan23295610 * varPadaTrojan23295610, 0.99646666772075 * varPadaTrojan23295612 * varPadaTrojan23295611, Silent.ar());
varPadaTrojan23295613 = FoaFocusY.ar(varPadaTrojan23295611 * env, signal * modY, varPadaTrojan23295613, Silent.ar());
varPadaTrojan23295614 = FMGrainBBF.ar(wave * DC.ar(0.36592221260071), wave * DC.ar(0.70137333869934), wave * DC.ar(0.6069883108139), wave * DC.ar(0.82271456718445), wave * DC.ar(0.098325490951538), wave * DC.ar(0.43930959701538), wave * DC.ar(0.41454195976257), wave * DC.ar(0.85429739952087), wave * DC.ar(0.78089809417725), wave * DC.ar(0.53953742980957), wave * DC.ar(0.55185317993164), wave * DC.ar(0.4046539068222));
// Variation test code
varPadaTrojan232956115 = WaveletDaub.ar(varPadaTrojan232956115 * in, TextVU.ar(varPadaTrojan23295610 * varPadaTrojan23295614, modY * modZ, varPadaTrojan23295611, varPadaTrojan232956117 * varPadaTrojan23295610, varPadaTrojan23295610 * in, varPadaTrojan232956115 * modY), varPadaTrojan2329569 * varPadaTrojan2329569, 0.9999766578764 * LastValue.ar(varPadaTrojan23295614 * DC.ar(0.99070143699646), varPadaTrojan23295614 * DC.ar(0.92218923568726)), Silent.ar());
varPadaTrojan232956116 = Lag3.ar(island, varPadaTrojan23295613, gateEnv, Silent.ar());
varPadaTrojan232956117 = LinCongN.ar(varPadaTrojan23295613 * varPadaTrojan2329569, varPadaTrojan232956116, env * varPadaTrojan23295610, gateEnv * varPadaTrojan23295613, varPadaTrojan232956115 * varPadaTrojan232956115, 0.9998106249178 * gateEnv * varPadaTrojan23295612, Silent.ar());
varPadaTrojan232956115 = FoaZoomZ.ar(0.74693775177002 * varPadaTrojan2329569 * varPadaTrojan232956115, x, 0.97531661652367 * varPadaTrojan23295614 * gateEnv, Normalizer.ar(varPadaTrojan23295610 * DC.ar(0.6379097700119), varPadaTrojan23295610 * DC.ar(0.31558346748352), varPadaTrojan23295611 * DC.ar(0.55873548984528)));
varPadaTrojan232956116 = CrossoverDistortion.ar(0.13218367099762 * varPadaTrojan2329569 * in, modX * varPadaTrojan2329569, x, Slub.ar(varPadaTrojan23295614 * DC.ar(0.76997554302216), varPadaTrojan23295614 * DC.ar(0.95722198486328)), Silent.ar());
varPadaTrojan232956117 = Crackle.ar(varPadaTrojan23295610, Limiter.ar(varPadaTrojan23295614 * DC.ar(0.55232584476471), varPadaTrojan23295613 * DC.ar(0.37595462799072), varPadaTrojan23295613 * DC.ar(0.308478474617)), Silent.ar());
varPadaTrojan232956115 = Hasher.ar(varPadaTrojan232956116, PosRatio.ar(varPadaTrojan23295614 * DC.ar(0.96956419944763), varPadaTrojan23295611 * DC.ar(0.6965948343277), varPadaTrojan23295613 * DC.ar(0.83600056171417)), Silent.ar());
varPadaTrojan232956116 = FoaPressX.ar(varPadaTrojan23295610 * modZ, varPadaTrojan232956117 * varPadaTrojan232956117, 0.99596830687619 * varPadaTrojan2329569 * modY, Silent.ar());
varPadaTrojan232956117 = OneZero.ar(BHiPass.ar(in, varPadaTrojan2329569 * varPadaTrojan232956117, varPadaTrojan2329569 * wave, 0.99725200216245 * varPadaTrojan232956115 * modY, Silent.ar()), varPadaTrojan23295612 * varPadaTrojan23295613, varPadaTrojan232956115, Silent.ar());

signal = varPadaTrojan232956117;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// SillyC.335232956
/////////////////////////////////////////////////////////

SynthDef.new("SillyC.335232956", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varSillyC3352329569;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varSillyC3352329569 = K2A.ar(t_trig).dup;
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
varSillyC3352329569 = InsideOut.ar(bufnum, 0.97186865155957 * modX * in, Silent.ar());
varSillyC3352329569 = FoaZoomZ.ar(signal * signal, amp, 0.99938892440398 * modZ, Silent.ar());

signal = varSillyC3352329569;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// SillyC.3352329561
/////////////////////////////////////////////////////////

SynthDef.new("SillyC.3352329561", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varSillyC3352329569, varSillyC335232956110;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varSillyC3352329569 = varSillyC335232956110 = K2A.ar(t_trig).dup;
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
varSillyC3352329569 = QuadC.ar(signal * gateEnv, varSillyC3352329569 * signal, modZ * varSillyC3352329569, modY, 0.73139226436615 * modX * env, 0.93041368597951 * Sieve1.ar(wave * DC.ar(0.16409504413605), wave * DC.ar(0.6648827791214), wave * DC.ar(0.54463171958923), wave * DC.ar(0.013247132301331), wave * DC.ar(0.87421059608459)), Silent.ar());
varSillyC3352329569 = GlitchRHPF.ar(x, signal, amp, in, Silent.ar());
// Variation test code
varSillyC335232956110 = Concat2.ar(signal * modX, wave * wave, signal, env * env, signal * in, wave * varSillyC335232956110, gateEnv * gateEnv, wave * gateEnv, RMShelf2.ar(0.98361396789551 * varSillyC335232956110 * in, ToggleFF.ar(varSillyC3352329569 * DC.ar(0.13127934932709)).exprange(1, SampleRate.ir), wave, 0.048344924068726 * modZ * modZ, Silent.ar()), modY * env, gateEnv, modZ * varSillyC3352329569.minNyquist(), 0.1543470621109 * env, Balance2.ar(varSillyC3352329569 * DC.ar(0.63741219043732), varSillyC3352329569 * DC.ar(0.77782332897186), varSillyC3352329569 * DC.ar(0.18453979492188), varSillyC3352329569 * DC.ar(0.95293271541595)), Silent.ar());
varSillyC335232956110 = Allpass1.ar(modZ, modZ * in, 0.99436215730744 * gateEnv * signal, Silent.ar());
varSillyC335232956110 = BLowPass.ar(env * gateEnv, SpruceBudworm.ar(varSillyC3352329569 * DC.ar(0.71902215480804), varSillyC3352329569 * DC.ar(0.62919735908508), varSillyC3352329569 * DC.ar(0.92075371742249), varSillyC3352329569 * DC.ar(0.54574239253998), varSillyC3352329569 * DC.ar(0.5824898481369), varSillyC3352329569 * DC.ar(0.42820751667023), varSillyC3352329569 * DC.ar(0.37145555019379), varSillyC3352329569 * DC.ar(0.26424062252045), varSillyC3352329569 * DC.ar(0.33127760887146), varSillyC3352329569 * DC.ar(0.90984272956848), varSillyC3352329569 * DC.ar(0.98893296718597), varSillyC3352329569 * DC.ar(0.00010597705841064)).exprange(1, SampleRate.ir), modY * modZ, 0.99998859463813 * varSillyC3352329569 * env, Silent.ar());

signal = varSillyC335232956110;
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
varAustr_Parasite3202329579 = Gendy1.ar(modX * env, wave, signal * modX, gate, in * wave, IEnvGen.ar(wave * DC.ar(0.11829710006714), wave * DC.ar(0.019633054733276), wave * DC.ar(0.33262968063354), wave * DC.ar(0.28155696392059)).exprange(1, SampleRate.ir), gateEnv * modY, gate, FSinOsc.ar(FincoSprottM.ar(wave * DC.ar(0.90810668468475), wave * DC.ar(0.50611555576324), wave * DC.ar(0.78153884410858), wave * DC.ar(0.14996087551117), wave * DC.ar(0.3352792263031), wave * DC.ar(0.2739372253418), wave * DC.ar(0.39801645278931), wave * DC.ar(0.045127749443054), wave * DC.ar(0.82582080364227)).exprange(1, SampleRate.ir), env, 0.99808030943888 * Oregonator.ar(wave * DC.ar(0.91482675075531), wave * DC.ar(0.12314581871033), wave * DC.ar(0.80669927597046), wave * DC.ar(0.45283842086792), wave * DC.ar(0.056694030761719), wave * DC.ar(0.42127597332001), wave * DC.ar(0.78053855895996), wave * DC.ar(0.88908135890961), wave * DC.ar(0.63341319561005), wave * DC.ar(0.037650227546692)), Silent.ar()), env, varAustr_Parasite3202329579, FoaDirectY.ar(wave * DC.ar(0.17868840694427), wave * DC.ar(0.42966938018799), wave * DC.ar(0.91474723815918), wave * DC.ar(0.97656786441803)));
varAustr_Parasite3202329579 = Henon2DL.ar(YigClifford3DL.ar(wave * DC.ar(0.68160796165466), wave * DC.ar(0.64822542667389), wave * DC.ar(0.47043454647064), wave * DC.ar(0.53059124946594), wave * DC.ar(0.070807456970215), wave * DC.ar(0.82099759578705), wave * DC.ar(0.93321573734283), wave * DC.ar(0.58978033065796), wave * DC.ar(0.091419816017151), wave * DC.ar(0.01822817325592)).exprange(1, SampleRate.ir), wave, z, gate, env, modZ * in, 0.99987097971768 * env * modX, Silent.ar());

signal = varAustr_Parasite3202329579;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Zombie.VPI.15467232957
/////////////////////////////////////////////////////////

SynthDef.new("Zombie.VPI.15467232957", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varZombieVPI154672329579, varZombieVPI1546723295710;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varZombieVPI154672329579 = varZombieVPI1546723295710 = K2A.ar(t_trig).dup;
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
varZombieVPI154672329579 = Henon2DC.ar(modX * modY, wave * gateEnv, 0.90252983570099 * varZombieVPI1546723295710 * signal, 0.10615849494934 * FoaTumble.ar(wave * DC.ar(0.61210465431213), wave * DC.ar(0.044479131698608), wave * DC.ar(0.50133049488068), wave * DC.ar(0.9772629737854)), wave * in, y, 0.96405816200808 * signal * modZ, Silent.ar());
varZombieVPI1546723295710 = Latoocarfian2DN.ar(env * modX, gateEnv * gateEnv, modZ * varZombieVPI1546723295710, z, varZombieVPI154672329579 * varZombieVPI154672329579, wave, gate, modY * modX, BBandPass.ar(wave * DC.ar(0.94522452354431), wave * DC.ar(0.2012243270874), wave * DC.ar(0.1458455324173), wave * DC.ar(0.9399927854538), wave * DC.ar(0.75106847286224)), Silent.ar());
varZombieVPI154672329579 = BRZ2.ar(modX, Spreader.ar(wave * DC.ar(0.39521837234497), wave * DC.ar(0.15193748474121), wave * DC.ar(0.43526697158813), wave * DC.ar(0.10442078113556), wave * DC.ar(0.028004169464111)), Silent.ar());
varZombieVPI1546723295710 = CombFormlet.ar(wave * DC.ar(0.88674736022949), wave * DC.ar(0.27665090560913), wave * DC.ar(0.10127198696136), wave * DC.ar(0.049764752388), wave * DC.ar(0.29821014404297), wave * DC.ar(0.47449970245361), wave * DC.ar(0.42280519008636));

signal = varZombieVPI1546723295710;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// HLLT.49402329591
/////////////////////////////////////////////////////////

SynthDef.new("HLLT.49402329591", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varHLLT49402329599, varHLLT494023295910, varHLLT494023295911, varHLLT494023295912, varHLLT4940232959113;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varHLLT49402329599 = varHLLT494023295910 = varHLLT494023295911 = varHLLT494023295912 = varHLLT4940232959113 = K2A.ar(t_trig).dup;
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
varHLLT49402329599 = Trig.ar(varHLLT494023295912, gateEnv * varHLLT494023295910);
varHLLT494023295910 = YigMandelbulbN.ar(BBandStop.ar(wave * DC.ar(0.022103190422058), wave * DC.ar(0.069235682487488), wave * DC.ar(0.81761789321899), wave * DC.ar(0.83088684082031), wave * DC.ar(0.75936007499695)).exprange(1, SampleRate.ir), in * gateEnv, varHLLT494023295910, env * in, bufnum, 0.99698600181325 * modY * varHLLT494023295910, Silent.ar());
varHLLT494023295911 = BufRd.ar(2, Array.fill(2.pow(12), { |i| rrand(-1, 1) }).as(LocalBuf), varHLLT494023295911 * varHLLT494023295911, VOsc3.ar(Array.fill(2.pow(14), { |i| rrand(-1, 1) }).as(LocalBuf), gateEnv * wave, modX * gateEnv, LagUD.ar(wave * DC.ar(0.45861911773682), wave * DC.ar(0.67111551761627), wave * DC.ar(0.071224093437195), wave * DC.ar(0.9072083234787), wave * DC.ar(0.62709844112396)).exprange(1, SampleRate.ir), 0.99697018059983 * varHLLT494023295910 * varHLLT49402329599, Silent.ar()), modY);
varHLLT494023295912 = Balance.ar(varHLLT49402329599 * wave, varHLLT494023295912 * varHLLT494023295911, modZ, varHLLT4940232959113 * wave, modX, Stepper.ar(wave * DC.ar(0.11616230010986), wave * DC.ar(0.44224548339844), wave * DC.ar(0.67487418651581), wave * DC.ar(0.064716100692749), wave * DC.ar(0.27804338932037), wave * DC.ar(0.17526090145111)));
varHLLT49402329599 = Ball.ar(bufnum, varHLLT4940232959113 * varHLLT494023295912, env * varHLLT49402329599, varHLLT494023295910 * varHLLT49402329599);
varHLLT494023295910 = BufRd.ar(2, Array.fill(2.pow(16), { |i| rrand(-1, 1) }).as(LocalBuf), modY * wave, amp, 0.80019664764404 * wave * modX);
varHLLT494023295911 = Brusselator.ar(modY, 0.93556356430054 * modX * varHLLT49402329599, x, 0.42737889289856 * Squiz.ar(wave * DC.ar(0.12888252735138), wave * DC.ar(0.10079050064087), wave * DC.ar(0.81437385082245), wave * DC.ar(0.16724610328674), wave * DC.ar(0.47366952896118), wave * DC.ar(0.73016953468323)), 0.30022311210632 * Pulse.ar(wave * DC.ar(0.85646653175354), wave * DC.ar(0.10130715370178), wave * DC.ar(0.19081950187683), wave * DC.ar(0.36335575580597)), StkMoog.ar(in * modZ, amp, signal, varHLLT494023295912, varHLLT4940232959113 * signal, varHLLT494023295911 * varHLLT49402329599, modY * varHLLT49402329599, varHLLT494023295912, Silent.ar()), modZ, Silent.ar());
varHLLT494023295912 = TGrains.ar(2, gateEnv * modZ, Array.fill(2.pow(12), { |i| rrand(-1, 1) }).as(LocalBuf), varHLLT494023295910 * wave, gateEnv, varHLLT49402329599 * gateEnv, bufnum, z, in);
// Variation test code
varHLLT4940232959113 = Gendy2.ar(modY, env * signal, varHLLT494023295911, varHLLT494023295912, varHLLT494023295911, modY * in, y, gate, bufnum, varHLLT49402329599 * varHLLT494023295911, z, in, modZ, SoftClipper4.ar(varHLLT494023295911 * DC.ar(0.89715075492859)));
varHLLT4940232959113 = FoaZoomX.ar(modZ, modX * gateEnv, 0.9998349024026 * modX * env, FincoSprottS.ar(varHLLT494023295910 * DC.ar(0.51598632335663), varHLLT49402329599 * DC.ar(0.46717548370361), varHLLT494023295911 * DC.ar(0.74144089221954), varHLLT494023295912 * DC.ar(0.5324342250824), varHLLT494023295912 * DC.ar(0.12391865253448), varHLLT494023295910 * DC.ar(0.55763649940491), varHLLT494023295912 * DC.ar(0.7055059671402), varHLLT494023295910 * DC.ar(0.65286123752594), varHLLT49402329599 * DC.ar(0.16964852809906)));
varHLLT4940232959113 = MonoGrain.ar(bufnum, varHLLT494023295911 * gateEnv, gateEnv * wave, modZ * in, 0.088098277355379 * in * varHLLT494023295910, Silent.ar());

signal = varHLLT4940232959113;
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
varJSScreegor23295911 = GrainIn.ar(2, varJSScreegor23295910, modY, wave * varJSScreegor2329599, gate, bufnum, varJSScreegor23295912, 0.73789232122052 * gateEnv * varJSScreegor2329599, Silent.ar());
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
// JS.Screegor2329591
/////////////////////////////////////////////////////////

SynthDef.new("JS.Screegor2329591", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varJSScreegor2329599, varJSScreegor23295910, varJSScreegor23295911, varJSScreegor23295912, varJSScreegor232959113;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varJSScreegor2329599 = varJSScreegor23295910 = varJSScreegor23295911 = varJSScreegor23295912 = varJSScreegor232959113 = K2A.ar(t_trig).dup;
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
varJSScreegor2329599 = MidEQ.ar(in * wave, signal * varJSScreegor232959113, varJSScreegor2329599, 0.72234189510345 * env, varJSScreegor23295910, Silent.ar());
varJSScreegor23295910 = A2B.ar(modX * modZ, varJSScreegor2329599 * varJSScreegor2329599, modY, varJSScreegor23295910);
varJSScreegor23295911 = Balance2.ar(varJSScreegor23295911, env * modZ.ring3(LinExp.ar(wave * DC.ar(0.75846946239471), wave * DC.ar(0.28710746765137), wave * DC.ar(0.091989517211914), wave * DC.ar(0.80381894111633), wave * DC.ar(0.99923062324524))), varJSScreegor2329599, signal * varJSScreegor232959113);
varJSScreegor23295912 = BufGrainI.ar(varJSScreegor232959113 * varJSScreegor23295912, varJSScreegor2329599 * env, bufnum, modX, in * signal, bufnum, bufnum, varJSScreegor23295912 * gateEnv, wave * modY, 0.99957675113593 * gateEnv * gateEnv, Silent.ar());
varJSScreegor2329599 = LatoocarfianN.ar(varJSScreegor23295911 * varJSScreegor232959113, amp, varJSScreegor23295911, y, varJSScreegor23295912 * varJSScreegor23295910, bufnum, z, LFDNoise1.ar(wave * DC.ar(0.94552850723267), wave * DC.ar(0.74335396289825), wave * DC.ar(0.27709138393402)), Silent.ar());
varJSScreegor23295910 = LinXFade2.ar(varJSScreegor23295912 * modZ, env * env, varJSScreegor23295911 * modZ, amp);
varJSScreegor23295911 = FMGrainB.ar(TBetaRand.ar(wave * DC.ar(0.25551724433899), wave * DC.ar(0.85227477550507), wave * DC.ar(0.77017319202423), wave * DC.ar(0.61571168899536), wave * DC.ar(0.25759160518646), wave * DC.ar(0.77969121932983), wave * DC.ar(0.48386907577515)), 0.27226972579956 * varJSScreegor2329599 * in, Pluck.ar(wave * DC.ar(0.23246145248413), wave * DC.ar(0.76265859603882), wave * DC.ar(0.32044816017151), wave * DC.ar(0.033931612968445), wave * DC.ar(0.66790354251862), wave * DC.ar(0.75626242160797), wave * DC.ar(0.955890417099), wave * DC.ar(0.033758759498596)).exprange(1, SampleRate.ir), in * modY, z, bufnum, 0.99995411135364 * varJSScreegor2329599 * modY, Silent.ar());
varJSScreegor23295912 = QuadL.ar(wave * DC.ar(0.54195499420166), wave * DC.ar(0.8289600610733), wave * DC.ar(0.90351366996765), wave * DC.ar(0.096412777900696), wave * DC.ar(0.10561144351959), wave * DC.ar(0.12646162509918), wave * DC.ar(0.65754115581512));
// Variation test code
varJSScreegor232959113 = DC.ar(modZ * wave);
varJSScreegor232959113 = FoaZoomY.ar(in, varJSScreegor2329599 * signal, env, Silent.ar());
varJSScreegor232959113 = BufAllpassC.ar(Array.fill(2.pow(11), { |i| rrand(-1, 1) }).as(LocalBuf).ring2(Ringz.ar(varJSScreegor23295912 * DC.ar(0.33161437511444), varJSScreegor2329599 * DC.ar(0.53032255172729), varJSScreegor2329599 * DC.ar(0.47623956203461), varJSScreegor23295911 * DC.ar(0.098460674285889), varJSScreegor2329599 * DC.ar(0.67389047145844))), env * modZ, varJSScreegor232959113 * varJSScreegor23295912, 0.20807254314423 * gateEnv * signal, StereoConvolution2L.ar(varJSScreegor2329599 * DC.ar(0.22339987754822), varJSScreegor23295910 * DC.ar(0.27021789550781), varJSScreegor2329599 * DC.ar(0.074213624000549), varJSScreegor23295910 * DC.ar(0.97987270355225), varJSScreegor23295912 * DC.ar(0.71160244941711), varJSScreegor23295911 * DC.ar(0.50064337253571), varJSScreegor23295910 * DC.ar(0.54101133346558), varJSScreegor23295911 * DC.ar(0.63150107860565)), Silent.ar());

signal = varJSScreegor232959113;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// W32.HLLP.Scrambler.E233001
/////////////////////////////////////////////////////////

SynthDef.new("W32.HLLP.Scrambler.E233001", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varW32HLLPScramblerE2330019, varW32HLLPScramblerE23300110;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varW32HLLPScramblerE2330019 = varW32HLLPScramblerE23300110 = K2A.ar(t_trig).dup;
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
varW32HLLPScramblerE2330019 = BLowShelf.ar(wave * modZ, modY * modX, amp, env, 0.99961249843009 * Slope.ar(wave * DC.ar(0.5547194480896), wave * DC.ar(0.45583069324493), wave * DC.ar(0.13168179988861)), Silent.ar());
varW32HLLPScramblerE23300110 = FincoSprottS.ar(modX * wave, gate, gateEnv * varW32HLLPScramblerE2330019, modX * gateEnv, gateEnv, modX * wave.linexp(wave * DC.ar(0.26870226860046), wave * DC.ar(0.82188904285431), wave * DC.ar(0.16747164726257), wave * DC.ar(0.97306334972382), wave * DC.ar(0.47692394256592)), BAllPass.ar(gateEnv * modX, modZ * modZ, 0.12284457683563 * signal * varW32HLLPScramblerE2330019, 0.79781403684319 * signal * modZ, Silent.ar()), DelayC.ar(wave * DC.ar(0.96488666534424), wave * DC.ar(0.2703971862793), wave * DC.ar(0.15323746204376), wave * DC.ar(0.30631446838379), wave * DC.ar(0.24002861976624)), Silent.ar());
varW32HLLPScramblerE2330019 = FoaNFC.ar(wave * DC.ar(0.5315260887146), wave * DC.ar(0.65854740142822), wave * DC.ar(0.11131477355957), wave * DC.ar(0.36626541614532));
varW32HLLPScramblerE23300110 = ChuaL.ar(wave * DC.ar(0.90901219844818), wave * DC.ar(0.76781392097473), wave * DC.ar(0.051366209983826), wave * DC.ar(0.64186429977417), wave * DC.ar(0.24066805839539), wave * DC.ar(0.9524792432785), wave * DC.ar(0.47047257423401), wave * DC.ar(0.65584528446198), wave * DC.ar(0.5009902715683), wave * DC.ar(0.088190317153931), wave * DC.ar(0.5379581451416), wave * DC.ar(0.063296914100647));

signal = varW32HLLPScramblerE23300110;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// W95.ILMX.1291233002
/////////////////////////////////////////////////////////

SynthDef.new("W95.ILMX.1291233002", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varW95ILMX12912330029, varW95ILMX129123300210, varW95ILMX129123300211, varW95ILMX129123300212, varW95ILMX129123300213;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varW95ILMX12912330029 = varW95ILMX129123300210 = varW95ILMX129123300211 = varW95ILMX129123300212 = varW95ILMX129123300213 = K2A.ar(t_trig).dup;
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
varW95ILMX12912330029 = BRF.ar(modZ, in * modZ, bufnum, 0.98614304551477 * env * varW95ILMX129123300213, Silent.ar());
varW95ILMX129123300210 = Standard2DC.ar(varW95ILMX129123300212 * modX, varW95ILMX12912330029 * in, varW95ILMX129123300210, signal * in, 0.24455618858337 * env * modX, TIRand.ar(wave * DC.ar(0.29999315738678), wave * DC.ar(0.93404471874237), wave * DC.ar(0.97204101085663)), Silent.ar());
varW95ILMX129123300211 = PartConv.ar(bufnum, varW95ILMX12912330029, Array.fill(2.pow(16), { |i| rrand(-1, 1) }).as(LocalBuf), modZ, Silent.ar());
varW95ILMX129123300212 = LFNoise0.ar(StkClarinet.ar(wave * DC.ar(0.24162530899048), wave * DC.ar(0.67744934558868), wave * DC.ar(0.32289063930511), wave * DC.ar(0.48273122310638), wave * DC.ar(0.72091364860535), wave * DC.ar(0.92588973045349), wave * DC.ar(0.7389087677002), wave * DC.ar(0.79790902137756), wave * DC.ar(0.087827563285828)).exprange(1, SampleRate.ir), 0.99995341003273 * varW95ILMX129123300212 * modY, Silent.ar());
varW95ILMX129123300213 = GravityGrid.ar(varW95ILMX129123300212 * modZ.linexp(wave * DC.ar(0.68496191501617), wave * DC.ar(0.94695103168488), wave * DC.ar(0.82788860797882), wave * DC.ar(0.96512377262115), wave * DC.ar(0.84573876857758)), 0.40850114822388 * modZ * env, varW95ILMX129123300213 * varW95ILMX12912330029, varW95ILMX129123300213 * varW95ILMX129123300213, Array.fill(2.pow(13), { |i| rrand(-1, 1) }).as(LocalBuf), 0.9259802205845 * RunningMin.ar(wave * DC.ar(0.76782846450806), wave * DC.ar(0.26387989521027)), Silent.ar());
varW95ILMX12912330029 = AtsAmp.ar(wave * DC.ar(0.9758095741272), wave * DC.ar(0.069427490234375), wave * DC.ar(0.32421779632568), wave * DC.ar(0.99624252319336), wave * DC.ar(0.6888462305069));
varW95ILMX129123300210 = PeakEQ4.ar(amp, FoaRotate.ar(wave * DC.ar(0.56857943534851), wave * DC.ar(0.76130294799805), wave * DC.ar(0.810138463974), wave * DC.ar(0.09626829624176)).exprange(1, SampleRate.ir), varW95ILMX12912330029 * varW95ILMX129123300213, signal);
varW95ILMX129123300211 = BLBufRd.ar(wave * DC.ar(0.19838273525238), wave * DC.ar(0.051233053207397), wave * DC.ar(0.043167233467102));
varW95ILMX129123300212 = BFEncode1.ar(modY * modX, in * varW95ILMX129123300213, 0.49813079833984 * BMoog.ar(wave * DC.ar(0.47095954418182), wave * DC.ar(0.45820605754852), wave * DC.ar(0.77671790122986), wave * DC.ar(0.86464619636536), wave * DC.ar(0.79269552230835), wave * DC.ar(0.63089168071747), wave * DC.ar(0.34725677967072)), 0.85771989822388 * gateEnv * varW95ILMX129123300211, 0.4624091386795 * wave * varW95ILMX129123300210, varW95ILMX129123300212 * modZ);
varW95ILMX129123300213 = BufDelayL.ar(wave * DC.ar(0.03252375125885), wave * DC.ar(0.43389880657196), wave * DC.ar(0.5816935300827), wave * DC.ar(0.018530130386353), wave * DC.ar(0.049135088920593));

signal = varW95ILMX129123300213;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// VBS.Destroyer.Trojan2330021
/////////////////////////////////////////////////////////

SynthDef.new("VBS.Destroyer.Trojan2330021", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varVBSDestroyerTrojan2330029, varVBSDestroyerTrojan23300210, varVBSDestroyerTrojan23300211, varVBSDestroyerTrojan23300212, varVBSDestroyerTrojan23300213, varVBSDestroyerTrojan23300214, varVBSDestroyerTrojan233002115;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varVBSDestroyerTrojan2330029 = varVBSDestroyerTrojan23300210 = varVBSDestroyerTrojan23300211 = varVBSDestroyerTrojan23300212 = varVBSDestroyerTrojan23300213 = varVBSDestroyerTrojan23300214 = varVBSDestroyerTrojan233002115 = K2A.ar(t_trig).dup;
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
varVBSDestroyerTrojan2330029 = RedNoise.ar(modY * env, 0.98997696669666 * varVBSDestroyerTrojan233002115 * modX, Silent.ar());
varVBSDestroyerTrojan23300210 = RunningSum.ar(varVBSDestroyerTrojan23300214 * varVBSDestroyerTrojan23300211, modZ * varVBSDestroyerTrojan23300211);
varVBSDestroyerTrojan23300211 = WaveLoss.ar(varVBSDestroyerTrojan23300210 * varVBSDestroyerTrojan23300212, modY, varVBSDestroyerTrojan23300213 * varVBSDestroyerTrojan23300210, modY * signal, 0.37075117981254 * varVBSDestroyerTrojan23300211, Silent.ar());
varVBSDestroyerTrojan23300212 = DelayL.ar(signal * varVBSDestroyerTrojan23300210, bufnum, modY * varVBSDestroyerTrojan23300210, in, Silent.ar());
varVBSDestroyerTrojan23300213 = BufDelayC.ar(Array.fill(2.pow(14), { |i| rrand(-1, 1) }).as(LocalBuf), amp.expexp(wave * DC.ar(0.39432382583618), wave * DC.ar(0.55746519565582), wave * DC.ar(0.19709503650665), wave * DC.ar(0.8542355298996), wave * DC.ar(0.77129054069519)), varVBSDestroyerTrojan23300213 * env, 0.99917642662451 * wave * modY, Silent.ar());
varVBSDestroyerTrojan23300214 = IEnvGen.ar(varVBSDestroyerTrojan23300211 * varVBSDestroyerTrojan2330029, modX, 0.99972209050163 * varVBSDestroyerTrojan233002115 * varVBSDestroyerTrojan23300212, Silent.ar());
varVBSDestroyerTrojan2330029 = FreqShift.ar(varVBSDestroyerTrojan233002115, wave, in * varVBSDestroyerTrojan2330029, 0.74914411816134 * varVBSDestroyerTrojan23300213 * varVBSDestroyerTrojan233002115, Silent.ar());
varVBSDestroyerTrojan23300210 = SetResetFF.ar(wave * DC.ar(0.80011570453644), wave * DC.ar(0.91411638259888));
varVBSDestroyerTrojan23300211 = SetResetFF.ar(env * wave, modX * signal);
varVBSDestroyerTrojan23300212 = Squiz.ar(wave * DC.ar(0.91577672958374), wave * DC.ar(0.074122905731201), wave * DC.ar(0.25699603557587), wave * DC.ar(0.80050313472748), wave * DC.ar(0.42736637592316), wave * DC.ar(0.62657296657562));
varVBSDestroyerTrojan23300213 = GrayNoise.ar(wave * DC.ar(0.98078143596649), wave * DC.ar(0.28348398208618));
varVBSDestroyerTrojan23300214 = Compander.ar(varVBSDestroyerTrojan23300212, LorenzL.ar(wave * DC.ar(0.44765782356262), wave * DC.ar(0.043652176856995), wave * DC.ar(0.20139336585999), wave * DC.ar(0.74799275398254), wave * DC.ar(0.43520998954773), wave * DC.ar(0.06230366230011), wave * DC.ar(0.43709051609039), wave * DC.ar(0.047221183776855), wave * DC.ar(0.92856729030609), wave * DC.ar(0.83265793323517)), modY * varVBSDestroyerTrojan2330029, 0.5304890871048 * wave, wave, env, varVBSDestroyerTrojan23300212 * in, FMGrainIBF.ar(wave * DC.ar(0.67118167877197), wave * DC.ar(0.90408933162689), wave * DC.ar(0.76362299919128), wave * DC.ar(0.36163914203644), wave * DC.ar(0.95486795902252), wave * DC.ar(0.076443076133728), wave * DC.ar(0.65531539916992), wave * DC.ar(0.046944499015808), wave * DC.ar(0.42811357975006), wave * DC.ar(0.71681082248688), wave * DC.ar(0.44120943546295), wave * DC.ar(0.14527833461761), wave * DC.ar(0.67494356632233), wave * DC.ar(0.87040853500366)), Silent.ar());
// Variation test code
varVBSDestroyerTrojan233002115 = AtsNoise.ar(Array.fill(2.pow(11), { |i| rrand(-1, 1) }).as(LocalBuf), varVBSDestroyerTrojan2330029 * varVBSDestroyerTrojan2330029, modZ, varVBSDestroyerTrojan23300211, Silent.ar());
varVBSDestroyerTrojan233002115 = Formant.ar(Gendy3.ar(varVBSDestroyerTrojan23300210 * DC.ar(0.93746864795685), varVBSDestroyerTrojan23300213 * DC.ar(0.53566980361938), varVBSDestroyerTrojan23300210 * DC.ar(0.18897175788879), varVBSDestroyerTrojan23300213 * DC.ar(0.49090945720673), varVBSDestroyerTrojan23300214 * DC.ar(0.01410186290741), varVBSDestroyerTrojan23300210 * DC.ar(0.68278706073761), varVBSDestroyerTrojan23300211 * DC.ar(0.22091972827911), varVBSDestroyerTrojan23300213 * DC.ar(0.79971861839294), varVBSDestroyerTrojan23300210 * DC.ar(0.28557312488556), varVBSDestroyerTrojan2330029 * DC.ar(0.31352770328522), varVBSDestroyerTrojan23300211 * DC.ar(0.11780858039856)).exprange(1, SampleRate.ir), WeaklyNonlinear2.ar(varVBSDestroyerTrojan23300212 * DC.ar(0.14705085754395), varVBSDestroyerTrojan23300214 * DC.ar(0.63131463527679), varVBSDestroyerTrojan23300211 * DC.ar(0.99815666675568), varVBSDestroyerTrojan23300213 * DC.ar(0.63608837127686), varVBSDestroyerTrojan23300211 * DC.ar(0.98166966438293), varVBSDestroyerTrojan23300214 * DC.ar(0.1172399520874), varVBSDestroyerTrojan23300212 * DC.ar(0.26772511005402), varVBSDestroyerTrojan23300211 * DC.ar(0.28542196750641), varVBSDestroyerTrojan23300213 * DC.ar(0.85318350791931), varVBSDestroyerTrojan23300212 * DC.ar(0.20987689495087), varVBSDestroyerTrojan2330029 * DC.ar(0.20482790470123), varVBSDestroyerTrojan23300214 * DC.ar(0.7237411737442), varVBSDestroyerTrojan23300214 * DC.ar(0.47842872142792)).exprange(1, SampleRate.ir), varVBSDestroyerTrojan23300211, varVBSDestroyerTrojan23300211, Silent.ar());
varVBSDestroyerTrojan233002115 = TwoTube.ar(varVBSDestroyerTrojan233002115 * varVBSDestroyerTrojan23300213, varVBSDestroyerTrojan23300214 * varVBSDestroyerTrojan23300211, varVBSDestroyerTrojan23300214 * modY, varVBSDestroyerTrojan23300210 * varVBSDestroyerTrojan23300211, varVBSDestroyerTrojan233002115, in, Silent.ar());

signal = varVBSDestroyerTrojan233002115;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// DeadByte.199233003
/////////////////////////////////////////////////////////

SynthDef.new("DeadByte.199233003", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varDeadByte1992330039, varDeadByte19923300310, varDeadByte19923300311, varDeadByte19923300312, varDeadByte19923300313, varDeadByte19923300314;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varDeadByte1992330039 = varDeadByte19923300310 = varDeadByte19923300311 = varDeadByte19923300312 = varDeadByte19923300313 = varDeadByte19923300314 = K2A.ar(t_trig).dup;
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
varDeadByte1992330039 = GVerb.ar(0.78980708122253 * varDeadByte1992330039 * signal, gate, x, varDeadByte19923300314 * varDeadByte19923300313, signal * modX, wave, varDeadByte19923300310, y, gateEnv * varDeadByte19923300313, island, varDeadByte1992330039, Silent.ar());
varDeadByte19923300310 = COsc.ar(Array.fill(2.pow(14), { |i| rrand(-1, 1) }).as(LocalBuf), modX * gateEnv, varDeadByte19923300313 * modX, wave, Silent.ar());
varDeadByte19923300311 = DecodeB2.ar(2, modZ, varDeadByte19923300311 * modX, modZ * signal, island);
varDeadByte19923300312 = AmpComp.ar(varDeadByte19923300311 * env, modZ, in * signal);
varDeadByte19923300313 = OSWrap8.ar(varDeadByte19923300312, modX, 0.044138669967651 * modX * varDeadByte19923300312);
varDeadByte19923300314 = LFClipNoise.ar(wave, Out.ar(wave * DC.ar(0.15326333045959), wave * DC.ar(0.27226066589355)), Silent.ar());
varDeadByte1992330039 = Ball.ar(wave * DC.ar(0.38817059993744), wave * DC.ar(0.68054783344269), wave * DC.ar(0.96738028526306), wave * DC.ar(0.70141708850861));
varDeadByte19923300310 = Convolution2L.ar(wave * DC.ar(0.61436748504639), wave * DC.ar(0.067027568817139), wave * DC.ar(0.08343768119812), wave * DC.ar(0.68195259571075), wave * DC.ar(0.96299803256989), wave * DC.ar(0.50006139278412), wave * DC.ar(0.046925187110901));
varDeadByte19923300311 = A2B.ar(varDeadByte19923300314, modZ * modX, wave * gateEnv, z);
varDeadByte19923300312 = TwoPole.ar(wave * DC.ar(0.94474351406097), wave * DC.ar(0.89067816734314), wave * DC.ar(0.79937970638275), wave * DC.ar(0.53903639316559), wave * DC.ar(0.11801779270172));
varDeadByte19923300313 = RedPhasor.ar(wave * DC.ar(0.22064650058746), wave * DC.ar(0.031752109527588), wave * DC.ar(0.14084184169769), wave * DC.ar(0.75350344181061), wave * DC.ar(0.2342643737793), wave * DC.ar(0.20601606369019), wave * DC.ar(0.38550937175751));
varDeadByte19923300314 = SinGrainI.ar(gateEnv * varDeadByte1992330039, varDeadByte19923300314 * signal, varDeadByte1992330039 * varDeadByte19923300313, bufnum, bufnum, modZ * varDeadByte1992330039, FMGrain.ar(wave * DC.ar(0.76754784584045), wave * DC.ar(0.0014441013336182), wave * DC.ar(0.79097831249237), wave * DC.ar(0.47803938388824), wave * DC.ar(0.43715631961823), wave * DC.ar(0.27768552303314), wave * DC.ar(0.61715698242188)), FoaProximity.ar(wave * DC.ar(0.81052708625793), wave * DC.ar(0.22322452068329), wave * DC.ar(0.27297377586365), wave * DC.ar(0.80691432952881)));

signal = varDeadByte19923300314;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// DeadByte.1992330031
/////////////////////////////////////////////////////////

SynthDef.new("DeadByte.1992330031", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varDeadByte1992330039, varDeadByte19923300310, varDeadByte19923300311, varDeadByte19923300312, varDeadByte19923300313, varDeadByte19923300314, varDeadByte199233003115, varDeadByte199233003116, varDeadByte199233003117, varDeadByte199233003118, varDeadByte199233003119;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varDeadByte1992330039 = varDeadByte19923300310 = varDeadByte19923300311 = varDeadByte19923300312 = varDeadByte19923300313 = varDeadByte19923300314 = varDeadByte199233003115 = varDeadByte199233003116 = varDeadByte199233003117 = varDeadByte199233003118 = varDeadByte199233003119 = K2A.ar(t_trig).dup;
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
varDeadByte1992330039 = Wrap.ar(0.3023362159729 * Balance.ar(wave * DC.ar(0.97146654129028), wave * DC.ar(0.97088491916656), wave * DC.ar(0.24029695987701), wave * DC.ar(0.83154857158661), wave * DC.ar(0.39693343639374), wave * DC.ar(0.83418250083923)), varDeadByte1992330039 * modX, SoftClipAmp8.ar(wave * DC.ar(0.90328013896942), wave * DC.ar(0.075596690177917), wave * DC.ar(0.70585870742798), wave * DC.ar(0.63753128051758)));
varDeadByte19923300310 = FoaZoomX.ar(wave, amp, 0.99887230605057 * modY * gateEnv, Silent.ar());
varDeadByte19923300311 = FMGrainI.ar(modY * varDeadByte199233003118, t_trig, varDeadByte199233003118 * modX, SoftClipAmp4.ar(wave * DC.ar(0.64253103733063), wave * DC.ar(0.044488191604614), wave * DC.ar(0.23728251457214), wave * DC.ar(0.060803651809692)).exprange(1, SampleRate.ir), 0.11030745506287 * modY * varDeadByte199233003116, bufnum, bufnum, modZ * wave, HyperTerrain.ar(wave * DC.ar(0.78856241703033), wave * DC.ar(0.41188609600067), wave * DC.ar(0.20076239109039), wave * DC.ar(0.18839073181152), wave * DC.ar(0.27347660064697), wave * DC.ar(0.34016895294189)), Silent.ar());
varDeadByte19923300312 = BFEncode2.ar(modY * in, gateEnv * varDeadByte1992330039, t_trig, env * varDeadByte199233003117, varDeadByte19923300312, varDeadByte19923300312.sqrdif(TWindex.ar(wave * DC.ar(0.71382629871368), wave * DC.ar(0.7521026134491), wave * DC.ar(0.100417137146))));
varDeadByte19923300313 = Wrap.ar(gate, y, gate);
varDeadByte19923300314 = Convolution3.ar(varDeadByte19923300314, varDeadByte19923300313 * varDeadByte19923300311, wave * varDeadByte19923300312, varDeadByte19923300310 * modY, gateEnv, Silent.ar());
varDeadByte1992330039 = RMShelf2.ar(0.42783534526825 * AmpCompA.ar(wave * DC.ar(0.34599339962006), wave * DC.ar(0.78491520881653), wave * DC.ar(0.12966501712799), wave * DC.ar(0.98455584049225)), FoaZoomX.ar(wave * DC.ar(0.13306796550751), wave * DC.ar(0.67933130264282), wave * DC.ar(0.51523160934448), wave * DC.ar(0.30913376808167)).exprange(1, SampleRate.ir).blend(wave * DC.ar(0.38513016700745), wave * DC.ar(0.06848418712616)), YigClifford3DC.ar(modX * varDeadByte19923300311, modX * gateEnv, Lorenz2DC.ar(wave * DC.ar(0.4431174993515), wave * DC.ar(0.59384846687317), wave * DC.ar(0.29703593254089), wave * DC.ar(0.21982359886169), wave * DC.ar(0.85936427116394), wave * DC.ar(0.81863522529602), wave * DC.ar(0.037962436676025), wave * DC.ar(0.12753188610077), wave * DC.ar(0.29257583618164), wave * DC.ar(0.74152541160583), wave * DC.ar(0.82260513305664)), y, amp, 0.60518383979797 * varDeadByte199233003117 * gateEnv, z, modX * env, Tumble.ar(wave * DC.ar(0.75846898555756), wave * DC.ar(0.78260314464569), wave * DC.ar(0.014073014259338), wave * DC.ar(0.6624675989151), wave * DC.ar(0.17508399486542)), Silent.ar()), FhnTrig.ar(wave * DC.ar(0.38591814041138), wave * DC.ar(0.9634975194931), wave * DC.ar(0.88174843788147), wave * DC.ar(0.94920897483826), wave * DC.ar(0.52495491504669), wave * DC.ar(0.54624140262604), wave * DC.ar(0.039453983306885), wave * DC.ar(0.44893395900726), wave * DC.ar(0.5470324754715), wave * DC.ar(0.54032695293427), wave * DC.ar(0.29128801822662)), Silent.ar());
varDeadByte19923300310 = SinTone.ar(wave * DC.ar(0.73058199882507), wave * DC.ar(0.28757166862488), wave * DC.ar(0.5921505689621), wave * DC.ar(0.77878785133362));
varDeadByte19923300311 = ArrayMax.ar(wave * DC.ar(0.35810673236847));
varDeadByte19923300312 = SVF.ar(modZ * varDeadByte199233003119, modY, env * varDeadByte19923300310, AmplitudeMod.ar(wave * DC.ar(0.46754217147827), wave * DC.ar(0.93907451629639), wave * DC.ar(0.6653813123703), wave * DC.ar(0.34680211544037), wave * DC.ar(0.98454308509827)), in * modX, signal * varDeadByte19923300313, signal * varDeadByte1992330039, 0.17585563659668 * SendTrig.ar(wave * DC.ar(0.39577531814575), wave * DC.ar(0.9280880689621), wave * DC.ar(0.85960793495178)), 0.96832315527369 * varDeadByte199233003119 * varDeadByte19923300314, Silent.ar());
varDeadByte19923300313 = Henon2DL.ar(gateEnv * in, modX, varDeadByte19923300312 * varDeadByte1992330039, varDeadByte19923300314 * modY, wave * signal, varDeadByte199233003117 * wave, HenonL.ar(wave * DC.ar(0.35691940784454), wave * DC.ar(0.73535203933716), wave * DC.ar(0.074750065803528), wave * DC.ar(0.1573988199234), wave * DC.ar(0.87759697437286), wave * DC.ar(0.31621086597443), wave * DC.ar(0.30361819267273)), XOut.ar(wave * DC.ar(0.99855220317841), wave * DC.ar(0.30024933815002), wave * DC.ar(0.84584581851959)));
varDeadByte19923300314 = FoaAsymmetry.ar(wave * DC.ar(0.75504541397095), wave * DC.ar(0.37838387489319), wave * DC.ar(0.063222646713257), wave * DC.ar(0.576167345047));
// Variation test code
varDeadByte199233003115 = XLine.ar(varDeadByte19923300312 * varDeadByte199233003116, varDeadByte19923300312 * varDeadByte199233003117, 0.82508206367493 * Lag2.ar(varDeadByte1992330039 * DC.ar(0.89829981327057), varDeadByte19923300311 * DC.ar(0.97289609909058), varDeadByte1992330039 * DC.ar(0.5064697265625), varDeadByte19923300310 * DC.ar(0.46739709377289)), env, Silent.ar(), x);
varDeadByte199233003116 = ClipNoise.ar(0.95559864086827 * varDeadByte1992330039 * modY, Silent.ar());
varDeadByte199233003117 = RedPhasor.ar(signal * signal, varDeadByte19923300314 * env, env, varDeadByte19923300314 * varDeadByte19923300310, 0.19959354400635 * varDeadByte199233003118 * modX, modZ, amp);
varDeadByte199233003118 = Fhn2DL.ar(signal * varDeadByte19923300312, varDeadByte199233003116 * wave, varDeadByte19923300310 * varDeadByte19923300312, modX, modZ * varDeadByte199233003118.exprange(varDeadByte19923300311 * DC.ar(0.74397623538971), varDeadByte19923300310 * DC.ar(0.71352994441986)), modY, varDeadByte199233003119 * signal, varDeadByte199233003115 * modZ, varDeadByte1992330039 * modX, 0.99976025409906 * varDeadByte199233003115, Silent.ar());
varDeadByte199233003119 = LFClipNoise.ar(varDeadByte19923300314 * modX, 0.99994378405865 * signal * varDeadByte1992330039, Silent.ar());
varDeadByte199233003115 = CombL.ar(island, modZ, modZ, varDeadByte1992330039 * varDeadByte1992330039, 0.99818294202732 * varDeadByte1992330039 * varDeadByte19923300312, Silent.ar());
varDeadByte199233003116 = BufWr.ar([DelayC.ar(varDeadByte19923300312 * DC.ar(0.28835427761078), varDeadByte19923300313 * DC.ar(0.7549592256546), varDeadByte19923300312 * DC.ar(0.81636190414429), varDeadByte19923300313 * DC.ar(0.62337374687195), varDeadByte1992330039 * DC.ar(0.21911656856537)), PosRatio.ar(varDeadByte1992330039 * DC.ar(0.89588701725006), varDeadByte1992330039 * DC.ar(0.84014058113098), varDeadByte19923300311 * DC.ar(0.062543988227844))], Array.fill(2.pow(16), { |i| rrand(-1, 1) }).as(LocalBuf), 0.39921581745148 * WalshHadamard.ar(varDeadByte19923300310 * DC.ar(0.125603556633), varDeadByte19923300310 * DC.ar(0.43297052383423), varDeadByte19923300314 * DC.ar(0.71688485145569), varDeadByte19923300312 * DC.ar(0.79999816417694)), SpruceBudworm.ar(t_trig, amp, varDeadByte199233003115 * varDeadByte19923300312, varDeadByte19923300310 * env.curvelin(varDeadByte19923300313 * DC.ar(0.40906000137329), varDeadByte19923300310 * DC.ar(0.28194892406464), varDeadByte19923300310 * DC.ar(0.77655911445618), varDeadByte19923300313 * DC.ar(0.36791610717773), varDeadByte19923300312 * DC.ar(0.89297676086426), varDeadByte19923300314 * DC.ar(0.60471510887146)), 0.15589904785156 * gateEnv * varDeadByte199233003119, bufnum, varDeadByte19923300310 * in, in * env, Maxamp.ar(varDeadByte1992330039 * DC.ar(0.33674550056458), varDeadByte19923300314 * DC.ar(0.47806465625763)), y, 0.99987238054848 * signal, BHiShelf.ar(varDeadByte19923300312 * DC.ar(0.13400280475616), varDeadByte1992330039 * DC.ar(0.39980590343475), varDeadByte19923300311 * DC.ar(0.03545618057251), varDeadByte19923300314 * DC.ar(0.22068226337433), varDeadByte19923300311 * DC.ar(0.13612818717957), varDeadByte19923300310 * DC.ar(0.24678409099579))));
varDeadByte199233003117 = BufCombC.ar(Array.fill(2.pow(10), { |i| rrand(-1, 1) }).as(LocalBuf), OSTrunc4.ar(OSTrunc8.ar(varDeadByte19923300313 * DC.ar(0.56448268890381), varDeadByte19923300311 * DC.ar(0.072514057159424)), varDeadByte199233003118 * varDeadByte19923300313), varDeadByte1992330039, t_trig, FBSineC.ar(varDeadByte19923300310 * DC.ar(0.42326295375824), varDeadByte19923300313 * DC.ar(0.72475826740265), varDeadByte19923300310 * DC.ar(0.43234527111053), varDeadByte19923300313 * DC.ar(0.42004311084747), varDeadByte19923300312 * DC.ar(0.70274865627289), varDeadByte19923300310 * DC.ar(0.66550862789154), varDeadByte19923300313 * DC.ar(0.62320327758789), varDeadByte1992330039 * DC.ar(0.013435006141663), varDeadByte19923300313 * DC.ar(0.94597375392914)), Silent.ar());
varDeadByte199233003118 = SoftClipAmp8.ar(varDeadByte199233003118, modX * varDeadByte199233003118, 0.98000293092054 * varDeadByte1992330039 * modZ, Silent.ar());
varDeadByte199233003119 = Shaper.ar(Array.fill(2.pow(12), { |i| rrand(-1, 1) }).as(LocalBuf), varDeadByte199233003119 * modZ, modX, SmoothDecimator.ar(varDeadByte19923300313 * DC.ar(0.16537034511566), varDeadByte19923300311 * DC.ar(0.398397564888), varDeadByte19923300311 * DC.ar(0.65618896484375), varDeadByte19923300312 * DC.ar(0.84952819347382), varDeadByte19923300314 * DC.ar(0.9038006067276)));
varDeadByte199233003115 = PitchShift.ar(island, amp, Balance.ar(in, varDeadByte199233003119, 0.67815661430359 * varDeadByte1992330039 * gateEnv, modZ * modY, Instruction.ar(varDeadByte19923300312 * DC.ar(0.0014727115631104), varDeadByte19923300314 * DC.ar(0.63516807556152), varDeadByte1992330039 * DC.ar(0.59692060947418)), Silent.ar()).excess(BufCombN.ar(varDeadByte19923300313 * DC.ar(0.45807290077209), varDeadByte19923300313 * DC.ar(0.50918447971344), varDeadByte19923300314 * DC.ar(0.073252558708191), varDeadByte19923300313 * DC.ar(0.99769067764282), varDeadByte19923300312 * DC.ar(0.12049412727356), varDeadByte19923300314 * DC.ar(0.048433780670166))), varDeadByte199233003118, bufnum, 0.99853486917834 * varDeadByte199233003116 * varDeadByte19923300311, Silent.ar());
varDeadByte199233003116 = Klang.ar(`[[PVInfo.ar(varDeadByte19923300311 * DC.ar(0.52945590019226), varDeadByte19923300314 * DC.ar(0.082698464393616), varDeadByte1992330039 * DC.ar(0.90127813816071), varDeadByte19923300314 * DC.ar(0.016768097877502), varDeadByte19923300311 * DC.ar(0.97003161907196)), LPF1.ar(varDeadByte1992330039 * DC.ar(0.18435406684875), varDeadByte19923300314 * DC.ar(0.41132545471191))], [LatoocarfianTrig.ar(varDeadByte1992330039 * DC.ar(0.1803092956543), varDeadByte1992330039 * DC.ar(0.899249792099), varDeadByte1992330039 * DC.ar(0.40626621246338), varDeadByte1992330039 * DC.ar(0.45018219947815), varDeadByte19923300312 * DC.ar(0.2572181224823), varDeadByte1992330039 * DC.ar(0.69451367855072), varDeadByte19923300313 * DC.ar(0.83147394657135), varDeadByte1992330039 * DC.ar(0.15204000473022), varDeadByte19923300314 * DC.ar(0.79865252971649), varDeadByte19923300310 * DC.ar(0.80851566791534)), WalshHadamard.ar(varDeadByte1992330039 * DC.ar(0.37681674957275), varDeadByte19923300311 * DC.ar(0.41005098819733), varDeadByte19923300313 * DC.ar(0.089494705200195), varDeadByte19923300314 * DC.ar(0.015320658683777))], [CombN.ar(varDeadByte19923300311 * DC.ar(0.50186777114868), varDeadByte19923300311 * DC.ar(0.5231077671051), varDeadByte19923300314 * DC.ar(0.63194465637207), varDeadByte19923300310 * DC.ar(0.43817365169525), varDeadByte19923300310 * DC.ar(0.39123809337616), varDeadByte19923300310 * DC.ar(0.91363310813904)), Convolution3.ar(varDeadByte19923300310 * DC.ar(0.25526356697083), varDeadByte19923300311 * DC.ar(0.63806784152985), varDeadByte19923300311 * DC.ar(0.16750180721283), varDeadByte19923300312 * DC.ar(0.28345263004303), varDeadByte19923300314 * DC.ar(0.44082534313202), varDeadByte19923300314 * DC.ar(0.84457397460938))]], modZ * signal, wave * varDeadByte19923300310);
varDeadByte199233003117 = BRF.ar(bufnum, CombN.ar(varDeadByte19923300310 * DC.ar(0.55373644828796), varDeadByte1992330039 * DC.ar(0.39939153194427), varDeadByte19923300310 * DC.ar(0.62023317813873), varDeadByte19923300312 * DC.ar(0.54003596305847), varDeadByte19923300313 * DC.ar(0.26132917404175), varDeadByte19923300310 * DC.ar(0.11408114433289)).exprange(1, SampleRate.ir), 0.26600801944733 * varDeadByte19923300311 * in, SoftClipAmp8.ar(varDeadByte19923300310 * DC.ar(0.60766088962555), varDeadByte19923300312 * DC.ar(0.85473346710205), varDeadByte19923300314 * DC.ar(0.9741917848587), varDeadByte19923300312 * DC.ar(0.61662268638611)), Silent.ar());
varDeadByte199233003118 = TPV.ar(0.66761720180511 * varDeadByte19923300314 * modX, varDeadByte199233003119.lagud(varDeadByte19923300311 * DC.ar(0.31579864025116), varDeadByte1992330039 * DC.ar(0.36052453517914)), varDeadByte19923300313, varDeadByte19923300310 * varDeadByte199233003115, x, FMHEncode1.ar(varDeadByte19923300312 * DC.ar(0.44319534301758), varDeadByte19923300313 * DC.ar(0.75149488449097), varDeadByte19923300312 * DC.ar(0.37943482398987), varDeadByte1992330039 * DC.ar(0.23525738716125), varDeadByte19923300310 * DC.ar(0.064274311065674), varDeadByte19923300314 * DC.ar(0.82631480693817)), bufnum, env * varDeadByte1992330039, 0.82508913878891 * varDeadByte199233003119 * varDeadByte19923300311, Silent.ar());
varDeadByte199233003119 = Fhn2DN.ar(FreqShift.ar(varDeadByte1992330039 * DC.ar(0.95294237136841), varDeadByte19923300310 * DC.ar(0.87252950668335), varDeadByte1992330039 * DC.ar(0.92645561695099), varDeadByte19923300311 * DC.ar(0.1016138792038), varDeadByte19923300311 * DC.ar(0.45931303501129)).exprange(1, SampleRate.ir), varDeadByte19923300311, varDeadByte199233003118 * modY, gateEnv * varDeadByte19923300313, varDeadByte199233003117, signal * varDeadByte19923300313, varDeadByte19923300314 * varDeadByte1992330039, bufnum, varDeadByte199233003115, 0.99893243724531 * varDeadByte199233003119 * varDeadByte19923300312, Silent.ar());

signal = varDeadByte199233003119;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// MF233003
/////////////////////////////////////////////////////////

SynthDef.new("MF233003", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varMF2330039;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varMF2330039 = K2A.ar(t_trig).dup;
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
varMF2330039 = MembraneCircle.ar(BiPanB2.ar(varMF2330039, gateEnv * modZ, x, in * gateEnv), gate, modX, MembraneHexagon.ar(wave * DC.ar(0.92817139625549), wave * DC.ar(0.44681942462921), wave * DC.ar(0.49111783504486), wave * DC.ar(0.33516073226929), wave * DC.ar(0.32063138484955)), Silent.ar());
varMF2330039 = NL2.ar(wave * DC.ar(0.33726239204407), wave * DC.ar(0.31823265552521), wave * DC.ar(0.32743167877197), wave * DC.ar(0.57615578174591), wave * DC.ar(0.50313353538513), wave * DC.ar(0.39991688728333), wave * DC.ar(0.76855075359344), wave * DC.ar(0.78173243999481));

signal = varMF2330039;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Rythem233004
/////////////////////////////////////////////////////////

SynthDef.new("Rythem233004", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varRythem2330049, varRythem23300410;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varRythem2330049 = varRythem23300410 = K2A.ar(t_trig).dup;
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
varRythem2330049 = Slope.ar(varRythem2330049 * modZ, 0.92201304851961 * varRythem23300410 * varRythem2330049, Silent.ar());
varRythem23300410 = MoogFF.ar(wave * modY, gateEnv * signal, gate, modZ * varRythem23300410, 0.96719447872083 * gateEnv * varRythem23300410, Silent.ar());
varRythem2330049 = Median.ar(modZ * modY, z, 0.90546445754487 * signal * signal, Silent.ar());
varRythem23300410 = FMGrainBF.ar(Lag2UD.ar(wave * DC.ar(0.84413206577301), wave * DC.ar(0.20630931854248), wave * DC.ar(0.53952586650848), wave * DC.ar(0.48485064506531), wave * DC.ar(0.87897861003876)), env, modY, modX * modY, modY, modY * signal, env * wave, amp, 0.38764309883118 * signal, varRythem2330049, Silent.ar().wrap2(DemandEnvGen.ar(wave * DC.ar(0.058540821075439), wave * DC.ar(0.098291873931885), wave * DC.ar(0.060242652893066), wave * DC.ar(0.70691752433777), wave * DC.ar(0.66781258583069), wave * DC.ar(0.79150295257568), wave * DC.ar(0.61332511901855), wave * DC.ar(0.82676792144775), wave * DC.ar(0.34349572658539), wave * DC.ar(0.15388250350952))));

signal = varRythem23300410;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Rythem2330041
/////////////////////////////////////////////////////////

SynthDef.new("Rythem2330041", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varRythem2330049, varRythem23300410, varRythem233004111;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varRythem2330049 = varRythem23300410 = varRythem233004111 = K2A.ar(t_trig).dup;
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
varRythem2330049 = PanAz.ar(2, gate, modY, modZ * gateEnv, modY * varRythem2330049, modY);
varRythem23300410 = CircleRamp.ar(TWindex.ar(wave * DC.ar(0.013226866722107), wave * DC.ar(0.86814057826996), wave * DC.ar(0.48889219760895)), modZ * wave, FoaZoomX.ar(wave * DC.ar(0.94262731075287), wave * DC.ar(0.10161077976227), wave * DC.ar(0.10484337806702), wave * DC.ar(0.28752076625824)), modY, 0.42634858816376 * signal * signal, Silent.ar());
varRythem2330049 = WhiteNoise.ar(BPeakEQ.ar(wave * DC.ar(0.3738317489624), wave * DC.ar(0.80090093612671), wave * DC.ar(0.054505228996277), wave * DC.ar(0.42806446552277), wave * DC.ar(0.093376874923706), wave * DC.ar(0.96861159801483)), Silent.ar());
varRythem23300410 = EnvDetect.ar(signal * gateEnv, in, 0.92817449569702 * varRythem233004111 * modX);
// Variation test code
varRythem233004111 = Delay1.ar(y, AmpComp.ar(varRythem23300410 * DC.ar(0.64758062362671), varRythem2330049 * DC.ar(0.83402800559998), varRythem2330049 * DC.ar(0.4777991771698)), Silent.ar());
varRythem233004111 = CompanderD.ar(bufnum, varRythem233004111 * modX.sqrsum(Beep.ar(varRythem2330049 * DC.ar(0.23541164398193), varRythem23300410 * DC.ar(0.84319508075714))), wave, modZ, IndexL.ar(Array.fill(2.pow(15), { |i| rrand(-1, 1) }).as(LocalBuf), in * varRythem2330049, LatoocarfianL.ar(varRythem2330049 * DC.ar(0.12212669849396), varRythem23300410 * DC.ar(0.081839561462402), varRythem2330049 * DC.ar(0.81751620769501), varRythem2330049 * DC.ar(0.34631216526031), varRythem23300410 * DC.ar(0.46456432342529), varRythem23300410 * DC.ar(0.0070594549179077), varRythem23300410 * DC.ar(0.56716239452362), varRythem23300410 * DC.ar(0.15860199928284), varRythem23300410 * DC.ar(0.22264242172241)), Silent.ar()), modZ * env, RMEQ.ar(varRythem2330049 * DC.ar(0.55459070205688), varRythem2330049 * DC.ar(0.67334568500519), varRythem2330049 * DC.ar(0.7102255821228), varRythem2330049 * DC.ar(0.099339246749878), varRythem23300410 * DC.ar(0.63770163059235), varRythem2330049 * DC.ar(0.6951709985733)), Silent.ar());
varRythem233004111 = BufAllpassC.ar(Array.fill(2.pow(16), { |i| rrand(-1, 1) }).as(LocalBuf), varRythem23300410 * wave, varRythem23300410 * varRythem233004111, gateEnv, 0.97366966809834 * env * modX, Silent.ar());

signal = varRythem233004111;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// W97M.Listi.A233004
/////////////////////////////////////////////////////////

SynthDef.new("W97M.Listi.A233004", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varW97MListiA2330049;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varW97MListiA2330049 = K2A.ar(t_trig).dup;
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
varW97MListiA2330049 = TBrownRand.ar(in, in * in, 0.79179215431213 * modX * in, in * modX, modX * modY, wave, Silent.ar());
varW97MListiA2330049 = Gbman2DL.ar(gateEnv * env, in * env, gateEnv, 0.60544419288635 * Slope.ar(wave * DC.ar(0.71685171127319), wave * DC.ar(0.9346296787262), wave * DC.ar(0.83000230789185)), 0.99859087841402 * in * modZ, Silent.ar());

signal = varW97MListiA2330049;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// WM.Concept.DD233005
/////////////////////////////////////////////////////////

SynthDef.new("WM.Concept.DD233005", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varWMConceptDD2330059, varWMConceptDD23300510;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varWMConceptDD2330059 = varWMConceptDD23300510 = K2A.ar(t_trig).dup;
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
varWMConceptDD2330059 = Instruction.ar(Array.fill(2.pow(15), { |i| rrand(-1, 1) }).as(LocalBuf).lag3ud(wave * DC.ar(0.12258422374725), wave * DC.ar(0.87479937076569)), Gendy5.ar(wave * DC.ar(0.89214110374451), wave * DC.ar(0.99701952934265), wave * DC.ar(0.80010080337524), wave * DC.ar(0.38406574726105), wave * DC.ar(0.54474806785583), wave * DC.ar(0.8460465669632), wave * DC.ar(0.70782589912415), wave * DC.ar(0.65445268154144), wave * DC.ar(0.32089686393738), wave * DC.ar(0.28183555603027), wave * DC.ar(0.60972714424133), wave * DC.ar(0.029800176620483)), Silent.ar());
varWMConceptDD23300510 = CheckBadValues.ar(signal * modX, island, gateEnv * gateEnv);
varWMConceptDD2330059 = LFCub.ar(wave * modZ, DoubleNestedAllpassN.ar(0.27939939498901 * modZ * wave, bufnum, varWMConceptDD23300510, gate, varWMConceptDD2330059 * wave, x, amp, gateEnv * gateEnv, gateEnv * modZ, bufnum, 0.84974910475138 * in * gateEnv, Silent.ar()), 0.82358862728319 * signal, Silent.ar());
varWMConceptDD23300510 = FoaNFC.ar(in * signal, modX * modX, 0.99992320661588 * Duty.ar(wave * DC.ar(0.19166171550751), wave * DC.ar(0.72206747531891), wave * DC.ar(0.72317624092102), wave * DC.ar(0.10128998756409)), Silent.ar());

signal = varWMConceptDD23300510;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// WM.Concept.DD2330051
/////////////////////////////////////////////////////////

SynthDef.new("WM.Concept.DD2330051", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varWMConceptDD2330059, varWMConceptDD23300510, varWMConceptDD233005111;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varWMConceptDD2330059 = varWMConceptDD23300510 = varWMConceptDD233005111 = K2A.ar(t_trig).dup;
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
varWMConceptDD2330059 = HenonN.ar(modX, wave * wave, LinCongC.ar(wave * DC.ar(0.4392147064209), wave * DC.ar(0.14008760452271), wave * DC.ar(0.63334167003632), wave * DC.ar(0.96121954917908), wave * DC.ar(0.23848116397858), wave * DC.ar(0.28379929065704), wave * DC.ar(0.34743988513947)), Henon2DL.ar(wave * DC.ar(0.84049713611603), wave * DC.ar(0.26507341861725), wave * DC.ar(0.70564997196198), wave * DC.ar(0.48763060569763), wave * DC.ar(0.06034791469574), wave * DC.ar(0.21011698246002), wave * DC.ar(0.66448664665222), wave * DC.ar(0.99589335918427)), 0.60459446907043 * gateEnv * varWMConceptDD23300510, varWMConceptDD233005111, Silent.ar());
varWMConceptDD23300510 = FoaNFC.ar(modY, signal, FreeVerb2.ar(wave * DC.ar(0.76921164989471), wave * DC.ar(0.91813218593597), wave * DC.ar(0.10420179367065), wave * DC.ar(0.068651437759399), wave * DC.ar(0.31534194946289), wave * DC.ar(0.76617980003357), wave * DC.ar(0.47202384471893)), NL.ar(wave * DC.ar(0.17359113693237), wave * DC.ar(0.79354667663574), wave * DC.ar(0.65529596805573), wave * DC.ar(0.053231477737427), wave * DC.ar(0.29530346393585), wave * DC.ar(0.3244776725769), wave * DC.ar(0.90847206115723)));
varWMConceptDD2330059 = OSWrap4.ar(varWMConceptDD23300510 * varWMConceptDD23300510, varWMConceptDD23300510 * modY, varWMConceptDD23300510 * varWMConceptDD233005111);
varWMConceptDD23300510 = OnePole.ar(varWMConceptDD2330059 * varWMConceptDD233005111, y, 0.9995035564409 * in * varWMConceptDD233005111, Silent.ar());
// Variation test code
varWMConceptDD233005111 = Henon2DN.ar(MembraneHexagon.ar(varWMConceptDD2330059 * DC.ar(0.91491460800171), varWMConceptDD2330059 * DC.ar(0.40123498439789), varWMConceptDD23300510 * DC.ar(0.14039444923401), varWMConceptDD2330059 * DC.ar(0.5527275800705), varWMConceptDD2330059 * DC.ar(0.03593385219574)).exprange(1, SampleRate.ir), FreqShift.ar(varWMConceptDD23300510 * DC.ar(0.31775426864624), varWMConceptDD23300510 * DC.ar(0.52006280422211), varWMConceptDD23300510 * DC.ar(0.0037198066711426), varWMConceptDD2330059 * DC.ar(0.54600059986115), varWMConceptDD23300510 * DC.ar(0.9772641658783)).exprange(1, SampleRate.ir), in * signal, 0.77600514888763 * gateEnv * modZ, island, modX, signal, Silent.ar());
varWMConceptDD233005111 = LFClipNoise.ar(modY * in, BufGrainB.ar(varWMConceptDD23300510 * DC.ar(0.168665766716), varWMConceptDD2330059 * DC.ar(0.6777446269989), varWMConceptDD2330059 * DC.ar(0.92463147640228), varWMConceptDD2330059 * DC.ar(0.82320010662079), varWMConceptDD2330059 * DC.ar(0.30381774902344), varWMConceptDD2330059 * DC.ar(0.77495396137238), varWMConceptDD23300510 * DC.ar(0.45463955402374), varWMConceptDD23300510 * DC.ar(0.63574254512787), varWMConceptDD2330059 * DC.ar(0.55698156356812)), Silent.ar());
varWMConceptDD233005111 = B2UHJ.ar(wave * varWMConceptDD23300510, signal, modX * in);

signal = varWMConceptDD233005111;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// TPE233006
/////////////////////////////////////////////////////////

SynthDef.new("TPE233006", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varTPE2330069, varTPE23300610;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varTPE2330069 = varTPE23300610 = K2A.ar(t_trig).dup;
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
varTPE2330069 = PlayBuf.ar(2, Array.fill(2.pow(12), { |i| rrand(-1, 1) }).as(LocalBuf), env, in * modZ, modZ, gateEnv * modZ, modY * wave);
varTPE23300610 = StkFlute.ar(signal * signal, amp, 0.46925520896912 * wave * wave, varTPE23300610, env, Silent.ar());
varTPE2330069 = LinCongC.ar(wave * DC.ar(0.91322028636932), wave * DC.ar(0.84181535243988), wave * DC.ar(0.58329725265503), wave * DC.ar(0.15964674949646), wave * DC.ar(0.31370365619659), wave * DC.ar(0.90189921855927), wave * DC.ar(0.86497569084167));
varTPE23300610 = OSFold4.ar(wave * DC.ar(0.52658534049988), wave * DC.ar(0.63773882389069), wave * DC.ar(0.90750181674957));

signal = varTPE23300610;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// W32.Juejue233006
/////////////////////////////////////////////////////////

SynthDef.new("W32.Juejue233006", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varW32Juejue2330069, varW32Juejue23300610;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varW32Juejue2330069 = varW32Juejue23300610 = K2A.ar(t_trig).dup;
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
varW32Juejue2330069 = LoopBuf.ar(2, Array.fill(2.pow(15), { |i| rrand(-1, 1) }).as(LocalBuf), varW32Juejue2330069 * varW32Juejue23300610, t_trig, wave * modY, in, in * gateEnv, signal * varW32Juejue23300610);
varW32Juejue23300610 = TRand.ar(modY * modX, z, modZ);
varW32Juejue2330069 = NestedAllpassL.ar(wave * DC.ar(0.67284524440765), wave * DC.ar(0.32170712947845), wave * DC.ar(0.025388479232788), wave * DC.ar(0.29930281639099), wave * DC.ar(0.40016865730286), wave * DC.ar(0.71946144104004), wave * DC.ar(0.68628287315369), wave * DC.ar(0.94626188278198), wave * DC.ar(0.52677690982819));
varW32Juejue23300610 = Convolution3.ar(wave * DC.ar(0.71820485591888), wave * DC.ar(0.408447265625), wave * DC.ar(0.68391990661621), wave * DC.ar(0.84195876121521), wave * DC.ar(0.10054290294647), wave * DC.ar(0.35705673694611));

signal = varW32Juejue23300610;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Fabulous.1755233007
/////////////////////////////////////////////////////////

SynthDef.new("Fabulous.1755233007", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varFabulous17552330079, varFabulous175523300710, varFabulous175523300711;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varFabulous17552330079 = varFabulous175523300710 = varFabulous175523300711 = K2A.ar(t_trig).dup;
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
varFabulous17552330079 = RMShelf2.ar(varFabulous17552330079 * varFabulous175523300710, env, x, varFabulous17552330079, Silent.ar());
varFabulous175523300710 = Wrap.ar(in * varFabulous17552330079, signal, island);
varFabulous175523300711 = PeakFollower.ar(in * modZ, modZ);
varFabulous17552330079 = DoubleNestedAllpassN.ar(InGrainIBF.ar(wave * DC.ar(0.92376029491425), wave * DC.ar(0.75866568088531), wave * DC.ar(0.32983374595642), wave * DC.ar(0.65571165084839), wave * DC.ar(0.10896337032318), wave * DC.ar(0.50167226791382), wave * DC.ar(0.20591759681702), wave * DC.ar(0.47113585472107), wave * DC.ar(0.37536692619324), wave * DC.ar(0.99704742431641), wave * DC.ar(0.18104922771454), wave * DC.ar(0.16326475143433)), signal * wave, signal * varFabulous175523300711, 0.54017198085785 * varFabulous17552330079 * varFabulous175523300711, varFabulous175523300710 * modX, varFabulous175523300710 * signal, signal, 0.29686450958252 * varFabulous175523300711 * varFabulous17552330079, in, wave * modZ, FoaRotate.ar(wave * DC.ar(0.5827499628067), wave * DC.ar(0.095180749893188), wave * DC.ar(0.53863024711609), wave * DC.ar(0.82397902011871)), Silent.ar());
varFabulous175523300710 = Henon2DC.ar(wave * DC.ar(0.67631793022156), wave * DC.ar(0.22993898391724), wave * DC.ar(0.49547755718231), wave * DC.ar(0.072068214416504), wave * DC.ar(0.0088495016098022), wave * DC.ar(0.97740387916565), wave * DC.ar(0.44913029670715), wave * DC.ar(0.93792700767517));
varFabulous175523300711 = MonoGrainBF.ar(modY * signal, Formlet.ar(wave * DC.ar(0.27894878387451), wave * DC.ar(0.60971713066101), wave * DC.ar(0.97265923023224), wave * DC.ar(0.39796912670135), wave * DC.ar(0.7325131893158), wave * DC.ar(0.74928152561188)), z, y, x, signal * env, env * gateEnv, varFabulous17552330079 * env, varFabulous175523300711 * gateEnv, 0.99998357494929 * env * modY, Silent.ar());

signal = varFabulous175523300711;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// YCTC.1571233007
/////////////////////////////////////////////////////////

SynthDef.new("YCTC.1571233007", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varYCTC15712330079, varYCTC157123300710, varYCTC157123300711, varYCTC157123300712, varYCTC157123300713, varYCTC157123300714;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varYCTC15712330079 = varYCTC157123300710 = varYCTC157123300711 = varYCTC157123300712 = varYCTC157123300713 = varYCTC157123300714 = K2A.ar(t_trig).dup;
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
varYCTC15712330079 = SVF.ar(in * varYCTC157123300712, RMEQ.ar(varYCTC157123300711 * varYCTC15712330079, varYCTC157123300711 * modZ, gateEnv, wave * varYCTC157123300712, 0.68291126448693 * varYCTC157123300710 * varYCTC157123300712, Silent.ar()), varYCTC15712330079, t_trig, 0.66135346889496 * signal * varYCTC157123300710, varYCTC157123300714 * modX, env * modY, varYCTC15712330079 * env, 0.98823830213563 * modY * env.clip2(BufGrainI.ar(wave * DC.ar(0.66861391067505), wave * DC.ar(0.92526423931122), wave * DC.ar(0.42224287986755), wave * DC.ar(0.28022396564484), wave * DC.ar(0.10822355747223), wave * DC.ar(0.18347263336182), wave * DC.ar(0.86523687839508), wave * DC.ar(0.53307604789734), wave * DC.ar(0.79756021499634), wave * DC.ar(0.57651555538177), wave * DC.ar(0.76209008693695))), Silent.ar());
varYCTC157123300710 = MdaPiano.ar(modZ.curvelin(wave * DC.ar(0.73402512073517), wave * DC.ar(0.26162219047546), wave * DC.ar(0.4100968837738), wave * DC.ar(0.68385136127472), wave * DC.ar(0.66739237308502), wave * DC.ar(0.14148283004761)), env * varYCTC157123300714, varYCTC157123300714 * wave, modZ * varYCTC157123300712, varYCTC157123300710, amp, NeedleRect.ar(wave * DC.ar(0.98962962627411), wave * DC.ar(0.68829834461212), wave * DC.ar(0.6962434053421), wave * DC.ar(0.89529776573181), wave * DC.ar(0.92418956756592), wave * DC.ar(0.12535786628723), wave * DC.ar(0.26029932498932)), signal * varYCTC157123300712, modZ * gateEnv, t_trig, t_trig, bufnum, island, varYCTC157123300711 * gateEnv, varYCTC15712330079 * varYCTC157123300713, gateEnv.lag(wave * DC.ar(0.1682915687561), wave * DC.ar(0.21360301971436)), Silent.ar());
varYCTC157123300711 = FMGrainBBF.ar(NestedAllpassN.ar(wave * DC.ar(0.44804918766022), wave * DC.ar(0.42167043685913), wave * DC.ar(0.03717303276062), wave * DC.ar(0.67405414581299), wave * DC.ar(0.19743657112122), wave * DC.ar(0.68647658824921), wave * DC.ar(0.73183417320251), wave * DC.ar(0.93954014778137), wave * DC.ar(0.011515140533447)), gate, modY * signal, varYCTC157123300713, varYCTC157123300712 * modX, bufnum, modX, varYCTC15712330079 * modZ, FoaFocusX.ar(wave * DC.ar(0.38346529006958), wave * DC.ar(0.17590403556824), wave * DC.ar(0.22930955886841), wave * DC.ar(0.55438077449799)), amp, varYCTC15712330079, Silent.ar());
varYCTC157123300712 = Clipper32.ar(gate, z, env * signal);
varYCTC157123300713 = PulseDivider.ar(signal * varYCTC157123300710, modY * varYCTC157123300712.fold(wave * DC.ar(0.84028291702271), wave * DC.ar(0.32927691936493)), env);
varYCTC157123300714 = NLFiltL.ar(0.071940898895264 * signal * gateEnv, varYCTC15712330079 * varYCTC157123300714, env * signal, bufnum, amp, modX, modZ, Silent.ar());
varYCTC15712330079 = Convolution2.ar(gateEnv * varYCTC15712330079.atan2(SinGrainBF.ar(wave * DC.ar(0.77659463882446), wave * DC.ar(0.38804495334625), wave * DC.ar(0.59322381019592), wave * DC.ar(0.84489393234253), wave * DC.ar(0.38684499263763), wave * DC.ar(0.76508104801178), wave * DC.ar(0.98878467082977), wave * DC.ar(0.0626620054245), wave * DC.ar(0.90661060810089))), env * varYCTC157123300710, Allpass1.ar(wave * DC.ar(0.051730751991272), wave * DC.ar(0.25546586513519), wave * DC.ar(0.033573865890503), wave * DC.ar(0.31900227069855)), modZ, in, Silent.ar());
varYCTC157123300710 = Gendy3.ar(wave * DC.ar(0.26507592201233), wave * DC.ar(0.94177281856537), wave * DC.ar(0.4501668214798), wave * DC.ar(0.61130785942078), wave * DC.ar(0.30551087856293), wave * DC.ar(0.22179615497589), wave * DC.ar(0.66981339454651), wave * DC.ar(0.14807236194611), wave * DC.ar(0.97789192199707), wave * DC.ar(0.55928587913513), wave * DC.ar(0.35531270503998));
varYCTC157123300711 = Stepper.ar(wave * gateEnv, varYCTC157123300711 * modX, varYCTC157123300711 * modZ, Integrator.ar(wave * DC.ar(0.24204933643341), wave * DC.ar(0.91732919216156), wave * DC.ar(0.52739274501801), wave * DC.ar(0.88959062099457)), z, y);
varYCTC157123300712 = Henon2DC.ar(env * varYCTC157123300714, gateEnv, varYCTC157123300713, x, in.range(wave * DC.ar(0.18857753276825), wave * DC.ar(0.76252424716949)), in, modZ, Silent.ar());
varYCTC157123300713 = FitzHughNagumo.ar(wave * DC.ar(0.51022732257843), wave * DC.ar(0.15901625156403), wave * DC.ar(0.0047187805175781), wave * DC.ar(0.87514686584473), wave * DC.ar(0.7697331905365), wave * DC.ar(0.90826046466827), wave * DC.ar(0.2351576089859), wave * DC.ar(0.11016118526459), wave * DC.ar(0.78781890869141));
varYCTC157123300714 = FoaTumble.ar(varYCTC157123300714 * modX, 0.32719421386719 * varYCTC157123300710 * modX, varYCTC15712330079, Silent.ar());

signal = varYCTC157123300714;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// PWSTEAL.Trojan233008
/////////////////////////////////////////////////////////

SynthDef.new("PWSTEAL.Trojan233008", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varPWSTEALTrojan2330089, varPWSTEALTrojan23300810, varPWSTEALTrojan23300811, varPWSTEALTrojan23300812;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varPWSTEALTrojan2330089 = varPWSTEALTrojan23300810 = varPWSTEALTrojan23300811 = varPWSTEALTrojan23300812 = K2A.ar(t_trig).dup;
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
varPWSTEALTrojan2330089 = FMGrainBF.ar(gateEnv * varPWSTEALTrojan23300811, varPWSTEALTrojan2330089 * gateEnv, varPWSTEALTrojan23300812 * wave, wave * wave, varPWSTEALTrojan23300811 * modZ, y, bufnum, island, modZ, Slope.ar(wave * DC.ar(0.51808786392212), wave * DC.ar(0.6275886297226), wave * DC.ar(0.076315522193909)), Silent.ar());
varPWSTEALTrojan23300810 = NL.ar(varPWSTEALTrojan23300810, Array.fill(2.pow(10), { |i| rrand(-1, 1) }).as(LocalBuf), Array.fill(2.pow(12), { |i| rrand(-1, 1) }).as(LocalBuf), wave * modY, modY, varPWSTEALTrojan23300812, KmeansToBPSet1.ar(wave * DC.ar(0.76847350597382), wave * DC.ar(0.10204887390137), wave * DC.ar(0.72880280017853), wave * DC.ar(0.077790021896362), wave * DC.ar(0.85295641422272), wave * DC.ar(0.10501730442047), wave * DC.ar(0.49451243877411), wave * DC.ar(0.88320314884186), wave * DC.ar(0.059553265571594), wave * DC.ar(0.24122369289398)));
varPWSTEALTrojan23300811 = AmplitudeMod.ar(varPWSTEALTrojan23300811 * varPWSTEALTrojan23300811, signal, 0.18183612823486 * modX * env, 0.9996553788686 * varPWSTEALTrojan2330089.slew(wave * DC.ar(0.55766773223877), wave * DC.ar(0.49510145187378)), Silent.ar());
varPWSTEALTrojan23300812 = FoaPushX.ar(modY, varPWSTEALTrojan2330089 * modY, RedPhasor2.ar(wave * DC.ar(0.40438938140869), wave * DC.ar(0.16086983680725), wave * DC.ar(0.45998096466064), wave * DC.ar(0.68847358226776), wave * DC.ar(0.30910933017731), wave * DC.ar(0.50511229038239), wave * DC.ar(0.25348079204559)), Silent.ar());
varPWSTEALTrojan2330089 = YigCliffordN.ar(gateEnv * in, varPWSTEALTrojan2330089 * gateEnv, wave * modY, TwoZero.ar(wave * signal, modX * varPWSTEALTrojan23300811, varPWSTEALTrojan2330089 * varPWSTEALTrojan2330089, 0.90936478687985 * modZ, Silent.ar()), modY, modY, 0.78899991512299 * SoftClipAmp.ar(wave * DC.ar(0.19161021709442), wave * DC.ar(0.71450817584991), wave * DC.ar(0.94705092906952), wave * DC.ar(0.23991942405701)), BufWr.ar(wave * DC.ar(0.079986095428467), wave * DC.ar(0.18850791454315), wave * DC.ar(0.6785489320755), wave * DC.ar(0.45904731750488)), Silent.ar());
varPWSTEALTrojan23300810 = FMGrainIBF.ar(env * modX, modY, modZ, NLFiltL.ar(wave * DC.ar(0.027816772460938), wave * DC.ar(0.44239473342896), wave * DC.ar(0.72900092601776), wave * DC.ar(0.46921372413635), wave * DC.ar(0.016161203384399), wave * DC.ar(0.94099617004395), wave * DC.ar(0.79787290096283), wave * DC.ar(0.47588527202606)).exprange(1, SampleRate.ir), modZ, bufnum, bufnum, modY * signal, modX * varPWSTEALTrojan23300812, signal, wave * env, modX * env, varPWSTEALTrojan2330089, Silent.ar());
varPWSTEALTrojan23300811 = Timer.ar(modX * varPWSTEALTrojan23300810);
varPWSTEALTrojan23300812 = PV_JensenAndersen.ar(wave * DC.ar(0.46444606781006), wave * DC.ar(0.38671100139618), wave * DC.ar(0.49351787567139), wave * DC.ar(0.72378277778625), wave * DC.ar(0.82689940929413), wave * DC.ar(0.35663449764252), wave * DC.ar(0.17109036445618));

signal = varPWSTEALTrojan23300812;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// WM.Wazzu.N233008
/////////////////////////////////////////////////////////

SynthDef.new("WM.Wazzu.N233008", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varWMWazzuN2330089, varWMWazzuN23300810, varWMWazzuN23300811, varWMWazzuN23300812, varWMWazzuN23300813, varWMWazzuN23300814, varWMWazzuN23300815;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varWMWazzuN2330089 = varWMWazzuN23300810 = varWMWazzuN23300811 = varWMWazzuN23300812 = varWMWazzuN23300813 = varWMWazzuN23300814 = varWMWazzuN23300815 = K2A.ar(t_trig).dup;
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
varWMWazzuN2330089 = Balance2.ar(env, varWMWazzuN23300810, SmoothDecimator.ar(wave * DC.ar(0.39850676059723), wave * DC.ar(0.21272838115692), wave * DC.ar(0.63519287109375), wave * DC.ar(0.44453823566437), wave * DC.ar(0.036530613899231)), varWMWazzuN23300813 * signal);
varWMWazzuN23300810 = AmpComp.ar(LFSaw.ar(wave * DC.ar(0.21621561050415), wave * DC.ar(0.47560632228851), wave * DC.ar(0.70528340339661), wave * DC.ar(0.99973177909851)).exprange(1, SampleRate.ir), Standard2DC.ar(wave * DC.ar(0.41429841518402), wave * DC.ar(0.96527802944183), wave * DC.ar(0.298135638237), wave * DC.ar(0.79658913612366), wave * DC.ar(0.094555497169495), wave * DC.ar(0.21269869804382), wave * DC.ar(0.036948800086975)), 0.079074382781982 * in * env);
varWMWazzuN23300811 = WalshHadamard.ar(x, varWMWazzuN23300813 * wave, Perlin3.ar(wave * DC.ar(0.10579228401184), wave * DC.ar(0.78014767169952), wave * DC.ar(0.26388883590698)), Silent.ar());
varWMWazzuN23300812 = Clip.ar(wave, env * varWMWazzuN23300811, varWMWazzuN23300813 * modZ);
varWMWazzuN23300813 = Lorenz2DC.ar(varWMWazzuN23300812 * varWMWazzuN23300813, modY, modY * varWMWazzuN23300812, y, varWMWazzuN23300810 * in, varWMWazzuN23300812, island, varWMWazzuN2330089, varWMWazzuN2330089 * env, 0.37711313871909 * varWMWazzuN23300811, Silent.ar());
varWMWazzuN23300814 = RLPF.ar(varWMWazzuN23300815 * varWMWazzuN23300811, env * in, 0.70790922641754 * varWMWazzuN23300813 * modZ, 0.99998843778667 * varWMWazzuN23300811 * varWMWazzuN2330089, Silent.ar());
varWMWazzuN23300815 = InGrainBF.ar(wave * varWMWazzuN23300815, bufnum, env * varWMWazzuN23300815.ring2(BFEncodeSter.ar(wave * DC.ar(0.62840461730957), wave * DC.ar(0.55911958217621), wave * DC.ar(0.92357850074768), wave * DC.ar(0.73076105117798), wave * DC.ar(0.53445017337799), wave * DC.ar(0.28094172477722), wave * DC.ar(0.10148537158966), wave * DC.ar(0.23664748668671))), modY * varWMWazzuN23300813, 0.81545972824097 * in * varWMWazzuN23300810, gateEnv * modX, in, 0.56720826309828 * NLFiltC.ar(wave * DC.ar(0.044921159744263), wave * DC.ar(0.47740340232849), wave * DC.ar(0.15868091583252), wave * DC.ar(0.22739732265472), wave * DC.ar(0.77699649333954), wave * DC.ar(0.36317133903503), wave * DC.ar(0.77761209011078), wave * DC.ar(0.77681457996368)).bitAnd(OnePole.ar(wave * DC.ar(0.94626092910767), wave * DC.ar(0.029704928398132), wave * DC.ar(0.23676443099976), wave * DC.ar(0.88794529438019))), Silent.ar());
varWMWazzuN2330089 = LinCongC.ar(wave * DC.ar(0.85739660263062), wave * DC.ar(0.45450043678284), wave * DC.ar(0.93850445747375), wave * DC.ar(0.64926362037659), wave * DC.ar(0.97328746318817), wave * DC.ar(0.75784432888031), wave * DC.ar(0.52852213382721));
varWMWazzuN23300810 = Fhn2DL.ar(varWMWazzuN23300815 * varWMWazzuN2330089, env * modY, 0.74082481861115 * varWMWazzuN23300814 * varWMWazzuN23300810, varWMWazzuN23300810 * varWMWazzuN23300813, varWMWazzuN2330089, Blip.ar(varWMWazzuN2330089, y, 0.99995173984367 * in * wave, SetResetFF.ar(wave * DC.ar(0.99063503742218), wave * DC.ar(0.21319139003754))), in * modX, modY, varWMWazzuN23300815 * varWMWazzuN23300813, varWMWazzuN23300813, Silent.ar());
varWMWazzuN23300811 = B2A.ar(wave * DC.ar(0.30800879001617), wave * DC.ar(0.95741057395935), wave * DC.ar(0.79264533519745), wave * DC.ar(0.3047798871994));
varWMWazzuN23300812 = WhiteNoise.ar(DelayC.ar(wave * DC.ar(0.52351272106171), wave * DC.ar(0.39968466758728), wave * DC.ar(0.82254648208618), wave * DC.ar(0.72113871574402), wave * DC.ar(0.41937744617462)), Silent.ar());
varWMWazzuN23300813 = LPCVals.ar(Array.fill(2.pow(11), { |i| rrand(-1, 1) }).as(LocalBuf).unipolar(wave * DC.ar(0.48070621490479)), varWMWazzuN23300810);
varWMWazzuN23300814 = B2A.ar(in * varWMWazzuN23300814, gate, varWMWazzuN23300810, 0.53432178497314 * signal * varWMWazzuN23300811);
varWMWazzuN23300815 = BFEncodeSter.ar(wave * DC.ar(0.77754306793213), wave * DC.ar(0.35037577152252), wave * DC.ar(0.081715941429138), wave * DC.ar(0.24122714996338), wave * DC.ar(0.20459032058716), wave * DC.ar(0.88729107379913), wave * DC.ar(0.74789679050446), wave * DC.ar(0.12838232517242));

signal = varWMWazzuN23300815;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// BAT.Small.A233009
/////////////////////////////////////////////////////////

SynthDef.new("BAT.Small.A233009", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varBATSmallA2330099, varBATSmallA23300910, varBATSmallA23300911;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varBATSmallA2330099 = varBATSmallA23300910 = varBATSmallA23300911 = K2A.ar(t_trig).dup;
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
varBATSmallA2330099 = InGrainBBF.ar(COsc.ar(wave * DC.ar(0.43234944343567), wave * DC.ar(0.084222912788391), wave * DC.ar(0.29613673686981), wave * DC.ar(0.20323944091797), wave * DC.ar(0.45457220077515)), env, amp, bufnum, wave, wave, in * modX, gate, modX, Silent.ar());
varBATSmallA23300910 = BufGrainI.ar(modY * signal, gate, bufnum, signal, island, bufnum, bufnum, modY * modX, amp, RedNoise.ar(wave * DC.ar(0.20625412464142), wave * DC.ar(0.36161041259766), wave * DC.ar(0.78652608394623)), Silent.ar());
varBATSmallA23300911 = Metro.ar(wave * wave, varBATSmallA2330099.slew(wave * DC.ar(0.45678544044495), wave * DC.ar(0.83019936084747)), varBATSmallA23300910, Silent.ar());
varBATSmallA2330099 = BufGrainBF.ar(signal * varBATSmallA2330099, modZ, bufnum, signal, amp, wave, varBATSmallA23300911 * signal, z, island.expexp(wave * DC.ar(0.47679245471954), wave * DC.ar(0.73245716094971), wave * DC.ar(0.019187927246094), wave * DC.ar(0.88614201545715), wave * DC.ar(0.16394746303558)), in, 0.96656308639378 * modY * varBATSmallA2330099, Silent.ar());
varBATSmallA23300910 = InGrainIBF.ar(signal * signal, varBATSmallA23300910 * env, varBATSmallA23300910 * modX, bufnum, bufnum, t_trig, in * modX, modZ * signal, 0.53081285953522 * Blip.ar(wave * DC.ar(0.33895039558411), wave * DC.ar(0.059305787086487), wave * DC.ar(0.50253546237946), wave * DC.ar(0.6060653924942)), 0.89351081848145 * varBATSmallA2330099 * modX, 0.6533250916124 * varBATSmallA2330099 * signal.unipolar(wave * DC.ar(0.63668155670166)), Silent.ar());
varBATSmallA23300911 = LFDNoise3.ar(YigCliffordC.ar(wave * DC.ar(0.086580514907837), wave * DC.ar(0.42144525051117), wave * DC.ar(0.63205289840698), wave * DC.ar(0.58100116252899), wave * DC.ar(0.92638289928436), wave * DC.ar(0.31162643432617), wave * DC.ar(0.37150382995605), wave * DC.ar(0.28632485866547), wave * DC.ar(0.99120843410492)).exprange(1, SampleRate.ir), gateEnv, Silent.ar());

signal = varBATSmallA23300911;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// CW.317233011
/////////////////////////////////////////////////////////

SynthDef.new("CW.317233011", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varCW3172330119, varCW31723301110, varCW31723301111;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varCW3172330119 = varCW31723301110 = varCW31723301111 = K2A.ar(t_trig).dup;
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
varCW3172330119 = StandardN.ar(wave, wave * modY, 0.67696809768677 * signal * in, env * in, 0.99960404575184 * modX * wave, Silent.ar());
varCW31723301110 = NTube.ar(0.43104243278503 * modY * env, [Crackle.ar(wave * DC.ar(0.13100588321686), wave * DC.ar(0.74865853786469), wave * DC.ar(0.84600174427032)), Latoocarfian2DN.ar(wave * DC.ar(0.85763478279114), wave * DC.ar(0.50651836395264), wave * DC.ar(0.46123361587524), wave * DC.ar(0.89139008522034), wave * DC.ar(0.39696526527405), wave * DC.ar(0.83181142807007), wave * DC.ar(0.90860199928284), wave * DC.ar(0.30185890197754), wave * DC.ar(0.58612990379333), wave * DC.ar(0.1386102437973))], [MdaPiano.ar(wave * DC.ar(0.34883940219879), wave * DC.ar(0.7626473903656), wave * DC.ar(0.10626196861267), wave * DC.ar(0.97536957263947), wave * DC.ar(0.9287885427475), wave * DC.ar(0.6631031036377), wave * DC.ar(0.25217461585999), wave * DC.ar(0.19027280807495), wave * DC.ar(0.38446259498596), wave * DC.ar(0.062316536903381), wave * DC.ar(0.081321001052856), wave * DC.ar(0.26976215839386), wave * DC.ar(0.87640416622162), wave * DC.ar(0.2526136636734), wave * DC.ar(0.63207197189331), wave * DC.ar(0.043884873390198), wave * DC.ar(0.85103404521942)), LocalOut.ar(wave * DC.ar(0.076383233070374))], [BufGrainIBF.ar(wave * DC.ar(0.63266038894653), wave * DC.ar(0.072152137756348), wave * DC.ar(0.87226152420044), wave * DC.ar(0.3384222984314), wave * DC.ar(0.5966089963913), wave * DC.ar(0.82267117500305), wave * DC.ar(0.87929010391235), wave * DC.ar(0.69209492206573), wave * DC.ar(0.1491003036499), wave * DC.ar(0.95904970169067), wave * DC.ar(0.010588765144348), wave * DC.ar(0.16976678371429), wave * DC.ar(0.68892729282379), wave * DC.ar(0.66143500804901), wave * DC.ar(0.11246824264526)), RedLbyl.ar(wave * DC.ar(0.15526652336121), wave * DC.ar(0.99656426906586), wave * DC.ar(0.67457473278046))], 0.54532246338332 * varCW31723301111, Silent.ar());
varCW31723301111 = PartConv.ar(gate, modX * modZ, Array.fill(2.pow(12), { |i| rrand(-1, 1) }).as(LocalBuf), wave, Silent.ar());
varCW3172330119 = FoaPushY.ar(env * varCW31723301110, modX * signal, wave, Silent.ar());
varCW31723301110 = BHiShelf.ar(wave * DC.ar(0.92335629463196), wave * DC.ar(0.61816382408142), wave * DC.ar(0.83712673187256), wave * DC.ar(0.17292606830597), wave * DC.ar(0.78466868400574), wave * DC.ar(0.34647178649902));
varCW31723301111 = Tumble.ar(z, 0.45981621742249 * varCW3172330119 * wave, signal, modY * varCW31723301111, env);

signal = varCW31723301111;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Orsam233011
/////////////////////////////////////////////////////////

SynthDef.new("Orsam233011", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varOrsam2330119;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varOrsam2330119 = K2A.ar(t_trig).dup;
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
varOrsam2330119 = Atari2600.ar(env, wave, modX * modY, modY * modZ, env * varOrsam2330119.lag3(wave * DC.ar(0.21537041664124), wave * DC.ar(0.24284434318542)), gateEnv * in, signal);
varOrsam2330119 = DecodeB2.ar(2, modX * in, x, signal, t_trig);

signal = varOrsam2330119;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Orsam2330111
/////////////////////////////////////////////////////////

SynthDef.new("Orsam2330111", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varOrsam2330119, varOrsam233011110;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varOrsam2330119 = varOrsam233011110 = K2A.ar(t_trig).dup;
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
varOrsam2330119 = FitzHughNagumo.ar(varOrsam233011110 * wave, env, gateEnv * signal, amp, modY, TIRand.ar(wave * DC.ar(0.20521092414856), wave * DC.ar(0.77685880661011), wave * DC.ar(0.28474009037018)), amp, 0.99996878173353 * modY * env, Silent.ar());
varOrsam2330119 = Breakcore.ar(Array.fill(2.pow(16), { |i| rrand(-1, 1) }).as(LocalBuf), gateEnv * modZ, YigMandelbulbN.ar(wave * DC.ar(0.78528153896332), wave * DC.ar(0.39676630496979), wave * DC.ar(0.99373257160187), wave * DC.ar(0.75562453269958), wave * DC.ar(0.77184963226318), wave * DC.ar(0.69569957256317), wave * DC.ar(0.36594045162201)), modY * in, Klang.ar(`[[AtsPartial.ar(wave * DC.ar(0.80485987663269), wave * DC.ar(0.53041386604309), wave * DC.ar(0.32940220832825), wave * DC.ar(0.30996131896973), wave * DC.ar(0.070322513580322), wave * DC.ar(0.23717141151428), wave * DC.ar(0.64911568164825)), SawDPW.ar(wave * DC.ar(0.59928393363953), wave * DC.ar(0.60320627689362), wave * DC.ar(0.68887901306152), wave * DC.ar(0.62579548358917))], [ArrayMin.ar(wave * DC.ar(0.072710514068604)), MidEQ.ar(wave * DC.ar(0.64049184322357), wave * DC.ar(0.66445410251617), wave * DC.ar(0.74891006946564), wave * DC.ar(0.98788154125214), wave * DC.ar(0.14754223823547), wave * DC.ar(0.099412560462952))], [OSTrunc8.ar(wave * DC.ar(0.89702641963959), wave * DC.ar(0.23933267593384)), DoubleNestedAllpassC.ar(wave * DC.ar(0.81100606918335), wave * DC.ar(0.79148185253143), wave * DC.ar(0.96307933330536), wave * DC.ar(0.66413915157318), wave * DC.ar(0.73666536808014), wave * DC.ar(0.10047149658203), wave * DC.ar(0.44319093227386), wave * DC.ar(0.23882400989532), wave * DC.ar(0.77650737762451), wave * DC.ar(0.27412152290344), wave * DC.ar(0.81331181526184), wave * DC.ar(0.69742000102997))]], Convolution2L.ar(wave * DC.ar(0.098777770996094), wave * DC.ar(0.96098935604095), wave * DC.ar(0.82441520690918), wave * DC.ar(0.29883968830109), wave * DC.ar(0.2555273771286), wave * DC.ar(0.6106470823288), wave * DC.ar(0.40636765956879)).exprange(1, SampleRate.ir), varOrsam233011110));
// Variation test code
varOrsam233011110 = GravityGrid2.ar(amp, 0.67065179347992 * varOrsam2330119 * varOrsam233011110, modY * wave, signal * gateEnv.range(varOrsam2330119 * DC.ar(0.42429721355438), varOrsam2330119 * DC.ar(0.41573584079742)), Array.fill(2.pow(16), { |i| rrand(-1, 1) }).as(LocalBuf), HPZ2.ar(varOrsam2330119 * DC.ar(0.21618807315826), varOrsam2330119 * DC.ar(0.044361710548401), varOrsam2330119 * DC.ar(0.94859492778778)), VOsc.ar(varOrsam2330119 * DC.ar(0.53699171543121), varOrsam2330119 * DC.ar(0.32075917720795), varOrsam2330119 * DC.ar(0.88780796527863), varOrsam2330119 * DC.ar(0.5858439207077), varOrsam2330119 * DC.ar(0.61261868476868)));
varOrsam233011110 = Lag3UD.ar(varOrsam233011110 * signal, modZ, varOrsam233011110, 0.99388456342691 * gateEnv * wave, Silent.ar());
varOrsam233011110 = MoogLadder.ar(varOrsam233011110 * varOrsam2330119, modY * varOrsam2330119, BufGrainBF.ar(env * signal, in, bufnum, wave * wave, bufnum, 0.63758838176727 * gateEnv * modX, island, z, gateEnv * in, 0.89270234107971 * in * varOrsam2330119, Gendy3.ar(varOrsam2330119 * DC.ar(0.057064175605774), varOrsam2330119 * DC.ar(0.084652304649353), varOrsam2330119 * DC.ar(0.87506830692291), varOrsam2330119 * DC.ar(0.20028388500214), varOrsam2330119 * DC.ar(0.41476535797119), varOrsam2330119 * DC.ar(0.61334240436554), varOrsam2330119 * DC.ar(0.52000331878662), varOrsam2330119 * DC.ar(0.43562638759613), varOrsam2330119 * DC.ar(0.93238937854767), varOrsam2330119 * DC.ar(0.60102295875549), varOrsam2330119 * DC.ar(0.46797525882721)), Silent.ar()), 0.99995277529706 * LPZ1.ar(varOrsam2330119 * DC.ar(0.15230309963226), varOrsam2330119 * DC.ar(0.88938796520233), varOrsam2330119 * DC.ar(0.96663880348206)), Silent.ar());

signal = varOrsam233011110;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Bomber.13472330111
/////////////////////////////////////////////////////////

SynthDef.new("Bomber.13472330111", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varBomber13472330119, varBomber134723301110, varBomber134723301111, varBomber1347233011112, varBomber1347233011113, varBomber1347233011114;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varBomber13472330119 = varBomber134723301110 = varBomber134723301111 = varBomber1347233011112 = varBomber1347233011113 = varBomber1347233011114 = K2A.ar(t_trig).dup;
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
varBomber13472330119 = SoftClipAmp.ar(varBomber134723301111 * varBomber13472330119, varBomber1347233011112, signal, Silent.ar());
varBomber134723301110 = Brusselator.ar(0.39106428623199 * wave * gateEnv, bufnum, varBomber13472330119 * gateEnv, island, varBomber1347233011114 * modZ, modX * varBomber13472330119, varBomber134723301110, Silent.ar());
varBomber134723301111 = BFManipulate.ar(signal, signal * wave, 0.8109815120697 * modX * gateEnv, modZ, varBomber134723301110 * gateEnv, AmplitudeMod.ar(wave * modX, signal, signal * in, 0.96895282061883 * varBomber1347233011113 * varBomber1347233011112, Silent.ar()), modY);
varBomber13472330119 = PSinGrain.ar(VOsc.ar(wave * DC.ar(0.105637550354), wave * DC.ar(0.18193054199219), wave * DC.ar(0.19450771808624), wave * DC.ar(0.32732331752777), wave * DC.ar(0.076992273330688)).exprange(1, SampleRate.ir), bufnum, modX * wave);
varBomber134723301110 = BPeakEQ.ar(signal * env, gateEnv * signal, y, varBomber1347233011114 * in, CombN.ar(wave * DC.ar(0.045340180397034), wave * DC.ar(0.88498651981354), wave * DC.ar(0.98938846588135), wave * DC.ar(0.88492321968079), wave * DC.ar(0.31482577323914), wave * DC.ar(0.52516055107117)), Silent.ar());
varBomber134723301111 = Perlin3.ar(wave * DC.ar(0.94239592552185), wave * DC.ar(0.72763204574585), wave * DC.ar(0.1744749546051));
// Variation test code
varBomber1347233011112 = MostChange.ar(wave * env, modX * varBomber134723301111);
varBomber1347233011113 = Pan4.ar(0.72309911251068 * BFEncode2.ar(varBomber134723301110 * DC.ar(0.45184934139252), varBomber134723301111 * DC.ar(0.42247974872589), varBomber13472330119 * DC.ar(0.014849424362183), varBomber13472330119 * DC.ar(0.50870871543884), varBomber134723301111 * DC.ar(0.93593454360962), varBomber13472330119 * DC.ar(0.32722461223602)), modZ * varBomber1347233011114, 0.93070304393768 * modY, DoubleWell3.ar(StkBlowHole.ar(varBomber13472330119 * DC.ar(0.39683091640472), varBomber134723301110 * DC.ar(0.99470138549805), varBomber134723301111 * DC.ar(0.070965528488159), varBomber134723301110 * DC.ar(0.29799270629883), varBomber13472330119 * DC.ar(0.17247295379639), varBomber13472330119 * DC.ar(0.53948593139648), varBomber134723301111 * DC.ar(0.61750793457031), varBomber13472330119 * DC.ar(0.23629331588745)), varBomber13472330119 * varBomber1347233011112, y, varBomber1347233011112 * gateEnv, varBomber1347233011114 * varBomber13472330119, varBomber134723301111 * modY, 0.98101921765086 * varBomber13472330119 * varBomber134723301110, Silent.ar()));
varBomber1347233011114 = MonoGrainBF.ar(0.8636691570282 * varBomber1347233011112 * gateEnv, gateEnv * varBomber1347233011113, varBomber1347233011113, modY, varBomber134723301111 * modZ, y, 0.68075048923492 * varBomber13472330119 * varBomber13472330119, varBomber1347233011113, gate, 0.99997633641179 * LFNoise0.ar(varBomber13472330119 * DC.ar(0.21455121040344), varBomber134723301110 * DC.ar(0.16677367687225), varBomber134723301111 * DC.ar(0.30943310260773)), Silent.ar());
varBomber1347233011112 = FoaPressY.ar(wave, x, 0.94128047022549 * varBomber13472330119 * wave, Silent.ar());
varBomber1347233011113 = AtsPartial.ar(Array.fill(2.pow(14), { |i| rrand(-1, 1) }).as(LocalBuf), env * modY, signal * modY, varBomber1347233011112 * gateEnv, signal, modY, Silent.ar());
varBomber1347233011114 = SoftClipAmp4.ar(signal, gateEnv * modX, 0.71442914006304 * modX * varBomber1347233011113, Silent.ar());
varBomber1347233011112 = LFClipNoise.ar(env * modX, env, Silent.ar());
varBomber1347233011113 = Spring.ar(DynKlang.ar(`[[Peak.ar(varBomber13472330119 * DC.ar(0.22044932842255), varBomber134723301110 * DC.ar(0.98510229587555)), YigCliffordL.ar(varBomber134723301111 * DC.ar(0.31683707237244), varBomber134723301111 * DC.ar(0.15456092357635), varBomber134723301111 * DC.ar(0.18399691581726), varBomber13472330119 * DC.ar(0.38727593421936), varBomber13472330119 * DC.ar(0.44726419448853), varBomber13472330119 * DC.ar(0.461141705513), varBomber13472330119 * DC.ar(0.28526365756989), varBomber13472330119 * DC.ar(0.19024586677551), varBomber13472330119 * DC.ar(0.40872359275818))], [RLPF.ar(varBomber134723301111 * DC.ar(0.41937243938446), varBomber134723301110 * DC.ar(0.23272228240967), varBomber134723301111 * DC.ar(0.71301698684692), varBomber134723301111 * DC.ar(0.62903892993927), varBomber134723301110 * DC.ar(0.29245722293854)), MdaPiano.ar(varBomber134723301110 * DC.ar(0.49831175804138), varBomber134723301111 * DC.ar(0.3819488286972), varBomber13472330119 * DC.ar(0.58837234973907), varBomber134723301110 * DC.ar(0.80416393280029), varBomber134723301110 * DC.ar(0.54174864292145), varBomber134723301111 * DC.ar(0.13517665863037), varBomber134723301110 * DC.ar(0.46308493614197), varBomber134723301111 * DC.ar(0.1489691734314), varBomber13472330119 * DC.ar(0.7777441740036), varBomber134723301111 * DC.ar(0.76285147666931), varBomber134723301110 * DC.ar(0.96094858646393), varBomber134723301111 * DC.ar(0.3659086227417), varBomber134723301111 * DC.ar(0.6135665178299), varBomber134723301110 * DC.ar(0.63183963298798), varBomber134723301111 * DC.ar(0.81957316398621), varBomber134723301110 * DC.ar(0.60537672042847), varBomber134723301110 * DC.ar(0.5009868144989))], [DoubleWell3.ar(varBomber13472330119 * DC.ar(0.13370168209076), varBomber13472330119 * DC.ar(0.18332326412201), varBomber134723301111 * DC.ar(0.93301403522491), varBomber13472330119 * DC.ar(0.75263714790344), varBomber134723301111 * DC.ar(0.25372755527496), varBomber134723301111 * DC.ar(0.35554456710815), varBomber134723301110 * DC.ar(0.39749002456665), varBomber13472330119 * DC.ar(0.82617700099945)), Latch.ar(varBomber134723301110 * DC.ar(0.59389126300812), varBomber134723301110 * DC.ar(0.58630979061127))]], modX * env, modX), varBomber134723301110 * varBomber1347233011114, z);
varBomber1347233011114 = Standard2DC.ar(modX * signal, Lag3UD.ar(varBomber134723301110 * DC.ar(0.608314037323), varBomber13472330119 * DC.ar(0.63174998760223), varBomber134723301110 * DC.ar(0.0048438310623169), varBomber134723301111 * DC.ar(0.74438512325287), varBomber13472330119 * DC.ar(0.48506152629852)).exprange(1, SampleRate.ir), varBomber134723301110, t_trig, signal, 0.93690980200805 * env * modX, Silent.ar());

signal = varBomber1347233011114;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// W32.Pocal233012
/////////////////////////////////////////////////////////

SynthDef.new("W32.Pocal233012", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varW32Pocal2330129, varW32Pocal23301210, varW32Pocal23301211, varW32Pocal23301212;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varW32Pocal2330129 = varW32Pocal23301210 = varW32Pocal23301211 = varW32Pocal23301212 = K2A.ar(t_trig).dup;
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
varW32Pocal2330129 = StkClarinet.ar(modY * varW32Pocal2330129, varW32Pocal2330129 * in, modZ * varW32Pocal2330129, modX * in, t_trig, LFPar.ar(wave * DC.ar(0.45867049694061), wave * DC.ar(0.28599429130554), wave * DC.ar(0.81792616844177), wave * DC.ar(0.52287650108337)), modZ * env, 0.99888462336599 * in, Silent.ar());
varW32Pocal23301210 = Demand.ar(varW32Pocal2330129 * varW32Pocal2330129, in * varW32Pocal23301210, z);
varW32Pocal23301211 = SawDPW.ar(in * wave, varW32Pocal23301211.lag3ud(wave * DC.ar(0.89765214920044), wave * DC.ar(0.32681572437286)), 0.43248474659179 * signal.linlin(wave * DC.ar(0.34602463245392), wave * DC.ar(0.4942911863327), wave * DC.ar(0.53696477413177), wave * DC.ar(0.63929414749146), wave * DC.ar(0.43874228000641)), Silent.ar());
varW32Pocal23301212 = StkVoicForm.ar(signal * wave, modX * varW32Pocal2330129, varW32Pocal2330129, env, modX, island, gateEnv * modY, 0.99997335513203 * wave, Silent.ar().slew(wave * DC.ar(0.0014749765396118), wave * DC.ar(0.32724702358246)));
varW32Pocal2330129 = PeakEQ4.ar(modX * signal, modY * modY, 0.98690986633301 * SkipNeedle.ar(wave * DC.ar(0.14632594585419), wave * DC.ar(0.33239126205444), wave * DC.ar(0.71326637268066)), modZ);
varW32Pocal23301210 = LatoocarfianTrig.ar(varW32Pocal23301211 * gateEnv, AtsNoise.ar(wave * DC.ar(0.081100821495056), wave * DC.ar(0.36722838878632), wave * DC.ar(0.69345498085022), wave * DC.ar(0.23051047325134), wave * DC.ar(0.24224877357483)).exprange(1, SampleRate.ir), varW32Pocal2330129 * varW32Pocal2330129, signal, y, wave * varW32Pocal23301210, varW32Pocal23301211 * wave, RecordBuf.ar(wave * DC.ar(0.80093514919281), wave * DC.ar(0.89615380764008), wave * DC.ar(0.30840837955475), wave * DC.ar(0.53199481964111), wave * DC.ar(0.19080889225006), wave * DC.ar(0.33255898952484), wave * DC.ar(0.86719810962677), wave * DC.ar(0.39942502975464), wave * DC.ar(0.27283346652985)), modZ, Silent.ar());
varW32Pocal23301211 = Convolution2L.ar(wave * DC.ar(0.36871790885925), wave * DC.ar(0.91188538074493), wave * DC.ar(0.27741014957428), wave * DC.ar(0.36045694351196), wave * DC.ar(0.17582726478577), wave * DC.ar(0.75473034381866), wave * DC.ar(0.69808793067932));
varW32Pocal23301212 = StkVoicForm.ar(modX, varW32Pocal23301211 * varW32Pocal23301211, gate, MostChange.ar(wave * DC.ar(0.97861301898956), wave * DC.ar(0.47509324550629)).exprange(1, SampleRate.ir), varW32Pocal2330129 * gateEnv, t_trig, varW32Pocal2330129 * env, 0.99915445690254 * in, Silent.ar());

signal = varW32Pocal23301212;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// IRC.Jany233012
/////////////////////////////////////////////////////////

SynthDef.new("IRC.Jany233012", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varIRCJany2330129, varIRCJany23301210;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varIRCJany2330129 = varIRCJany23301210 = K2A.ar(t_trig).dup;
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
varIRCJany2330129 = SinGrainBF.ar(modY * signal, 0.10299575328827 * varIRCJany2330129 * wave, modZ * in, gate, wave, wave * signal.explin(wave * DC.ar(0.23141396045685), wave * DC.ar(0.84468674659729), wave * DC.ar(0.18380320072174), wave * DC.ar(0.74660634994507), wave * DC.ar(0.66158890724182)), Pluck.ar(wave * DC.ar(0.98234665393829), wave * DC.ar(0.48155462741852), wave * DC.ar(0.64552235603333), wave * DC.ar(0.80355274677277), wave * DC.ar(0.84608721733093), wave * DC.ar(0.63272678852081), wave * DC.ar(0.40943145751953), wave * DC.ar(0.0088344812393188)), 0.95386847656917 * env * modZ, Silent.ar());
varIRCJany23301210 = SMS.ar(modY * wave, in * gateEnv, 0.19558143615723 * varIRCJany23301210 * modZ, 0.058011412620544 * modX * wave, modX, 0.996871885817 * gateEnv * modY, Silent.ar(), signal * varIRCJany23301210, modY * modX, 0.99844508153442 * wave * env, Array.fill(2.pow(11), { |i| rrand(-1, 1) }).as(LocalBuf), EnvDetect.ar(wave * DC.ar(0.13885045051575), wave * DC.ar(0.7823144197464), wave * DC.ar(0.62900352478027)), Silent.ar());
varIRCJany2330129 = BAllPass.ar(modY * modY, Lag2.ar(wave * DC.ar(0.64485585689545), wave * DC.ar(0.55866146087646), wave * DC.ar(0.19748425483704), wave * DC.ar(0.34182643890381)).exprange(1, SampleRate.ir), modX * gateEnv, StandardN.ar(wave * DC.ar(0.17626881599426), wave * DC.ar(0.5918231010437), wave * DC.ar(0.37951529026031), wave * DC.ar(0.49233341217041), wave * DC.ar(0.068065524101257), wave * DC.ar(0.14996528625488)), Silent.ar());
varIRCJany23301210 = BFEncode2.ar(env * modX, signal * varIRCJany23301210, modY, bufnum, 0.67740619182587 * env * modZ, gate);

signal = varIRCJany23301210;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// VVM.205233012
/////////////////////////////////////////////////////////

SynthDef.new("VVM.205233012", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varVVM2052330129, varVVM20523301210, varVVM20523301211;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varVVM2052330129 = varVVM20523301210 = varVVM20523301211 = K2A.ar(t_trig).dup;
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
varVVM2052330129 = LFTri.ar(varVVM20523301210, varVVM20523301211 * gateEnv, 0.9829514333053 * wave * env, Silent.ar());
varVVM20523301210 = CuspN.ar(varVVM20523301210 * gateEnv, y, y, Phasor.ar(env * signal, env, gateEnv * in, modZ * in, varVVM20523301211 * modZ), BRZ2.ar(wave * DC.ar(0.02918529510498), wave * DC.ar(0.71148443222046), wave * DC.ar(0.50197410583496)), Silent.ar());
varVVM20523301211 = CombFormlet.ar(wave, Pokey.ar(wave * DC.ar(0.30478847026825), wave * DC.ar(0.14059209823608), wave * DC.ar(0.23500502109528), wave * DC.ar(0.73987233638763), wave * DC.ar(0.97572147846222), wave * DC.ar(0.72112369537354), wave * DC.ar(0.40766441822052), wave * DC.ar(0.17924642562866), wave * DC.ar(0.90895187854767)).exprange(1, SampleRate.ir), in, modX * varVVM20523301210, signal, Silent.ar(), PitchShift.ar(env * varVVM2052330129, 0.61499226093292 * in * env, gateEnv, env, wave * modY, 0.2296882171205 * varVVM2052330129 * modZ, Silent.ar()));
varVVM2052330129 = GbmanTrig.ar(wave * DC.ar(0.064728617668152), wave * DC.ar(0.49226725101471), wave * DC.ar(0.084589719772339), wave * DC.ar(0.46295809745789), wave * DC.ar(0.12978136539459), wave * DC.ar(0.48970782756805));
varVVM20523301210 = Fhn2DC.ar(wave * wave, modZ * in, varVVM20523301211, gateEnv * modX, 0.51892995834351 * modZ * varVVM20523301210, varVVM2052330129, z, signal, z, signal, Silent.ar());
varVVM20523301211 = FMGrainBF.ar(TwoZero.ar(wave * DC.ar(0.82194769382477), wave * DC.ar(0.088456511497498), wave * DC.ar(0.64041388034821), wave * DC.ar(0.91373181343079), wave * DC.ar(0.036317825317383)), gateEnv * modX, gateEnv * wave, modY * wave, env * varVVM2052330129, Latoocarfian2DC.ar(wave * DC.ar(0.26066946983337), wave * DC.ar(0.019298553466797), wave * DC.ar(0.4060435295105), wave * DC.ar(0.13809955120087), wave * DC.ar(0.020886659622192), wave * DC.ar(0.22181344032288), wave * DC.ar(0.99441027641296), wave * DC.ar(0.82333195209503), wave * DC.ar(0.30508232116699), wave * DC.ar(0.49133265018463)), y, varVVM20523301211 * varVVM2052330129, wave * modY.round(Pluck.ar(wave * DC.ar(0.72793674468994), wave * DC.ar(0.83862519264221), wave * DC.ar(0.22955679893494), wave * DC.ar(0.67068254947662), wave * DC.ar(0.68085634708405), wave * DC.ar(0.67216551303864), wave * DC.ar(0.27173471450806), wave * DC.ar(0.28640615940094))), gateEnv, Silent.ar());

signal = varVVM20523301211;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// VVM.2052330121
/////////////////////////////////////////////////////////

SynthDef.new("VVM.2052330121", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varVVM2052330129, varVVM20523301210, varVVM20523301211, varVVM205233012112, varVVM205233012113, varVVM205233012114;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varVVM2052330129 = varVVM20523301210 = varVVM20523301211 = varVVM205233012112 = varVVM205233012113 = varVVM205233012114 = K2A.ar(t_trig).dup;
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
varVVM2052330129 = Lag2.ar(bufnum, bufnum, 0.76444127528284 * varVVM20523301211 * gateEnv, Silent.ar());
varVVM20523301210 = AY8910.ar(modZ * modZ, amp, varVVM205233012114, RedNoise.ar(wave * DC.ar(0.49737179279327), wave * DC.ar(0.14421093463898), wave * DC.ar(0.76265180110931)), 0.84782385826111 * varVVM205233012112 * signal, varVVM20523301211, modY, modY * modX, bufnum, 0.51555359363556 * wave * varVVM205233012114, 0.32952558994293 * varVVM20523301210 * signal, signal, amp.round(GbmanTrig.ar(wave * DC.ar(0.84939932823181), wave * DC.ar(0.50691366195679), wave * DC.ar(0.27410817146301), wave * DC.ar(0.16282451152802), wave * DC.ar(0.60497164726257), wave * DC.ar(0.64024233818054))), signal, varVVM205233012113 * env);
varVVM20523301211 = Slew.ar(varVVM20523301210, env, varVVM20523301210 * modY, TBrownRand.ar(wave * DC.ar(0.58809792995453), wave * DC.ar(0.59456944465637), wave * DC.ar(0.43573248386383), wave * DC.ar(0.77600371837616), wave * DC.ar(0.57254469394684), wave * DC.ar(0.5373193025589), wave * DC.ar(0.12480592727661)), Silent.ar());
varVVM2052330129 = Summer.ar(varVVM205233012113 * varVVM205233012113, varVVM205233012114 * varVVM20523301211, y, in);
varVVM20523301210 = PanX2D.ar(2, 2, signal * varVVM20523301211, varVVM205233012112 * in, modX, gateEnv * modZ, 0.38672089576721 * modX * varVVM20523301211, varVVM20523301211);
varVVM20523301211 = StkClarinet.ar(wave * DC.ar(0.11273753643036), wave * DC.ar(0.89994609355927), wave * DC.ar(0.28229665756226), wave * DC.ar(0.55658376216888), wave * DC.ar(0.60076642036438), wave * DC.ar(0.22498559951782), wave * DC.ar(0.07166314125061), wave * DC.ar(0.81208086013794), wave * DC.ar(0.0065574645996094));
// Variation test code
varVVM205233012112 = Standard2DC.ar(modZ, in * in, 0.825608253479 * env * signal, 0.97614729404449 * env * env, varVVM20523301211, 0.99997575909197 * CombL.ar(varVVM2052330129 * DC.ar(0.6304395198822), varVVM20523301210 * DC.ar(0.58262884616852), varVVM20523301210 * DC.ar(0.14454197883606), varVVM2052330129 * DC.ar(0.74232006072998), varVVM20523301211 * DC.ar(0.50376784801483), varVVM2052330129 * DC.ar(0.71816027164459)), Silent.ar());
varVVM205233012113 = PanB.ar(in * varVVM20523301210, varVVM205233012112, modX, in * signal);
varVVM205233012114 = QuadN.ar(modY * varVVM205233012112, varVVM205233012112 * signal, varVVM205233012113 * wave, x, modZ * varVVM20523301210, LinCongL.ar(varVVM2052330129 * DC.ar(0.7633581161499), varVVM2052330129 * DC.ar(0.20380818843842), varVVM20523301211 * DC.ar(0.92879867553711), varVVM20523301210 * DC.ar(0.85765361785889), varVVM2052330129 * DC.ar(0.56493067741394), varVVM2052330129 * DC.ar(0.21295607089996), varVVM20523301211 * DC.ar(0.24725615978241)), Silent.ar());
varVVM205233012112 = DelayN.ar(varVVM205233012112 * wave, signal * varVVM205233012112, gate, 0.98192611961956 * varVVM205233012113 * env, Silent.ar());
varVVM205233012113 = StkShakers.ar(gateEnv * gateEnv, gate, island, varVVM2052330129 * varVVM205233012112, signal * env, 0.98414054296044 * varVVM2052330129 * gateEnv, Silent.ar());
varVVM205233012114 = Osc.ar(Array.fill(2.pow(10), { |i| rrand(-1, 1) }).as(LocalBuf), PulseCount.ar(varVVM2052330129 * DC.ar(0.58590829372406), varVVM20523301211 * DC.ar(0.17557013034821)).exprange(1, SampleRate.ir), 0.9505752325058 * ClipNoise.ar(varVVM20523301210 * DC.ar(0.50498020648956), varVVM20523301210 * DC.ar(0.50552988052368)), modZ, Silent.ar());
varVVM205233012112 = BLowShelf.ar(env, TDuty.ar(varVVM20523301210 * DC.ar(0.6873607635498), varVVM20523301211 * DC.ar(0.80358171463013), varVVM2052330129 * DC.ar(0.95308005809784), varVVM20523301210 * DC.ar(0.59843957424164), varVVM2052330129 * DC.ar(0.2758697271347)).exprange(1, SampleRate.ir), 0.69609880447388 * signal, env * signal, 0.94026000731773 * varVVM2052330129, Silent.ar());
varVVM205233012113 = XOut.ar((80 + (island * 2)), modY * varVVM2052330129, [BufDelayL.ar(varVVM20523301210 * DC.ar(0.74433839321136), varVVM20523301210 * DC.ar(0.65967535972595), varVVM20523301211 * DC.ar(0.44052314758301), varVVM2052330129 * DC.ar(0.84344828128815), varVVM2052330129 * DC.ar(0.83825325965881)), TBall.ar(varVVM2052330129 * DC.ar(0.40452015399933), varVVM20523301211 * DC.ar(0.26215887069702), varVVM2052330129 * DC.ar(0.29938089847565), varVVM20523301211 * DC.ar(0.4151668548584))]);
varVVM205233012114 = Friction.ar(modZ, varVVM20523301211 * modY, modX, modY, varVVM20523301211 * signal, OscN.ar(Array.fill(2.pow(16), { |i| rrand(-1, 1) }).as(LocalBuf), varVVM205233012114 * varVVM2052330129, in * modZ, varVVM205233012114, Silent.ar()), 0.99900275187888 * varVVM20523301210 * varVVM205233012114, Silent.ar());

signal = varVVM205233012114;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Tina.826233013
/////////////////////////////////////////////////////////

SynthDef.new("Tina.826233013", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varTina8262330139, varTina82623301310, varTina82623301311, varTina82623301312;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varTina8262330139 = varTina82623301310 = varTina82623301311 = varTina82623301312 = K2A.ar(t_trig).dup;
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
varTina8262330139 = ClipNoise.ar(env, Silent.ar());
varTina82623301310 = CombN.ar(varTina82623301311 * modZ, 0.26182973384857 * CoinGate.ar(wave * DC.ar(0.055273771286011), wave * DC.ar(0.00029146671295166)), varTina82623301311 * env.lag2ud(wave * DC.ar(0.93118119239807), wave * DC.ar(0.76241993904114)), 0.15186047554016 * Fold.ar(wave * DC.ar(0.080437421798706), wave * DC.ar(0.45935904979706), wave * DC.ar(0.46622812747955)), LatoocarfianL.ar(wave * DC.ar(0.74636805057526), wave * DC.ar(0.79733407497406), wave * DC.ar(0.084787726402283), wave * DC.ar(0.035469651222229), wave * DC.ar(0.68475043773651), wave * DC.ar(0.79693305492401), wave * DC.ar(0.70164334774017), wave * DC.ar(0.69085502624512), wave * DC.ar(0.92052686214447)), Silent.ar());
varTina82623301311 = SwitchDelay.ar(bufnum, signal, modZ * varTina82623301312, LocalOut.ar([IFFT.ar(wave * DC.ar(0.6624584197998), wave * DC.ar(0.28387188911438), wave * DC.ar(0.45585811138153)), CrossoverDistortion.ar(wave * DC.ar(0.11697006225586), wave * DC.ar(0.63405525684357), wave * DC.ar(0.7000983953476), wave * DC.ar(0.34934437274933), wave * DC.ar(0.14273512363434))].linlin(wave * DC.ar(0.73569333553314), wave * DC.ar(0.77026033401489), wave * DC.ar(0.49365568161011), wave * DC.ar(0.10553026199341), wave * DC.ar(0.99766063690186))), modY, varTina8262330139 * varTina8262330139, OSTrunc4.ar(wave * DC.ar(0.23794388771057), wave * DC.ar(0.38691997528076)), Silent.ar());
varTina82623301312 = PanB2.ar(modZ * wave, gateEnv * signal, 0.79496955871582 * in * varTina8262330139);
varTina8262330139 = OneZero.ar(wave * DC.ar(0.78193414211273), wave * DC.ar(0.50051474571228), wave * DC.ar(0.26714158058167), wave * DC.ar(0.094753623008728));
varTina82623301310 = FMGrainBF.ar(signal * signal, PulseCount.ar(in * env, modY * modY), SinGrainB.ar(wave * DC.ar(0.37285733222961), wave * DC.ar(0.38276827335358), wave * DC.ar(0.34944355487823), wave * DC.ar(0.80945754051208), wave * DC.ar(0.7298846244812), wave * DC.ar(0.31637167930603)).exprange(1, SampleRate.ir), gateEnv, varTina82623301312 * in, wave * env, y, gateEnv, wave * modZ, 0.28961725195264 * env * signal, Silent.ar());
varTina82623301311 = Spreader.ar(modZ * modZ, varTina82623301310, 0.91020023822784 * varTina82623301312 * signal, LPFVS6.ar(wave * DC.ar(0.17964828014374), wave * DC.ar(0.50114321708679), wave * DC.ar(0.9555469751358)), Silent.ar());
varTina82623301312 = InGrain.ar(signal * varTina82623301312, 0.95244610309601 * FoaPushZ.ar(wave * DC.ar(0.43532037734985), wave * DC.ar(0.92985892295837), wave * DC.ar(0.099332571029663), wave * DC.ar(0.11160123348236)), gateEnv * modZ, 0.99254695812139 * modY * gateEnv.madd(wave * DC.ar(0.88076436519623), wave * DC.ar(0.30583333969116)), Silent.ar());

signal = varTina82623301312;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// DREG.2079233014
/////////////////////////////////////////////////////////

SynthDef.new("DREG.2079233014", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varDREG20792330149;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varDREG20792330149 = K2A.ar(t_trig).dup;
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
varDREG20792330149 = HenonTrig.ar(wave, modX, SN76489.ar(modX, island, varDREG20792330149, modY * in.fold(wave * DC.ar(0.86708307266235), wave * DC.ar(0.28321719169617)), varDREG20792330149, modZ, env * modZ, in, gateEnv * modY), env, gateEnv * in, modZ, env, Lorenz2DC.ar(wave * DC.ar(0.62212121486664), wave * DC.ar(0.40776431560516), wave * DC.ar(0.74607050418854), wave * DC.ar(0.82365822792053), wave * DC.ar(0.56857812404633), wave * DC.ar(0.61953032016754), wave * DC.ar(0.1604231595993), wave * DC.ar(0.960040807724), wave * DC.ar(0.90028929710388), wave * DC.ar(0.42828297615051), wave * DC.ar(0.95843040943146)));
varDREG20792330149 = Formant.ar(wave * DC.ar(0.93325281143188), wave * DC.ar(0.76288282871246), wave * DC.ar(0.46025764942169), wave * DC.ar(0.4275951385498), wave * DC.ar(0.57659268379211));

signal = varDREG20792330149;
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
varDREG20792330149 = PartConv.ar(MeanTriggered.ar(wave * DC.ar(0.88088643550873), wave * DC.ar(0.48221147060394), wave * DC.ar(0.25944674015045), wave * DC.ar(0.12814497947693), wave * DC.ar(0.95844972133636)), env * varDREG20792330149, Array.fill(2.pow(15), { |i| rrand(-1, 1) }).as(LocalBuf), 0.7650141392878 * NLFiltN.ar(wave * DC.ar(0.98696386814117), wave * DC.ar(0.1642678976059), wave * DC.ar(0.1723780632019), wave * DC.ar(0.56101393699646), wave * DC.ar(0.23220574855804), wave * DC.ar(0.97382748126984), wave * DC.ar(0.38779735565186), wave * DC.ar(0.645840883255)), Silent.ar());
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
// Win.Pada.22902330151
/////////////////////////////////////////////////////////

SynthDef.new("Win.Pada.22902330151", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varWinPada22902330159, varWinPada229023301510, varWinPada2290233015111, varWinPada2290233015112, varWinPada2290233015113, varWinPada2290233015114;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varWinPada22902330159 = varWinPada229023301510 = varWinPada2290233015111 = varWinPada2290233015112 = varWinPada2290233015113 = varWinPada2290233015114 = K2A.ar(t_trig).dup;
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
varWinPada22902330159 = ScopeOut.ar([AtsNoise.ar(wave * DC.ar(0.63003218173981), wave * DC.ar(0.39635479450226), wave * DC.ar(0.81711292266846), wave * DC.ar(0.46268343925476), wave * DC.ar(0.30029404163361)), DoubleWell.ar(wave * DC.ar(0.76574754714966), wave * DC.ar(0.57757222652435), wave * DC.ar(0.045514225959778), wave * DC.ar(0.43899893760681), wave * DC.ar(0.51773524284363), wave * DC.ar(0.93002390861511), wave * DC.ar(0.80706298351288), wave * DC.ar(0.68794286251068), wave * DC.ar(0.31730031967163), wave * DC.ar(0.76815366744995))], Array.fill(2.pow(16), { |i| rrand(-1, 1) }).as(LocalBuf));
varWinPada229023301510 = Tumble.ar(varWinPada2290233015112, varWinPada2290233015111, varWinPada2290233015113, varWinPada229023301510 * gateEnv, t_trig);
varWinPada22902330159 = FoaDominateZ.ar(gateEnv * varWinPada2290233015113, in, SetResetFF.ar(wave * DC.ar(0.5474625825882), wave * DC.ar(0.041587591171265)), Silent.ar());
varWinPada229023301510 = AmpCompA.ar(wave * DC.ar(0.77517199516296), wave * DC.ar(0.47968339920044), wave * DC.ar(0.72118484973907), wave * DC.ar(0.59890162944794));
// Variation test code
varWinPada2290233015111 = BufDelayC.ar(Array.fill(2.pow(13), { |i| rrand(-1, 1) }).as(LocalBuf), modX, varWinPada22902330159 * varWinPada229023301510, 0.93273939776047 * Hasher.ar(varWinPada229023301510 * DC.ar(0.19615256786346), varWinPada22902330159 * DC.ar(0.1126754283905), varWinPada22902330159 * DC.ar(0.34718692302704)), Silent.ar());
varWinPada2290233015112 = RosslerL.ar(modX * signal, gateEnv * varWinPada2290233015112, varWinPada2290233015112 * modZ, modZ, varWinPada22902330159, env * varWinPada2290233015113, gateEnv, y, 0.99812042482203 * modZ * gateEnv, Silent.ar());
varWinPada2290233015113 = BFEncode2.ar(signal, 0.07304835319519 * gateEnv * env, Beep.ar(in, env * modX), 0.96755933761597 * varWinPada22902330159 * varWinPada22902330159, signal * signal, modZ * varWinPada2290233015111);
varWinPada2290233015114 = MZPokey.ar(gateEnv * gateEnv, bufnum, modX, varWinPada2290233015114, env * varWinPada22902330159, varWinPada2290233015111, varWinPada2290233015113, modY, varWinPada2290233015114 * varWinPada22902330159);
varWinPada2290233015111 = NL2.ar(varWinPada2290233015112, Array.fill(2.pow(12), { |i| rrand(-1, 1) }).as(LocalBuf), in * varWinPada2290233015111, Decay.ar(varWinPada2290233015113 * gateEnv, signal * modY, in, Silent.ar()), 0.9736385345459 * Phasor.ar(varWinPada22902330159 * DC.ar(0.22604167461395), varWinPada22902330159 * DC.ar(0.53036284446716), varWinPada22902330159 * DC.ar(0.51534795761108), varWinPada22902330159 * DC.ar(0.54216516017914), varWinPada229023301510 * DC.ar(0.36808490753174)), gateEnv, BufGrainI.ar(varWinPada22902330159 * DC.ar(0.81388819217682), varWinPada22902330159 * DC.ar(0.68199980258942), varWinPada22902330159 * DC.ar(0.9642927646637), varWinPada22902330159 * DC.ar(0.49099040031433), varWinPada22902330159 * DC.ar(0.53347504138947), varWinPada229023301510 * DC.ar(0.64417493343353), varWinPada22902330159 * DC.ar(0.095013380050659), varWinPada22902330159 * DC.ar(0.34676313400269), varWinPada229023301510 * DC.ar(0.79606521129608), varWinPada229023301510 * DC.ar(0.85242450237274), varWinPada229023301510 * DC.ar(0.91912364959717)), Silent.ar());
varWinPada2290233015112 = BrownNoise.ar(modZ, Silent.ar());
varWinPada2290233015113 = LPF1.ar(varWinPada229023301510 * varWinPada2290233015112, varWinPada22902330159 * varWinPada22902330159);
varWinPada2290233015114 = Nes2.ar(varWinPada229023301510 * varWinPada2290233015111, 0.24837160110474 * env * modX, gate, Lag.ar(varWinPada22902330159 * signal, modZ, varWinPada22902330159, Silent.ar()), gateEnv * modZ, varWinPada229023301510 * varWinPada2290233015114, wave, varWinPada2290233015114, t_trig, gateEnv * modY, t_trig, gateEnv, modX, 0.93797433376312 * modX, bufnum, gateEnv * wave, varWinPada22902330159 * modX, varWinPada2290233015112, varWinPada2290233015112 * wave, varWinPada229023301510 * in);
varWinPada2290233015111 = BufGrainIBF.ar(modY * varWinPada2290233015114, island, bufnum, varWinPada2290233015112, 0.3954404592514 * modX * gateEnv, bufnum.ring4(BufGrainI.ar(varWinPada22902330159 * DC.ar(0.95509791374207), varWinPada22902330159 * DC.ar(0.15711832046509), varWinPada22902330159 * DC.ar(0.54387676715851), varWinPada22902330159 * DC.ar(0.56427919864655), varWinPada229023301510 * DC.ar(0.67262971401215), varWinPada22902330159 * DC.ar(0.20150125026703), varWinPada22902330159 * DC.ar(0.026589632034302), varWinPada229023301510 * DC.ar(0.19118738174438), varWinPada229023301510 * DC.ar(0.19591748714447), varWinPada229023301510 * DC.ar(0.72697579860687), varWinPada229023301510 * DC.ar(0.069037795066833))), bufnum, env * wave, varWinPada229023301510 * varWinPada2290233015111, island, varWinPada2290233015113 * wave, wave, varWinPada2290233015114, varWinPada2290233015112, Silent.ar());
varWinPada2290233015112 = BFManipulate.ar(bufnum, modZ, 0.088713765144348 * signal * modZ, bufnum, varWinPada2290233015111 * wave, varWinPada229023301510 * gateEnv, wave * env);
varWinPada2290233015113 = PinkNoise.ar(signal, Silent.ar());
varWinPada2290233015114 = FoaFocusZ.ar(wave * wave, env * varWinPada22902330159, 0.99825454541258 * varWinPada2290233015113 * gateEnv, Silent.ar());

signal = varWinPada2290233015114;
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
varXMLarouxDX2330159 = Integrator.ar(varXMLarouxDX2330159 * signal, wave * in, StkPluck.ar(wave * DC.ar(0.14218199253082), wave * DC.ar(0.66103160381317), wave * DC.ar(0.15386855602264), wave * DC.ar(0.63290929794312)), Silent.ar());
varXMLarouxDX2330159 = DetectIndex.ar(Array.fill(2.pow(12), { |i| rrand(-1, 1) }).as(LocalBuf), varXMLarouxDX2330159 * in, modY, Silent.ar());

signal = varXMLarouxDX2330159;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




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
varBlood2330179 = FoaDominateY.ar(varBlood23301710 * modY, BrownNoise.ar(0.9994052038197 * wave * varBlood2330179, Silent.ar()), varBlood23301710, Silent.ar());
varBlood23301710 = FoaTilt.ar(signal * gateEnv, varBlood2330179 * modX, in, Silent.ar().bitOr(BBandStop.ar(wave * DC.ar(0.59522032737732), wave * DC.ar(0.91291832923889), wave * DC.ar(0.62202572822571), wave * DC.ar(0.13478481769562), wave * DC.ar(0.62496721744537))));
varBlood2330179 = Hilbert.ar(0.76815128326416 * modZ * gateEnv, 0.99330389085365 * FoaTilt.ar(wave * DC.ar(0.12853991985321), wave * DC.ar(0.10409510135651), wave * DC.ar(0.0067107677459717), wave * DC.ar(0.3663341999054)), Silent.ar());
varBlood23301710 = PulseCount.ar(env * in, FoaTilt.ar(wave * DC.ar(0.21421587467194), wave * DC.ar(0.094895720481873), wave * DC.ar(0.023848176002502), wave * DC.ar(0.59971845149994)));

signal = varBlood23301710;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Blood2330171
/////////////////////////////////////////////////////////

SynthDef.new("Blood2330171", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varBlood2330179, varBlood23301710, varBlood233017111, varBlood233017112, varBlood233017113, varBlood233017114;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varBlood2330179 = varBlood23301710 = varBlood233017111 = varBlood233017112 = varBlood233017113 = varBlood233017114 = K2A.ar(t_trig).dup;
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
varBlood2330179 = MostChange.ar(env * varBlood233017112, bufnum);
varBlood23301710 = UHJ2B.ar(modX, island);
varBlood2330179 = Ramp.ar(gateEnv, 0.62299001216888 * varBlood233017114 * modX, 0.97813889221791 * wave * varBlood233017112.curvelin(wave * DC.ar(0.47001326084137), wave * DC.ar(0.26973366737366), wave * DC.ar(0.03868305683136), wave * DC.ar(0.59950530529022), wave * DC.ar(0.30890667438507), wave * DC.ar(0.23676550388336)), Silent.ar());
varBlood23301710 = Pokey.ar(wave * DC.ar(0.8130795955658), wave * DC.ar(0.52023994922638), wave * DC.ar(0.83252894878387), wave * DC.ar(0.43308985233307), wave * DC.ar(0.98760783672333), wave * DC.ar(0.92891621589661), wave * DC.ar(0.57629644870758), wave * DC.ar(0.28777647018433), wave * DC.ar(0.73793411254883));
// Variation test code
varBlood233017111 = Concat.ar(varBlood233017114, 0.44422614574432 * varBlood233017114 * gateEnv, modY * varBlood23301710, modZ * varBlood2330179, varBlood23301710, varBlood233017114 * varBlood23301710, in, modY, signal * in, gateEnv * env, wave, signal, 0.22381039705184 * TIRand.ar(varBlood23301710 * DC.ar(0.84119546413422), varBlood23301710 * DC.ar(0.83065402507782), varBlood2330179 * DC.ar(0.55330312252045)), Silent.ar());
varBlood233017112 = RedDPCMdecode.ar(env * varBlood233017111.madd(varBlood2330179 * DC.ar(0.82361149787903), varBlood2330179 * DC.ar(0.77529084682465)).rightShift(FMGrainIBF.ar(varBlood23301710 * DC.ar(0.55424153804779), varBlood2330179 * DC.ar(0.40895485877991), varBlood2330179 * DC.ar(0.71814107894897), varBlood23301710 * DC.ar(0.6712851524353), varBlood2330179 * DC.ar(0.68845665454865), varBlood23301710 * DC.ar(0.14604806900024), varBlood2330179 * DC.ar(0.096925973892212), varBlood23301710 * DC.ar(0.3228759765625), varBlood2330179 * DC.ar(0.12992870807648), varBlood2330179 * DC.ar(0.66865384578705), varBlood23301710 * DC.ar(0.99901759624481), varBlood23301710 * DC.ar(0.22904062271118), varBlood23301710 * DC.ar(0.85502231121063), varBlood23301710 * DC.ar(0.69141042232513))));
varBlood233017113 = LPF1.ar(varBlood233017112 * modY, LatoocarfianC.ar(varBlood2330179 * DC.ar(0.97746121883392), varBlood23301710 * DC.ar(0.1066107749939), varBlood23301710 * DC.ar(0.82881343364716), varBlood23301710 * DC.ar(0.31247997283936), varBlood2330179 * DC.ar(0.19183886051178), varBlood2330179 * DC.ar(0.84751760959625), varBlood23301710 * DC.ar(0.091429948806763), varBlood2330179 * DC.ar(0.19746708869934), varBlood23301710 * DC.ar(0.017950773239136)).exprange(1, SampleRate.ir));
varBlood233017114 = Pluck.ar(bufnum, env * modZ, varBlood23301710, 0.17116510868073 * modY * varBlood2330179, PV_JensenAndersen.ar(Array.fill(2.pow(14), { |i| rrand(-1, 1) }).as(LocalBuf), modX, AudioMSG.ar(varBlood2330179 * DC.ar(0.042119264602661), varBlood2330179 * DC.ar(0.10038065910339), varBlood23301710 * DC.ar(0.2691330909729), varBlood2330179 * DC.ar(0.8800094127655)), varBlood233017114 * varBlood233017113, t_trig, wave * varBlood233017112, wave), x, wave, Silent.ar());
varBlood233017111 = AtsBand.ar(Array.fill(2.pow(15), { |i| rrand(-1, 1) }).as(LocalBuf), varBlood233017114 * gateEnv, env * env.unsignedRightShift(HPZ2.ar(varBlood2330179 * DC.ar(0.43245029449463), varBlood2330179 * DC.ar(0.14026546478271), varBlood23301710 * DC.ar(0.12003302574158))), AmplitudeMod.ar(varBlood2330179 * DC.ar(0.055688261985779), varBlood23301710 * DC.ar(0.19893550872803), varBlood2330179 * DC.ar(0.23195290565491), varBlood2330179 * DC.ar(0.67824816703796), varBlood2330179 * DC.ar(0.15145981311798)), Silent.ar());
varBlood233017112 = TBetaRand.ar(modY, env, modZ * signal, 0.13452482223511 * varBlood233017113, wave * in, 0.09709059740592 * modY * varBlood23301710, Silent.ar());
varBlood233017113 = FreeVerb.ar(varBlood23301710 * modZ, y, varBlood233017111 * varBlood23301710, varBlood233017112, 0.97473663628441 * modY * wave, RMShelf.ar(varBlood23301710 * DC.ar(0.061140537261963), varBlood2330179 * DC.ar(0.083848476409912), varBlood2330179 * DC.ar(0.18862879276276), varBlood23301710 * DC.ar(0.93450951576233), varBlood2330179 * DC.ar(0.42417669296265)));
varBlood233017114 = FMGrainIBF.ar(varBlood233017114 * varBlood233017114, varBlood23301710 * in, YigClifford3DC.ar(varBlood2330179 * DC.ar(0.027517080307007), varBlood23301710 * DC.ar(0.93215262889862), varBlood2330179 * DC.ar(0.39473044872284), varBlood2330179 * DC.ar(0.84349036216736), varBlood2330179 * DC.ar(0.28156054019928), varBlood23301710 * DC.ar(0.30316364765167), varBlood2330179 * DC.ar(0.61009764671326), varBlood23301710 * DC.ar(0.74472463130951), varBlood23301710 * DC.ar(0.2508373260498), varBlood2330179 * DC.ar(0.66114151477814)).exprange(1, SampleRate.ir), DoubleWell.ar(varBlood2330179 * DC.ar(0.98494982719421), varBlood2330179 * DC.ar(0.48248302936554), varBlood23301710 * DC.ar(0.94705665111542), varBlood23301710 * DC.ar(0.19701147079468), varBlood23301710 * DC.ar(0.33926057815552), varBlood23301710 * DC.ar(0.13248956203461), varBlood23301710 * DC.ar(0.83871066570282), varBlood2330179 * DC.ar(0.9445538520813), varBlood23301710 * DC.ar(0.35398685932159), varBlood23301710 * DC.ar(0.69877219200134)).exprange(1, SampleRate.ir), 0.051845788955688 * varBlood233017113 * varBlood233017114, bufnum, bufnum, gate, 0.36646449565887 * Clipper32.ar(varBlood23301710 * DC.ar(0.0093938112258911), varBlood2330179 * DC.ar(0.71391725540161), varBlood2330179 * DC.ar(0.90199971199036)), env.lag(varBlood23301710 * DC.ar(0.10675442218781), varBlood2330179 * DC.ar(0.065285801887512)), YigMandelbulbN.ar(modY * varBlood233017113, modY * varBlood23301710, env * wave, gateEnv * varBlood233017111, bufnum, 0.33474566761192 * modX * varBlood2330179, Silent.ar()), in * modZ, 0.98911164711579 * LinCongC.ar(varBlood2330179 * DC.ar(0.042436838150024), varBlood23301710 * DC.ar(0.60281920433044), varBlood23301710 * DC.ar(0.17583751678467), varBlood2330179 * DC.ar(0.34774160385132), varBlood2330179 * DC.ar(0.49006426334381), varBlood2330179 * DC.ar(0.71744811534882), varBlood2330179 * DC.ar(0.94904112815857)), Silent.ar());
varBlood233017111 = FoaPsychoShelf.ar(0.59991466999054 * env * wave, FoaProximity.ar(varBlood23301710 * DC.ar(0.71290683746338), varBlood23301710 * DC.ar(0.06260073184967), varBlood2330179 * DC.ar(0.084345459938049), varBlood23301710 * DC.ar(0.44993841648102)).exprange(1, SampleRate.ir), 0.93414688110352 * wave * varBlood23301710, varBlood233017112 * gateEnv, 0.99917774251512 * varBlood233017114 * signal, Silent.ar());
varBlood233017112 = AnalyseEvents2.ar(varBlood233017113 * varBlood2330179, Array.fill(2.pow(12), { |i| rrand(-1, 1) }).as(LocalBuf), gateEnv, varBlood233017113 * varBlood233017112, BufCombN.ar(Array.fill(2.pow(15), { |i| rrand(-1, 1) }).as(LocalBuf), varBlood23301710 * varBlood233017113, x.lag2(varBlood2330179 * DC.ar(0.44138920307159), varBlood23301710 * DC.ar(0.23591446876526)), StkMoog.ar(varBlood23301710 * DC.ar(0.09870719909668), varBlood2330179 * DC.ar(0.12113356590271), varBlood2330179 * DC.ar(0.58772897720337), varBlood2330179 * DC.ar(0.35905265808105), varBlood23301710 * DC.ar(0.42409980297089), varBlood23301710 * DC.ar(0.6504944562912), varBlood2330179 * DC.ar(0.20468008518219), varBlood23301710 * DC.ar(0.56395530700684), varBlood2330179 * DC.ar(0.29926252365112)), 0.99895961441824 * wave * wave.trunc(Gendy4.ar(varBlood2330179 * DC.ar(0.97065734863281), varBlood23301710 * DC.ar(0.58075165748596), varBlood23301710 * DC.ar(0.080678820610046), varBlood23301710 * DC.ar(0.15448117256165), varBlood2330179 * DC.ar(0.20494019985199), varBlood2330179 * DC.ar(0.61542987823486), varBlood23301710 * DC.ar(0.69187796115875), varBlood2330179 * DC.ar(0.31745541095734), varBlood2330179 * DC.ar(0.29890775680542), varBlood2330179 * DC.ar(0.43626189231873), varBlood2330179 * DC.ar(0.7116082906723), varBlood23301710 * DC.ar(0.57925951480865))), Silent.ar()), Limiter.ar(gateEnv * gateEnv, SkipNeedle.ar(varBlood23301710 * DC.ar(0.65001881122589), varBlood2330179 * DC.ar(0.88626515865326), varBlood23301710 * DC.ar(0.33765172958374)), varBlood233017111 * varBlood233017114));
varBlood233017113 = GrainFM.ar(2, modY * varBlood233017114, varBlood2330179 * env, varBlood233017113, varBlood233017111 * modY, x, varBlood233017112 * varBlood233017112, bufnum, z, 0.93628373659284 * varBlood233017111 * varBlood23301710, Silent.ar());
varBlood233017114 = DoubleWell.ar(varBlood233017112 * signal.bipolar(varBlood23301710 * DC.ar(0.94871008396149)), gate, 0.89450836181641 * signal * modZ, varBlood2330179 * varBlood23301710, LADSPA.ar(2, varBlood23301710 * wave, z), amp, gate, varBlood233017111 * gateEnv, 0.999848751698 * modX * varBlood23301710, Silent.ar());

signal = varBlood233017114;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// W97M.FF233018
/////////////////////////////////////////////////////////

SynthDef.new("W97M.FF233018", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varW97MFF2330189, varW97MFF23301810, varW97MFF23301811, varW97MFF23301812;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varW97MFF2330189 = varW97MFF23301810 = varW97MFF23301811 = varW97MFF23301812 = K2A.ar(t_trig).dup;
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
varW97MFF2330189 = FincoSprottM.ar(varW97MFF23301811 * varW97MFF23301811, in * modZ, x, varW97MFF23301812, env.lag2(wave * DC.ar(0.43026089668274), wave * DC.ar(0.96520066261292)), gateEnv * varW97MFF23301811, island, 0.9999883071567 * DelayC.ar(wave * DC.ar(0.12561285495758), wave * DC.ar(0.74948239326477), wave * DC.ar(0.037559270858765), wave * DC.ar(0.040821313858032), wave * DC.ar(0.96731305122375)), Silent.ar());
varW97MFF23301810 = Concat2.ar(z, env * varW97MFF23301810, modY * signal, gate, y, gate, x, gateEnv, varW97MFF2330189, varW97MFF23301810 * env.wrap(wave * DC.ar(0.80446124076843), wave * DC.ar(0.065091490745544)), modY * gateEnv, varW97MFF2330189, y, varW97MFF23301812, VMScan2D.ar(wave * DC.ar(0.71808969974518), wave * DC.ar(0.16894745826721), wave * DC.ar(0.5699976682663)));
varW97MFF23301811 = CoinGate.ar(B2Ster.ar(wave * DC.ar(0.35163497924805), wave * DC.ar(0.29692685604095), wave * DC.ar(0.53021728992462), wave * DC.ar(0.42628479003906), wave * DC.ar(0.34294259548187)), 0.17918252944946 * varW97MFF23301810 * varW97MFF2330189);
varW97MFF23301812 = SendTrig.ar(0.10882306098938 * modX * in, RunningMax.ar(wave * DC.ar(0.60349142551422), wave * DC.ar(0.84239149093628)), in * wave);
varW97MFF2330189 = YigCliffordC.ar(modX * signal, y.linexp(wave * DC.ar(0.94713318347931), wave * DC.ar(0.045397639274597), wave * DC.ar(0.063942432403564), wave * DC.ar(0.013374209403992), wave * DC.ar(0.85632431507111)), gate.fold(wave * DC.ar(0.15722453594208), wave * DC.ar(0.95212483406067)), t_trig, in * modZ, 0.082275867462158 * modZ * in, modX * modY, modX, Silent.ar());
varW97MFF23301810 = Duty.ar(varW97MFF23301810, gateEnv * varW97MFF23301810.wrap(wave * DC.ar(0.75805234909058), wave * DC.ar(0.72241520881653)), modX, 0.85520315170288 * in * in);
varW97MFF23301811 = DoubleWell3.ar(0.57383751869202 * wave * varW97MFF23301812, island, in, modY * gateEnv, z, modX * modY, SinGrainI.ar(wave * DC.ar(0.98650646209717), wave * DC.ar(0.96553122997284), wave * DC.ar(0.53664410114288), wave * DC.ar(0.055180907249451), wave * DC.ar(0.8051905632019), wave * DC.ar(0.17588603496552), wave * DC.ar(0.51993465423584), wave * DC.ar(0.85022616386414)), Silent.ar());
varW97MFF23301812 = LFNoise1.ar(TIRand.ar(wave * DC.ar(0.23378586769104), wave * DC.ar(0.82583177089691), wave * DC.ar(0.4616756439209)).exprange(1, SampleRate.ir), 0.99974980803349 * varW97MFF23301812 * varW97MFF23301810, Silent.ar());

signal = varW97MFF23301812;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Dei.1948233018
/////////////////////////////////////////////////////////

SynthDef.new("Dei.1948233018", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varDei19482330189;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varDei19482330189 = K2A.ar(t_trig).dup;
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
varDei19482330189 = FoaPressX.ar(in, 0.65769982337952 * in * env, LinCongN.ar(wave * DC.ar(0.35550081729889), wave * DC.ar(0.34308040142059), wave * DC.ar(0.41935789585114), wave * DC.ar(0.96199107170105), wave * DC.ar(0.16299962997437), wave * DC.ar(0.3754734992981), wave * DC.ar(0.56383657455444)), BFEncodeSter.ar(wave * DC.ar(0.38386130332947), wave * DC.ar(0.91645991802216), wave * DC.ar(0.48133850097656), wave * DC.ar(0.99111270904541), wave * DC.ar(0.9808257818222), wave * DC.ar(0.41158485412598), wave * DC.ar(0.42221641540527), wave * DC.ar(0.40729951858521)));
varDei19482330189 = LinExp.ar(gate, modY * modZ, gate, z, modY * in);

signal = varDei19482330189;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Dei.19482330181
/////////////////////////////////////////////////////////

SynthDef.new("Dei.19482330181", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varDei19482330189, varDei1948233018110;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varDei19482330189 = varDei1948233018110 = K2A.ar(t_trig).dup;
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
varDei19482330189 = InsideOut.ar(in * signal, 0.99303014295301 * gateEnv * varDei1948233018110, Silent.ar());
varDei19482330189 = TBall.ar(z, gate, modY * env, varDei1948233018110 * modY);
// Variation test code
varDei1948233018110 = LinCongL.ar(varDei19482330189, wave, modY, modY * in, amp, RLPF.ar(varDei19482330189 * DC.ar(0.86983048915863), varDei19482330189 * DC.ar(0.85311937332153), varDei19482330189 * DC.ar(0.52146446704865), varDei19482330189 * DC.ar(0.54460203647614), varDei19482330189 * DC.ar(0.72003221511841)), Silent.ar());
varDei1948233018110 = HenonL.ar(FoaPressX.ar(varDei19482330189 * DC.ar(0.23512887954712), varDei19482330189 * DC.ar(0.041672587394714), varDei19482330189 * DC.ar(0.71669888496399), varDei19482330189 * DC.ar(0.1165509223938)).exprange(1, SampleRate.ir), varDei19482330189 * modZ, gateEnv * varDei1948233018110, 0.77116429805756 * modX * varDei19482330189, modX, 0.99606720100519 * env * varDei1948233018110, Silent.ar());
varDei1948233018110 = Sweep.ar(wave * env, 0.52092492580414 * env * signal);

signal = varDei1948233018110;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// XM.Laroux.KT233019
/////////////////////////////////////////////////////////

SynthDef.new("XM.Laroux.KT233019", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varXMLarouxKT2330199, varXMLarouxKT23301910;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varXMLarouxKT2330199 = varXMLarouxKT23301910 = K2A.ar(t_trig).dup;
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
varXMLarouxKT2330199 = ClipNoise.ar(0.99900483801558 * gateEnv * wave, Silent.ar());
varXMLarouxKT23301910 = BufDelayN.ar(Array.fill(2.pow(13), { |i| rrand(-1, 1) }).as(LocalBuf), in * modX, modZ * varXMLarouxKT2330199, CoinGate.ar(wave * DC.ar(0.090769529342651), wave * DC.ar(0.014753222465515)), Silent.ar());
varXMLarouxKT2330199 = BufRd.ar(2, Array.fill(2.pow(15), { |i| rrand(-1, 1) }).as(LocalBuf), varXMLarouxKT23301910, wave.fold(wave * DC.ar(0.35828757286072), wave * DC.ar(0.92290818691254)), ZeroCrossing.ar(wave * DC.ar(0.42801177501678)));
varXMLarouxKT23301910 = BFDecode1.ar(wave * DC.ar(0.19425356388092), wave * DC.ar(0.21654725074768), wave * DC.ar(0.34707748889923), wave * DC.ar(0.19346237182617), wave * DC.ar(0.99680924415588), wave * DC.ar(0.93800175189972), wave * DC.ar(0.37125623226166), wave * DC.ar(0.68453764915466), wave * DC.ar(0.045803904533386));

signal = varXMLarouxKT23301910;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// hllp.Arian.8936233019
/////////////////////////////////////////////////////////

SynthDef.new("hllp.Arian.8936233019", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varhllpArian89362330199, varhllpArian893623301910, varhllpArian893623301911, varhllpArian893623301912, varhllpArian893623301913;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varhllpArian89362330199 = varhllpArian893623301910 = varhllpArian893623301911 = varhllpArian893623301912 = varhllpArian893623301913 = K2A.ar(t_trig).dup;
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
varhllpArian89362330199 = B2UHJ.ar(env * signal, modY, varhllpArian893623301912 * modZ);
varhllpArian893623301910 = RHPF.ar(varhllpArian893623301912 * varhllpArian893623301913, RegaliaMitraEQ.ar(wave * DC.ar(0.011176943778992), wave * DC.ar(0.27829265594482), wave * DC.ar(0.81485605239868), wave * DC.ar(0.9558492898941), wave * DC.ar(0.014732718467712), wave * DC.ar(0.51382160186768)).exprange(1, SampleRate.ir), varhllpArian893623301911 * modY, 0.99892155720849 * varhllpArian89362330199 * modY, Silent.ar());
varhllpArian893623301911 = APF.ar(in, Gate.ar(wave * DC.ar(0.16723716259003), wave * DC.ar(0.7520227432251)).exprange(1, SampleRate.ir).range(wave * DC.ar(0.84202229976654), wave * DC.ar(0.63341867923737)), modX, 0.94871762934492 * gateEnv * in, Silent.ar());
varhllpArian893623301912 = LFGauss.ar(in * modZ, varhllpArian893623301913 * modX, RunningMax.ar(wave * DC.ar(0.17416846752167), wave * DC.ar(0.44561922550201)), varhllpArian893623301910, varhllpArian89362330199 * modX);
varhllpArian893623301913 = BAllPass.ar(varhllpArian893623301910 * modY, MoogFF.ar(wave * DC.ar(0.13595986366272), wave * DC.ar(0.11277115345001), wave * DC.ar(0.44018816947937), wave * DC.ar(0.90800666809082), wave * DC.ar(0.35812020301819), wave * DC.ar(0.35738885402679)).exprange(1, SampleRate.ir), gateEnv * modX, 0.99997026831563 * FoaPressZ.ar(wave * DC.ar(0.56887936592102), wave * DC.ar(0.044553756713867), wave * DC.ar(0.3890335559845), wave * DC.ar(0.49105286598206)), Silent.ar());
varhllpArian89362330199 = EnvDetect.ar(wave * varhllpArian89362330199, LTI.ar(modZ * in, Array.fill(2.pow(15), { |i| rrand(-1, 1) }).as(LocalBuf), Array.fill(2.pow(12), { |i| rrand(-1, 1) }).as(LocalBuf), 0.60845173243348 * gateEnv * varhllpArian893623301912, Silent.ar()), z);
varhllpArian893623301910 = AudioMSG.ar(wave * DC.ar(0.9550404548645), wave * DC.ar(0.42002391815186), wave * DC.ar(0.48123204708099), wave * DC.ar(0.77720606327057));
varhllpArian893623301911 = LFGauss.ar(wave * DC.ar(0.73325097560883), wave * DC.ar(0.44071650505066), wave * DC.ar(0.10391736030579), wave * DC.ar(0.31766057014465), wave * DC.ar(0.78977334499359));
varhllpArian893623301912 = MembraneHexagon.ar(wave * DC.ar(0.78329396247864), wave * DC.ar(0.62102997303009), wave * DC.ar(0.58442068099976), wave * DC.ar(0.36273801326752), wave * DC.ar(0.074002504348755));
varhllpArian893623301913 = RunningSum.ar(modX, 0.28408467769623 * RMShelf2.ar(wave * DC.ar(0.35217046737671), wave * DC.ar(0.24372959136963), wave * DC.ar(0.2941837310791), wave * DC.ar(0.95073056221008), wave * DC.ar(0.38451683521271)));

signal = varhllpArian893623301913;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Backdoor.Botex233019
/////////////////////////////////////////////////////////

SynthDef.new("Backdoor.Botex233019", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varBackdoorBotex2330199;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varBackdoorBotex2330199 = K2A.ar(t_trig).dup;
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
varBackdoorBotex2330199 = Vibrato.ar(modZ, modZ * modZ, wave, island, 0.66746258735657 * env * wave.wrap(wave * DC.ar(0.92968654632568), wave * DC.ar(0.6811625957489)), varBackdoorBotex2330199 * modZ, 0.16886329650879 * in, island);
varBackdoorBotex2330199 = BMoog.ar(wave * DC.ar(0.30166292190552), wave * DC.ar(0.77224135398865), wave * DC.ar(0.43379247188568), wave * DC.ar(0.50189685821533), wave * DC.ar(0.23935770988464), wave * DC.ar(0.025989532470703), wave * DC.ar(0.084885478019714));

signal = varBackdoorBotex2330199;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Anticad.4096.F233019
/////////////////////////////////////////////////////////

SynthDef.new("Anticad.4096.F233019", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varAnticad4096F2330199, varAnticad4096F23301910, varAnticad4096F23301911;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varAnticad4096F2330199 = varAnticad4096F23301910 = varAnticad4096F23301911 = K2A.ar(t_trig).dup;
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
varAnticad4096F2330199 = AllpassN.ar(wave, varAnticad4096F2330199 * modX, in, FoaFocusX.ar(wave * DC.ar(0.16115486621857), wave * DC.ar(0.57935500144958), wave * DC.ar(0.76000785827637), wave * DC.ar(0.51874852180481)), 0.99988532874751 * wave * signal, Latoocarfian2DL.ar(wave * DC.ar(0.27771055698395), wave * DC.ar(0.83690989017487), wave * DC.ar(0.78374660015106), wave * DC.ar(0.29332435131073), wave * DC.ar(0.96263468265533), wave * DC.ar(0.37368309497833), wave * DC.ar(0.020210385322571), wave * DC.ar(0.96607446670532), wave * DC.ar(0.35603260993958), wave * DC.ar(0.42447221279144)));
varAnticad4096F23301910 = EnvDetect.ar(gateEnv * varAnticad4096F23301911, modX * varAnticad4096F23301910, x);
varAnticad4096F23301911 = BBandStop.ar(gateEnv.lag2(wave * DC.ar(0.45668637752533), wave * DC.ar(0.33066010475159)), varAnticad4096F2330199, in * varAnticad4096F23301910, env, Silent.ar().bitOr(BufAllpassC.ar(wave * DC.ar(0.74188697338104), wave * DC.ar(0.84412133693695), wave * DC.ar(0.19960200786591), wave * DC.ar(0.47896814346313), wave * DC.ar(0.88702392578125), wave * DC.ar(0.034521818161011))));
varAnticad4096F2330199 = PVInfo.ar(Array.fill(2.pow(10), { |i| rrand(-1, 1) }).as(LocalBuf), signal * env, wave, 0.99992613661286 * BufCombC.ar(wave * DC.ar(0.10375988483429), wave * DC.ar(0.8460031747818), wave * DC.ar(0.84333729743958), wave * DC.ar(0.28008890151978), wave * DC.ar(0.48594760894775), wave * DC.ar(0.20270264148712)), Silent.ar());
varAnticad4096F23301910 = Ringz.ar(modZ * env, varAnticad4096F23301911 * varAnticad4096F23301910, wave, modY, Silent.ar());
varAnticad4096F23301911 = Changed.ar(modX * in, varAnticad4096F23301910 * modY.ring2(Rotate.ar(wave * DC.ar(0.75630712509155), wave * DC.ar(0.0051928758621216), wave * DC.ar(0.25255084037781), wave * DC.ar(0.18854522705078), wave * DC.ar(0.6746518611908))));

signal = varAnticad4096F23301911;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Anticad.4096.F2330191
/////////////////////////////////////////////////////////

SynthDef.new("Anticad.4096.F2330191", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varAnticad4096F2330199, varAnticad4096F23301910, varAnticad4096F23301911, varAnticad4096F233019112;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varAnticad4096F2330199 = varAnticad4096F23301910 = varAnticad4096F23301911 = varAnticad4096F233019112 = K2A.ar(t_trig).dup;
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
varAnticad4096F2330199 = Wrap.ar(varAnticad4096F23301911 * varAnticad4096F2330199, modZ * varAnticad4096F23301910, varAnticad4096F23301910 * in);
varAnticad4096F23301910 = DelTapWr.ar(Array.fill(2.pow(11), { |i| rrand(-1, 1) }).as(LocalBuf), bufnum);
varAnticad4096F23301911 = Tap.ar(Array.fill(2.pow(11), { |i| rrand(-1, 1) }).as(LocalBuf), 2, varAnticad4096F23301911 * varAnticad4096F23301911);
varAnticad4096F2330199 = QuadN.ar(varAnticad4096F23301911, varAnticad4096F23301911, modX, env * modY, y, wave, Silent.ar());
varAnticad4096F23301910 = InsideOut.ar(wave * DC.ar(0.061137318611145), wave * DC.ar(0.49232196807861), wave * DC.ar(0.37570571899414));
varAnticad4096F23301911 = SelectL.ar(varAnticad4096F233019112 * gateEnv, [Standard2DL.ar(wave * DC.ar(0.9462593793869), wave * DC.ar(0.036675214767456), wave * DC.ar(0.42531168460846), wave * DC.ar(0.15624630451202), wave * DC.ar(0.55949234962463), wave * DC.ar(0.074922800064087), wave * DC.ar(0.16268026828766)), DelayC.ar(wave * DC.ar(0.55501711368561), wave * DC.ar(0.358722448349), wave * DC.ar(0.13678884506226), wave * DC.ar(0.65041089057922), wave * DC.ar(0.14486193656921))]);
// Variation test code
varAnticad4096F233019112 = PartConv.ar(gateEnv.lag(varAnticad4096F23301911 * DC.ar(0.87747716903687), varAnticad4096F2330199 * DC.ar(0.53089666366577)), FSinOsc.ar(varAnticad4096F23301911, env * env, signal, Silent.ar()), Array.fill(2.pow(16), { |i| rrand(-1, 1) }).as(LocalBuf).wrap(varAnticad4096F23301911 * DC.ar(0.7676008939743), varAnticad4096F2330199 * DC.ar(0.57438051700592)), 0.9999676338743 * in * varAnticad4096F23301911, BrownNoise.ar(varAnticad4096F2330199 * DC.ar(0.41616833209991), varAnticad4096F23301910 * DC.ar(0.87293493747711)));
varAnticad4096F233019112 = AtsSynth.ar(Array.fill(2.pow(12), { |i| rrand(-1, 1) }).as(LocalBuf), env, z, Gbman2DN.ar(SinOsc.ar(varAnticad4096F2330199 * DC.ar(0.40701138973236), varAnticad4096F2330199 * DC.ar(0.88641238212585), varAnticad4096F23301911 * DC.ar(0.45205497741699), varAnticad4096F2330199 * DC.ar(0.66425406932831)).exprange(1, SampleRate.ir), MarkovSynth.ar(varAnticad4096F23301910 * DC.ar(0.16781938076019), varAnticad4096F23301911 * DC.ar(0.23064124584198), varAnticad4096F23301910 * DC.ar(0.70948946475983), varAnticad4096F23301911 * DC.ar(0.919753074646)).exprange(1, SampleRate.ir), varAnticad4096F23301910 * env, modZ * in, 0.65573281120243 * varAnticad4096F23301911 * varAnticad4096F233019112, Silent.ar()), varAnticad4096F233019112, varAnticad4096F23301911 * modX, gateEnv, varAnticad4096F23301911, Silent.ar());
varAnticad4096F233019112 = IndexL.ar(Array.fill(2.pow(13), { |i| rrand(-1, 1) }).as(LocalBuf), gateEnv * env, modX, Silent.ar());

signal = varAnticad4096F233019112;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// SVC.1689.B233020
/////////////////////////////////////////////////////////

SynthDef.new("SVC.1689.B233020", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varSVC1689B2330209;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varSVC1689B2330209 = K2A.ar(t_trig).dup;
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
varSVC1689B2330209 = B2UHJ.ar(wave * modY, island, modX * env);
varSVC1689B2330209 = IIRFilter.ar(wave * DC.ar(0.25497937202454), wave * DC.ar(0.61924910545349), wave * DC.ar(0.7069673538208), wave * DC.ar(0.79083120822906), wave * DC.ar(0.80067503452301));

signal = varSVC1689B2330209;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// SVC.1689.B2330201
/////////////////////////////////////////////////////////

SynthDef.new("SVC.1689.B2330201", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varSVC1689B2330209, varSVC1689B233020110;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varSVC1689B2330209 = varSVC1689B233020110 = K2A.ar(t_trig).dup;
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
varSVC1689B2330209 = LocalOut.ar([AY.ar(wave * DC.ar(0.052034735679626), wave * DC.ar(0.30263769626617), wave * DC.ar(0.049910068511963), wave * DC.ar(0.49853336811066), wave * DC.ar(0.039582848548889), wave * DC.ar(0.90513944625854), wave * DC.ar(0.3756765127182), wave * DC.ar(0.07838249206543), wave * DC.ar(0.54554712772369), wave * DC.ar(0.24150907993317), wave * DC.ar(0.36289274692535), wave * DC.ar(0.79970622062683), wave * DC.ar(0.78627824783325)), FoaPressZ.ar(wave * DC.ar(0.89449083805084), wave * DC.ar(0.12183082103729), wave * DC.ar(0.089605569839478), wave * DC.ar(0.045943737030029))]);
varSVC1689B2330209 = ArrayMax.ar([SinGrainBBF.ar(wave * DC.ar(0.64929723739624), wave * DC.ar(0.12101757526398), wave * DC.ar(0.70248818397522), wave * DC.ar(0.85755908489227), wave * DC.ar(0.37324464321136), wave * DC.ar(0.64122354984283), wave * DC.ar(0.55247497558594), wave * DC.ar(0.46636855602264), wave * DC.ar(0.21600604057312), wave * DC.ar(0.17274558544159)), FoaDirectY.ar(wave * DC.ar(0.70713007450104), wave * DC.ar(0.43695139884949), wave * DC.ar(0.47894525527954), wave * DC.ar(0.10762667655945))]);
// Variation test code
varSVC1689B233020110 = Tilt.ar(0.90869212150574 * in * in, env * varSVC1689B233020110, island, bufnum, z);
varSVC1689B233020110 = FoaPushZ.ar(wave.linexp(varSVC1689B2330209 * DC.ar(0.92442774772644), varSVC1689B2330209 * DC.ar(0.37047386169434), varSVC1689B2330209 * DC.ar(0.19817328453064), varSVC1689B2330209 * DC.ar(0.07318103313446), varSVC1689B2330209 * DC.ar(0.073530435562134)), gateEnv, modX, Silent.ar());
varSVC1689B233020110 = Concat.ar(OneZero.ar(modZ, modZ, Pan2.ar(varSVC1689B2330209 * DC.ar(0.32208263874054), varSVC1689B2330209 * DC.ar(0.64888846874237), varSVC1689B2330209 * DC.ar(0.96739220619202)), SoftClipper8.ar(varSVC1689B2330209 * DC.ar(0.29605042934418))), bufnum, gate, 0.80234158039093 * gateEnv * gateEnv.linexp(varSVC1689B2330209 * DC.ar(0.17494094371796), varSVC1689B2330209 * DC.ar(0.62282311916351), varSVC1689B2330209 * DC.ar(0.46349453926086), varSVC1689B2330209 * DC.ar(0.78401100635529), varSVC1689B2330209 * DC.ar(0.12241184711456)), env, gateEnv * modY, modX * signal, signal * in, t_trig, env * env, varSVC1689B2330209 * varSVC1689B2330209, z.expexp(varSVC1689B2330209 * DC.ar(0.79695391654968), varSVC1689B2330209 * DC.ar(0.79579901695251), varSVC1689B2330209 * DC.ar(0.36042833328247), varSVC1689B2330209 * DC.ar(0.52542972564697), varSVC1689B2330209 * DC.ar(0.93297791481018)), varSVC1689B233020110, Silent.ar());

signal = varSVC1689B233020110;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




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
varAdwareCoolpp233020112 = TGrains.ar(2, wave * env.round(BufAllpassN.ar(varAdwareCoolpp23302010 * DC.ar(0.65125417709351), varAdwareCoolpp23302011 * DC.ar(0.44214737415314), varAdwareCoolpp23302011 * DC.ar(0.25167429447174), varAdwareCoolpp2330209 * DC.ar(0.98298227787018), varAdwareCoolpp2330209 * DC.ar(0.63354301452637), varAdwareCoolpp2330209 * DC.ar(0.1937872171402))), Array.fill(2.pow(16), { |i| rrand(-1, 1) }).as(LocalBuf), env * modY, gateEnv * env, y, amp, y, varAdwareCoolpp23302010);
varAdwareCoolpp233020113 = LFPulse.ar(modY * in, wave, varAdwareCoolpp23302011, 0.99974482623203 * in * varAdwareCoolpp23302010, Silent.ar());
varAdwareCoolpp233020112 = LFClipNoise.ar(modY, MostChange.ar(varAdwareCoolpp23302010 * DC.ar(0.23451459407806), varAdwareCoolpp23302011 * DC.ar(0.37073409557343)).minNyquist(), Silent.ar());
varAdwareCoolpp233020113 = FBSineN.ar(IndexL.ar(varAdwareCoolpp2330209 * DC.ar(0.62046802043915), varAdwareCoolpp23302010 * DC.ar(0.76723802089691), varAdwareCoolpp23302010 * DC.ar(0.77872431278229), varAdwareCoolpp23302011 * DC.ar(0.77097511291504)).exprange(1, SampleRate.ir), modZ * in, VOsc.ar(Array.fill(2.pow(14), { |i| rrand(-1, 1) }).as(LocalBuf), in, gateEnv, BufAllpassN.ar(varAdwareCoolpp23302010 * DC.ar(0.11191523075104), varAdwareCoolpp23302010 * DC.ar(0.44003176689148), varAdwareCoolpp23302010 * DC.ar(0.56128835678101), varAdwareCoolpp2330209 * DC.ar(0.0090219974517822), varAdwareCoolpp23302011 * DC.ar(0.69766008853912), varAdwareCoolpp23302010 * DC.ar(0.98686897754669)), Silent.ar()), modZ * varAdwareCoolpp233020113, modX * signal, Clipper8.ar(varAdwareCoolpp23302010 * modZ, varAdwareCoolpp2330209 * in, gate), varAdwareCoolpp233020112 * varAdwareCoolpp23302011, HenonL.ar(varAdwareCoolpp23302011 * DC.ar(0.27196753025055), varAdwareCoolpp23302011 * DC.ar(0.88601160049438), varAdwareCoolpp2330209 * DC.ar(0.49642074108124), varAdwareCoolpp23302010 * DC.ar(0.88215017318726), varAdwareCoolpp23302010 * DC.ar(0.56603407859802), varAdwareCoolpp23302010 * DC.ar(0.84657979011536), varAdwareCoolpp23302011 * DC.ar(0.53402268886566)), Silent.ar());
varAdwareCoolpp233020112 = BFEncode2.ar(varAdwareCoolpp23302010 * varAdwareCoolpp2330209, in, varAdwareCoolpp23302010 * wave, varAdwareCoolpp23302011 * varAdwareCoolpp23302011, in, varAdwareCoolpp2330209 * varAdwareCoolpp233020113);
varAdwareCoolpp233020113 = FMGrainBF.ar(in * gateEnv, varAdwareCoolpp233020112 * varAdwareCoolpp233020113, in * in, modZ, modZ * varAdwareCoolpp23302011, gateEnv * modX, varAdwareCoolpp233020113, amp, y, 0.99995806635664 * varAdwareCoolpp23302010 * modZ, Silent.ar());

signal = varAdwareCoolpp233020113;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// W95.Sab.753233020
/////////////////////////////////////////////////////////

SynthDef.new("W95.Sab.753233020", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varW95Sab7532330209, varW95Sab75323302010, varW95Sab75323302011, varW95Sab75323302012, varW95Sab75323302013, varW95Sab75323302014;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varW95Sab7532330209 = varW95Sab75323302010 = varW95Sab75323302011 = varW95Sab75323302012 = varW95Sab75323302013 = varW95Sab75323302014 = K2A.ar(t_trig).dup;
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
varW95Sab7532330209 = Beep.ar(SawDPW.ar(wave * DC.ar(0.99706864356995), wave * DC.ar(0.90699815750122), wave * DC.ar(0.63794553279877), wave * DC.ar(0.85271346569061)).exprange(1, SampleRate.ir), island);
varW95Sab75323302010 = LPZ2.ar(z, varW95Sab75323302012, Silent.ar());
varW95Sab75323302011 = BFEncodeSter.ar(varW95Sab75323302011, x.lag2(wave * DC.ar(0.24694430828094), wave * DC.ar(0.40297484397888)), modZ * varW95Sab75323302010, wave, wave, 0.61704552173615 * varW95Sab75323302011 * varW95Sab75323302014, env * env, modZ * modY);
varW95Sab75323302012 = Instruction.ar(Array.fill(2.pow(12), { |i| rrand(-1, 1) }).as(LocalBuf), 0.87972845658441 * LFGauss.ar(wave * DC.ar(0.39745759963989), wave * DC.ar(0.064849972724915), wave * DC.ar(0.047043085098267), wave * DC.ar(0.21630215644836), wave * DC.ar(0.22739374637604)), Silent.ar());
varW95Sab75323302013 = DoubleNestedAllpassL.ar(modX * env, env * modX, 0.11980164051056 * modZ * signal, modY * varW95Sab75323302010, x, varW95Sab75323302011 * varW95Sab7532330209, gateEnv * varW95Sab75323302011, t_trig, varW95Sab75323302013 * varW95Sab75323302012, varW95Sab7532330209, 0.99685480882487 * varW95Sab75323302013 * env, Silent.ar());
varW95Sab75323302014 = Dust2.ar(modZ * varW95Sab75323302013, varW95Sab75323302012, QuadC.ar(wave * DC.ar(0.57894659042358), wave * DC.ar(0.70230638980865), wave * DC.ar(0.86418545246124), wave * DC.ar(0.40217924118042), wave * DC.ar(0.2436398267746), wave * DC.ar(0.39041614532471), wave * DC.ar(0.6524840593338)));
varW95Sab7532330209 = LFSaw.ar(varW95Sab75323302011 * varW95Sab75323302010, varW95Sab75323302012 * modY, 0.98445262214109 * gateEnv * modY, Silent.ar());
varW95Sab75323302010 = VOSIM.ar(gateEnv, varW95Sab75323302012, varW95Sab75323302013 * varW95Sab75323302013, varW95Sab75323302011 * varW95Sab75323302012, 0.99656360775657 * varW95Sab75323302013 * varW95Sab75323302011, Silent.ar());
varW95Sab75323302011 = Gendy1.ar(wave * DC.ar(0.71255218982697), wave * DC.ar(0.98382568359375), wave * DC.ar(0.36639666557312), wave * DC.ar(0.038662433624268), wave * DC.ar(0.81460571289062), wave * DC.ar(0.9077399969101), wave * DC.ar(0.62261164188385), wave * DC.ar(0.18729841709137), wave * DC.ar(0.27177119255066), wave * DC.ar(0.86373519897461), wave * DC.ar(0.015665054321289), wave * DC.ar(0.97834694385529));
varW95Sab75323302012 = TWindex.ar(wave * DC.ar(0.48257863521576), wave * DC.ar(0.72378206253052), wave * DC.ar(0.98621106147766));
varW95Sab75323302013 = StkPluck.ar(wave * DC.ar(0.99159967899323), wave * DC.ar(0.77380466461182), wave * DC.ar(0.18544542789459), wave * DC.ar(0.52134430408478));
varW95Sab75323302014 = MedianTriggered.ar(varW95Sab75323302014, in * modY, varW95Sab7532330209, wave, Silent.ar());

signal = varW95Sab75323302014;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Better233021
/////////////////////////////////////////////////////////

SynthDef.new("Better233021", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varBetter2330219, varBetter23302110, varBetter23302111, varBetter23302112;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varBetter2330219 = varBetter23302110 = varBetter23302111 = varBetter23302112 = K2A.ar(t_trig).dup;
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
varBetter2330219 = TExpRand.ar(in * gateEnv, varBetter23302110 * modX, varBetter23302110 * in);
varBetter23302110 = LFNoise1.ar(WeaklyNonlinear2.ar(wave * DC.ar(0.9002959728241), wave * DC.ar(0.54320919513702), wave * DC.ar(0.11200225353241), wave * DC.ar(0.22499692440033), wave * DC.ar(0.85343444347382), wave * DC.ar(0.92457389831543), wave * DC.ar(0.53964376449585), wave * DC.ar(0.78867876529694), wave * DC.ar(0.14825356006622), wave * DC.ar(0.67719614505768), wave * DC.ar(0.68109428882599), wave * DC.ar(0.94223189353943), wave * DC.ar(0.45643556118011)).exprange(1, SampleRate.ir), NeedleRect.ar(wave * DC.ar(0.011634707450867), wave * DC.ar(0.066174387931824), wave * DC.ar(0.59356439113617), wave * DC.ar(0.43854165077209), wave * DC.ar(0.1804107427597), wave * DC.ar(0.61894106864929), wave * DC.ar(0.98240256309509)), Silent.ar());
varBetter23302111 = SoftClipper8.ar(modZ * modZ);
varBetter23302112 = Integrator.ar(modX, t_trig, Impulse.ar(wave * DC.ar(0.91752910614014), wave * DC.ar(0.29067718982697), wave * DC.ar(0.040480256080627), wave * DC.ar(0.23963916301727)), Silent.ar());
varBetter2330219 = WaveletDaub.ar(signal, z, signal * modY, 0.99063405363834 * signal * varBetter23302111, Silent.ar());
varBetter23302110 = StandardN.ar(varBetter23302110 * in, varBetter2330219 * varBetter23302110, varBetter23302112, signal, modZ, Silent.ar());
varBetter23302111 = Vibrato.ar(wave * DC.ar(0.026304244995117), wave * DC.ar(0.65276038646698), wave * DC.ar(0.14466094970703), wave * DC.ar(0.2824319601059), wave * DC.ar(0.3145797252655), wave * DC.ar(0.8867119550705), wave * DC.ar(0.44447493553162), wave * DC.ar(0.17461466789246));
varBetter23302112 = SOS.ar(modZ, gate, signal * varBetter2330219, varBetter23302111 * varBetter2330219, env * varBetter2330219, 0.73719882965088 * modX * gateEnv, 0.99988341635314 * modY * modY, Silent.ar());

signal = varBetter23302112;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// HLC.5001233021
/////////////////////////////////////////////////////////

SynthDef.new("HLC.5001233021", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varHLC50012330219, varHLC500123302110;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varHLC50012330219 = varHLC500123302110 = K2A.ar(t_trig).dup;
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
varHLC50012330219 = Convolution2.ar(gate, x, gateEnv * varHLC50012330219, gateEnv * varHLC50012330219, in, Silent.ar());
varHLC500123302110 = BufCombN.ar(Array.fill(2.pow(14), { |i| rrand(-1, 1) }).as(LocalBuf), gate, t_trig, FoaPressX.ar(wave * DC.ar(0.14579272270203), wave * DC.ar(0.22818171977997), wave * DC.ar(0.50449275970459), wave * DC.ar(0.31713366508484)), modZ, Silent.ar());
varHLC50012330219 = MedianTriggered.ar(wave * DC.ar(0.56709384918213), wave * DC.ar(0.32672739028931), wave * DC.ar(0.85156047344208), wave * DC.ar(0.28476095199585), wave * DC.ar(0.72267317771912));
varHLC500123302110 = SinOsc.ar(RLPFD.ar(wave * DC.ar(0.037336349487305), wave * DC.ar(0.63802564144135), wave * DC.ar(0.31957137584686), wave * DC.ar(0.38830649852753), wave * DC.ar(0.86025559902191), wave * DC.ar(0.37332952022552)).exprange(1, SampleRate.ir), signal * varHLC500123302110, varHLC50012330219, Silent.ar());

signal = varHLC500123302110;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// IVP233022
/////////////////////////////////////////////////////////

SynthDef.new("IVP233022", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varIVP2330229, varIVP23302210;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varIVP2330229 = varIVP23302210 = K2A.ar(t_trig).dup;
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
varIVP2330229 = SinGrainIBF.ar(modY * varIVP2330229, 0.93099093437195 * varIVP23302210 * in, AudioMSG.ar(wave * DC.ar(0.82302534580231), wave * DC.ar(0.012037754058838), wave * DC.ar(0.77192997932434), wave * DC.ar(0.70207595825195)).exprange(1, SampleRate.ir).minNyquist(), bufnum, bufnum, amp, wave * env, 0.39340734481812 * in * varIVP2330229, in, island, 0.99726901412822 * SoftClipAmp4.ar(wave * DC.ar(0.45406913757324), wave * DC.ar(0.61918497085571), wave * DC.ar(0.62657845020294), wave * DC.ar(0.27723896503448)).linlin(wave * DC.ar(0.66436231136322), wave * DC.ar(0.68906402587891), wave * DC.ar(0.79709148406982), wave * DC.ar(0.63366103172302), wave * DC.ar(0.10237181186676)), Silent.ar());
varIVP23302210 = SinOscFB.ar(gateEnv * wave, varIVP2330229 * varIVP2330229, varIVP2330229, Silent.ar());
varIVP2330229 = LPCAnalyzer.ar(in, env * modY, z, env * varIVP2330229, x, z, z, 0.92448382296847 * varIVP23302210 * varIVP2330229, Silent.ar());
varIVP23302210 = Lorenz2DL.ar(wave * DC.ar(0.30294811725616), wave * DC.ar(0.62948274612427), wave * DC.ar(0.33742129802704), wave * DC.ar(0.72639405727386), wave * DC.ar(0.38583850860596), wave * DC.ar(0.52959823608398), wave * DC.ar(0.6302342414856), wave * DC.ar(0.56410610675812), wave * DC.ar(0.98211717605591), wave * DC.ar(0.9305100440979), wave * DC.ar(0.59328699111938));

signal = varIVP23302210;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Eumel.347.D2330231
/////////////////////////////////////////////////////////

SynthDef.new("Eumel.347.D2330231", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varEumel347D2330239, varEumel347D23302310, varEumel347D23302311, varEumel347D23302312, varEumel347D233023113, varEumel347D233023114, varEumel347D233023115, varEumel347D233023116;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varEumel347D2330239 = varEumel347D23302310 = varEumel347D23302311 = varEumel347D23302312 = varEumel347D233023113 = varEumel347D233023114 = varEumel347D233023115 = varEumel347D233023116 = K2A.ar(t_trig).dup;
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
varEumel347D2330239 = YigMandelbulbN.ar(Breakcore.ar(wave * DC.ar(0.099938750267029), wave * DC.ar(0.48997104167938), wave * DC.ar(0.81243455410004), wave * DC.ar(0.46495449542999), wave * DC.ar(0.30386817455292)).exprange(1, SampleRate.ir), modX, varEumel347D233023116 * varEumel347D23302312, amp, 0.32306706905365 * varEumel347D233023115 * varEumel347D23302312, Logistic.ar(wave * DC.ar(0.26193249225616), wave * DC.ar(0.82982397079468), wave * DC.ar(0.41953015327454), wave * DC.ar(0.80759394168854), wave * DC.ar(0.012427568435669)), Silent.ar());
varEumel347D23302310 = VOsc.ar(Array.fill(2.pow(16), { |i| rrand(-1, 1) }).as(LocalBuf), SyncSaw.ar(wave * DC.ar(0.64515972137451), wave * DC.ar(0.87927091121674), wave * DC.ar(0.62784290313721), wave * DC.ar(0.2577508687973)).exprange(1, SampleRate.ir), varEumel347D23302312, KmeansToBPSet1.ar(wave * DC.ar(0.32441961765289), wave * DC.ar(0.22978365421295), wave * DC.ar(0.32988238334656), wave * DC.ar(0.44444715976715), wave * DC.ar(0.98296892642975), wave * DC.ar(0.81589996814728), wave * DC.ar(0.58535552024841), wave * DC.ar(0.081328630447388), wave * DC.ar(0.25484144687653), wave * DC.ar(0.79397463798523)), Gbman2DC.ar(wave * DC.ar(0.90152621269226), wave * DC.ar(0.4565395116806), wave * DC.ar(0.50143802165985), wave * DC.ar(0.37241363525391), wave * DC.ar(0.92537522315979), wave * DC.ar(0.65230453014374)));
varEumel347D23302311 = SoftClipAmp.ar(varEumel347D23302312 * varEumel347D233023116, in * varEumel347D23302311, 0.99960958715011 * modX * modZ, Silent.ar());
varEumel347D23302312 = PartConv.ar(gateEnv * signal, signal * modY, Array.fill(2.pow(11), { |i| rrand(-1, 1) }).as(LocalBuf), 0.99998906803903 * varEumel347D23302311 * varEumel347D233023115, Silent.ar());
varEumel347D2330239 = Dust2.ar(wave * DC.ar(0.37782216072083), wave * DC.ar(0.93253362178802), wave * DC.ar(0.90963494777679));
varEumel347D23302310 = HenonN.ar(wave * DC.ar(0.84847152233124), wave * DC.ar(0.64557671546936), wave * DC.ar(0.81167411804199), wave * DC.ar(0.90082085132599), wave * DC.ar(0.5200332403183), wave * DC.ar(0.92649662494659), wave * DC.ar(0.12975025177002));
varEumel347D23302311 = Lorenz2DN.ar(varEumel347D233023115 * signal, gateEnv * wave, z, varEumel347D23302311 * modX, modY * in, modY * varEumel347D233023116, signal, modY, x, 0.91540436320893 * varEumel347D23302311, Silent.ar());
varEumel347D23302312 = Limiter.ar(wave * DC.ar(0.9038724899292), wave * DC.ar(0.44557690620422), wave * DC.ar(0.60427117347717));
// Variation test code
varEumel347D233023113 = InGrainIBF.ar(env * modX, wave, 0.98288154602051 * varEumel347D23302311 * varEumel347D23302312, bufnum, bufnum, x, 0.22983002662659 * Slope.ar(varEumel347D2330239 * DC.ar(0.0029014348983765), varEumel347D23302310 * DC.ar(0.022617936134338), varEumel347D23302311 * DC.ar(0.083416104316711)), 0.62103283405304 * modY * env, env * varEumel347D2330239, bufnum, DelTapWr.ar(varEumel347D23302312 * DC.ar(0.58312284946442), varEumel347D2330239 * DC.ar(0.84157454967499)), Silent.ar());
varEumel347D233023114 = LorenzTrig.ar(modX, varEumel347D233023113 * modX, varEumel347D23302310, varEumel347D2330239, varEumel347D23302312 * modY, env, in * env, wave, bufnum, NLFiltN.ar(varEumel347D2330239 * DC.ar(0.21065175533295), varEumel347D23302310 * DC.ar(0.36847388744354), varEumel347D23302311 * DC.ar(0.76578545570374), varEumel347D2330239 * DC.ar(0.21641373634338), varEumel347D23302312 * DC.ar(0.73051798343658), varEumel347D23302312 * DC.ar(0.42375087738037), varEumel347D23302310 * DC.ar(0.49724042415619), varEumel347D23302311 * DC.ar(0.14423501491547)), Silent.ar());
varEumel347D233023115 = YigCliffordL.ar(modX, signal, modZ * modY, varEumel347D233023115 * varEumel347D233023116, wave, varEumel347D233023113, 0.2495858669281 * gateEnv * varEumel347D2330239, FoaFocusZ.ar(varEumel347D2330239 * DC.ar(0.037703990936279), varEumel347D23302310 * DC.ar(0.81288123130798), varEumel347D23302312 * DC.ar(0.060823082923889), varEumel347D23302312 * DC.ar(0.33715188503265)), SinOscFB.ar(varEumel347D2330239 * DC.ar(0.52579474449158), varEumel347D23302310 * DC.ar(0.54325377941132), varEumel347D2330239 * DC.ar(0.228111743927), varEumel347D23302312 * DC.ar(0.70740211009979)));
varEumel347D233023116 = StkPluck.ar(PSinGrain.ar(varEumel347D23302312 * DC.ar(0.4952290058136), varEumel347D23302311 * DC.ar(0.59017372131348), varEumel347D23302311 * DC.ar(0.32126009464264)).exprange(1, SampleRate.ir), wave * in, signal, Silent.ar());
varEumel347D233023113 = LinCongN.ar(gateEnv * varEumel347D233023114, env, varEumel347D23302310 * modX, varEumel347D23302310, in * varEumel347D23302312, wave, Silent.ar());
varEumel347D233023114 = FMGrainIBF.ar(gateEnv, in, modX * varEumel347D233023116, varEumel347D233023115 * modY, modX * varEumel347D233023114, bufnum, bufnum, varEumel347D23302310 * varEumel347D233023113, varEumel347D233023116 * varEumel347D23302312, varEumel347D2330239 * varEumel347D233023116, gateEnv * varEumel347D233023113, varEumel347D23302311, wave, Silent.ar());
varEumel347D233023115 = QuadL.ar(SpruceBudworm.ar(varEumel347D2330239 * DC.ar(0.73889982700348), varEumel347D23302310 * DC.ar(0.20782995223999), varEumel347D2330239 * DC.ar(0.74177479743958), varEumel347D23302311 * DC.ar(0.71821904182434), varEumel347D2330239 * DC.ar(0.95973992347717), varEumel347D23302312 * DC.ar(0.19515109062195), varEumel347D23302312 * DC.ar(0.40101337432861), varEumel347D23302312 * DC.ar(0.59501338005066), varEumel347D2330239 * DC.ar(0.1578528881073), varEumel347D23302312 * DC.ar(0.23545062541962), varEumel347D23302310 * DC.ar(0.3867734670639), varEumel347D23302311 * DC.ar(0.11648881435394)).exprange(1, SampleRate.ir), DoubleNestedAllpassC.ar(modZ * gateEnv, varEumel347D233023113 * varEumel347D233023114, varEumel347D233023113 * in, varEumel347D233023115 * varEumel347D23302311, y, varEumel347D233023113, varEumel347D233023114 * varEumel347D2330239, varEumel347D23302311, varEumel347D233023114, varEumel347D23302311 * modZ, 0.99990373168432 * wave * varEumel347D23302312, Silent.ar()), Sieve1.ar(Array.fill(2.pow(12), { |i| rrand(-1, 1) }).as(LocalBuf), z, gateEnv * modZ, 0.84558581247847 * Pulse.ar(varEumel347D23302310 * DC.ar(0.41769850254059), varEumel347D2330239 * DC.ar(0.82255601882935), varEumel347D2330239 * DC.ar(0.46677792072296), varEumel347D23302312 * DC.ar(0.29743540287018)), Silent.ar()), env, amp, 0.99993591899025 * modX, Silent.ar());
varEumel347D233023116 = VMScan2D.ar(Array.fill(2.pow(13), { |i| rrand(-1, 1) }).as(LocalBuf), 0.99924874702866 * LPCVals.ar(varEumel347D2330239 * DC.ar(0.67502546310425), varEumel347D23302312 * DC.ar(0.5368584394455)), Silent.ar());
varEumel347D233023113 = TGrains2.ar(2, varEumel347D233023113 * wave, Array.fill(2.pow(12), { |i| rrand(-1, 1) }).as(LocalBuf), in, bufnum, amp, 0.10402297973633 * varEumel347D2330239 * gateEnv, varEumel347D23302312 * varEumel347D2330239, varEumel347D233023115, varEumel347D2330239, FincoSprottM.ar(varEumel347D23302311 * gateEnv, LFDNoise0.ar(varEumel347D2330239 * DC.ar(0.07840096950531), varEumel347D23302310 * DC.ar(0.47605359554291), varEumel347D23302312 * DC.ar(0.8883091211319)), env * varEumel347D23302311, varEumel347D233023115 * varEumel347D23302312, varEumel347D23302311, signal, varEumel347D233023113 * modY, 0.94202519175837 * gateEnv * in, Silent.ar()));
varEumel347D233023114 = Convolution2L.ar(gateEnv, modY * env, varEumel347D233023113 * wave, Atari2600.ar(y, 0.045337319374084 * varEumel347D23302312 * varEumel347D23302310, signal * varEumel347D23302310, varEumel347D233023116 * modX, gateEnv * varEumel347D233023116, modY * modY, signal), varEumel347D23302312, 0.43359722452397 * modY * varEumel347D23302310, Silent.ar());
varEumel347D233023115 = Out.ar((80 + (island * 2)), [StereoConvolution2L.ar(varEumel347D23302311 * DC.ar(0.15606081485748), varEumel347D2330239 * DC.ar(0.051035404205322), varEumel347D23302310 * DC.ar(0.56990015506744), varEumel347D23302312 * DC.ar(0.084383964538574), varEumel347D23302312 * DC.ar(0.68695652484894), varEumel347D23302310 * DC.ar(0.6363844871521), varEumel347D23302312 * DC.ar(0.81913924217224), varEumel347D23302312 * DC.ar(0.95203351974487)), Gendy3.ar(varEumel347D23302311 * DC.ar(0.88317012786865), varEumel347D23302311 * DC.ar(0.6389285326004), varEumel347D23302312 * DC.ar(0.34859883785248), varEumel347D23302311 * DC.ar(0.19657599925995), varEumel347D23302311 * DC.ar(0.64163768291473), varEumel347D2330239 * DC.ar(0.75258600711823), varEumel347D23302312 * DC.ar(0.73865640163422), varEumel347D2330239 * DC.ar(0.99727976322174), varEumel347D2330239 * DC.ar(0.62362837791443), varEumel347D2330239 * DC.ar(0.36018919944763), varEumel347D23302312 * DC.ar(0.14395272731781))]);
varEumel347D233023116 = SelectL.ar(varEumel347D233023116 * wave, [Latch.ar(varEumel347D23302310 * DC.ar(0.30874514579773), varEumel347D23302311 * DC.ar(0.62484550476074)), Clipper8.ar(varEumel347D23302310 * DC.ar(0.10976040363312), varEumel347D23302312 * DC.ar(0.78621649742126), varEumel347D23302311 * DC.ar(0.79713070392609))]);

signal = varEumel347D233023116;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




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




/////////////////////////////////////////////////////////
// WM.Padania.D:It233026
/////////////////////////////////////////////////////////

SynthDef.new("WM.Padania.D:It233026", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varWMPadaniaDIt2330269, varWMPadaniaDIt23302610, varWMPadaniaDIt23302611, varWMPadaniaDIt23302612, varWMPadaniaDIt23302613, varWMPadaniaDIt23302614;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varWMPadaniaDIt2330269 = varWMPadaniaDIt23302610 = varWMPadaniaDIt23302611 = varWMPadaniaDIt23302612 = varWMPadaniaDIt23302613 = varWMPadaniaDIt23302614 = K2A.ar(t_trig).dup;
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
varWMPadaniaDIt2330269 = Gbman2DC.ar(SkipNeedle.ar(wave * DC.ar(0.65139353275299), wave * DC.ar(0.9298609495163), wave * DC.ar(0.47388458251953)).exprange(1, SampleRate.ir), env, varWMPadaniaDIt2330269, x.lag2(wave * DC.ar(0.47186172008514), wave * DC.ar(0.2004896402359)), LatoocarfianC.ar(wave * DC.ar(0.23058092594147), wave * DC.ar(0.75820255279541), wave * DC.ar(0.69478011131287), wave * DC.ar(0.41889011859894), wave * DC.ar(0.37534236907959), wave * DC.ar(0.033594369888306), wave * DC.ar(0.46896123886108), wave * DC.ar(0.40057051181793), wave * DC.ar(0.44129610061646)), Silent.ar());
varWMPadaniaDIt23302610 = CuspL.ar(gateEnv * signal, varWMPadaniaDIt23302613 * gateEnv, wave * varWMPadaniaDIt2330269, varWMPadaniaDIt23302611 * varWMPadaniaDIt2330269, varWMPadaniaDIt23302612, Silent.ar());
varWMPadaniaDIt23302611 = MembraneCircle.ar(modX * varWMPadaniaDIt23302613, 0.59973526000977 * modZ * in, 0.16176748275757 * varWMPadaniaDIt23302610 * varWMPadaniaDIt23302610, 0.99990306030187 * modX * modZ, Silent.ar());
varWMPadaniaDIt23302612 = LPZ1.ar(0.91319942474365 * varWMPadaniaDIt23302614 * modX, 0.78396908168765 * varWMPadaniaDIt23302611 * varWMPadaniaDIt2330269, Silent.ar());
varWMPadaniaDIt23302613 = StkMoog.ar(wave, modX * modY, modX.hypot(SinGrainBF.ar(wave * DC.ar(0.8658002614975), wave * DC.ar(0.95100820064545), wave * DC.ar(0.79671776294708), wave * DC.ar(0.60413312911987), wave * DC.ar(0.49169325828552), wave * DC.ar(0.04759693145752), wave * DC.ar(0.19927477836609), wave * DC.ar(0.79033946990967), wave * DC.ar(0.24042940139771))), DC.ar(wave * DC.ar(0.36187815666199)).exprange(1, SampleRate.ir), GrainSin.ar(2, modZ * modZ, varWMPadaniaDIt23302612, gateEnv * modY, varWMPadaniaDIt23302611 * env, bufnum, signal * varWMPadaniaDIt23302610, 0.99987469507447 * varWMPadaniaDIt23302614 * varWMPadaniaDIt23302614, Silent.ar()), varWMPadaniaDIt23302613 * varWMPadaniaDIt23302612, modZ * varWMPadaniaDIt23302613, FoaNFC.ar(wave * DC.ar(0.84054660797119), wave * DC.ar(0.65396809577942), wave * DC.ar(0.32092344760895), wave * DC.ar(0.11596536636353)), Silent.ar());
varWMPadaniaDIt23302614 = DC.ar(varWMPadaniaDIt23302610);
varWMPadaniaDIt2330269 = SMS.ar(modZ * in, varWMPadaniaDIt23302613, modZ, wave * varWMPadaniaDIt23302614, 0.88364768028259 * varWMPadaniaDIt23302611 * env, 0.27330870238912 * modX * varWMPadaniaDIt2330269, GlitchRHPF.ar(wave * DC.ar(0.29661417007446), wave * DC.ar(0.083503723144531), wave * DC.ar(0.76568555831909), wave * DC.ar(0.56215631961823), wave * DC.ar(0.92170095443726)), signal * signal, varWMPadaniaDIt23302612, env, Array.fill(2.pow(12), { |i| rrand(-1, 1) }).as(LocalBuf), modX, Silent.ar());
varWMPadaniaDIt23302610 = DelayC.ar(OneZero.ar(gateEnv * modY, signal, varWMPadaniaDIt23302611, Silent.ar()), varWMPadaniaDIt23302614, modZ * in, 0.41395682203881 * LFDNoise3.ar(wave * DC.ar(0.26970422267914), wave * DC.ar(0.3781623840332), wave * DC.ar(0.13341295719147)), Silent.ar());
varWMPadaniaDIt23302611 = StkMandolin.ar(varWMPadaniaDIt23302614 * in, varWMPadaniaDIt23302614, wave * modZ.excess(MonoGrainBF.ar(wave * DC.ar(0.046005725860596), wave * DC.ar(0.90971660614014), wave * DC.ar(0.6036102771759), wave * DC.ar(0.9529333114624), wave * DC.ar(0.23613619804382), wave * DC.ar(0.30636274814606), wave * DC.ar(0.66354978084564), wave * DC.ar(0.83205556869507), wave * DC.ar(0.1658536195755), wave * DC.ar(0.0077333450317383), wave * DC.ar(0.2158191204071))), env * gateEnv, varWMPadaniaDIt23302611, signal * varWMPadaniaDIt23302613, wave * varWMPadaniaDIt23302612, 0.96965983433421 * YigClifford3DN.ar(wave * DC.ar(0.82523691654205), wave * DC.ar(0.64151835441589), wave * DC.ar(0.65838611125946), wave * DC.ar(0.78526735305786), wave * DC.ar(0.30584728717804), wave * DC.ar(0.8730776309967), wave * DC.ar(0.49207031726837), wave * DC.ar(0.2880220413208), wave * DC.ar(0.46512567996979), wave * DC.ar(0.85385882854462)), Silent.ar().curvelin(wave * DC.ar(0.13519155979156), wave * DC.ar(0.55379557609558), wave * DC.ar(0.057724952697754), wave * DC.ar(0.11754810810089), wave * DC.ar(0.099578619003296), wave * DC.ar(0.48939371109009)));
varWMPadaniaDIt23302612 = FoaFocusZ.ar(x, varWMPadaniaDIt23302610 * signal, 0.99978498279144 * modY * gateEnv, Silent.ar());
varWMPadaniaDIt23302613 = MoogLadder.ar(wave * DC.ar(0.79565691947937), wave * DC.ar(0.92800164222717), wave * DC.ar(0.45365524291992), wave * DC.ar(0.18641221523285), wave * DC.ar(0.93321645259857));
varWMPadaniaDIt23302614 = Latoocarfian2DL.ar(wave * DC.ar(0.74879503250122), wave * DC.ar(0.666264295578), wave * DC.ar(0.91321647167206), wave * DC.ar(0.44656908512115), wave * DC.ar(0.76242804527283), wave * DC.ar(0.40675139427185), wave * DC.ar(0.29911816120148), wave * DC.ar(0.10306179523468), wave * DC.ar(0.58815217018127), wave * DC.ar(0.72210550308228));

signal = varWMPadaniaDIt23302614;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Printerceptor2330271
/////////////////////////////////////////////////////////

SynthDef.new("Printerceptor2330271", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varPrinterceptor2330279, varPrinterceptor23302710, varPrinterceptor23302711, varPrinterceptor233027112, varPrinterceptor233027113, varPrinterceptor233027114, varPrinterceptor233027115;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varPrinterceptor2330279 = varPrinterceptor23302710 = varPrinterceptor23302711 = varPrinterceptor233027112 = varPrinterceptor233027113 = varPrinterceptor233027114 = varPrinterceptor233027115 = K2A.ar(t_trig).dup;
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
varPrinterceptor2330279 = DoubleNestedAllpassN.ar(varPrinterceptor233027113 * env, varPrinterceptor23302711 * modX.linlin(wave * DC.ar(0.35682058334351), wave * DC.ar(0.067199230194092), wave * DC.ar(0.45282137393951), wave * DC.ar(0.9731959104538), wave * DC.ar(0.4174507856369)), 0.81889617443085 * modZ * modX, modZ, 0.026743412017822 * StkBandedWG.ar(wave * DC.ar(0.39042139053345), wave * DC.ar(0.091386675834656), wave * DC.ar(0.76704835891724), wave * DC.ar(0.57649195194244), wave * DC.ar(0.36440014839172), wave * DC.ar(0.17185175418854), wave * DC.ar(0.19670248031616), wave * DC.ar(0.75611102581024), wave * DC.ar(0.79206764698029), wave * DC.ar(0.39058887958527), wave * DC.ar(0.21149694919586)), varPrinterceptor233027114 * varPrinterceptor233027114, 0.52535653114319 * wave * varPrinterceptor2330279, z, gateEnv * env, island, 0.99989652564458 * varPrinterceptor23302710 * env, Silent.ar());
varPrinterceptor23302710 = InGrainB.ar(varPrinterceptor23302711 * wave, varPrinterceptor233027112 * varPrinterceptor233027113, varPrinterceptor233027113 * varPrinterceptor233027113, bufnum, 0.99162971690412 * gateEnv * modX, Silent.ar());
varPrinterceptor23302711 = BFEncodeSter.ar(modX, 0.10091876983643 * Metro.ar(wave * DC.ar(0.30594491958618), wave * DC.ar(0.51570463180542), wave * DC.ar(0.016448020935059), wave * DC.ar(0.53717803955078)), varPrinterceptor233027115, FMHEncode1.ar(wave * DC.ar(0.66558718681335), wave * DC.ar(0.67515933513641), wave * DC.ar(0.30037260055542), wave * DC.ar(0.43877756595612), wave * DC.ar(0.20958280563354), wave * DC.ar(0.83645057678223)), gateEnv, varPrinterceptor23302710 * modY, 0.3347259759903 * modY * varPrinterceptor233027113, varPrinterceptor233027114 * gateEnv);
varPrinterceptor2330279 = Gendy1.ar(wave * DC.ar(0.30634963512421), wave * DC.ar(0.074788451194763), wave * DC.ar(0.50897312164307), wave * DC.ar(0.022374033927917), wave * DC.ar(0.84175646305084), wave * DC.ar(0.63490509986877), wave * DC.ar(0.46876561641693), wave * DC.ar(0.6719343662262), wave * DC.ar(0.8330819606781), wave * DC.ar(0.098460912704468), wave * DC.ar(0.17997360229492), wave * DC.ar(0.1966118812561));
varPrinterceptor23302710 = BHiShelf.ar(wave, modY * varPrinterceptor233027112, varPrinterceptor2330279 * wave, modZ * varPrinterceptor233027113, 0.79952645787348 * wave * modZ, Silent.ar());
varPrinterceptor23302711 = TDelay.ar(wave * DC.ar(0.71544146537781), wave * DC.ar(0.70092558860779));
// Variation test code
varPrinterceptor233027112 = Balance.ar(modY, 0.85123002529144 * varPrinterceptor23302711 * varPrinterceptor2330279, t_trig, wave, 0.99146856163576 * modZ * varPrinterceptor23302711, Silent.ar());
varPrinterceptor233027113 = BufDelayC.ar(Array.fill(2.pow(15), { |i| rrand(-1, 1) }).as(LocalBuf).mod(NeedleRect.ar(varPrinterceptor23302710 * DC.ar(0.084262132644653), varPrinterceptor23302710 * DC.ar(0.29639363288879), varPrinterceptor2330279 * DC.ar(0.71250092983246), varPrinterceptor23302710 * DC.ar(0.81646871566772), varPrinterceptor23302711 * DC.ar(0.66390001773834), varPrinterceptor23302710 * DC.ar(0.44834935665131), varPrinterceptor23302711 * DC.ar(0.97957289218903))), x, modZ * varPrinterceptor233027114, 0.99895447843411 * signal * modY, Silent.ar());
varPrinterceptor233027114 = Clipper32.ar(t_trig, island, signal * signal);
varPrinterceptor233027115 = Saw.ar(signal * modZ, CombC.ar(varPrinterceptor2330279 * DC.ar(0.31475806236267), varPrinterceptor23302711 * DC.ar(0.39175415039062), varPrinterceptor23302711 * DC.ar(0.36922526359558), varPrinterceptor23302710 * DC.ar(0.18864977359772), varPrinterceptor23302710 * DC.ar(0.49782276153564), varPrinterceptor23302710 * DC.ar(0.26358163356781)), Silent.ar());
varPrinterceptor233027112 = LPF1.ar(IndexL.ar(Array.fill(2.pow(10), { |i| rrand(-1, 1) }).as(LocalBuf).rightShift(SOS.ar(varPrinterceptor2330279 * DC.ar(0.40409588813782), varPrinterceptor23302710 * DC.ar(0.54850840568542), varPrinterceptor23302711 * DC.ar(0.54148602485657), varPrinterceptor23302711 * DC.ar(0.57213723659515), varPrinterceptor2330279 * DC.ar(0.92480099201202), varPrinterceptor23302711 * DC.ar(0.11242020130157), varPrinterceptor23302711 * DC.ar(0.19827330112457), varPrinterceptor23302711 * DC.ar(0.32061862945557))), modX, signal, Silent.ar()), env * gateEnv);
varPrinterceptor233027113 = Beep.ar(modX, env);
varPrinterceptor233027114 = Gendy5.ar(modZ, varPrinterceptor233027113 * varPrinterceptor233027112, modY * gateEnv, MembraneCircle.ar(bufnum, 0.74987065792084 * env * modY, wave * varPrinterceptor233027113, 0.95314064063707 * gateEnv * varPrinterceptor2330279, Silent.ar()), modZ, wave, amp, varPrinterceptor23302710, gate, signal * signal, gateEnv, CombN.ar(varPrinterceptor23302711 * DC.ar(0.76011824607849), varPrinterceptor23302710 * DC.ar(0.76230132579803), varPrinterceptor2330279 * DC.ar(0.34585356712341), varPrinterceptor2330279 * DC.ar(0.33911514282227), varPrinterceptor23302710 * DC.ar(0.34770631790161), varPrinterceptor2330279 * DC.ar(0.63363146781921)));
varPrinterceptor233027115 = StkVoicForm.ar(DelayN.ar(varPrinterceptor23302711 * DC.ar(0.91558063030243), varPrinterceptor2330279 * DC.ar(0.19629216194153), varPrinterceptor23302711 * DC.ar(0.93946695327759), varPrinterceptor23302711 * DC.ar(0.80434727668762), varPrinterceptor23302710 * DC.ar(0.21279299259186)).exprange(1, SampleRate.ir), amp, t_trig, HenonTrig.ar(varPrinterceptor23302710 * DC.ar(0.031192302703857), varPrinterceptor23302710 * DC.ar(0.62250077724457), varPrinterceptor23302710 * DC.ar(0.8666650056839), varPrinterceptor23302711 * DC.ar(0.53073394298553), varPrinterceptor23302710 * DC.ar(0.0042321681976318), varPrinterceptor2330279 * DC.ar(0.9438978433609), varPrinterceptor2330279 * DC.ar(0.84480774402618), varPrinterceptor23302710 * DC.ar(0.63326752185822)).exprange(1, SampleRate.ir), y, bufnum, env * in, 0.84315871495893 * modZ * varPrinterceptor2330279, Silent.ar());
varPrinterceptor233027112 = FoaDirectY.ar(varPrinterceptor233027113 * modZ, wave * varPrinterceptor23302710, varPrinterceptor2330279, Silent.ar());
varPrinterceptor233027113 = Standard2DN.ar(varPrinterceptor233027112 * env, modY * varPrinterceptor233027113, varPrinterceptor233027113, y, bufnum, 0.99286915335912 * modZ * modZ, Silent.ar());
varPrinterceptor233027114 = SkipNeedle.ar(wave * wave, x, varPrinterceptor233027114);
varPrinterceptor233027115 = Gendy2.ar(island, 0.24517035484314 * varPrinterceptor2330279 * varPrinterceptor23302710, 0.17076790332794 * gateEnv * varPrinterceptor233027115, 0.18085265159607 * varPrinterceptor23302710 * varPrinterceptor233027114, in, gateEnv * env, in, varPrinterceptor2330279, bufnum, wave * in, amp, x, varPrinterceptor23302710, PeakEQ4.ar(varPrinterceptor23302711 * DC.ar(0.12556183338165), varPrinterceptor23302711 * DC.ar(0.63143646717072), varPrinterceptor23302711 * DC.ar(0.15389919281006), varPrinterceptor2330279 * DC.ar(0.70228254795074)));

signal = varPrinterceptor233027115;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// KVS.1942233027
/////////////////////////////////////////////////////////

SynthDef.new("KVS.1942233027", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varKVS19422330279, varKVS194223302710, varKVS194223302711;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varKVS19422330279 = varKVS194223302710 = varKVS194223302711 = K2A.ar(t_trig).dup;
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
varKVS19422330279 = RedDPCMdecode.ar(z);
varKVS194223302710 = PlayBuf.ar(2, Array.fill(2.pow(13), { |i| rrand(-1, 1) }).as(LocalBuf), 0.54345321655273 * Slub.ar(wave * DC.ar(0.96403706073761), wave * DC.ar(0.41947829723358)), gateEnv * modZ, varKVS19422330279, amp, island);
varKVS194223302711 = InRect.ar(gate, modZ, Rect.new(0, 0, 0.52925097942352, 0.40609216690063));
varKVS19422330279 = Limiter.ar(in * in, signal, varKVS194223302710);
varKVS194223302710 = SoftClipper8.ar(bufnum);
varKVS194223302711 = TDuty.ar(wave * DC.ar(0.0060365200042725), wave * DC.ar(0.033525466918945), wave * DC.ar(0.96836757659912), wave * DC.ar(0.56145477294922), wave * DC.ar(0.77596545219421));

signal = varKVS194223302711;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Zorm-B.1123233027
/////////////////////////////////////////////////////////

SynthDef.new("Zorm-B.1123233027", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varZormB11232330279, varZormB112323302710;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varZormB11232330279 = varZormB112323302710 = K2A.ar(t_trig).dup;
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
varZormB11232330279 = TwoTube.ar(x, varZormB11232330279, RHPF.ar(wave * DC.ar(0.15320599079132), wave * DC.ar(0.88820767402649), wave * DC.ar(0.098684549331665), wave * DC.ar(0.15822649002075), wave * DC.ar(0.62360394001007)), modZ, gateEnv * env, RedPhasor.ar(wave * DC.ar(0.43504393100739), wave * DC.ar(0.82653105258942), wave * DC.ar(0.79690480232239), wave * DC.ar(0.20451366901398), wave * DC.ar(0.82059323787689), wave * DC.ar(0.80222105979919), wave * DC.ar(0.63864719867706)), Silent.ar());
varZormB112323302710 = FoaPanB.ar(varZormB112323302710 * in, signal * env, modX, 0.57209192886329 * RunningMin.ar(wave * DC.ar(0.35258984565735), wave * DC.ar(0.1814101934433)), Silent.ar());
varZormB11232330279 = BufAllpassL.ar(Array.fill(2.pow(12), { |i| rrand(-1, 1) }).as(LocalBuf), env, modX, wave * signal, modX, Silent.ar());
varZormB112323302710 = VOsc.ar(Array.fill(2.pow(10), { |i| rrand(-1, 1) }).as(LocalBuf), in * modX, signal * modZ, signal, QuadN.ar(wave * DC.ar(0.87404048442841), wave * DC.ar(0.68812143802643), wave * DC.ar(0.94405114650726), wave * DC.ar(0.47751986980438), wave * DC.ar(0.61409091949463), wave * DC.ar(0.12343275547028), wave * DC.ar(0.65665209293365)));

signal = varZormB112323302710;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// X97M.vcx.h233027
/////////////////////////////////////////////////////////

SynthDef.new("X97M.vcx.h233027", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varX97Mvcxh2330279, varX97Mvcxh23302710;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varX97Mvcxh2330279 = varX97Mvcxh23302710 = K2A.ar(t_trig).dup;
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
varX97Mvcxh2330279 = Rotate2.ar(gateEnv, modZ * signal, env);
varX97Mvcxh23302710 = Clipper32.ar(y, env, in * modZ);
varX97Mvcxh2330279 = BufAllpassN.ar(wave * DC.ar(0.91395592689514), wave * DC.ar(0.35668087005615), wave * DC.ar(0.78086721897125), wave * DC.ar(0.97092318534851), wave * DC.ar(0.28794574737549), wave * DC.ar(0.71032571792603));
varX97Mvcxh23302710 = WaveLoss.ar(modY * modX, x, modY, wave * signal, BFManipulate.ar(wave * DC.ar(0.009276270866394), wave * DC.ar(0.057274699211121), wave * DC.ar(0.11561751365662), wave * DC.ar(0.78167414665222), wave * DC.ar(0.34322595596313), wave * DC.ar(0.78779458999634), wave * DC.ar(0.67964100837708)), Silent.ar());

signal = varX97Mvcxh23302710;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Vien.629233027
/////////////////////////////////////////////////////////

SynthDef.new("Vien.629233027", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varVien6292330279, varVien62923302710, varVien62923302711, varVien62923302712, varVien62923302713;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varVien6292330279 = varVien62923302710 = varVien62923302711 = varVien62923302712 = varVien62923302713 = K2A.ar(t_trig).dup;
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
varVien6292330279 = GrayNoise.ar(DetectSilence.ar(wave * DC.ar(0.91979765892029), wave * DC.ar(0.72635567188263), wave * DC.ar(0.12025511264801), wave * DC.ar(0.10111725330353)), Silent.ar());
varVien62923302710 = Disintegrator.ar(varVien62923302713 * gateEnv, 0.23617279529572 * in * modZ, 0.99925325027544 * modZ * signal, varVien62923302711, Silent.ar());
varVien62923302711 = APF.ar(x, varVien62923302710, gateEnv * varVien6292330279, modX, Silent.ar());
varVien62923302712 = FBSineC.ar(in, varVien62923302712 * modY, modX * varVien62923302711, DoubleWell3.ar(wave * DC.ar(0.54373168945312), wave * DC.ar(0.62112176418304), wave * DC.ar(0.98277878761292), wave * DC.ar(0.28685355186462), wave * DC.ar(0.55166327953339), wave * DC.ar(0.006627082824707), wave * DC.ar(0.13696014881134), wave * DC.ar(0.0333012342453)), modZ, varVien62923302713, x, varVien62923302713, Silent.ar());
varVien62923302713 = LFDNoise3.ar(FoaPushZ.ar(wave * DC.ar(0.20964825153351), wave * DC.ar(0.16650462150574), wave * DC.ar(0.56004595756531), wave * DC.ar(0.96428847312927)).exprange(1, SampleRate.ir), varVien62923302710.thresh(FMHEncode0.ar(wave * DC.ar(0.72808587551117), wave * DC.ar(0.40268743038177), wave * DC.ar(0.31064879894257), wave * DC.ar(0.8396942615509))), NTube.ar(wave * DC.ar(0.79769122600555), wave * DC.ar(0.86619293689728), wave * DC.ar(0.37406814098358), wave * DC.ar(0.57609510421753), wave * DC.ar(0.16934764385223), wave * DC.ar(0.71464776992798)));
varVien6292330279 = ZeroCrossing.ar(wave * DC.ar(0.74626314640045));
varVien62923302710 = BPZ2.ar(modZ * varVien6292330279, modY, Silent.ar());
varVien62923302711 = UHJ2B.ar(0.68792676925659 * env * varVien6292330279, varVien62923302713);
varVien62923302712 = MembraneCircle.ar(varVien62923302711, island, varVien62923302710.ring4(SoftClipper8.ar(wave * DC.ar(0.37980151176453))), 0.99991832926346 * Wrap.ar(wave * DC.ar(0.065890550613403), wave * DC.ar(0.97160041332245), wave * DC.ar(0.37056386470795)), Silent.ar());
varVien62923302713 = FreqShift.ar(modX * gateEnv, PVInfo.ar(wave * DC.ar(0.99793076515198), wave * DC.ar(0.46685659885406), wave * DC.ar(0.66877472400665), wave * DC.ar(0.49935305118561), wave * DC.ar(0.81707084178925)).exprange(1, SampleRate.ir), modZ * gateEnv, 0.99824781106511 * in * modX.blend(wave * DC.ar(0.21494948863983), wave * DC.ar(0.25710868835449)), Silent.ar());

signal = varVien62923302713;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// HLLP.6416233028
/////////////////////////////////////////////////////////

SynthDef.new("HLLP.6416233028", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varHLLP64162330289, varHLLP641623302810, varHLLP641623302811;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varHLLP64162330289 = varHLLP641623302810 = varHLLP641623302811 = K2A.ar(t_trig).dup;
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
varHLLP64162330289 = TTendency.ar(gateEnv * in, gate, gateEnv * varHLLP641623302811, modY, varHLLP641623302811 * env, gateEnv * signal);
varHLLP641623302810 = RegaliaMitraEQ.ar(wave * signal, modZ * modX, 0.75321674346924 * env * wave, varHLLP64162330289 * signal, 0.99996756360892 * wave * varHLLP641623302811, Silent.ar());
varHLLP641623302811 = XFadeRotate.ar(0.71155691146851 * signal * varHLLP641623302811, 0.50457370281219 * varHLLP641623302811 * modZ);
varHLLP64162330289 = LinPan2.ar(x, in, amp);
varHLLP641623302810 = TDuty.ar(wave * DC.ar(0.75926184654236), wave * DC.ar(0.41244459152222), wave * DC.ar(0.20533299446106), wave * DC.ar(0.12455308437347), wave * DC.ar(0.96278667449951));
varHLLP641623302811 = FitzHughNagumo.ar(env, 0.15044963359833 * varHLLP64162330289 * signal, varHLLP641623302811 * modY, varHLLP64162330289, varHLLP641623302811, modZ, in, 0.99626596092697 * varHLLP641623302810 * gateEnv, Silent.ar());

signal = varHLLP641623302811;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Eastern233028
/////////////////////////////////////////////////////////

SynthDef.new("Eastern233028", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varEastern2330289;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varEastern2330289 = K2A.ar(t_trig).dup;
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
varEastern2330289 = Gendy1.ar(wave * env, 0.58568167686462 * modZ * in, XOut.ar((80 + (island * 2)), FoaPushZ.ar(wave * DC.ar(0.38195633888245), wave * DC.ar(0.86101615428925), wave * DC.ar(0.5357506275177), wave * DC.ar(0.13032150268555)), [LFNoise1.ar(wave * DC.ar(0.92334139347076), wave * DC.ar(0.43116128444672), wave * DC.ar(0.46027410030365)), Stepper.ar(wave * DC.ar(0.27123486995697), wave * DC.ar(0.68724775314331), wave * DC.ar(0.84720623493195), wave * DC.ar(0.33537173271179), wave * DC.ar(0.27796375751495), wave * DC.ar(0.98898887634277))]), gate, varEastern2330289 * signal, env * signal, wave, x, modZ * gateEnv, modZ, 0.99985591203175 * modY * gateEnv, Silent.ar());
varEastern2330289 = Logistic.ar(varEastern2330289, modY * modZ, t_trig, 0.90142023954119 * gateEnv * modX, Silent.ar());

signal = varEastern2330289;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Attitude.724233029
/////////////////////////////////////////////////////////

SynthDef.new("Attitude.724233029", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varAttitude7242330299, varAttitude72423302910, varAttitude72423302911, varAttitude72423302912, varAttitude72423302913, varAttitude72423302914, varAttitude72423302915;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varAttitude7242330299 = varAttitude72423302910 = varAttitude72423302911 = varAttitude72423302912 = varAttitude72423302913 = varAttitude72423302914 = varAttitude72423302915 = K2A.ar(t_trig).dup;
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
varAttitude7242330299 = Oregonator.ar(gate, varAttitude72423302911 * varAttitude72423302914, varAttitude72423302913, signal * varAttitude7242330299, env * varAttitude7242330299, modY, gateEnv, signal * wave, 0.99998399982055 * modZ, Silent.ar());
varAttitude72423302910 = DoubleWell3.ar(gate, z, amp, y, HenonC.ar(wave * DC.ar(0.3660991191864), wave * DC.ar(0.5361602306366), wave * DC.ar(0.7892130613327), wave * DC.ar(0.94151794910431), wave * DC.ar(0.92439830303192), wave * DC.ar(0.76164710521698), wave * DC.ar(0.039467573165894)), varAttitude72423302912, 0.99986528694654 * wave * gateEnv, Lag2.ar(wave * DC.ar(0.14848291873932), wave * DC.ar(0.24371373653412), wave * DC.ar(0.45037627220154), wave * DC.ar(0.31631314754486)));
varAttitude72423302911 = GbmanL.ar(modZ, 0.44252610206604 * Streson.ar(wave * DC.ar(0.89572370052338), wave * DC.ar(0.34200060367584), wave * DC.ar(0.34626042842865), wave * DC.ar(0.89967262744904), wave * DC.ar(0.47035264968872)), island, Slew.ar(wave * DC.ar(0.56258249282837), wave * DC.ar(0.70090591907501), wave * DC.ar(0.88654577732086), wave * DC.ar(0.66620290279388), wave * DC.ar(0.049799680709839)), Silent.ar());
varAttitude72423302912 = Tumble.ar(x, modZ, modX * modZ, signal * varAttitude72423302912, gateEnv * in);
varAttitude72423302913 = BFEncodeSter.ar(InGrain.ar(gateEnv * modX, varAttitude72423302912 * gateEnv, varAttitude72423302912, 0.95471760660716 * modZ * varAttitude72423302913, Silent.ar()), 0.96002578735352 * modX * varAttitude7242330299.slew(wave * DC.ar(0.074311375617981), wave * DC.ar(0.53410172462463)), varAttitude72423302913 * varAttitude72423302911, varAttitude72423302913 * varAttitude7242330299, modX, island, varAttitude72423302913 * varAttitude72423302915, gateEnv);
varAttitude72423302914 = InGrainBF.ar(varAttitude72423302912, varAttitude72423302910 * varAttitude72423302910, varAttitude72423302910 * varAttitude72423302914, varAttitude72423302910, gate, varAttitude72423302913, amp, 0.99025387771803 * wave * modZ, Allpass1.ar(wave * DC.ar(0.48136794567108), wave * DC.ar(0.28404796123505), wave * DC.ar(0.26456141471863), wave * DC.ar(0.67225635051727)));
varAttitude72423302915 = FoaTilt.ar(modZ * varAttitude7242330299, varAttitude72423302911, 0.99804443860121 * modY * varAttitude72423302913, Silent.ar());
varAttitude7242330299 = Oregonator.ar(modY, varAttitude7242330299 * varAttitude72423302914, varAttitude72423302910, varAttitude72423302911 * varAttitude72423302914, wave * modY, varAttitude72423302915, island, gate, wave, Silent.ar());
varAttitude72423302910 = FoaTumble.ar(wave * DC.ar(0.21191322803497), wave * DC.ar(0.51875305175781), wave * DC.ar(0.38248288631439), wave * DC.ar(0.28999471664429));
varAttitude72423302911 = Spring.ar(modZ * wave, 0.30090391635895 * LPF1.ar(wave * DC.ar(0.72512447834015), wave * DC.ar(0.60302317142487)), 0.49018514156342 * modX * gateEnv);
varAttitude72423302912 = AmpComp.ar(wave * DC.ar(0.19261336326599), wave * DC.ar(0.39812469482422), wave * DC.ar(0.30414402484894));
varAttitude72423302913 = Duty.ar(0.90081918239594 * modZ * varAttitude72423302913, island.linexp(wave * DC.ar(0.99674367904663), wave * DC.ar(0.47604501247406), wave * DC.ar(0.59265089035034), wave * DC.ar(0.81488358974457), wave * DC.ar(0.65108013153076)), modX, varAttitude72423302911);
varAttitude72423302914 = BRF.ar(0.70418775081635 * env * modZ, modX, varAttitude72423302910 * modZ, SinGrainBF.ar(wave * DC.ar(0.73768591880798), wave * DC.ar(0.068397879600525), wave * DC.ar(0.20212125778198), wave * DC.ar(0.34268653392792), wave * DC.ar(0.87840747833252), wave * DC.ar(0.63905787467957), wave * DC.ar(0.40439903736115), wave * DC.ar(0.86317813396454), wave * DC.ar(0.16290473937988)), Silent.ar());
varAttitude72423302915 = StkBandedWG.ar(wave * DC.ar(0.0072109699249268), wave.abs + DC.ar(0.15967428684235), wave.abs + DC.ar(0.66881453990936), wave.abs + DC.ar(0.51287007331848), wave.abs + DC.ar(0.80300509929657), wave.abs + DC.ar(0.61520731449127), wave.abs + DC.ar(0.63871359825134), wave.abs + DC.ar(0.075629234313965), wave * DC.ar(0.40032196044922), 1);

signal = varAttitude72423302915;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Father_Mac.306.B233029
/////////////////////////////////////////////////////////

SynthDef.new("Father_Mac.306.B233029", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varFather_Mac306B2330299, varFather_Mac306B23302910;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varFather_Mac306B2330299 = varFather_Mac306B23302910 = K2A.ar(t_trig).dup;
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
varFather_Mac306B2330299 = LPZ2.ar(x, varFather_Mac306B2330299, BFEncodeSter.ar(wave * DC.ar(0.60888636112213), wave * DC.ar(0.82685244083405), wave * DC.ar(0.828369140625), wave * DC.ar(0.7123498916626), wave * DC.ar(0.60276126861572), wave * DC.ar(0.036690473556519), wave * DC.ar(0.84910452365875), wave * DC.ar(0.35186731815338)));
varFather_Mac306B23302910 = TGaussRand.ar(modZ * env, modZ.clip2(OnePole.ar(wave * DC.ar(0.51143217086792), wave * DC.ar(0.092794179916382), wave * DC.ar(0.26204359531403), wave * DC.ar(0.94389843940735))), BufGrainB.ar(wave * DC.ar(0.43207895755768), wave * DC.ar(0.21424555778503), wave * DC.ar(0.75090348720551), wave * DC.ar(0.1971378326416), wave * DC.ar(0.053568243980408), wave * DC.ar(0.74488949775696), wave * DC.ar(0.73055529594421), wave * DC.ar(0.80901336669922), wave * DC.ar(0.77641940116882)), modX, Silent.ar());
varFather_Mac306B2330299 = SMS.ar(Ramp.ar(wave * DC.ar(0.65346765518188), wave * DC.ar(0.48176264762878), wave * DC.ar(0.74451613426208), wave * DC.ar(0.2997567653656)), amp, z, amp, island.lagud(wave * DC.ar(0.7829772233963), wave * DC.ar(0.68974006175995)), CuspN.ar(wave * DC.ar(0.20139527320862), wave * DC.ar(0.69928991794586), wave * DC.ar(0.51466381549835), wave * DC.ar(0.88855648040771), wave * DC.ar(0.79467356204987), wave * DC.ar(0.38238453865051)), BinData.ar(wave * DC.ar(0.53522408008575), wave * DC.ar(0.76816248893738), wave * DC.ar(0.59309101104736)), 0.28762519359589 * varFather_Mac306B2330299, wave * varFather_Mac306B2330299, 0.99995348088032 * modX * wave, Array.fill(2.pow(12), { |i| rrand(-1, 1) }).as(LocalBuf).scaleneg(B2Ster.ar(wave * DC.ar(0.55001306533813), wave * DC.ar(0.92267441749573), wave * DC.ar(0.65790390968323), wave * DC.ar(0.94079232215881), wave * DC.ar(0.37747275829315))), 0.9964009357462 * varFather_Mac306B23302910 * modY, Silent.ar());
varFather_Mac306B23302910 = FoaPushZ.ar(wave * DC.ar(0.25121068954468), wave * DC.ar(0.43336594104767), wave * DC.ar(0.60484111309052), wave * DC.ar(0.69244074821472));

signal = varFather_Mac306B23302910;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Father_Mac.306.B2330291
/////////////////////////////////////////////////////////

SynthDef.new("Father_Mac.306.B2330291", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varFather_Mac306B2330299, varFather_Mac306B23302910, varFather_Mac306B233029111, varFather_Mac306B233029112, varFather_Mac306B233029113;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varFather_Mac306B2330299 = varFather_Mac306B23302910 = varFather_Mac306B233029111 = varFather_Mac306B233029112 = varFather_Mac306B233029113 = K2A.ar(t_trig).dup;
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
varFather_Mac306B2330299 = TwoZero.ar(B2A.ar(y, amp, 0.52046489715576 * varFather_Mac306B2330299, in * varFather_Mac306B233029113), modY * varFather_Mac306B233029113, gateEnv * varFather_Mac306B233029113, EnvDetect.ar(wave * DC.ar(0.70528876781464), wave * DC.ar(0.030730843544006), wave * DC.ar(0.90408360958099)), Silent.ar());
varFather_Mac306B23302910 = Tap.ar(Array.fill(2.pow(11), { |i| rrand(-1, 1) }).as(LocalBuf), 2, wave * modY);
varFather_Mac306B2330299 = Ramp.ar(varFather_Mac306B233029112 * varFather_Mac306B233029111, varFather_Mac306B233029113 * varFather_Mac306B2330299, LFClipNoise.ar(wave * DC.ar(0.53508794307709), wave * DC.ar(0.70096790790558), wave * DC.ar(0.51556074619293)), Silent.ar());
varFather_Mac306B23302910 = FMHDecode1.ar(wave * DC.ar(0.52722096443176), wave * DC.ar(0.95116853713989), wave * DC.ar(0.6687970161438), wave * DC.ar(0.9468537569046), wave * DC.ar(0.68006324768066), wave * DC.ar(0.60323178768158), wave * DC.ar(0.026539921760559), wave * DC.ar(0.54860627651215), wave * DC.ar(0.18736517429352), wave * DC.ar(0.49271905422211), wave * DC.ar(0.074627280235291), wave * DC.ar(0.57974982261658), wave * DC.ar(0.54821693897247));
// Variation test code
varFather_Mac306B233029111 = MoogFF.ar(gate, modX, varFather_Mac306B23302910 * varFather_Mac306B23302910, amp, 0.99970331520232 * varFather_Mac306B233029112 * varFather_Mac306B23302910, Silent.ar());
varFather_Mac306B233029112 = StandardN.ar(LTI.ar(varFather_Mac306B23302910 * DC.ar(0.76301848888397), varFather_Mac306B23302910 * DC.ar(0.32078969478607), varFather_Mac306B23302910 * DC.ar(0.59708881378174), varFather_Mac306B23302910 * DC.ar(0.57413458824158), varFather_Mac306B23302910 * DC.ar(0.80347990989685)).exprange(1, SampleRate.ir), varFather_Mac306B23302910 * gateEnv, bufnum, gate, varFather_Mac306B2330299, LFDClipNoise.ar(varFather_Mac306B2330299 * DC.ar(0.30288982391357), varFather_Mac306B2330299 * DC.ar(0.93135559558868), varFather_Mac306B23302910 * DC.ar(0.68070220947266)));
varFather_Mac306B233029113 = B2UHJ.ar(in, bufnum, gate);
varFather_Mac306B233029111 = RunningMin.ar(varFather_Mac306B233029111, signal * env);
varFather_Mac306B233029112 = EnvFollow.ar(gateEnv * gateEnv, varFather_Mac306B233029112 * gateEnv, 0.99697501497367 * RMShelf.ar(varFather_Mac306B23302910 * DC.ar(0.24573969841003), varFather_Mac306B2330299 * DC.ar(0.54405677318573), varFather_Mac306B2330299 * DC.ar(0.6458135843277), varFather_Mac306B23302910 * DC.ar(0.61887180805206), varFather_Mac306B23302910 * DC.ar(0.68982565402985)).slew(varFather_Mac306B2330299 * DC.ar(0.48347973823547), varFather_Mac306B23302910 * DC.ar(0.26771724224091)), Silent.ar());
varFather_Mac306B233029113 = Clipper8.ar(varFather_Mac306B233029112, modY, varFather_Mac306B23302910);
varFather_Mac306B233029111 = BeatWarper.ar(2, Array.fill(2.pow(12), { |i| rrand(-1, 1) }).as(LocalBuf), varFather_Mac306B233029113, modZ * modX, gateEnv * varFather_Mac306B233029111, in * modZ, varFather_Mac306B23302910 * varFather_Mac306B233029113, IFFT.ar(Array.fill(2.pow(12), { |i| rrand(-1, 1) }).as(LocalBuf), varFather_Mac306B233029113 * env, y), LFNoise1.ar(varFather_Mac306B2330299 * DC.ar(0.77075850963593), varFather_Mac306B23302910 * DC.ar(0.29561793804169), varFather_Mac306B2330299 * DC.ar(0.99920868873596)), Silent.ar());
varFather_Mac306B233029112 = GrayNoise.ar(0.99998149742153 * BRZ2.ar(varFather_Mac306B2330299 * DC.ar(0.38711643218994), varFather_Mac306B23302910 * DC.ar(0.2261791229248), varFather_Mac306B23302910 * DC.ar(0.54840242862701)), MantissaMask.ar(varFather_Mac306B23302910 * DC.ar(0.61913895606995), varFather_Mac306B23302910 * DC.ar(0.997518658638), varFather_Mac306B23302910 * DC.ar(0.091924667358398), varFather_Mac306B2330299 * DC.ar(0.26463234424591)));
varFather_Mac306B233029113 = OSFold8.ar(bufnum, modZ, modX);

signal = varFather_Mac306B233029113;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// MUHAHAH233029
/////////////////////////////////////////////////////////

SynthDef.new("MUHAHAH233029", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varMUHAHAH2330299, varMUHAHAH23302910, varMUHAHAH23302911, varMUHAHAH23302912;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varMUHAHAH2330299 = varMUHAHAH23302910 = varMUHAHAH23302911 = varMUHAHAH23302912 = K2A.ar(t_trig).dup;
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
varMUHAHAH2330299 = Integrator.ar(modX * wave, gateEnv * signal, 0.64060930952769 * env * in, Silent.ar());
varMUHAHAH23302910 = PVSynth.ar(Array.fill(2.pow(14), { |i| rrand(-1, 1) }).as(LocalBuf), env, in, varMUHAHAH23302912, varMUHAHAH23302912 * signal, varMUHAHAH23302911, varMUHAHAH23302912 * varMUHAHAH23302911, signal, Silent.ar());
varMUHAHAH23302911 = GbmanN.ar(in * gateEnv, varMUHAHAH23302911, varMUHAHAH23302912 * in, varMUHAHAH23302911, Silent.ar());
varMUHAHAH23302912 = AtsNoiSynth.ar(Array.fill(2.pow(10), { |i| rrand(-1, 1) }).as(LocalBuf), env * varMUHAHAH23302910, y, wave * varMUHAHAH23302911, gate, env * varMUHAHAH23302911, modX, modZ * varMUHAHAH23302912, FMGrainBF.ar(wave * DC.ar(0.98931074142456), wave * DC.ar(0.090172410011292), wave * DC.ar(0.49039113521576), wave * DC.ar(0.56354653835297), wave * DC.ar(0.31640017032623), wave * DC.ar(0.64220631122589), wave * DC.ar(0.043557524681091), wave * DC.ar(0.64674758911133), wave * DC.ar(0.05453634262085), wave * DC.ar(0.27327346801758), wave * DC.ar(0.90085911750793)).exprange(1, SampleRate.ir), env * varMUHAHAH23302910, varMUHAHAH23302910 * varMUHAHAH23302911, wave, IEnvGen.ar(wave * DC.ar(0.33869826793671), wave * DC.ar(0.92112994194031), wave * DC.ar(0.92523169517517), wave * DC.ar(0.75294697284698)), Silent.ar());
varMUHAHAH2330299 = WaveTerrain.ar(Array.fill(2.pow(16), { |i| rrand(-1, 1) }).as(LocalBuf), gateEnv * modX, gate, x, modX, varMUHAHAH23302911, Silent.ar());
varMUHAHAH23302910 = SN76489.ar(signal, wave, y, 0.21528136730194 * modY * wave, z, varMUHAHAH23302912, amp, env, in);
varMUHAHAH23302911 = Balance.ar(gateEnv * in, 0.8743634223938 * gateEnv * signal, QuadN.ar(wave * DC.ar(0.20624566078186), wave * DC.ar(0.22992014884949), wave * DC.ar(0.6604311466217), wave * DC.ar(0.63113021850586), wave * DC.ar(0.73870718479156), wave * DC.ar(0.13167285919189), wave * DC.ar(0.8217226266861)), varMUHAHAH23302910 * in, RunningMin.ar(wave * DC.ar(0.066489696502686), wave * DC.ar(0.88749730587006)), Silent.ar());
varMUHAHAH23302912 = RegaliaMitraEQ.ar(varMUHAHAH23302910 * wave, varMUHAHAH23302910, in, varMUHAHAH23302912 * modY, BBandPass.ar(wave * DC.ar(0.27730119228363), wave * DC.ar(0.81544864177704), wave * DC.ar(0.77541697025299), wave * DC.ar(0.79894399642944), wave * DC.ar(0.79716527462006)), Silent.ar());

signal = varMUHAHAH23302912;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Predator.1036233030
/////////////////////////////////////////////////////////

SynthDef.new("Predator.1036233030", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varPredator10362330309, varPredator103623303010;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varPredator10362330309 = varPredator103623303010 = K2A.ar(t_trig).dup;
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
varPredator10362330309 = Tap.ar(Array.fill(2.pow(10), { |i| rrand(-1, 1) }).as(LocalBuf), 2, modZ.excess(FincoSprottL.ar(wave * DC.ar(0.2695723772049), wave * DC.ar(0.44064259529114), wave * DC.ar(0.9774169921875), wave * DC.ar(0.74132990837097), wave * DC.ar(0.37181949615479), wave * DC.ar(0.72665369510651), wave * DC.ar(0.44938766956329), wave * DC.ar(0.96793937683105))));
varPredator103623303010 = LatoocarfianC.ar(modX * gateEnv, 0.046059250831604 * wave, varPredator103623303010.clip(wave * DC.ar(0.072496652603149), wave * DC.ar(0.35164022445679)), in * varPredator10362330309, modX * varPredator103623303010, z, wave * wave, 0.25852100114052 * modX * wave, Silent.ar());
varPredator10362330309 = ClipNoise.ar(signal, FMGrainB.ar(wave * DC.ar(0.39183628559113), wave * DC.ar(0.27374589443207), wave * DC.ar(0.017474889755249), wave * DC.ar(0.37374603748322), wave * DC.ar(0.99467241764069), wave * DC.ar(0.84277725219727), wave * DC.ar(0.3286679983139), wave * DC.ar(0.072044014930725)));
varPredator103623303010 = Fhn2DN.ar(env, Integrator.ar(wave * DC.ar(0.63677406311035), wave * DC.ar(0.047135353088379), wave * DC.ar(0.17515778541565), wave * DC.ar(0.67851758003235)).exprange(1, SampleRate.ir), modZ * modX, varPredator103623303010 * varPredator10362330309, y, z, gateEnv, t_trig, 0.74397051334381 * in * wave, gateEnv, Silent.ar());

signal = varPredator103623303010;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Gonzal.602330301
/////////////////////////////////////////////////////////

SynthDef.new("Gonzal.602330301", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varGonzal602330309, varGonzal6023303010, varGonzal6023303011, varGonzal6023303012, varGonzal6023303013, varGonzal6023303014, varGonzal6023303015, varGonzal60233030116, varGonzal60233030117, varGonzal60233030118, varGonzal60233030119;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varGonzal602330309 = varGonzal6023303010 = varGonzal6023303011 = varGonzal6023303012 = varGonzal6023303013 = varGonzal6023303014 = varGonzal6023303015 = varGonzal60233030116 = varGonzal60233030117 = varGonzal60233030118 = varGonzal60233030119 = K2A.ar(t_trig).dup;
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
varGonzal602330309 = DetectSilence.ar(OSFold4.ar(0.29669463634491 * varGonzal6023303011 * modX, amp, varGonzal60233030116 * varGonzal6023303013).lag3(wave * DC.ar(0.60795080661774), wave * DC.ar(0.74634301662445)), modY * varGonzal60233030119, modY, amp);
varGonzal6023303010 = COsc.ar(Array.fill(2.pow(16), { |i| rrand(-1, 1) }).as(LocalBuf), modX, 0.18612957000732 * modY * varGonzal602330309, PitchShift.ar(wave * DC.ar(0.95320117473602), wave * DC.ar(0.32518398761749), wave * DC.ar(0.27838587760925), wave * DC.ar(0.83138465881348), wave * DC.ar(0.81006217002869), wave * DC.ar(0.11236262321472), wave * DC.ar(0.12687528133392)), Silent.ar());
varGonzal6023303011 = StereoConvolution2L.ar(0.080579042434692 * KmeansToBPSet1.ar(wave * DC.ar(0.58878552913666), wave * DC.ar(0.51836562156677), wave * DC.ar(0.7695871591568), wave * DC.ar(0.14249956607819), wave * DC.ar(0.49670720100403), wave * DC.ar(0.34578251838684), wave * DC.ar(0.60775136947632), wave * DC.ar(0.57684504985809), wave * DC.ar(0.22995853424072), wave * DC.ar(0.10181403160095)), varGonzal6023303015 * varGonzal60233030117, varGonzal60233030118, modY * gateEnv, varGonzal60233030119 * varGonzal6023303012, varGonzal6023303014 * modZ, RosslerResL.ar(wave * DC.ar(0.61841726303101), wave * DC.ar(0.13955187797546), wave * DC.ar(0.075381517410278), wave * DC.ar(0.10374104976654), wave * DC.ar(0.90843915939331), wave * DC.ar(0.47536993026733), wave * DC.ar(0.80169761180878), wave * DC.ar(0.5090526342392), wave * DC.ar(0.74147439002991), wave * DC.ar(0.68000674247742), wave * DC.ar(0.067823052406311), wave * DC.ar(0.50838720798492)), Silent.ar());
varGonzal6023303012 = Line.ar(varGonzal602330309 * varGonzal60233030117, wave, in, varGonzal6023303014, AtsNoiSynth.ar(wave * DC.ar(0.033056616783142), wave * DC.ar(0.38613951206207), wave * DC.ar(0.88977873325348), wave * DC.ar(0.09358549118042), wave * DC.ar(0.31609964370728), wave * DC.ar(0.81627309322357), wave * DC.ar(0.9201831817627), wave * DC.ar(0.031735897064209), wave * DC.ar(0.079601049423218), wave * DC.ar(0.13442492485046), wave * DC.ar(0.85838282108307), wave * DC.ar(0.91213178634644), wave * DC.ar(0.46186983585358), wave * DC.ar(0.84637725353241)), in * varGonzal6023303015);
varGonzal6023303013 = QuadL.ar(modX, varGonzal6023303012 * varGonzal6023303014, varGonzal60233030118 * modZ, varGonzal6023303015, varGonzal6023303012 * varGonzal602330309, 0.98306707220584 * varGonzal6023303013 * modY, Silent.ar());
varGonzal6023303014 = PeakEQ4.ar(varGonzal60233030116 * varGonzal6023303012, Lag2.ar(wave * DC.ar(0.87159717082977), wave * DC.ar(0.81313765048981), wave * DC.ar(0.83476197719574), wave * DC.ar(0.010488867759705)).exprange(1, SampleRate.ir), 0.45136642456055 * varGonzal6023303015 * varGonzal60233030119, gateEnv * varGonzal60233030117);
varGonzal6023303015 = Changed.ar(gateEnv * varGonzal6023303014, FoaPushX.ar(wave * DC.ar(0.59973061084747), wave * DC.ar(0.38188517093658), wave * DC.ar(0.14086186885834), wave * DC.ar(0.45490741729736)));
varGonzal602330309 = GrainIn.ar(2, varGonzal60233030119 * varGonzal6023303012, wave, x.lincurve(wave * DC.ar(0.84980285167694), wave * DC.ar(0.74152004718781), wave * DC.ar(0.61467397212982), wave * DC.ar(0.53858375549316), wave * DC.ar(0.99803066253662), wave * DC.ar(0.56566941738129)), StkModalBar.ar(wave * DC.ar(0.88601362705231), wave * DC.ar(0.40894269943237), wave * DC.ar(0.38192486763), wave * DC.ar(0.061781525611877), wave * DC.ar(0.52140963077545), wave * DC.ar(0.318314909935), wave * DC.ar(0.097598791122437), wave * DC.ar(0.22866988182068), wave * DC.ar(0.28269422054291), wave * DC.ar(0.087601780891418), wave * DC.ar(0.27170705795288)), bufnum, varGonzal60233030118 * varGonzal6023303012, 0.98310756000251 * varGonzal6023303014 * varGonzal60233030116, TExpRand.ar(wave * DC.ar(0.98976385593414), wave * DC.ar(0.34535419940948), wave * DC.ar(0.22674131393433)));
varGonzal6023303010 = Integrator.ar(varGonzal6023303011 * varGonzal60233030118, modX, 0.99919594411656 * varGonzal60233030119 * modY, Silent.ar());
varGonzal6023303011 = FMHEncode1.ar(modZ, island, modX * varGonzal6023303013, 0.86302304267883 * in * varGonzal60233030119, in * varGonzal6023303012, varGonzal6023303013 * varGonzal6023303011);
varGonzal6023303012 = Lag2UD.ar(varGonzal6023303013 * wave, x, 0.62633419036865 * TPV.ar(wave * DC.ar(0.17572283744812), wave * DC.ar(0.35346221923828), wave * DC.ar(0.10260987281799), wave * DC.ar(0.060967326164246), wave * DC.ar(0.05462646484375), wave * DC.ar(0.59305644035339), wave * DC.ar(0.38202977180481), wave * DC.ar(0.18729448318481), wave * DC.ar(0.98281645774841), wave * DC.ar(0.86035263538361)), QuadC.ar(wave * DC.ar(0.41661882400513), wave * DC.ar(0.38953709602356), wave * DC.ar(0.61447036266327), wave * DC.ar(0.54687464237213), wave * DC.ar(0.84918999671936), wave * DC.ar(0.2228569984436), wave * DC.ar(0.7924473285675)), Silent.ar());
varGonzal6023303013 = VOsc3.ar(Array.fill(2.pow(12), { |i| rrand(-1, 1) }).as(LocalBuf), varGonzal6023303012, varGonzal602330309 * varGonzal6023303013, wave * modX, SwitchDelay.ar(wave * DC.ar(0.01605212688446), wave * DC.ar(0.64027488231659), wave * DC.ar(0.27497947216034), wave * DC.ar(0.32656514644623), wave * DC.ar(0.38106882572174), wave * DC.ar(0.84997630119324), wave * DC.ar(0.69789981842041), wave * DC.ar(0.44687831401825)), Silent.ar());
varGonzal6023303014 = CheckBadValues.ar(varGonzal602330309 * varGonzal6023303010, y, gate);
varGonzal6023303015 = YigClifford3DL.ar(env * in, y, island, island, varGonzal6023303012 * in, modZ, varGonzal6023303014 * env, varGonzal602330309, 0.62828903809717 * varGonzal6023303011 * modX, Silent.ar());
// Variation test code
varGonzal60233030116 = CombFormlet.ar(varGonzal60233030116 * varGonzal602330309, signal * varGonzal6023303014, BufAllpassC.ar(Array.fill(2.pow(13), { |i| rrand(-1, 1) }).as(LocalBuf), varGonzal6023303011, 0.051394939422607 * Osc.ar(varGonzal6023303013 * DC.ar(0.26487982273102), varGonzal6023303013 * DC.ar(0.40903174877167), varGonzal602330309 * DC.ar(0.53857266902924), varGonzal6023303013 * DC.ar(0.047445058822632), varGonzal6023303010 * DC.ar(0.13413226604462)), 0.2195725440979 * RMEQ.ar(varGonzal6023303013 * DC.ar(0.67399191856384), varGonzal6023303012 * DC.ar(0.21926283836365), varGonzal6023303012 * DC.ar(0.75651454925537), varGonzal6023303011 * DC.ar(0.84443199634552), varGonzal6023303012 * DC.ar(0.32605397701263), varGonzal6023303014 * DC.ar(0.29844033718109)), RunningMax.ar(varGonzal6023303011 * DC.ar(0.16113579273224), varGonzal6023303015 * DC.ar(0.49228131771088)), WaveLoss.ar(varGonzal6023303014 * DC.ar(0.92297255992889), varGonzal602330309 * DC.ar(0.95671677589417), varGonzal6023303014 * DC.ar(0.9482182264328), varGonzal6023303015 * DC.ar(0.37112545967102), varGonzal6023303015 * DC.ar(0.90235579013824), varGonzal6023303012 * DC.ar(0.56174230575562))), 0.60902488231659 * in * varGonzal602330309, 0.99967615780537 * varGonzal6023303014 * in, TwoPole.ar(varGonzal6023303014 * DC.ar(0.98033046722412), varGonzal6023303015 * DC.ar(0.31012392044067), varGonzal602330309 * DC.ar(0.608283162117), varGonzal6023303010 * DC.ar(0.19567370414734), varGonzal6023303012 * DC.ar(0.60878658294678)), Standard2DC.ar(Gbman2DN.ar(varGonzal6023303014 * DC.ar(0.44652855396271), varGonzal602330309 * DC.ar(0.34301340579987), varGonzal6023303010 * DC.ar(0.7489253282547), varGonzal6023303013 * DC.ar(0.56973099708557), varGonzal6023303011 * DC.ar(0.95552241802216), varGonzal6023303013 * DC.ar(0.50081729888916)).exprange(1, SampleRate.ir), in, varGonzal6023303012 * gateEnv, varGonzal6023303015, varGonzal6023303014, modX, Silent.ar()));
varGonzal60233030117 = TBrownRand.ar(varGonzal6023303012 * gateEnv, varGonzal6023303012.fold(varGonzal6023303011 * DC.ar(0.45141351222992), varGonzal6023303014 * DC.ar(0.85684025287628)), varGonzal60233030116.exprange(varGonzal6023303014 * DC.ar(0.46358752250671), varGonzal6023303013 * DC.ar(0.94787526130676)), env, env * signal, modY, Silent.ar());
varGonzal60233030118 = LFNoise1.ar(wave * varGonzal6023303011, 0.94614739386172 * varGonzal6023303015, Silent.ar());
varGonzal60233030119 = Formlet.ar(varGonzal6023303011, modX * modX, wave * varGonzal6023303011, in * modX.lag3(varGonzal6023303013 * DC.ar(0.72871840000153), varGonzal6023303012 * DC.ar(0.4060480594635)), modY, Silent.ar());
varGonzal60233030116 = TGrains2.ar(2, varGonzal6023303013 * varGonzal6023303015, Array.fill(2.pow(10), { |i| rrand(-1, 1) }).as(LocalBuf), varGonzal6023303015 * varGonzal60233030119.fold2(TExpRand.ar(varGonzal6023303014 * DC.ar(0.55776488780975), varGonzal6023303010 * DC.ar(0.55726850032806), varGonzal6023303013 * DC.ar(0.46051597595215))), gate, y, varGonzal6023303010, wave * modY.curvelin(varGonzal6023303010 * DC.ar(0.21090972423553), varGonzal6023303010 * DC.ar(0.57745146751404), varGonzal6023303011 * DC.ar(0.34847092628479), varGonzal6023303014 * DC.ar(0.6481454372406), varGonzal6023303015 * DC.ar(0.49068021774292), varGonzal6023303015 * DC.ar(0.84206080436707)), 0.23926305770874 * varGonzal60233030119 * varGonzal6023303015, varGonzal6023303014 * modZ, 0.028853535652161 * SoftClipAmp.ar(varGonzal6023303010 * DC.ar(0.18426823616028), varGonzal6023303014 * DC.ar(0.53162682056427), varGonzal6023303013 * DC.ar(0.54545664787292), varGonzal602330309 * DC.ar(0.64157104492188)));
varGonzal60233030117 = Hilbert.ar(varGonzal60233030119 * varGonzal6023303010, modY, Silent.ar());
varGonzal60233030118 = PinkNoise.ar(varGonzal60233030119, Silent.ar());
varGonzal60233030119 = GrainBuf.ar(2, varGonzal6023303015 * modZ, modX * varGonzal6023303014, bufnum, varGonzal6023303015 * varGonzal60233030118, varGonzal6023303012, amp, gateEnv, bufnum, wave * varGonzal6023303013, 0.99993000612067 * modX * modX, Silent.ar());
varGonzal60233030116 = NLFiltC.ar(0.31269109249115 * varGonzal60233030117 * signal, varGonzal6023303015, AtsPartial.ar(Array.fill(2.pow(14), { |i| rrand(-1, 1) }).as(LocalBuf), varGonzal60233030119 * varGonzal6023303011, z, FoaFocusX.ar(varGonzal6023303011 * DC.ar(0.60950577259064), varGonzal6023303014 * DC.ar(0.72029161453247), varGonzal6023303014 * DC.ar(0.95344412326813), varGonzal6023303012 * DC.ar(0.30519437789917)).exprange(1, SampleRate.ir), MoogVCF.ar(varGonzal6023303014 * DC.ar(0.58588206768036), varGonzal602330309 * DC.ar(0.97305154800415), varGonzal6023303013 * DC.ar(0.48986613750458), varGonzal6023303010 * DC.ar(0.61010181903839), varGonzal6023303011 * DC.ar(0.91758942604065)).exprange(1, SampleRate.ir), 0.99881106878316 * in * varGonzal60233030117, Silent.ar()), varGonzal60233030118, signal, y, 0.9994206609712 * varGonzal60233030118, Silent.ar());
varGonzal60233030117 = XFade2.ar(env, amp.linexp(varGonzal6023303013 * DC.ar(0.56904816627502), varGonzal6023303010 * DC.ar(0.98203420639038), varGonzal6023303011 * DC.ar(0.8576043844223), varGonzal602330309 * DC.ar(0.45183122158051), varGonzal6023303013 * DC.ar(0.30923581123352)), varGonzal6023303014, LPF18.ar(in * varGonzal6023303010, MonoGrain.ar(varGonzal6023303011 * DC.ar(0.23240756988525), varGonzal6023303012 * DC.ar(0.40117120742798), varGonzal602330309 * DC.ar(0.61285614967346), varGonzal6023303015 * DC.ar(0.93393576145172), varGonzal6023303013 * DC.ar(0.2408983707428), varGonzal6023303011 * DC.ar(0.70749533176422)).exprange(1, SampleRate.ir), varGonzal6023303010, 0.71146678924561 * varGonzal60233030118 * varGonzal60233030117));
varGonzal60233030118 = RHPF.ar(0.084720015525818 * varGonzal60233030117 * in, Standard2DC.ar(varGonzal6023303013 * DC.ar(0.70939707756042), varGonzal602330309 * DC.ar(0.47694718837738), varGonzal6023303013 * DC.ar(0.066312909126282), varGonzal602330309 * DC.ar(0.24029564857483), varGonzal602330309 * DC.ar(0.38387608528137), varGonzal6023303014 * DC.ar(0.19616556167603), varGonzal6023303014 * DC.ar(0.29347121715546)).exprange(1, SampleRate.ir), varGonzal602330309 * varGonzal60233030119, StkMoog.ar(varGonzal6023303012 * DC.ar(0.055221438407898), varGonzal6023303011 * DC.ar(0.79064047336578), varGonzal6023303013 * DC.ar(0.47522902488708), varGonzal6023303010 * DC.ar(0.37805902957916), varGonzal6023303013 * DC.ar(0.6805819272995), varGonzal6023303011 * DC.ar(0.61290395259857), varGonzal602330309 * DC.ar(0.21034955978394), varGonzal6023303010 * DC.ar(0.17162024974823), varGonzal6023303013 * DC.ar(0.80555319786072)), Silent.ar());
varGonzal60233030119 = Astrocade.ar(varGonzal60233030116, y, varGonzal6023303013 * varGonzal6023303010, 0.39079713821411 * varGonzal6023303011 * varGonzal60233030119, wave * varGonzal6023303014, y.lag2ud(varGonzal6023303012 * DC.ar(0.69981729984283), varGonzal602330309 * DC.ar(0.79493403434753)), modX, varGonzal6023303011.lag2(varGonzal602330309 * DC.ar(0.72870552539825), varGonzal602330309 * DC.ar(0.77091777324677)));

signal = varGonzal60233030119;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// WM.ShowOff.BA233032
/////////////////////////////////////////////////////////

SynthDef.new("WM.ShowOff.BA233032", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varWMShowOffBA2330329, varWMShowOffBA23303210;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varWMShowOffBA2330329 = varWMShowOffBA23303210 = K2A.ar(t_trig).dup;
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
varWMShowOffBA2330329 = FOS.ar(x, bufnum, wave * modY, modZ * varWMShowOffBA23303210, in, Silent.ar());
varWMShowOffBA23303210 = Convolution2L.ar(varWMShowOffBA2330329 * varWMShowOffBA2330329, varWMShowOffBA2330329 * in, modY * gateEnv, 0.65335810184479 * gateEnv * wave, in, 0.99681548702168 * varWMShowOffBA2330329 * gateEnv, Silent.ar());
varWMShowOffBA2330329 = BufGrainI.ar(signal * modX, modZ * wave, bufnum, t_trig, z, bufnum, bufnum, in * in, gateEnv, gateEnv, Silent.ar());
varWMShowOffBA23303210 = Fhn2DL.ar(varWMShowOffBA23303210 * signal, varWMShowOffBA2330329 * in, modX * modZ.curvelin(wave * DC.ar(0.64047968387604), wave * DC.ar(0.73945295810699), wave * DC.ar(0.14565670490265), wave * DC.ar(0.69028508663177), wave * DC.ar(0.034051775932312), wave * DC.ar(0.00064921379089355)), env * modZ, InGrainI.ar(wave * DC.ar(0.14576292037964), wave * DC.ar(0.86885643005371), wave * DC.ar(0.042074799537659), wave * DC.ar(0.92579662799835), wave * DC.ar(0.27833199501038), wave * DC.ar(0.137082695961), wave * DC.ar(0.30413603782654), wave * DC.ar(0.092877388000488)), in * wave, varWMShowOffBA23303210 * wave, modY, varWMShowOffBA2330329, FOS.ar(wave * DC.ar(0.031799793243408), wave * DC.ar(0.090423822402954), wave * DC.ar(0.61665320396423), wave * DC.ar(0.25107502937317), wave * DC.ar(0.86079275608063), wave * DC.ar(0.14915323257446)), Silent.ar());

signal = varWMShowOffBA23303210;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");



/////////////////////////////////////////////////////////
// WM.ShowOff.BA2330321
/////////////////////////////////////////////////////////

SynthDef.new("WM.ShowOff.BA2330321", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varWMShowOffBA2330329, varWMShowOffBA23303210, varWMShowOffBA233032111, varWMShowOffBA233032112, varWMShowOffBA233032113;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varWMShowOffBA2330329 = varWMShowOffBA23303210 = varWMShowOffBA233032111 = varWMShowOffBA233032112 = varWMShowOffBA233032113 = K2A.ar(t_trig).dup;
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
varWMShowOffBA2330329 = YigClifford3DN.ar(modZ, bufnum, bufnum, x, gateEnv * gateEnv, gateEnv * in, varWMShowOffBA233032112, y, 0.82613660660687 * modZ * modZ, Slew.ar(wave * DC.ar(0.58669030666351), wave * DC.ar(0.34535300731659), wave * DC.ar(0.78133964538574), wave * DC.ar(0.38596832752228), wave * DC.ar(0.80052351951599)));
varWMShowOffBA23303210 = LorenzL.ar(varWMShowOffBA233032113 * signal, x, 0.26952564716339 * signal * modZ, modX * gateEnv, wave, 0.60975074768066 * varWMShowOffBA233032111 * env, varWMShowOffBA233032112 * varWMShowOffBA233032111, 0.7993358373642 * varWMShowOffBA233032112 * modY, 0.80769678265905 * modZ * env, Silent.ar());
varWMShowOffBA2330329 = NLFiltN.ar(wave * DC.ar(0.89425778388977), wave * DC.ar(0.46289265155792), wave * DC.ar(0.22149443626404), wave * DC.ar(0.23120832443237), wave * DC.ar(0.012928128242493), wave * DC.ar(0.75322246551514), wave * DC.ar(0.52597117424011), wave * DC.ar(0.64249038696289));
varWMShowOffBA23303210 = BufCombL.ar(wave * DC.ar(0.39031088352203), wave * DC.ar(0.073983907699585), wave * DC.ar(0.30860733985901), wave * DC.ar(0.14640140533447), wave * DC.ar(0.69122242927551), wave * DC.ar(0.17274188995361));
// Variation test code
varWMShowOffBA233032111 = Index.ar(Array.fill(2.pow(12), { |i| rrand(-1, 1) }).as(LocalBuf), 0.52045774459839 * varWMShowOffBA2330329 * wave, 0.44130505051256 * varWMShowOffBA233032112 * varWMShowOffBA2330329, Silent.ar());
varWMShowOffBA233032112 = TextVU.ar(varWMShowOffBA233032113 * varWMShowOffBA23303210, x, y, varWMShowOffBA23303210, island, modX * varWMShowOffBA233032111);
varWMShowOffBA233032113 = LPF1.ar(varWMShowOffBA23303210 * modZ, modX * gateEnv);
varWMShowOffBA233032111 = SwitchDelay.ar(varWMShowOffBA233032113 * modZ, env * env, in, bufnum, modZ * gateEnv, in, modZ, Silent.ar());
varWMShowOffBA233032112 = BPZ2.ar(0.94080746173859 * varWMShowOffBA23303210, 0.99677430105005 * env, Trig1.ar(varWMShowOffBA23303210 * DC.ar(0.79352879524231), varWMShowOffBA23303210 * DC.ar(0.23929619789124)));
varWMShowOffBA233032113 = Integrator.ar(gateEnv, 0.89216661453247 * varWMShowOffBA233032111 * modX, MoogFF.ar(varWMShowOffBA23303210 * DC.ar(0.11801648139954), varWMShowOffBA2330329 * DC.ar(0.41845464706421), varWMShowOffBA23303210 * DC.ar(0.8391432762146), varWMShowOffBA2330329 * DC.ar(0.29069912433624), varWMShowOffBA2330329 * DC.ar(0.65245079994202), varWMShowOffBA23303210 * DC.ar(0.57587575912476)), Silent.ar());
varWMShowOffBA233032111 = A2B.ar(MembraneCircle.ar(in, 0.35715854167938 * APF.ar(varWMShowOffBA2330329 * DC.ar(0.55712270736694), varWMShowOffBA2330329 * DC.ar(0.62432718276978), varWMShowOffBA23303210 * DC.ar(0.2243549823761), varWMShowOffBA23303210 * DC.ar(0.76245212554932), varWMShowOffBA23303210 * DC.ar(0.63832139968872)), modY * varWMShowOffBA233032111, 0.99398730858542 * gateEnv * varWMShowOffBA233032111, Silent.ar()), gateEnv, TGrains.ar(2, varWMShowOffBA233032113, Array.fill(2.pow(13), { |i| rrand(-1, 1) }).as(LocalBuf), x, 0.6808922290802 * Gendy4.ar(varWMShowOffBA23303210 * DC.ar(0.67115092277527), varWMShowOffBA23303210 * DC.ar(0.21416366100311), varWMShowOffBA23303210 * DC.ar(0.75495421886444), varWMShowOffBA2330329 * DC.ar(0.38622546195984), varWMShowOffBA2330329 * DC.ar(0.65176665782928), varWMShowOffBA2330329 * DC.ar(0.64046585559845), varWMShowOffBA23303210 * DC.ar(0.34893226623535), varWMShowOffBA2330329 * DC.ar(0.96734178066254), varWMShowOffBA2330329 * DC.ar(0.69383895397186), varWMShowOffBA2330329 * DC.ar(0.79149985313416), varWMShowOffBA23303210 * DC.ar(0.85297334194183), varWMShowOffBA2330329 * DC.ar(0.70768785476685)), 0.044437766075134 * wave * gateEnv, varWMShowOffBA233032112 * in, env, gate), gate);
varWMShowOffBA233032112 = Gendy5.ar(0.73184776306152 * env * wave, signal * modY, varWMShowOffBA233032112 * modZ, varWMShowOffBA233032111 * varWMShowOffBA233032111, varWMShowOffBA233032113 * varWMShowOffBA233032111, varWMShowOffBA23303210, env, wave * wave, varWMShowOffBA2330329, StkClarinet.ar(gateEnv * in, HenonC.ar(varWMShowOffBA2330329 * DC.ar(0.92255735397339), varWMShowOffBA23303210 * DC.ar(0.29439878463745), varWMShowOffBA2330329 * DC.ar(0.52349019050598), varWMShowOffBA23303210 * DC.ar(0.20549368858337), varWMShowOffBA23303210 * DC.ar(0.16908490657806), varWMShowOffBA2330329 * DC.ar(0.95749378204346), varWMShowOffBA23303210 * DC.ar(0.55038547515869)), Formant.ar(varWMShowOffBA2330329 * DC.ar(0.81126141548157), varWMShowOffBA23303210 * DC.ar(0.36884069442749), varWMShowOffBA23303210 * DC.ar(0.74364721775055), varWMShowOffBA23303210 * DC.ar(0.458411693573), varWMShowOffBA23303210 * DC.ar(0.50748181343079)), modZ, varWMShowOffBA2330329 * varWMShowOffBA2330329, wave * varWMShowOffBA233032113, varWMShowOffBA23303210 * wave, NLFiltC.ar(varWMShowOffBA2330329 * DC.ar(0.90754950046539), varWMShowOffBA2330329 * DC.ar(0.37789440155029), varWMShowOffBA23303210 * DC.ar(0.673903465271), varWMShowOffBA23303210 * DC.ar(0.70382106304169), varWMShowOffBA2330329 * DC.ar(0.88018703460693), varWMShowOffBA2330329 * DC.ar(0.39882564544678), varWMShowOffBA23303210 * DC.ar(0.15627586841583), varWMShowOffBA23303210 * DC.ar(0.16109704971313)), Silent.ar()), RLPFD.ar(varWMShowOffBA2330329 * DC.ar(0.90776228904724), varWMShowOffBA23303210 * DC.ar(0.67655694484711), varWMShowOffBA2330329 * DC.ar(0.55643689632416), varWMShowOffBA2330329 * DC.ar(0.69140899181366), varWMShowOffBA23303210 * DC.ar(0.33021259307861), varWMShowOffBA2330329 * DC.ar(0.95041513442993)), Latch.ar(varWMShowOffBA23303210 * DC.ar(0.27800023555756), varWMShowOffBA2330329 * DC.ar(0.033499598503113)));
varWMShowOffBA233032113 = RMShelf.ar(varWMShowOffBA2330329, varWMShowOffBA233032112, env * modZ, 0.70325321602844 * modX * wave, Silent.ar());

signal = varWMShowOffBA233032113;
signal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * env);

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");

)



