//////////////////////////////////////////////////////////////////////////////////////////////////////////
// GeneratedSynthDefs--Fri-Nov-22-17:46:54-2013
//////////////////////////////////////////////////////////////////////////////////////////////////////////


(
/////////////////////////////////////////////////////////
// Trojan.Ansibomb.Kit174527
/////////////////////////////////////////////////////////

SynthDef.new("Trojan.Ansibomb.Kit174527", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varTrojanAnsibombKit1745279, varTrojanAnsibombKit17452710;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varTrojanAnsibombKit1745279 = varTrojanAnsibombKit17452710 = K2A.ar(t_trig).dup;
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
varTrojanAnsibombKit1745279 = BRF.ar(varTrojanAnsibombKit1745279 * modZ, varTrojanAnsibombKit1745279, gate, LFCub.ar(wave * DC.ar(0.97318994998932), wave * DC.ar(0.04035472869873), wave * DC.ar(0.36376786231995), wave * DC.ar(0.041225790977478)), Silent.ar());
varTrojanAnsibombKit17452710 = Blip.ar(varTrojanAnsibombKit17452710 * signal, varTrojanAnsibombKit17452710 * modX, 0.99996594044139 * wave * signal, Median.ar(wave * DC.ar(0.86342763900757), wave * DC.ar(0.83688485622406), wave * DC.ar(0.1837340593338), wave * DC.ar(0.2785542011261)));
varTrojanAnsibombKit1745279 = RMShelf.ar(Index.ar(wave * DC.ar(0.12057971954346), wave * DC.ar(0.15215659141541), wave * DC.ar(0.028699159622192), wave * DC.ar(0.75682938098907)), gateEnv, gate, 0.9982672871317 * modX, Silent.ar());
varTrojanAnsibombKit17452710 = DC.ar(wave * DC.ar(0.8896598815918));

signal = varTrojanAnsibombKit17452710;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// Father_Mac.306.B174528
/////////////////////////////////////////////////////////

SynthDef.new("Father_Mac.306.B174528", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varFather_Mac306B1745289, varFather_Mac306B17452810;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varFather_Mac306B1745289 = varFather_Mac306B17452810 = K2A.ar(t_trig).dup;
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
varFather_Mac306B1745289 = RMShelf.ar(modZ * modY, gateEnv * gateEnv, varFather_Mac306B17452810 * in, varFather_Mac306B17452810, Silent.ar());
varFather_Mac306B17452810 = Normalizer.ar(0.43144536018372 * modY * varFather_Mac306B17452810, 0.77340257167816 * wave * modZ, signal);
varFather_Mac306B1745289 = BHiPass.ar(wave * DC.ar(0.43564903736115), wave * DC.ar(0.24951362609863), wave * DC.ar(0.64126133918762), wave * DC.ar(0.97440457344055), wave * DC.ar(0.81301665306091));
varFather_Mac306B17452810 = Lorenz2DC.ar(modY * varFather_Mac306B1745289, varFather_Mac306B17452810, varFather_Mac306B17452810 * modZ, varFather_Mac306B1745289 * varFather_Mac306B17452810, LPFVS6.ar(wave * DC.ar(0.069701671600342), wave * DC.ar(0.68608069419861), wave * DC.ar(0.89295947551727)), modX, modZ * modY, 0.85429382324219 * varFather_Mac306B1745289, varFather_Mac306B17452810 * signal, env, Silent.ar());

signal = varFather_Mac306B17452810;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// Backdoor.Assasin.Kit174528
/////////////////////////////////////////////////////////

SynthDef.new("Backdoor.Assasin.Kit174528", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varBackdoorAssasinKit1745289;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varBackdoorAssasinKit1745289 = K2A.ar(t_trig).dup;
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
varBackdoorAssasinKit1745289 = Clip.ar(wave * modZ, 0.75934231281281 * in * env, modY * modZ);
varBackdoorAssasinKit1745289 = SanityCheck.ar(signal);

signal = varBackdoorAssasinKit1745289;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// Yougdos.Worm174528
/////////////////////////////////////////////////////////

SynthDef.new("Yougdos.Worm174528", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varYougdosWorm1745289, varYougdosWorm17452810, varYougdosWorm17452811, varYougdosWorm17452812, varYougdosWorm17452813, varYougdosWorm17452814;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varYougdosWorm1745289 = varYougdosWorm17452810 = varYougdosWorm17452811 = varYougdosWorm17452812 = varYougdosWorm17452813 = varYougdosWorm17452814 = K2A.ar(t_trig).dup;
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
varYougdosWorm1745289 = BBandPass.ar(varYougdosWorm17452813 * varYougdosWorm17452810, modX * modX, varYougdosWorm1745289, signal, Silent.ar());
varYougdosWorm17452810 = GrainFM.ar(2, OSWrap4.ar(wave * DC.ar(0.64506804943085), wave * DC.ar(0.23172700405121), wave * DC.ar(0.13756227493286)), modZ * gateEnv, modY * varYougdosWorm17452814, varYougdosWorm17452811 * varYougdosWorm1745289, modY * signal, x, bufnum, modX, 0.99478750015008 * varYougdosWorm17452813 * varYougdosWorm17452813, Silent.ar());
varYougdosWorm17452811 = PeakFollower.ar(varYougdosWorm1745289 * varYougdosWorm17452813, in * modX);
varYougdosWorm17452812 = SN76489.ar(FBSineC.ar(wave * DC.ar(0.95421969890594), wave * DC.ar(0.17730188369751), wave * DC.ar(0.88718318939209), wave * DC.ar(0.99223518371582), wave * DC.ar(0.46913027763367), wave * DC.ar(0.49976289272308), wave * DC.ar(0.40042436122894), wave * DC.ar(0.49131536483765), wave * DC.ar(0.15848958492279)), in * varYougdosWorm17452814.lincurve(wave * DC.ar(0.30437695980072), wave * DC.ar(0.042053818702698), wave * DC.ar(0.08530604839325), wave * DC.ar(0.68020117282867), wave * DC.ar(0.54796946048737), wave * DC.ar(0.43326675891876)), x, NLFiltC.ar(wave * DC.ar(0.27714276313782), wave * DC.ar(0.71331262588501), wave * DC.ar(0.40594637393951), wave * DC.ar(0.36727225780487), wave * DC.ar(0.82612335681915), wave * DC.ar(0.19746160507202), wave * DC.ar(0.79189908504486), wave * DC.ar(0.97498595714569)), varYougdosWorm17452813, gate, wave * signal, 0.48892855644226 * StkSaxofony.ar(wave * DC.ar(0.31532168388367), wave * DC.ar(0.94078254699707), wave * DC.ar(0.26070034503937), wave * DC.ar(0.280064702034), wave * DC.ar(0.34990799427032), wave * DC.ar(0.44093787670135), wave * DC.ar(0.54449379444122), wave * DC.ar(0.91279780864716), wave * DC.ar(0.61712265014648), wave * DC.ar(0.63737905025482), wave * DC.ar(0.216304063797)), varYougdosWorm17452810 * varYougdosWorm17452813);
varYougdosWorm17452813 = YigCliffordC.ar(varYougdosWorm17452812 * varYougdosWorm17452813.exprange(wave * DC.ar(0.38335275650024), wave * DC.ar(0.039577484130859)), amp, varYougdosWorm17452810 * modY, PulseDivider.ar(wave * DC.ar(0.31344127655029), wave * DC.ar(0.7059930562973), wave * DC.ar(0.036103367805481)), in * modX.expexp(wave * DC.ar(0.56451261043549), wave * DC.ar(0.13797342777252), wave * DC.ar(0.065373539924622), wave * DC.ar(0.16121530532837), wave * DC.ar(0.93657112121582)), varYougdosWorm17452813 * gateEnv, gateEnv * varYougdosWorm17452813, 0.95781039418716 * varYougdosWorm17452814 * signal, Silent.ar());
varYougdosWorm17452814 = MidEQ.ar(bufnum, modY * varYougdosWorm17452811, modY * gateEnv, gate, 0.87410198867366 * varYougdosWorm17452812 * gateEnv, Silent.ar());
varYougdosWorm1745289 = GlitchRHPF.ar(signal * varYougdosWorm17452812, varYougdosWorm17452810 * varYougdosWorm1745289, modY, 0.99888676611485 * varYougdosWorm17452811 * varYougdosWorm17452810, Silent.ar());
varYougdosWorm17452810 = Latch.ar(varYougdosWorm1745289, varYougdosWorm17452810 * gateEnv);
varYougdosWorm17452811 = A2B.ar(island, varYougdosWorm1745289 * varYougdosWorm17452810, island, island);
varYougdosWorm17452812 = Standard2DN.ar(wave * DC.ar(0.77997827529907), wave * DC.ar(0.62856531143188), wave * DC.ar(0.54376375675201), wave * DC.ar(0.12531411647797), wave * DC.ar(0.8044992685318), wave * DC.ar(0.58448421955109), wave * DC.ar(0.52023589611053));
varYougdosWorm17452813 = RedLbyl.ar(x, varYougdosWorm17452810, x);
varYougdosWorm17452814 = StkFlute.ar(wave * DC.ar(0.5370135307312), wave * DC.ar(0.86129009723663), wave * DC.ar(0.76127791404724), wave * DC.ar(0.22933506965637), wave * DC.ar(0.77218973636627), wave * DC.ar(0.38077092170715));

signal = varYougdosWorm17452814;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// Khiznjak.642174529
/////////////////////////////////////////////////////////

SynthDef.new("Khiznjak.642174529", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varKhiznjak6421745299, varKhiznjak64217452910, varKhiznjak64217452911;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varKhiznjak6421745299 = varKhiznjak64217452910 = varKhiznjak64217452911 = K2A.ar(t_trig).dup;
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
varKhiznjak6421745299 = FoaPressZ.ar(varKhiznjak64217452910 * modX, modZ, 0.99998738442905 * varKhiznjak64217452910 * env, Silent.ar());
varKhiznjak64217452910 = MembraneHexagon.ar(varKhiznjak64217452910 * modY, island, gateEnv * varKhiznjak64217452910, WaveletDaub.ar(wave * DC.ar(0.97445940971375), wave * DC.ar(0.75951313972473), wave * DC.ar(0.48622620105743), wave * DC.ar(0.28634345531464), wave * DC.ar(0.54216742515564)), Silent.ar());
varKhiznjak64217452911 = Sweep.ar(modZ * varKhiznjak64217452910, gate);
varKhiznjak6421745299 = WaveTerrain.ar(Array.fill(2.pow(12), { |i| rrand(-1, 1) }).as(LocalBuf), varKhiznjak64217452911, in, island, 0.26779699325562 * in * env, varKhiznjak64217452910, Silent.ar());
varKhiznjak64217452910 = PinkNoise.ar(0.09726715829579 * env, Silent.ar());
varKhiznjak64217452911 = AtsPartial.ar(Array.fill(2.pow(16), { |i| rrand(-1, 1) }).as(LocalBuf), bufnum, in * varKhiznjak6421745299, env * modX, modZ * wave, env, WeaklyNonlinear.ar(wave * DC.ar(0.27731466293335), wave * DC.ar(0.46411919593811), wave * DC.ar(0.1446338891983), wave * DC.ar(0.20626866817474), wave * DC.ar(0.39614236354828), wave * DC.ar(0.67046976089478), wave * DC.ar(0.15924167633057), wave * DC.ar(0.050347208976746), wave * DC.ar(0.60842716693878), wave * DC.ar(0.54904747009277), wave * DC.ar(0.34506678581238), wave * DC.ar(0.50160229206085), wave * DC.ar(0.29695153236389)));

signal = varKhiznjak64217452911;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// FindABCD174530
/////////////////////////////////////////////////////////

SynthDef.new("FindABCD174530", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varFindABCD1745309;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varFindABCD1745309 = K2A.ar(t_trig).dup;
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
varFindABCD1745309 = Summer.ar(modX * modX, 0.67238819599152 * signal * wave, modZ * modZ, 0.16615092754364 * varFindABCD1745309 * env);
varFindABCD1745309 = Rotate2.ar(modZ, varFindABCD1745309 * in, modX);

signal = varFindABCD1745309;
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
// XRCE.464174531
/////////////////////////////////////////////////////////

SynthDef.new("XRCE.464174531", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varXRCE4641745319, varXRCE46417453110, varXRCE46417453111, varXRCE46417453112, varXRCE46417453113;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varXRCE4641745319 = varXRCE46417453110 = varXRCE46417453111 = varXRCE46417453112 = varXRCE46417453113 = K2A.ar(t_trig).dup;
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
varXRCE4641745319 = Delay1.ar(env * modX, 0.95637640373687 * modZ, Silent.ar());
varXRCE46417453110 = Rotate.ar(in, gateEnv, x, in * env.linexp(wave * DC.ar(0.62801718711853), wave * DC.ar(0.7947860956192), wave * DC.ar(0.88069140911102), wave * DC.ar(0.90036559104919), wave * DC.ar(0.84048044681549)), modZ * varXRCE4641745319.exprange(wave * DC.ar(0.91877722740173), wave * DC.ar(0.14865159988403)));
varXRCE46417453111 = TRand.ar(modY * gateEnv, t_trig, modY * varXRCE46417453112);
varXRCE46417453112 = TwoPole.ar(0.24633765220642 * env * modZ, varXRCE46417453111 * varXRCE46417453110, gateEnv * modX.lag(wave * DC.ar(0.32098436355591), wave * DC.ar(0.66460633277893)), 0.95621180123541 * varXRCE46417453113 * varXRCE46417453112, Silent.ar());
varXRCE46417453113 = RLPFD.ar(in * signal, varXRCE4641745319 * varXRCE46417453113, modX, env * env, 0.99741965557116 * varXRCE46417453113, Compander.ar(wave * DC.ar(0.56748199462891), wave * DC.ar(0.7290233373642), wave * DC.ar(0.37321054935455), wave * DC.ar(0.39372456073761), wave * DC.ar(0.85731220245361), wave * DC.ar(0.58211004734039), wave * DC.ar(0.49000811576843), wave * DC.ar(0.70614111423492), wave * DC.ar(0.99751794338226)));
varXRCE4641745319 = PeakEQ4.ar(wave * DC.ar(0.26682651042938), wave * DC.ar(0.12771534919739), wave * DC.ar(0.64550280570984), wave * DC.ar(0.27177035808563));
varXRCE46417453110 = Lag3UD.ar(wave * DC.ar(0.25327110290527), wave * DC.ar(0.018152356147766), wave * DC.ar(0.043277263641357), wave * DC.ar(0.52190220355988), wave * DC.ar(0.78861844539642));
varXRCE46417453111 = Balance2.ar(varXRCE46417453110, varXRCE46417453112 * gateEnv.round(FoaFocusX.ar(wave * DC.ar(0.81918287277222), wave * DC.ar(0.38016676902771), wave * DC.ar(0.88304591178894), wave * DC.ar(0.18805623054504))), z, modZ);
varXRCE46417453112 = MedianTriggered.ar(wave * DC.ar(0.95945227146149), wave * DC.ar(0.65034222602844), wave * DC.ar(0.1761269569397), wave * DC.ar(0.24077546596527), wave * DC.ar(0.64054751396179));
varXRCE46417453113 = DelayC.ar(wave * DC.ar(0.42462837696075), wave * DC.ar(0.70216464996338), wave * DC.ar(0.068354487419128), wave * DC.ar(0.15368604660034), wave * DC.ar(0.88596606254578));

signal = varXRCE46417453113;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// XRCE.4641745311
/////////////////////////////////////////////////////////

SynthDef.new("XRCE.4641745311", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varXRCE4641745319, varXRCE46417453110, varXRCE46417453111, varXRCE46417453112, varXRCE46417453113, varXRCE464174531114;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varXRCE4641745319 = varXRCE46417453110 = varXRCE46417453111 = varXRCE46417453112 = varXRCE46417453113 = varXRCE464174531114 = K2A.ar(t_trig).dup;
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
varXRCE4641745319 = LorenzTrig.ar(varXRCE46417453110 * varXRCE46417453110, modY, varXRCE464174531114, z, env, 0.52872467041016 * varXRCE46417453112 * in, env * varXRCE46417453112, amp, gateEnv * modZ, 0.50572542868886 * varXRCE464174531114 * varXRCE4641745319, Silent.ar());
varXRCE46417453110 = DelTapRd.ar(Array.fill(2.pow(13), { |i| rrand(-1, 1) }).as(LocalBuf), varXRCE46417453111, 0.20247185230255 * varXRCE46417453113 * signal, 0.9774261713028 * modY * wave.expexp(wave * DC.ar(0.87976479530334), wave * DC.ar(0.94997823238373), wave * DC.ar(0.1635046005249), wave * DC.ar(0.40253806114197), wave * DC.ar(0.86152935028076)), HyperTerrain.ar(wave * DC.ar(0.69902622699738), wave * DC.ar(0.04344367980957), wave * DC.ar(0.82347297668457), wave * DC.ar(0.74322831630707), wave * DC.ar(0.80930745601654), wave * DC.ar(0.72144258022308)), Silent.ar());
varXRCE46417453111 = StkShakers.ar(varXRCE46417453113 * signal, varXRCE46417453110 * varXRCE46417453112, varXRCE4641745319 * varXRCE464174531114, env.curvelin(wave * DC.ar(0.091651797294617), wave * DC.ar(0.33800327777863), wave * DC.ar(0.64226913452148), wave * DC.ar(0.40692520141602), wave * DC.ar(0.59551978111267), wave * DC.ar(0.987344622612)), in, 0.95134026214876 * signal * varXRCE464174531114, Silent.ar());
varXRCE46417453112 = Metro.ar(modY * gateEnv, t_trig, wave, Silent.ar());
varXRCE46417453113 = Vibrato.ar(varXRCE46417453111 * varXRCE4641745319, modX * varXRCE464174531114, wave, in, z, signal, z, 0.5264744758606 * modY * varXRCE46417453113);
varXRCE4641745319 = AmpComp.ar(BufGrain.ar(wave * DC.ar(0.57517349720001), wave * DC.ar(0.7398681640625), wave * DC.ar(0.3896951675415), wave * DC.ar(0.13352286815643), wave * DC.ar(0.061629891395569), wave * DC.ar(0.88026642799377), wave * DC.ar(0.084471225738525), wave * DC.ar(0.46440148353577)).exprange(1, SampleRate.ir), varXRCE46417453112 * modX, varXRCE46417453112 * modZ);
varXRCE46417453110 = StkMandolin.ar(wave * DC.ar(0.4657336473465), wave * DC.ar(0.12864577770233), wave * DC.ar(0.070628762245178), wave * DC.ar(0.22472989559174), wave * DC.ar(0.61582851409912), wave * DC.ar(0.73901045322418), wave * DC.ar(0.57614886760712), wave * DC.ar(0.029789686203003), wave * DC.ar(0.24969053268433));
varXRCE46417453111 = PartConv.ar(varXRCE46417453110 * varXRCE46417453110, gate, Array.fill(2.pow(11), { |i| rrand(-1, 1) }).as(LocalBuf), in, WaveLoss.ar(wave * DC.ar(0.62313258647919), wave * DC.ar(0.83341705799103), wave * DC.ar(0.0078252553939819), wave * DC.ar(0.48382019996643), wave * DC.ar(0.69835638999939), wave * DC.ar(0.71895706653595)));
varXRCE46417453112 = WaveLoss.ar(varXRCE4641745319 * env, 0.47923195362091 * varXRCE464174531114 * varXRCE464174531114, varXRCE464174531114, t_trig, ReplaceOut.ar(wave * DC.ar(0.16359567642212), wave * DC.ar(0.80413413047791)), Silent.ar());
varXRCE46417453113 = B2UHJ.ar(varXRCE46417453110, signal * signal, gateEnv * gateEnv);
// Variation test code
varXRCE464174531114 = QuadC.ar(env * in, signal, 0.28339970111847 * varXRCE46417453113 * varXRCE46417453113, wave * varXRCE46417453110, 0.73889374732971 * varXRCE46417453113 * varXRCE46417453111, varXRCE464174531114.range(varXRCE46417453110 * DC.ar(0.034435987472534), varXRCE46417453113 * DC.ar(0.62874948978424)), Silent.ar());
varXRCE464174531114 = Latch.ar(z, CoinGate.ar(varXRCE46417453112 * DC.ar(0.90851855278015), varXRCE46417453111 * DC.ar(0.78245091438293)));
varXRCE464174531114 = BufCombC.ar(Array.fill(2.pow(12), { |i| rrand(-1, 1) }).as(LocalBuf), 0.20073688030243 * varXRCE46417453111 * varXRCE46417453111, varXRCE46417453111, varXRCE464174531114 * varXRCE46417453113, 0.9900746849634 * varXRCE46417453113 * env, Silent.ar());

signal = varXRCE464174531114;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// Wildy.421174531
/////////////////////////////////////////////////////////

SynthDef.new("Wildy.421174531", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varWildy4211745319, varWildy42117453110, varWildy42117453111, varWildy42117453112, varWildy42117453113, varWildy42117453114;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varWildy4211745319 = varWildy42117453110 = varWildy42117453111 = varWildy42117453112 = varWildy42117453113 = varWildy42117453114 = K2A.ar(t_trig).dup;
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
varWildy4211745319 = PV_JensenAndersen.ar(Array.fill(2.pow(12), { |i| rrand(-1, 1) }).as(LocalBuf), 0.57986950874329 * varWildy42117453112 * varWildy42117453111, 0.0041776895523071 * wave * modZ.lag3ud(wave * DC.ar(0.009401798248291), wave * DC.ar(0.85599112510681)), varWildy42117453113, varWildy42117453112, amp, gateEnv * gateEnv);
varWildy42117453110 = Formlet.ar(gate, MembraneHexagon.ar(wave * DC.ar(0.53361189365387), wave * DC.ar(0.97965633869171), wave * DC.ar(0.055452942848206), wave * DC.ar(0.90830421447754), wave * DC.ar(0.048895120620728)).exprange(1, SampleRate.ir), modY * modY, varWildy42117453114 * wave, 0.87041431302342 * varWildy42117453114 * varWildy42117453112, Silent.ar());
varWildy42117453111 = VOSIM.ar(in * varWildy4211745319, StkBlowHole.ar(wave * DC.ar(0.063744306564331), wave * DC.ar(0.16550445556641), wave * DC.ar(0.79505479335785), wave * DC.ar(0.32170534133911), wave * DC.ar(0.58538544178009), wave * DC.ar(0.30074238777161), wave * DC.ar(0.85955607891083), wave * DC.ar(0.79001748561859)).exprange(1, SampleRate.ir), bufnum, z, 0.99992894412249 * in * varWildy42117453112.unipolar(wave * DC.ar(0.97458863258362)), Silent.ar());
varWildy42117453112 = FreeVerb2.ar(wave, amp, in * gateEnv, varWildy4211745319, varWildy42117453111, 0.9999506477457 * varWildy42117453113 * modY, Silent.ar());
varWildy42117453113 = HPF.ar(0.37142765522003 * varWildy42117453111, varWildy42117453112 * varWildy42117453114, 0.99998746749259 * signal * signal, Silent.ar());
varWildy42117453114 = SkipNeedle.ar(gateEnv, modZ, CombL.ar(wave, gate, 0.70660841464996 * wave * in, z, WaveletDaub.ar(wave * DC.ar(0.50179696083069), wave * DC.ar(0.98974478244781), wave * DC.ar(0.90015590190887), wave * DC.ar(0.097863674163818), wave * DC.ar(0.98121309280396)), Silent.ar()));
varWildy4211745319 = Klank.ar(`[[StkBeeThree.ar(wave * DC.ar(0.0013079643249512), wave * DC.ar(0.041638612747192), wave * DC.ar(0.24815654754639), wave * DC.ar(0.5473575592041), wave * DC.ar(0.79758358001709), wave * DC.ar(0.67973208427429), wave * DC.ar(0.020704627037048), wave * DC.ar(0.45747494697571), wave * DC.ar(0.234450340271)), Formlet.ar(wave * DC.ar(0.42101216316223), wave * DC.ar(0.29262971878052), wave * DC.ar(0.65248799324036), wave * DC.ar(0.89808797836304), wave * DC.ar(0.061530351638794), wave * DC.ar(0.38642299175262))], [LinExp.ar(wave * DC.ar(0.51633846759796), wave * DC.ar(0.38487064838409), wave * DC.ar(0.24751806259155), wave * DC.ar(0.30868768692017), wave * DC.ar(0.54134678840637)), AtsAmp.ar(wave * DC.ar(0.64843583106995), wave * DC.ar(0.36228585243225), wave * DC.ar(0.24187278747559), wave * DC.ar(0.74981296062469), wave * DC.ar(0.33197128772736))], [Clipper8.ar(wave * DC.ar(0.21204268932343), wave * DC.ar(0.45297396183014), wave * DC.ar(0.7505134344101)), HenonC.ar(wave * DC.ar(0.56603503227234), wave * DC.ar(0.65695202350616), wave * DC.ar(0.42468535900116), wave * DC.ar(0.98269331455231), wave * DC.ar(0.92197370529175), wave * DC.ar(0.63777875900269), wave * DC.ar(0.36192917823792))]], wave * wave, varWildy42117453110, Index.ar(wave * DC.ar(0.68769812583923), wave * DC.ar(0.15023756027222), wave * DC.ar(0.80023622512817), wave * DC.ar(0.391033411026)).exprange(1, SampleRate.ir), varWildy42117453110 * in);
varWildy42117453110 = InGrain.ar(varWildy42117453112 * modY, wave * varWildy42117453112, amp, 0.99991897262584 * varWildy42117453111 * wave, Silent.ar());
varWildy42117453111 = Tilt.ar(wave * DC.ar(0.099685907363892), wave * DC.ar(0.29454791545868), wave * DC.ar(0.71343219280243), wave * DC.ar(0.91491639614105), wave * DC.ar(0.48454701900482));
varWildy42117453112 = RedPhasor2.ar(wave * DC.ar(0.62561929225922), wave * DC.ar(0.94218289852142), wave * DC.ar(0.65719544887543), wave * DC.ar(0.13370907306671), wave * DC.ar(0.8758305311203), wave * DC.ar(0.10288655757904), wave * DC.ar(0.20761406421661));
varWildy42117453113 = Osc.ar(Array.fill(2.pow(12), { |i| rrand(-1, 1) }).as(LocalBuf), in * in, gate, LFDNoise0.ar(wave * DC.ar(0.48749208450317), wave * DC.ar(0.1568808555603), wave * DC.ar(0.85319936275482)), Silent.ar());
varWildy42117453114 = LFGauss.ar(modZ, varWildy42117453114 * varWildy42117453113, 0.040279865264893 * modZ * varWildy42117453111, varWildy42117453110 * modY, in);

signal = varWildy42117453114;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// Crepate.1944174532
/////////////////////////////////////////////////////////

SynthDef.new("Crepate.1944174532", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varCrepate19441745329, varCrepate194417453210;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varCrepate19441745329 = varCrepate194417453210 = K2A.ar(t_trig).dup;
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
varCrepate19441745329 = AtsFreq.ar(Array.fill(2.pow(10), { |i| rrand(-1, 1) }).as(LocalBuf), gateEnv * env, amp, 0.92496514934318 * FreeVerb.ar(wave * DC.ar(0.85551011562347), wave * DC.ar(0.51730799674988), wave * DC.ar(0.62499463558197), wave * DC.ar(0.13588845729828), wave * DC.ar(0.83281409740448), wave * DC.ar(0.12375020980835)), Silent.ar());
varCrepate194417453210 = OscN.ar(Array.fill(2.pow(10), { |i| rrand(-1, 1) }).as(LocalBuf), varCrepate19441745329 * gateEnv, 0.76343417167664 * modX * gateEnv, 0.99998542345492 * varCrepate19441745329 * in, Silent.ar());
varCrepate19441745329 = DoubleNestedAllpassN.ar(modX * modX, 0.61224389076233 * modZ * modX, modY * signal, wave, gateEnv * wave, env * modX, wave * varCrepate194417453210, y, y, varCrepate19441745329 * in, Lorenz2DC.ar(wave * DC.ar(0.072761535644531), wave * DC.ar(0.75127005577087), wave * DC.ar(0.87831580638885), wave * DC.ar(0.78021013736725), wave * DC.ar(0.88593459129333), wave * DC.ar(0.061753988265991), wave * DC.ar(0.48660588264465), wave * DC.ar(0.50997650623322), wave * DC.ar(0.16606605052948), wave * DC.ar(0.15058791637421), wave * DC.ar(0.62178432941437)), Silent.ar());
varCrepate194417453210 = RMAFoodChainL.ar(wave * DC.ar(0.96724212169647), wave * DC.ar(0.51081693172455), wave * DC.ar(0.50872707366943), wave * DC.ar(0.77855980396271), wave * DC.ar(0.32934582233429), wave * DC.ar(0.49034309387207), wave * DC.ar(0.22038805484772), wave * DC.ar(0.0014915466308594), wave * DC.ar(0.32895278930664), wave * DC.ar(0.89290142059326), wave * DC.ar(0.45366764068604), wave * DC.ar(0.31406116485596), wave * DC.ar(0.019795298576355), wave * DC.ar(0.52764320373535), wave * DC.ar(0.22791278362274));

signal = varCrepate194417453210;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// Linux.Amalthea174533
/////////////////////////////////////////////////////////

SynthDef.new("Linux.Amalthea174533", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varLinuxAmalthea1745339, varLinuxAmalthea17453310, varLinuxAmalthea17453311;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varLinuxAmalthea1745339 = varLinuxAmalthea17453310 = varLinuxAmalthea17453311 = K2A.ar(t_trig).dup;
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
varLinuxAmalthea1745339 = RedLbyl.ar(modX * modY, 0.017229080200195 * EnvDetect.ar(wave * DC.ar(0.063107132911682), wave * DC.ar(0.70719301700592), wave * DC.ar(0.50553131103516)).clip2(PitchShift.ar(wave * DC.ar(0.7999461889267), wave * DC.ar(0.87608373165131), wave * DC.ar(0.50289344787598), wave * DC.ar(0.064843058586121), wave * DC.ar(0.12177121639252), wave * DC.ar(0.10877513885498), wave * DC.ar(0.54083001613617))), amp);
varLinuxAmalthea17453310 = LinCongL.ar(varLinuxAmalthea1745339, y, 0.61442458629608 * modZ * varLinuxAmalthea17453311, varLinuxAmalthea17453311, signal * modY, 0.99996465916685 * modZ * varLinuxAmalthea1745339, Silent.ar());
varLinuxAmalthea17453311 = NLFiltN.ar(in, modZ * varLinuxAmalthea1745339, modX * varLinuxAmalthea17453310, env, gateEnv, env, PV_HainsworthFoote.ar(wave * DC.ar(0.779620885849), wave * DC.ar(0.73076629638672), wave * DC.ar(0.57621669769287), wave * DC.ar(0.34678888320923), wave * DC.ar(0.52979755401611)), Silent.ar());
varLinuxAmalthea1745339 = OnePole.ar(x, gateEnv, 0.99995197019547 * varLinuxAmalthea1745339 * modX, Silent.ar());
varLinuxAmalthea17453310 = Allpass1.ar(wave * DC.ar(0.53795754909515), wave * DC.ar(0.75576424598694), wave * DC.ar(0.86648321151733), wave * DC.ar(0.62494254112244));
varLinuxAmalthea17453311 = NeedleRect.ar(wave * DC.ar(0.7803590297699), wave * DC.ar(0.057959794998169), wave * DC.ar(0.75743925571442), wave * DC.ar(0.47445797920227), wave * DC.ar(0.20758950710297), wave * DC.ar(0.79167246818542), wave * DC.ar(0.51887714862823));

signal = varLinuxAmalthea17453311;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// Linux.Amalthea1745331
/////////////////////////////////////////////////////////

SynthDef.new("Linux.Amalthea1745331", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varLinuxAmalthea1745339, varLinuxAmalthea17453310, varLinuxAmalthea17453311, varLinuxAmalthea174533112, varLinuxAmalthea174533113, varLinuxAmalthea174533114;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varLinuxAmalthea1745339 = varLinuxAmalthea17453310 = varLinuxAmalthea17453311 = varLinuxAmalthea174533112 = varLinuxAmalthea174533113 = varLinuxAmalthea174533114 = K2A.ar(t_trig).dup;
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
varLinuxAmalthea1745339 = HenonC.ar(varLinuxAmalthea174533112 * varLinuxAmalthea17453310, modY, island, varLinuxAmalthea174533113 * modZ, 0.57282269001007 * modY * gateEnv, varLinuxAmalthea174533114, Silent.ar().bitXor(Gendy3.ar(wave * DC.ar(0.53512978553772), wave * DC.ar(0.67369675636292), wave * DC.ar(0.58829283714294), wave * DC.ar(0.19555759429932), wave * DC.ar(0.75439119338989), wave * DC.ar(0.14380323886871), wave * DC.ar(0.75607967376709), wave * DC.ar(0.86923921108246), wave * DC.ar(0.88083291053772), wave * DC.ar(0.17245101928711), wave * DC.ar(0.75205838680267))));
varLinuxAmalthea17453310 = NLFiltC.ar(signal, in, varLinuxAmalthea174533112 * modY, amp, modY, env, 0.99590016616151 * varLinuxAmalthea174533113 * env, Silent.ar());
varLinuxAmalthea17453311 = DiskIn.ar(2, Array.fill(2.pow(12), { |i| rrand(-1, 1) }).as(LocalBuf), in);
varLinuxAmalthea1745339 = GbmanTrig.ar(in * gateEnv, varLinuxAmalthea174533114, env, 0.45138800144196 * env * varLinuxAmalthea17453310, LPCVals.ar(wave * DC.ar(0.85225415229797), wave * DC.ar(0.88126838207245)), Silent.ar());
varLinuxAmalthea17453310 = YigMandelbulbN.ar(signal * signal, AtsParInfo.ar(wave * DC.ar(0.47745549678802), wave * DC.ar(0.43865537643433), wave * DC.ar(0.99570465087891), wave * DC.ar(0.069890379905701), wave * DC.ar(0.38894379138947)), modX, wave * varLinuxAmalthea174533113, varLinuxAmalthea174533112, env, Silent.ar());
varLinuxAmalthea17453311 = AllpassN.ar(x, varLinuxAmalthea17453310, varLinuxAmalthea17453310 * varLinuxAmalthea174533112, modX * varLinuxAmalthea174533112, FoaFocusX.ar(wave * DC.ar(0.26542913913727), wave * DC.ar(0.023423552513123), wave * DC.ar(0.8872834444046), wave * DC.ar(0.30520367622375)), Silent.ar());
// Variation test code
varLinuxAmalthea174533112 = StkSaxofony.ar(PV_JensenAndersen.ar(varLinuxAmalthea1745339 * DC.ar(0.94030368328094), varLinuxAmalthea17453311 * DC.ar(0.024828433990479), varLinuxAmalthea17453310 * DC.ar(0.77732980251312), varLinuxAmalthea17453310 * DC.ar(0.64461648464203), varLinuxAmalthea17453310 * DC.ar(0.97265589237213), varLinuxAmalthea1745339 * DC.ar(0.30985128879547), varLinuxAmalthea1745339 * DC.ar(0.84826397895813)).exprange(1, SampleRate.ir), y, modX, varLinuxAmalthea17453310, t_trig, signal * signal, gateEnv * varLinuxAmalthea17453311, gateEnv * varLinuxAmalthea174533112, varLinuxAmalthea174533112 * varLinuxAmalthea174533113, 0.99996403082629 * varLinuxAmalthea174533114 * varLinuxAmalthea174533114, Demand.ar(varLinuxAmalthea17453310 * DC.ar(0.21302711963654), varLinuxAmalthea17453311 * DC.ar(0.68988621234894), varLinuxAmalthea17453311 * DC.ar(0.97052204608917)));
varLinuxAmalthea174533113 = RedDPCMdecode.ar(varLinuxAmalthea174533113 * in);
varLinuxAmalthea174533114 = PeakEQ4.ar(env * varLinuxAmalthea174533113, varLinuxAmalthea1745339 * env, modX * varLinuxAmalthea17453310, t_trig);
varLinuxAmalthea174533112 = InRect.ar(wave, varLinuxAmalthea17453310 * env, Rect.new(0, 0, 0.20618236064911, 0.93088924884796));
varLinuxAmalthea174533113 = EnvDetect.ar(gateEnv, y, z);
varLinuxAmalthea174533114 = StandardN.ar(wave, varLinuxAmalthea174533112 * env, wave * varLinuxAmalthea174533112, varLinuxAmalthea1745339 * in, OSWrap8.ar(varLinuxAmalthea17453310 * DC.ar(0.25492453575134), varLinuxAmalthea17453311 * DC.ar(0.40514838695526), varLinuxAmalthea17453311 * DC.ar(0.27997267246246)), Silent.ar());
varLinuxAmalthea174533112 = Demand.ar(varLinuxAmalthea174533113 * varLinuxAmalthea1745339, signal * modX, amp);
varLinuxAmalthea174533113 = BufDelayL.ar(Array.fill(2.pow(14), { |i| rrand(-1, 1) }).as(LocalBuf), in * modZ, modY * varLinuxAmalthea1745339, varLinuxAmalthea174533113, Silent.ar());
varLinuxAmalthea174533114 = RedPhasor2.ar(FreeVerb2.ar(varLinuxAmalthea1745339 * DC.ar(0.93329560756683), varLinuxAmalthea1745339 * DC.ar(0.38084304332733), varLinuxAmalthea17453310 * DC.ar(0.23372566699982), varLinuxAmalthea17453311 * DC.ar(0.039721846580505), varLinuxAmalthea17453310 * DC.ar(0.99432551860809), varLinuxAmalthea1745339 * DC.ar(0.95132601261139), varLinuxAmalthea17453311 * DC.ar(0.36894822120667)), BufAllpassC.ar(Array.fill(2.pow(12), { |i| rrand(-1, 1) }).as(LocalBuf), wave, in * varLinuxAmalthea174533114, varLinuxAmalthea174533114, varLinuxAmalthea174533113, Silent.ar()), varLinuxAmalthea17453311 * modX, modX * modY, varLinuxAmalthea174533113 * modZ, wave, varLinuxAmalthea17453311);

signal = varLinuxAmalthea174533114;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// XM.Laroux.CQ174534
/////////////////////////////////////////////////////////

SynthDef.new("XM.Laroux.CQ174534", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varXMLarouxCQ1745349, varXMLarouxCQ17453410, varXMLarouxCQ17453411, varXMLarouxCQ17453412;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varXMLarouxCQ1745349 = varXMLarouxCQ17453410 = varXMLarouxCQ17453411 = varXMLarouxCQ17453412 = K2A.ar(t_trig).dup;
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
varXMLarouxCQ1745349 = MostChange.ar(amp, signal);
varXMLarouxCQ17453410 = BHiPass.ar(varXMLarouxCQ17453411, modY * env.lincurve(wave * DC.ar(0.37218630313873), wave * DC.ar(0.26337122917175), wave * DC.ar(0.5120108127594), wave * DC.ar(0.15703499317169), wave * DC.ar(0.25415599346161), wave * DC.ar(0.6002995967865)), varXMLarouxCQ17453410 * modX, 0.95871517186751 * varXMLarouxCQ17453412 * varXMLarouxCQ17453411, Silent.ar());
varXMLarouxCQ17453411 = RegaliaMitraEQ.ar(varXMLarouxCQ1745349, varXMLarouxCQ17453412 * varXMLarouxCQ17453412, modY * signal, varXMLarouxCQ1745349, 0.99991876423356 * HPZ2.ar(wave * DC.ar(0.44129359722137), wave * DC.ar(0.71465647220612), wave * DC.ar(0.084618330001831)), LFNoise1.ar(wave * DC.ar(0.45995986461639), wave * DC.ar(0.070912003517151), wave * DC.ar(0.43435096740723)));
varXMLarouxCQ17453412 = GlitchRHPF.ar(varXMLarouxCQ17453412 * varXMLarouxCQ17453410, LatoocarfianN.ar(wave * DC.ar(0.29398810863495), wave * DC.ar(0.95094799995422), wave * DC.ar(0.38523650169373), wave * DC.ar(0.58321738243103), wave * DC.ar(0.013965487480164), wave * DC.ar(0.61659228801727), wave * DC.ar(0.97039091587067), wave * DC.ar(0.11545932292938), wave * DC.ar(0.97287893295288)).exprange(1, SampleRate.ir), bufnum, 0.82403492874209 * gateEnv * modY, Silent.ar());
varXMLarouxCQ1745349 = RMAFoodChainL.ar(wave * DC.ar(0.45588910579681), wave * DC.ar(0.50843667984009), wave * DC.ar(0.5096572637558), wave * DC.ar(0.90505051612854), wave * DC.ar(0.47498083114624), wave * DC.ar(0.13434517383575), wave * DC.ar(0.58818912506104), wave * DC.ar(0.24069762229919), wave * DC.ar(0.1794764995575), wave * DC.ar(0.66894102096558), wave * DC.ar(0.36705899238586), wave * DC.ar(0.15382790565491), wave * DC.ar(0.64627969264984), wave * DC.ar(0.88529920578003), wave * DC.ar(0.092889428138733));
varXMLarouxCQ17453410 = OSFold4.ar(0.22590374946594 * wave * modX, env * in, wave * env);
varXMLarouxCQ17453411 = FOS.ar(wave * DC.ar(0.33228409290314), wave * DC.ar(0.9047863483429), wave * DC.ar(0.0077580213546753), wave * DC.ar(0.46738970279694), wave * DC.ar(0.46487760543823), wave * DC.ar(0.77757155895233));
varXMLarouxCQ17453412 = BBlockerBuf.ar(varXMLarouxCQ1745349 * varXMLarouxCQ17453412, Array.fill(2.pow(15), { |i| rrand(-1, 1) }).as(LocalBuf), modZ * varXMLarouxCQ17453410);

signal = varXMLarouxCQ17453412;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// June1745351
/////////////////////////////////////////////////////////

SynthDef.new("June1745351", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varJune1745359, varJune174535110, varJune174535111;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varJune1745359 = varJune174535110 = varJune174535111 = K2A.ar(t_trig).dup;
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
varJune1745359 = DelTapRd.ar(Array.fill(2.pow(10), { |i| rrand(-1, 1) }).as(LocalBuf), env, wave, y, 0.99983073121108 * varJune174535111 * varJune174535110, Silent.ar());
varJune1745359 = TDelay.ar(wave * modZ, gate);
// Variation test code
varJune174535110 = RedDPCMencode.ar(env, in * modZ);
varJune174535111 = FMHDecode1.ar(signal * wave.leftShift(TBrownRand.ar(varJune1745359 * DC.ar(0.91702723503113), varJune1745359 * DC.ar(0.8154878616333), varJune1745359 * DC.ar(0.58935534954071), varJune1745359 * DC.ar(0.97358274459839), varJune1745359 * DC.ar(0.77585244178772), varJune1745359 * DC.ar(0.68194103240967), varJune1745359 * DC.ar(0.88761508464813))), in, in * wave, signal, varJune174535110 * varJune174535111, z, signal, gateEnv * signal, modX, island, varJune174535110 * modY.max(B2UHJ.ar(varJune1745359 * DC.ar(0.7517501115799), varJune1745359 * DC.ar(0.31760001182556), varJune1745359 * DC.ar(0.79060459136963))), signal, Silent.ar());
varJune174535110 = TDelay.ar(varJune1745359, modX * varJune174535111);
varJune174535111 = LFClipNoise.ar(gateEnv * env, 0.99960730083766 * varJune174535111 * modX, Silent.ar());
varJune174535110 = GVerb.ar(0.35748541355133 * varJune1745359 * varJune174535110, wave * wave, amp.lag3ud(varJune1745359 * DC.ar(0.21593296527863), varJune1745359 * DC.ar(0.82687950134277)), SoftClipAmp4.ar(signal * wave, y, 0.99680563860572 * varJune174535110 * wave, Silent.ar()), gateEnv, island, varJune174535110 * signal, t_trig, in, wave, gateEnv, Silent.ar());
varJune174535111 = Lorenz2DC.ar(signal, gateEnv, 0.4602073431015 * varJune174535111 * varJune174535110, island, modX * wave.trunc(LPCVals.ar(varJune1745359 * DC.ar(0.27816104888916), varJune1745359 * DC.ar(0.70045530796051))), wave, varJune174535110, varJune174535110, y, AtsPartial.ar(varJune1745359 * DC.ar(0.47531878948212), varJune1745359 * DC.ar(0.74394643306732), varJune1745359 * DC.ar(0.9289687871933), varJune1745359 * DC.ar(0.49187827110291), varJune1745359 * DC.ar(0.15920913219452), varJune1745359 * DC.ar(0.53392517566681), varJune1745359 * DC.ar(0.35991168022156)), Silent.ar());

signal = varJune174535111;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// Leprosy.651174536
/////////////////////////////////////////////////////////

SynthDef.new("Leprosy.651174536", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varLeprosy6511745369;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varLeprosy6511745369 = K2A.ar(t_trig).dup;
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
varLeprosy6511745369 = TermanWang.ar(gateEnv, island, varLeprosy6511745369, wave * varLeprosy6511745369, MembraneCircle.ar(modY, env * env, gateEnv, 0.84531807739778 * varLeprosy6511745369 * in.lag3ud(wave * DC.ar(0.45792174339294), wave * DC.ar(0.52316009998322)), Silent.ar()), modZ * modZ, island, env * in, varLeprosy6511745369 * modZ, HenonTrig.ar(wave * DC.ar(0.16265749931335), wave * DC.ar(0.61050260066986), wave * DC.ar(0.27258634567261), wave * DC.ar(0.76656520366669), wave * DC.ar(0.47049248218536), wave * DC.ar(0.94265997409821), wave * DC.ar(0.18674182891846), wave * DC.ar(0.34760463237762)), Silent.ar());
varLeprosy6511745369 = Amplitude.ar(wave * DC.ar(0.25928103923798), wave * DC.ar(0.029788494110107), wave * DC.ar(0.95416700839996), wave * DC.ar(0.87967073917389), wave * DC.ar(0.08111035823822));

signal = varLeprosy6511745369;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// WM.Wazzu.AM174538
/////////////////////////////////////////////////////////

SynthDef.new("WM.Wazzu.AM174538", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varWMWazzuAM1745389, varWMWazzuAM17453810, varWMWazzuAM17453811, varWMWazzuAM17453812, varWMWazzuAM17453813, varWMWazzuAM17453814;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varWMWazzuAM1745389 = varWMWazzuAM17453810 = varWMWazzuAM17453811 = varWMWazzuAM17453812 = varWMWazzuAM17453813 = varWMWazzuAM17453814 = K2A.ar(t_trig).dup;
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
varWMWazzuAM1745389 = Decimator.ar(varWMWazzuAM17453811 * varWMWazzuAM17453812, modY * varWMWazzuAM17453810, varWMWazzuAM17453811 * varWMWazzuAM17453812, LinCongN.ar(wave * DC.ar(0.35479855537415), wave * DC.ar(0.56717932224274), wave * DC.ar(0.11807763576508), wave * DC.ar(0.54341399669647), wave * DC.ar(0.82191967964172), wave * DC.ar(0.2787811756134), wave * DC.ar(0.23316597938538)), Silent.ar());
varWMWazzuAM17453810 = YigCliffordN.ar(signal, varWMWazzuAM17453813 * varWMWazzuAM17453813, island, env * varWMWazzuAM17453812, varWMWazzuAM1745389 * varWMWazzuAM17453811, varWMWazzuAM17453812 * signal, x, 0.22664098711914 * FoaPressY.ar(wave * DC.ar(0.91878700256348), wave * DC.ar(0.67095696926117), wave * DC.ar(0.95524299144745), wave * DC.ar(0.39046919345856)), RedDPCMencode.ar(wave * DC.ar(0.7909060716629), wave * DC.ar(0.51607704162598)));
varWMWazzuAM17453811 = SinGrainB.ar(varWMWazzuAM17453812 * varWMWazzuAM17453810, x, signal.leftShift(Brusselator.ar(wave * DC.ar(0.76233637332916), wave * DC.ar(0.76435363292694), wave * DC.ar(0.95119857788086), wave * DC.ar(0.2096004486084), wave * DC.ar(0.034716129302979), wave * DC.ar(0.17543756961823), wave * DC.ar(0.3048369884491), wave * DC.ar(0.85868442058563))), bufnum, 0.99955811920999 * signal * gateEnv, Silent.ar());
varWMWazzuAM17453812 = FoaPushY.ar(modX * signal, modZ * varWMWazzuAM17453812, 0.99943163032654 * signal * varWMWazzuAM17453814, Silent.ar());
varWMWazzuAM17453813 = MeanTriggered.ar(HPZ1.ar(wave * DC.ar(0.022376537322998), wave * DC.ar(0.49600470066071), wave * DC.ar(0.052538394927979)), wave * varWMWazzuAM17453812, env.ring2(LPF.ar(wave * DC.ar(0.69030654430389), wave * DC.ar(0.95683312416077), wave * DC.ar(0.48411500453949), wave * DC.ar(0.15526437759399))), Summer.ar(wave * DC.ar(0.71178042888641), wave * DC.ar(0.10405254364014), wave * DC.ar(0.30639636516571), wave * DC.ar(0.046398162841797)), Silent.ar());
varWMWazzuAM17453814 = FoaPressZ.ar(modX * modX, env, 0.14198921170704 * modY * varWMWazzuAM17453811, Silent.ar());
varWMWazzuAM1745389 = Disintegrator.ar(varWMWazzuAM17453812 * varWMWazzuAM17453813, varWMWazzuAM17453810, modY, varWMWazzuAM17453812, OSFold4.ar(wave * DC.ar(0.46376407146454), wave * DC.ar(0.43203616142273), wave * DC.ar(0.90264093875885)));
varWMWazzuAM17453810 = LFBrownNoise2.ar(wave * DC.ar(0.84054744243622), wave * DC.ar(0.4073930978775), wave * DC.ar(0.26325881481171), wave * DC.ar(0.41869139671326), wave * DC.ar(0.28936004638672));
varWMWazzuAM17453811 = YigClifford3DC.ar(wave * DC.ar(0.045439839363098), wave * DC.ar(0.33136165142059), wave * DC.ar(0.094729661941528), wave * DC.ar(0.23130643367767), wave * DC.ar(0.84126794338226), wave * DC.ar(0.75076258182526), wave * DC.ar(0.64119648933411), wave * DC.ar(0.77756643295288), wave * DC.ar(0.74705827236176), wave * DC.ar(0.032812714576721));
varWMWazzuAM17453812 = Resonz.ar(0.81942343711853 * varWMWazzuAM17453811 * gateEnv, varWMWazzuAM17453810 * in, varWMWazzuAM17453813, SortBuf.ar(wave * DC.ar(0.60593330860138), wave * DC.ar(0.31215250492096), wave * DC.ar(0.353031873703)), Silent.ar());
varWMWazzuAM17453813 = AtsParInfo.ar(Array.fill(2.pow(13), { |i| rrand(-1, 1) }).as(LocalBuf), AllpassN.ar(in * modX, 0.29670941829681 * modY * env, t_trig, varWMWazzuAM17453814 * varWMWazzuAM17453813, 0.99967209817243 * wave * wave, Silent.ar()), signal * env, 0.42380072466777 * GlitchHPF.ar(wave * DC.ar(0.64017140865326), wave * DC.ar(0.18353378772736), wave * DC.ar(0.95387887954712), wave * DC.ar(0.88545179367065)), Silent.ar());
varWMWazzuAM17453814 = HyperTerrain.ar(Array.fill(2.pow(15), { |i| rrand(-1, 1) }).as(LocalBuf), varWMWazzuAM17453813 * varWMWazzuAM17453811, modY, 0.83436107635498 * gateEnv * varWMWazzuAM1745389, CheckBadValues.ar(wave * DC.ar(0.047956824302673), wave * DC.ar(0.2454948425293), wave * DC.ar(0.34915256500244)), Silent.ar());

signal = varWMWazzuAM17453814;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// HLLP.Malomush.8192174539
/////////////////////////////////////////////////////////

SynthDef.new("HLLP.Malomush.8192174539", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varHLLPMalomush81921745399, varHLLPMalomush819217453910, varHLLPMalomush819217453911, varHLLPMalomush819217453912;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varHLLPMalomush81921745399 = varHLLPMalomush819217453910 = varHLLPMalomush819217453911 = varHLLPMalomush819217453912 = K2A.ar(t_trig).dup;
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
varHLLPMalomush81921745399 = Timer.ar(wave * modZ);
varHLLPMalomush819217453910 = GlitchRHPF.ar(gate, modX, gateEnv.min(CombN.ar(wave * DC.ar(0.5032023191452), wave * DC.ar(0.076735019683838), wave * DC.ar(0.71764266490936), wave * DC.ar(0.54788851737976), wave * DC.ar(0.32900655269623), wave * DC.ar(0.60235440731049))), 0.98209083785012 * modY * env, Silent.ar());
varHLLPMalomush819217453911 = PanX2D.ar(2, 2, wave, in * varHLLPMalomush819217453911, varHLLPMalomush819217453912 * signal, modX * modX, z, varHLLPMalomush819217453912 * varHLLPMalomush819217453912);
varHLLPMalomush819217453912 = Line.ar(signal, modX, wave, varHLLPMalomush819217453910, Silent.ar(), varHLLPMalomush81921745399 * varHLLPMalomush819217453911);
varHLLPMalomush81921745399 = Clipper8.ar(wave * DC.ar(0.62429225444794), wave * DC.ar(0.64136862754822), wave * DC.ar(0.98177790641785));
varHLLPMalomush819217453910 = Oregonator.ar(wave * varHLLPMalomush819217453911, modX, varHLLPMalomush819217453911 * varHLLPMalomush819217453912, 0.069774866104126 * modY, varHLLPMalomush81921745399 * signal, in * gateEnv, gate, x, varHLLPMalomush819217453912, Silent.ar());
varHLLPMalomush819217453911 = Allpass1.ar(modZ * varHLLPMalomush819217453911, modZ, 0.98709390896332 * in * modY, Silent.ar());
varHLLPMalomush819217453912 = SanityCheck2.ar(amp);

signal = varHLLPMalomush819217453912;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// XBoot174540
/////////////////////////////////////////////////////////

SynthDef.new("XBoot174540", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varXBoot1745409;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varXBoot1745409 = K2A.ar(t_trig).dup;
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
varXBoot1745409 = NLFiltN.ar(modZ * env, 0.063244938850403 * in.clip(wave * DC.ar(0.64675450325012), wave * DC.ar(0.151038646698)), in, modX, modY * modY, modZ * modZ, FMGrainBBF.ar(wave * DC.ar(0.060720562934875), wave * DC.ar(0.38091158866882), wave * DC.ar(0.96333384513855), wave * DC.ar(0.62892031669617), wave * DC.ar(0.37204420566559), wave * DC.ar(0.69793748855591), wave * DC.ar(0.82352912425995), wave * DC.ar(0.6461763381958), wave * DC.ar(0.30486571788788), wave * DC.ar(0.084547519683838), wave * DC.ar(0.10487103462219), wave * DC.ar(0.032968759536743)), Silent.ar());
varXBoot1745409 = OSFold4.ar(wave * DC.ar(0.51483225822449), wave * DC.ar(0.56497931480408), wave * DC.ar(0.10650360584259));

signal = varXBoot1745409;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// HLLO.5504174541
/////////////////////////////////////////////////////////

SynthDef.new("HLLO.5504174541", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varHLLO55041745419, varHLLO550417454110, varHLLO550417454111;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varHLLO55041745419 = varHLLO550417454110 = varHLLO550417454111 = K2A.ar(t_trig).dup;
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
varHLLO55041745419 = Atari2600.ar(varHLLO550417454110, modZ, env * signal, signal * modY, modX, t_trig, varHLLO550417454110);
varHLLO550417454110 = FincoSprottM.ar(modY * env, env * varHLLO550417454110, t_trig, modY, modZ * signal, 0.8626594543457 * modY * gateEnv, LastValue.ar(wave * DC.ar(0.17413187026978), wave * DC.ar(0.30082499980927)), signal, Silent.ar());
varHLLO550417454111 = RunningMax.ar(varHLLO550417454111 * modZ, RunningMax.ar(wave * DC.ar(0.61260318756104), wave * DC.ar(0.82332634925842)));
varHLLO55041745419 = AllpassN.ar(0.67534756660461 * Clipper32.ar(wave * DC.ar(0.046388745307922), wave * DC.ar(0.34697222709656), wave * DC.ar(0.50858497619629)), varHLLO55041745419 * varHLLO55041745419, modZ * varHLLO550417454111, varHLLO55041745419, signal, Silent.ar());
varHLLO550417454110 = RLPF.ar(wave * DC.ar(0.1456127166748), wave * DC.ar(0.24581241607666), wave * DC.ar(0.99216151237488), wave * DC.ar(0.46953320503235), wave * DC.ar(0.12364137172699));
varHLLO550417454111 = RunningMin.ar(varHLLO55041745419 * modZ, env * varHLLO550417454110);

signal = varHLLO550417454111;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// Wit.gen174544
/////////////////////////////////////////////////////////

SynthDef.new("Wit.gen174544", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varWitgen1745449;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varWitgen1745449 = K2A.ar(t_trig).dup;
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
varWitgen1745449 = Hasher.ar(signal * signal, 0.97694172289836 * modX * gateEnv, Silent.ar());
varWitgen1745449 = LagUD.ar(0.37048470973969 * in * gateEnv, island, modZ * modZ, 0.99689832740043 * modY * gateEnv, Silent.ar());

signal = varWitgen1745449;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// Bin.Auto.BMR174545
/////////////////////////////////////////////////////////

SynthDef.new("Bin.Auto.BMR174545", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varBinAutoBMR1745459, varBinAutoBMR17454510, varBinAutoBMR17454511;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varBinAutoBMR1745459 = varBinAutoBMR17454510 = varBinAutoBMR17454511 = K2A.ar(t_trig).dup;
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
varBinAutoBMR1745459 = Lag3UD.ar(env, env * gateEnv, modY * in, in, Silent.ar());
varBinAutoBMR17454510 = Out.ar((80 + (island * 2)), [FMGrainBBF.ar(wave * DC.ar(0.47987675666809), wave * DC.ar(0.060139179229736), wave * DC.ar(0.11245012283325), wave * DC.ar(0.77606987953186), wave * DC.ar(0.38386988639832), wave * DC.ar(0.49717712402344), wave * DC.ar(0.14245867729187), wave * DC.ar(0.4958587884903), wave * DC.ar(0.0066784620285034), wave * DC.ar(0.75764894485474), wave * DC.ar(0.11594045162201), wave * DC.ar(0.47742426395416)), NTube.ar(wave * DC.ar(0.94567501544952), wave * DC.ar(0.09566342830658), wave * DC.ar(0.36859691143036), wave * DC.ar(0.27533328533173), wave * DC.ar(0.78511810302734), wave * DC.ar(0.93844282627106))]);
varBinAutoBMR17454511 = RunningMax.ar(varBinAutoBMR17454511 * wave, modX * varBinAutoBMR17454510);
varBinAutoBMR1745459 = StkMoog.ar(StkMandolin.ar(wave * DC.ar(0.40382981300354), wave * DC.ar(0.72732698917389), wave * DC.ar(0.23213756084442), wave * DC.ar(0.92108964920044), wave * DC.ar(0.79588532447815), wave * DC.ar(0.45496845245361), wave * DC.ar(0.75916731357574), wave * DC.ar(0.53740310668945), wave * DC.ar(0.54798352718353)).exprange(1, SampleRate.ir), t_trig, wave * signal, env.wrap(wave * DC.ar(0.19292163848877), wave * DC.ar(0.28997921943665)), signal * varBinAutoBMR17454510, x, varBinAutoBMR17454510 * varBinAutoBMR17454511, varBinAutoBMR17454511, Silent.ar());
varBinAutoBMR17454510 = Delay2.ar(modY, Perlin3.ar(wave * DC.ar(0.86633765697479), wave * DC.ar(0.0037541389465332), wave * DC.ar(0.22674262523651)), Silent.ar());
varBinAutoBMR17454511 = FMGrainB.ar(wave * DC.ar(0.32191896438599), wave * DC.ar(0.44232130050659), wave * DC.ar(0.10370635986328), wave * DC.ar(0.38326704502106), wave * DC.ar(0.48784613609314), wave * DC.ar(0.33448791503906), wave * DC.ar(0.92252826690674), wave * DC.ar(0.085428237915039));

signal = varBinAutoBMR17454511;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// WM.Mental.D174546
/////////////////////////////////////////////////////////

SynthDef.new("WM.Mental.D174546", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varWMMentalD1745469, varWMMentalD17454610, varWMMentalD17454611, varWMMentalD17454612;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varWMMentalD1745469 = varWMMentalD17454610 = varWMMentalD17454611 = varWMMentalD17454612 = K2A.ar(t_trig).dup;
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
varWMMentalD1745469 = LorenzL.ar(modZ * env, varWMMentalD1745469 * varWMMentalD17454612, modZ, varWMMentalD17454610 * wave, y, varWMMentalD17454612, varWMMentalD17454612, modX * in, Median.ar(wave * DC.ar(0.14942812919617), wave * DC.ar(0.92342782020569), wave * DC.ar(0.0081467628479004), wave * DC.ar(0.68982887268066)), Silent.ar());
varWMMentalD17454610 = BFEncodeSter.ar(modX * modX, modX, varWMMentalD17454610, gateEnv * modY, modZ * modZ, 0.76960647106171 * HPZ2.ar(wave * DC.ar(0.42853593826294), wave * DC.ar(0.79349684715271), wave * DC.ar(0.57072794437408)), varWMMentalD17454611, varWMMentalD17454610 * in);
varWMMentalD17454611 = StkBeeThree.ar(in * signal, modY * modY, varWMMentalD1745469 * env, wave * modZ, amp, modZ, wave * in, 0.99984167496675 * in * in, Silent.ar());
varWMMentalD17454612 = AtsAmp.ar(Array.fill(2.pow(12), { |i| rrand(-1, 1) }).as(LocalBuf), bufnum, varWMMentalD17454611 * varWMMentalD17454611, 0.93225789079204 * signal * signal.slew(wave * DC.ar(0.60464406013489), wave * DC.ar(0.87875616550446)), Silent.ar());
varWMMentalD1745469 = WrapIndex.ar(Array.fill(2.pow(14), { |i| rrand(-1, 1) }).as(LocalBuf), varWMMentalD1745469 * modY, 0.98966604518055 * varWMMentalD17454611, Silent.ar());
varWMMentalD17454610 = RedLbyl.ar(modY * wave, wave * varWMMentalD17454611, modZ * gateEnv);
varWMMentalD17454611 = BufAllpassC.ar(Array.fill(2.pow(16), { |i| rrand(-1, 1) }).as(LocalBuf), modZ * varWMMentalD17454612, modX, 0.23454999923706 * in, signal, Silent.ar());
varWMMentalD17454612 = LFDNoise0.ar(modY * varWMMentalD1745469, in, Silent.ar());

signal = varWMMentalD17454612;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// Hacktool.ZipPwdRecover174547
/////////////////////////////////////////////////////////

SynthDef.new("Hacktool.ZipPwdRecover174547", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varHacktoolZipPwdRecover1745479, varHacktoolZipPwdRecover17454710, varHacktoolZipPwdRecover17454711, varHacktoolZipPwdRecover17454712;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varHacktoolZipPwdRecover1745479 = varHacktoolZipPwdRecover17454710 = varHacktoolZipPwdRecover17454711 = varHacktoolZipPwdRecover17454712 = K2A.ar(t_trig).dup;
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
varHacktoolZipPwdRecover1745479 = InGrainIBF.ar(modZ * modX, in * varHacktoolZipPwdRecover17454710, wave, bufnum, bufnum, varHacktoolZipPwdRecover17454710, HenonN.ar(modY, varHacktoolZipPwdRecover17454711 * modZ, gateEnv * varHacktoolZipPwdRecover17454712, wave * wave, amp, Formant.ar(wave * DC.ar(0.39239418506622), wave * DC.ar(0.95831596851349), wave * DC.ar(0.80080425739288), wave * DC.ar(0.47467684745789), wave * DC.ar(0.3942369222641)), Silent.ar()), varHacktoolZipPwdRecover1745479, SinGrain.ar(varHacktoolZipPwdRecover1745479 * env, varHacktoolZipPwdRecover17454712 * signal, varHacktoolZipPwdRecover17454712 * signal, 0.60468005833171 * varHacktoolZipPwdRecover17454710 * modZ, Silent.ar()), varHacktoolZipPwdRecover17454712 * wave, modZ, Silent.ar());
varHacktoolZipPwdRecover17454710 = CoinGate.ar(modX, z);
varHacktoolZipPwdRecover17454711 = FMGrainI.ar(Spreader.ar(wave * DC.ar(0.14534878730774), wave * DC.ar(0.2009437084198), wave * DC.ar(0.17501413822174), wave * DC.ar(0.60443794727325), wave * DC.ar(0.015690445899963)), modY * modY.linlin(wave * DC.ar(0.083161950111389), wave * DC.ar(0.42733097076416), wave * DC.ar(0.65946483612061), wave * DC.ar(0.69844448566437), wave * DC.ar(0.85400664806366)), gateEnv * varHacktoolZipPwdRecover17454710, env * gateEnv, wave * env, bufnum, bufnum, z, 0.29521159792546 * InGrainBF.ar(wave * DC.ar(0.34434592723846), wave * DC.ar(0.84525740146637), wave * DC.ar(0.26817107200623), wave * DC.ar(0.19997477531433), wave * DC.ar(0.10494804382324), wave * DC.ar(0.53595018386841), wave * DC.ar(0.44430828094482), wave * DC.ar(0.52573025226593), wave * DC.ar(0.49252426624298)), Silent.ar());
varHacktoolZipPwdRecover17454712 = ClipNoise.ar(in, Silent.ar());
varHacktoolZipPwdRecover1745479 = FoaAsymmetry.ar(wave * DC.ar(0.13074588775635), wave * DC.ar(0.52366840839386), wave * DC.ar(0.52008628845215), wave * DC.ar(0.62573719024658));
varHacktoolZipPwdRecover17454710 = PSinGrain.ar(varHacktoolZipPwdRecover17454711 * in, varHacktoolZipPwdRecover17454711 * varHacktoolZipPwdRecover1745479, bufnum);
varHacktoolZipPwdRecover17454711 = DiskOut.ar(Array.fill(2.pow(16), { |i| rrand(-1, 1) }).as(LocalBuf), [BufCombC.ar(wave * DC.ar(0.41585171222687), wave * DC.ar(0.38827633857727), wave * DC.ar(0.97057795524597), wave * DC.ar(0.12988090515137), wave * DC.ar(0.85657775402069), wave * DC.ar(0.27859723567963)), OneZero.ar(wave * DC.ar(0.70466756820679), wave * DC.ar(0.20159637928009), wave * DC.ar(0.61380445957184), wave * DC.ar(0.011560440063477))]);
varHacktoolZipPwdRecover17454712 = CuspN.ar(NTube.ar(wave * DC.ar(0.82454419136047), wave * DC.ar(0.82759535312653), wave * DC.ar(0.2531156539917), wave * DC.ar(0.2130401134491), wave * DC.ar(0.34992563724518), wave * DC.ar(0.47129797935486)).exprange(1, SampleRate.ir), FoaPanB.ar(gateEnv * modZ, gateEnv, signal, 0.99653166941302 * modY * modX, Silent.ar()), signal, gateEnv * gateEnv, 0.99856763386871 * varHacktoolZipPwdRecover17454710 * modY, Silent.ar());

signal = varHacktoolZipPwdRecover17454712;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// Hacktool.ZipPwdRecover1745471
/////////////////////////////////////////////////////////

SynthDef.new("Hacktool.ZipPwdRecover1745471", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varHacktoolZipPwdRecover1745479, varHacktoolZipPwdRecover17454710, varHacktoolZipPwdRecover17454711, varHacktoolZipPwdRecover17454712, varHacktoolZipPwdRecover174547113, varHacktoolZipPwdRecover174547114, varHacktoolZipPwdRecover174547115, varHacktoolZipPwdRecover174547116, varHacktoolZipPwdRecover174547117;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varHacktoolZipPwdRecover1745479 = varHacktoolZipPwdRecover17454710 = varHacktoolZipPwdRecover17454711 = varHacktoolZipPwdRecover17454712 = varHacktoolZipPwdRecover174547113 = varHacktoolZipPwdRecover174547114 = varHacktoolZipPwdRecover174547115 = varHacktoolZipPwdRecover174547116 = varHacktoolZipPwdRecover174547117 = K2A.ar(t_trig).dup;
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
varHacktoolZipPwdRecover1745479 = FoaTumble.ar(signal * varHacktoolZipPwdRecover174547117, modZ * in, wave, Silent.ar());
varHacktoolZipPwdRecover17454710 = WaveTerrain.ar(Array.fill(2.pow(11), { |i| rrand(-1, 1) }).as(LocalBuf), varHacktoolZipPwdRecover174547113 * signal, varHacktoolZipPwdRecover1745479, x, varHacktoolZipPwdRecover174547114 * signal, 0.95777443070144 * varHacktoolZipPwdRecover17454711 * gateEnv, Silent.ar());
varHacktoolZipPwdRecover17454711 = StandardN.ar(Slope.ar(wave * DC.ar(0.89181542396545), wave * DC.ar(0.83780384063721), wave * DC.ar(0.04274308681488)).exprange(1, SampleRate.ir), signal * varHacktoolZipPwdRecover17454712, varHacktoolZipPwdRecover1745479, 0.072882890701294 * varHacktoolZipPwdRecover174547113 * signal.lag2ud(wave * DC.ar(0.41740596294403), wave * DC.ar(0.19517040252686)), modZ, Silent.ar());
varHacktoolZipPwdRecover17454712 = RecordBuf.ar([Latoocarfian2DL.ar(wave * DC.ar(0.29631197452545), wave * DC.ar(0.28950452804565), wave * DC.ar(0.51562583446503), wave * DC.ar(0.093254327774048), wave * DC.ar(0.63336336612701), wave * DC.ar(0.7568724155426), wave * DC.ar(0.12871730327606), wave * DC.ar(0.99211370944977), wave * DC.ar(0.6040540933609), wave * DC.ar(0.64135158061981)), Ramp.ar(wave * DC.ar(0.78626978397369), wave * DC.ar(0.53008675575256), wave * DC.ar(0.24287390708923), wave * DC.ar(0.93048179149628))], Array.fill(2.pow(13), { |i| rrand(-1, 1) }).as(LocalBuf), 0.10579001903534 * modY, modX, varHacktoolZipPwdRecover174547116 * wave, varHacktoolZipPwdRecover174547114 * varHacktoolZipPwdRecover1745479, signal * gateEnv, BFEncodeSter.ar(wave * DC.ar(0.18444919586182), wave * DC.ar(0.56530869007111), wave * DC.ar(0.79449200630188), wave * DC.ar(0.054514646530151), wave * DC.ar(0.17217409610748), wave * DC.ar(0.3442040681839), wave * DC.ar(0.033560991287231), wave * DC.ar(0.65643727779388)), wave);
varHacktoolZipPwdRecover1745479 = AtsNoiSynth.ar(wave * DC.ar(0.58613562583923), wave * DC.ar(0.43093502521515), wave * DC.ar(0.48444676399231), wave * DC.ar(0.56574630737305), wave * DC.ar(0.35310447216034), wave * DC.ar(0.48790001869202), wave * DC.ar(0.99721312522888), wave * DC.ar(0.97464418411255), wave * DC.ar(0.89110887050629), wave * DC.ar(0.25973355770111), wave * DC.ar(0.61956667900085), wave * DC.ar(0.036153316497803), wave * DC.ar(0.028315424919128), wave * DC.ar(0.81302058696747));
varHacktoolZipPwdRecover17454710 = Summer.ar(wave * DC.ar(0.63350045681), wave * DC.ar(0.48329746723175), wave * DC.ar(0.21233451366425), wave * DC.ar(0.53638553619385));
varHacktoolZipPwdRecover17454711 = LPZ2.ar(wave * DC.ar(0.23776793479919), wave * DC.ar(0.42575001716614), wave * DC.ar(0.038551807403564));
varHacktoolZipPwdRecover17454712 = Index.ar(Array.fill(2.pow(12), { |i| rrand(-1, 1) }).as(LocalBuf), modX * signal, varHacktoolZipPwdRecover17454711, Silent.ar());
// Variation test code
varHacktoolZipPwdRecover174547113 = FSinOsc.ar(Ball.ar(varHacktoolZipPwdRecover17454710 * DC.ar(0.33521389961243), varHacktoolZipPwdRecover1745479 * DC.ar(0.68533575534821), varHacktoolZipPwdRecover17454710 * DC.ar(0.039959311485291), varHacktoolZipPwdRecover17454711 * DC.ar(0.11037886142731)).exprange(1, SampleRate.ir), modX, AllpassC.ar(varHacktoolZipPwdRecover17454710 * DC.ar(0.027573108673096), varHacktoolZipPwdRecover17454711 * DC.ar(0.86407947540283), varHacktoolZipPwdRecover17454712 * DC.ar(0.98416912555695), varHacktoolZipPwdRecover17454712 * DC.ar(0.19506025314331), varHacktoolZipPwdRecover1745479 * DC.ar(0.35345566272736), varHacktoolZipPwdRecover17454710 * DC.ar(0.041086554527283)), LinCongC.ar(varHacktoolZipPwdRecover17454711 * DC.ar(0.81643891334534), varHacktoolZipPwdRecover17454711 * DC.ar(0.86225354671478), varHacktoolZipPwdRecover1745479 * DC.ar(0.56971216201782), varHacktoolZipPwdRecover17454711 * DC.ar(0.34802973270416), varHacktoolZipPwdRecover17454711 * DC.ar(0.69632232189178), varHacktoolZipPwdRecover17454710 * DC.ar(0.21979594230652), varHacktoolZipPwdRecover1745479 * DC.ar(0.70908236503601)));
varHacktoolZipPwdRecover174547114 = LADSPA.ar(2.slew(varHacktoolZipPwdRecover17454711 * DC.ar(0.98204827308655), varHacktoolZipPwdRecover17454711 * DC.ar(0.85168254375458)), wave, modZ * varHacktoolZipPwdRecover174547115);
varHacktoolZipPwdRecover174547115 = VBAP.ar(2, LPFVS6.ar(signal, varHacktoolZipPwdRecover174547115, modY), Array.fill(2.pow(15), { |i| rrand(-1, 1) }).as(LocalBuf), varHacktoolZipPwdRecover17454711, env, modY);
varHacktoolZipPwdRecover174547116 = StkMandolin.ar(LinExp.ar(varHacktoolZipPwdRecover17454712 * DC.ar(0.43632102012634), varHacktoolZipPwdRecover17454712 * DC.ar(0.015464067459106), varHacktoolZipPwdRecover17454710 * DC.ar(0.471804022789), varHacktoolZipPwdRecover17454710 * DC.ar(0.043391466140747), varHacktoolZipPwdRecover17454712 * DC.ar(0.81134736537933)).exprange(1, SampleRate.ir), varHacktoolZipPwdRecover174547115 * varHacktoolZipPwdRecover174547117, z, wave, island, varHacktoolZipPwdRecover174547115, env, 0.65930063325462 * varHacktoolZipPwdRecover17454712 * varHacktoolZipPwdRecover17454711, Silent.ar());
varHacktoolZipPwdRecover174547117 = Rotate.ar(varHacktoolZipPwdRecover174547116 * varHacktoolZipPwdRecover17454711, signal * varHacktoolZipPwdRecover174547113, wave, x, t_trig);
varHacktoolZipPwdRecover174547113 = Convolution2.ar(signal * varHacktoolZipPwdRecover174547117, 0.037104249000549 * signal * in, env * in, 0.84969878196716 * wave * signal, SyncSaw.ar(varHacktoolZipPwdRecover17454711 * DC.ar(0.35007739067078), varHacktoolZipPwdRecover1745479 * DC.ar(0.655238032341), varHacktoolZipPwdRecover17454710 * DC.ar(0.52512049674988), varHacktoolZipPwdRecover17454712 * DC.ar(0.87003910541534)), Silent.ar());
varHacktoolZipPwdRecover174547114 = SoftClipper4.ar(varHacktoolZipPwdRecover174547115 * varHacktoolZipPwdRecover174547113);
varHacktoolZipPwdRecover174547115 = IndexInBetween.ar(Array.fill(2.pow(15), { |i| rrand(-1, 1) }).as(LocalBuf), in * varHacktoolZipPwdRecover17454710, 0.99981130420115 * signal, Silent.ar());
varHacktoolZipPwdRecover174547116 = AverageOutput.ar(y, varHacktoolZipPwdRecover17454711, 0.99223628759361 * in * modX, Silent.ar());
varHacktoolZipPwdRecover174547117 = Gbman2DN.ar(varHacktoolZipPwdRecover17454712 * signal, varHacktoolZipPwdRecover174547117 * modY, in, varHacktoolZipPwdRecover17454710 * varHacktoolZipPwdRecover174547117, 0.085228954628312 * varHacktoolZipPwdRecover1745479 * env, Silent.ar());
varHacktoolZipPwdRecover174547113 = DC.ar(varHacktoolZipPwdRecover174547117);
varHacktoolZipPwdRecover174547114 = Changed.ar(varHacktoolZipPwdRecover1745479.excess(SelectL.ar(varHacktoolZipPwdRecover17454712 * DC.ar(0.74481761455536), varHacktoolZipPwdRecover17454711 * DC.ar(0.574622631073))), DelayL.ar(modZ, bufnum, Hilbert.ar(varHacktoolZipPwdRecover17454710 * DC.ar(0.89370727539062), varHacktoolZipPwdRecover1745479 * DC.ar(0.92030787467957), varHacktoolZipPwdRecover17454711 * DC.ar(0.54286122322083)), 0.10100067872084 * varHacktoolZipPwdRecover1745479, Silent.ar()));
varHacktoolZipPwdRecover174547115 = PanAz.ar(2, env, varHacktoolZipPwdRecover174547115, varHacktoolZipPwdRecover17454710 * modY, varHacktoolZipPwdRecover174547115, varHacktoolZipPwdRecover174547116);
varHacktoolZipPwdRecover174547116 = Lag3UD.ar(varHacktoolZipPwdRecover174547117 * modY, z, gate, varHacktoolZipPwdRecover1745479, Silent.ar());
varHacktoolZipPwdRecover174547117 = PeakFollower.ar(varHacktoolZipPwdRecover17454711 * varHacktoolZipPwdRecover1745479, varHacktoolZipPwdRecover174547113);

signal = varHacktoolZipPwdRecover174547117;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// XM.Team.A174547
/////////////////////////////////////////////////////////

SynthDef.new("XM.Team.A174547", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varXMTeamA1745479;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varXMTeamA1745479 = K2A.ar(t_trig).dup;
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
varXMTeamA1745479 = Gbman2DC.ar(modZ * varXMTeamA1745479, wave, in * in, y, in.lincurve(wave * DC.ar(0.11579394340515), wave * DC.ar(0.33786058425903), wave * DC.ar(0.69808304309845), wave * DC.ar(0.05330491065979), wave * DC.ar(0.50814998149872), wave * DC.ar(0.63920485973358)), Silent.ar());
varXMTeamA1745479 = Amplitude.ar(wave * DC.ar(0.18521273136139), wave * DC.ar(0.67038643360138), wave * DC.ar(0.32062494754791), wave * DC.ar(0.29921996593475), wave * DC.ar(0.019482493400574));

signal = varXMTeamA1745479;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// XM.Team.A1745471
/////////////////////////////////////////////////////////

SynthDef.new("XM.Team.A1745471", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varXMTeamA1745479, varXMTeamA174547110;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varXMTeamA1745479 = varXMTeamA174547110 = K2A.ar(t_trig).dup;
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
varXMTeamA1745479 = Latoocarfian2DL.ar(env, BufAllpassN.ar(wave * DC.ar(0.76170670986176), wave * DC.ar(0.51588773727417), wave * DC.ar(0.38467466831207), wave * DC.ar(0.88569295406342), wave * DC.ar(0.07343053817749), wave * DC.ar(0.60937559604645)).exprange(1, SampleRate.ir), modY, env * wave, y, varXMTeamA1745479, modX, modZ * modZ, 0.99717240671217 * signal * gateEnv, Silent.ar().lag(wave * DC.ar(0.37189054489136), wave * DC.ar(0.40467000007629)));
varXMTeamA1745479 = TermanWang.ar(y.madd(wave * DC.ar(0.33210706710815), wave * DC.ar(0.10964322090149)).ring2(Streson.ar(wave * DC.ar(0.017770886421204), wave * DC.ar(0.86749339103699), wave * DC.ar(0.55708158016205), wave * DC.ar(0.42026114463806), wave * DC.ar(0.85287070274353))), BPF.ar(signal * in, signal * modY, modX, 0.98753784523235 * gateEnv, Silent.ar()), modX * modX, in, FoaFocusX.ar(modZ, 0.25696456432343 * modX * modX, 0.94633676772662 * varXMTeamA174547110 * modZ, HyperTerrain.ar(wave * DC.ar(0.46475481987), wave * DC.ar(0.95376360416412), wave * DC.ar(0.061638832092285), wave * DC.ar(0.002730131149292), wave * DC.ar(0.59977984428406), wave * DC.ar(0.89548695087433))).minNyquist(), in * in, in, 0.76586616039276 * varXMTeamA1745479 * wave, signal * env, 0.69671016773393 * gateEnv * modZ, Silent.ar());
// Variation test code
varXMTeamA174547110 = TTendency.ar(in * signal, in * signal, varXMTeamA1745479, t_trig, modY * env, t_trig);
varXMTeamA174547110 = LatoocarfianTrig.ar(signal * modZ, Convolution3.ar(varXMTeamA1745479 * DC.ar(0.84205663204193), varXMTeamA1745479 * DC.ar(0.081478714942932), varXMTeamA1745479 * DC.ar(0.97062790393829), varXMTeamA1745479 * DC.ar(0.51128613948822), varXMTeamA1745479 * DC.ar(0.89601469039917), varXMTeamA1745479 * DC.ar(0.48456430435181)).exprange(1, SampleRate.ir), varXMTeamA1745479, modZ, signal, varXMTeamA1745479 * varXMTeamA1745479, x, 0.40950071811676 * in * env, 0.99604511325162 * env * varXMTeamA1745479, Silent.ar());
varXMTeamA174547110 = HPZ2.ar(modZ * signal, 0.8700406476068 * varXMTeamA1745479 * in, Silent.ar());

signal = varXMTeamA174547110;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// W32.Headout1745481
/////////////////////////////////////////////////////////

SynthDef.new("W32.Headout1745481", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varW32Headout1745489, varW32Headout17454810, varW32Headout17454811, varW32Headout17454812, varW32Headout17454813, varW32Headout17454814, varW32Headout174548115;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varW32Headout1745489 = varW32Headout17454810 = varW32Headout17454811 = varW32Headout17454812 = varW32Headout17454813 = varW32Headout17454814 = varW32Headout174548115 = K2A.ar(t_trig).dup;
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
varW32Headout1745489 = DemandEnvGen.ar(AverageOutput.ar(wave * DC.ar(0.84713995456696), wave * DC.ar(0.18902683258057), wave * DC.ar(0.60035812854767), wave * DC.ar(0.83584260940552)), in, 0.38989567756653 * IIRFilter.ar(wave * DC.ar(0.87011098861694), wave * DC.ar(0.21843600273132), wave * DC.ar(0.6574923992157), wave * DC.ar(0.024923324584961), wave * DC.ar(0.26461064815521)), gateEnv, varW32Headout17454814, env * varW32Headout1745489, varW32Headout174548115, bufnum, island, varW32Headout1745489 * env);
varW32Headout17454810 = Disintegrator.ar(wave, StereoConvolution2L.ar(wave * DC.ar(0.14494168758392), wave * DC.ar(0.34409701824188), wave * DC.ar(0.089644432067871), wave * DC.ar(0.73976898193359), wave * DC.ar(0.41786599159241), wave * DC.ar(0.053198575973511), wave * DC.ar(0.9338675737381), wave * DC.ar(0.49600517749786)), 0.99750674367249 * signal * varW32Headout17454814, AtsBand.ar(wave * DC.ar(0.099748015403748), wave * DC.ar(0.53359425067902), wave * DC.ar(0.6095757484436), wave * DC.ar(0.72969877719879), wave * DC.ar(0.79376566410065)), Silent.ar());
varW32Headout17454811 = LinCongC.ar(varW32Headout17454814 * varW32Headout1745489, modY, varW32Headout17454814 * varW32Headout174548115, gate, island, 0.82925030340694 * varW32Headout174548115 * varW32Headout1745489, Silent.ar());
varW32Headout17454812 = FMHEncode0.ar(0.39186668395996 * in * varW32Headout1745489, varW32Headout17454814 * wave, varW32Headout17454814 * env, varW32Headout174548115 * modZ);
varW32Headout17454813 = StkMoog.ar(modY * varW32Headout174548115, island, bufnum, wave * varW32Headout174548115, XFadeRotate.ar(bufnum, varW32Headout174548115), Spring.ar(varW32Headout17454810, Formant.ar(wave * DC.ar(0.92154252529144), wave * DC.ar(0.75081193447113), wave * DC.ar(0.024133324623108), wave * DC.ar(0.73660039901733), wave * DC.ar(0.35671830177307)), z), modX * env, 0.99971191192305 * varW32Headout1745489 * wave, Silent.ar());
varW32Headout17454814 = FoaFocusY.ar(varW32Headout17454814 * modZ, 0.92173027992249 * varW32Headout17454810 * in, 0.91992486686972 * env * varW32Headout17454813, SMS.ar(wave * DC.ar(0.10721528530121), wave * DC.ar(0.59213948249817), wave * DC.ar(0.50043261051178), wave * DC.ar(0.16632926464081), wave * DC.ar(0.99556136131287), wave * DC.ar(0.17329943180084), wave * DC.ar(0.12002980709076), wave * DC.ar(0.8105126619339), wave * DC.ar(0.31319284439087), wave * DC.ar(0.24627470970154), wave * DC.ar(0.20613873004913), wave * DC.ar(0.56143689155579), wave * DC.ar(0.52297806739807)));
varW32Headout1745489 = Concat.ar(varW32Headout174548115 * varW32Headout174548115, varW32Headout174548115, modY * varW32Headout17454810, 0.96304738521576 * modZ * modY, 0.4695930480957 * signal, bufnum, t_trig.absdif(RHPF.ar(wave * DC.ar(0.17286670207977), wave * DC.ar(0.77139747142792), wave * DC.ar(0.52735638618469), wave * DC.ar(0.31441974639893), wave * DC.ar(0.62427926063538))), Osc.ar(wave * DC.ar(0.86576092243195), wave * DC.ar(0.21150398254395), wave * DC.ar(0.90462481975555), wave * DC.ar(0.4454060792923), wave * DC.ar(0.3873907327652)), gateEnv * varW32Headout17454813, amp, varW32Headout17454813 * in, in, varW32Headout1745489, Silent.ar().absdif(StkBandedWG.ar(wave * DC.ar(0.43762230873108), wave * DC.ar(0.01352858543396), wave * DC.ar(0.15199565887451), wave * DC.ar(0.9545726776123), wave * DC.ar(0.44643640518188), wave * DC.ar(0.31633877754211), wave * DC.ar(0.61943733692169), wave * DC.ar(0.75992357730865), wave * DC.ar(0.41011297702789), wave * DC.ar(0.83141839504242), wave * DC.ar(0.84776616096497))));
varW32Headout17454810 = NestedAllpassC.ar(wave * DC.ar(0.76197719573975), wave * DC.ar(0.44150137901306), wave * DC.ar(0.23949301242828), wave * DC.ar(0.5140620470047), wave * DC.ar(0.83790755271912), wave * DC.ar(0.44996404647827), wave * DC.ar(0.59792339801788), wave * DC.ar(0.61781513690948), wave * DC.ar(0.60385406017303));
varW32Headout17454811 = LPZ2.ar(in, 0.98724512558255 * signal * varW32Headout17454810, Silent.ar());
varW32Headout17454812 = Gendy2.ar(wave * DC.ar(0.17543697357178), wave * DC.ar(0.019439220428467), wave * DC.ar(0.77571105957031), wave * DC.ar(0.87128663063049), wave * DC.ar(0.43196558952332), wave * DC.ar(0.63563764095306), wave * DC.ar(0.37693679332733), wave * DC.ar(0.46111929416656), wave * DC.ar(0.58451747894287), wave * DC.ar(0.31690943241119), wave * DC.ar(0.77718651294708), wave * DC.ar(0.34807920455933), wave * DC.ar(0.98473250865936), wave * DC.ar(0.90356040000916));
varW32Headout17454813 = LatoocarfianN.ar(wave * DC.ar(0.93811857700348), wave * DC.ar(0.82998883724213), wave * DC.ar(0.75805962085724), wave * DC.ar(0.43921267986298), wave * DC.ar(0.4242171049118), wave * DC.ar(0.30006098747253), wave * DC.ar(0.20620203018188), wave * DC.ar(0.056261301040649), wave * DC.ar(0.60006213188171));
varW32Headout17454814 = WeaklyNonlinear.ar(gateEnv * signal, LFDNoise0.ar(varW32Headout17454813 * modX, 0.71991759841386 * modX * modY, Silent.ar()), modY, 0.66889071464539 * Latoocarfian2DN.ar(wave * DC.ar(0.95605659484863), wave * DC.ar(0.64177918434143), wave * DC.ar(0.62166237831116), wave * DC.ar(0.26686728000641), wave * DC.ar(0.39865672588348), wave * DC.ar(0.10465443134308), wave * DC.ar(0.71985650062561), wave * DC.ar(0.055023312568665), wave * DC.ar(0.2138329744339), wave * DC.ar(0.84274923801422)), varW32Headout17454810, t_trig, varW32Headout17454814, 0.36146628856659 * varW32Headout174548115 * varW32Headout17454812, wave * varW32Headout17454812, modZ * env.max(WaveletDaub.ar(wave * DC.ar(0.33316791057587), wave * DC.ar(0.86201071739197), wave * DC.ar(0.70099198818207), wave * DC.ar(0.64129459857941), wave * DC.ar(0.063328862190247))), varW32Headout174548115, 0.99985759696304 * GlitchRHPF.ar(wave * DC.ar(0.060118198394775), wave * DC.ar(0.84224820137024), wave * DC.ar(0.94409656524658), wave * DC.ar(0.39877331256866), wave * DC.ar(0.061076760292053)), Silent.ar());
// Variation test code
varW32Headout174548115 = Latoocarfian2DN.ar(varW32Headout17454811 * modY, TwoZero.ar(varW32Headout17454812 * DC.ar(0.11768925189972), varW32Headout17454814 * DC.ar(0.49895942211151), varW32Headout17454810 * DC.ar(0.52365291118622), varW32Headout17454813 * DC.ar(0.4488912820816), varW32Headout1745489 * DC.ar(0.13313722610474)).exprange(1, SampleRate.ir), 0.57595860958099 * in * varW32Headout17454813.div(Line.ar(varW32Headout1745489 * DC.ar(0.30586087703705), varW32Headout17454812 * DC.ar(0.18995416164398), varW32Headout17454810 * DC.ar(0.36451077461243), varW32Headout17454812 * DC.ar(0.23911464214325), varW32Headout17454814 * DC.ar(0.66199624538422), varW32Headout17454810 * DC.ar(0.020798802375793))), varW32Headout17454813 * gateEnv, modZ.sqrsum(LinCongC.ar(varW32Headout17454813 * DC.ar(0.35266900062561), varW32Headout17454812 * DC.ar(0.13261377811432), varW32Headout17454812 * DC.ar(0.94412219524384), varW32Headout17454813 * DC.ar(0.68494784832001), varW32Headout1745489 * DC.ar(0.02182149887085), varW32Headout17454814 * DC.ar(0.25623679161072), varW32Headout1745489 * DC.ar(0.4895031452179))), in, varW32Headout17454814, varW32Headout17454813, 0.7989669584909 * env * env, Silent.ar());
varW32Headout174548115 = BufWr.ar([SanityCheck.ar(varW32Headout17454810 * DC.ar(5.1259994506836e-05)), YigMandelbulbN.ar(varW32Headout17454814 * DC.ar(0.24843323230743), varW32Headout17454811 * DC.ar(0.53423726558685), varW32Headout17454811 * DC.ar(0.1017017364502), varW32Headout1745489 * DC.ar(0.095906257629395), varW32Headout17454810 * DC.ar(0.36522626876831), varW32Headout17454813 * DC.ar(0.20311534404755), varW32Headout17454813 * DC.ar(0.54258275032043))], Array.fill(2.pow(10), { |i| rrand(-1, 1) }).as(LocalBuf), varW32Headout17454813, 0.93684005737305 * varW32Headout17454813 * modZ);
varW32Headout174548115 = TwoZero.ar(gateEnv * modZ, varW32Headout17454813 * env, varW32Headout17454811 * varW32Headout17454812, 0.94598691744988 * in * env, Silent.ar());

signal = varW32Headout174548115;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// W32.Negat174549
/////////////////////////////////////////////////////////

SynthDef.new("W32.Negat174549", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varW32Negat1745499, varW32Negat17454910, varW32Negat17454911, varW32Negat17454912, varW32Negat17454913, varW32Negat17454914;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varW32Negat1745499 = varW32Negat17454910 = varW32Negat17454911 = varW32Negat17454912 = varW32Negat17454913 = varW32Negat17454914 = K2A.ar(t_trig).dup;
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
varW32Negat1745499 = A2B.ar(z, y, varW32Negat1745499 * wave, 0.77632570266724 * varW32Negat17454912 * varW32Negat17454912);
varW32Negat17454910 = OneZero.ar(varW32Negat17454912, z, 0.99984212084011 * in * wave, Silent.ar());
varW32Negat17454911 = LFNoise2.ar(wave * modX, Oregonator.ar(wave * DC.ar(0.15330958366394), wave * DC.ar(0.62834525108337), wave * DC.ar(0.33352041244507), wave * DC.ar(0.39727926254272), wave * DC.ar(0.99405431747437), wave * DC.ar(0.9792891740799), wave * DC.ar(0.54552519321442), wave * DC.ar(0.71487593650818), wave * DC.ar(0.54698991775513), wave * DC.ar(0.89048027992249)), Silent.ar());
varW32Negat17454912 = Astrocade.ar(0.11359894275665 * wave * gateEnv, env * varW32Negat17454914, varW32Negat17454911 * gateEnv, modX * env, env, 0.063159227371216 * MonoGrain.ar(wave * DC.ar(0.50136208534241), wave * DC.ar(0.85936176776886), wave * DC.ar(0.56987226009369), wave * DC.ar(0.76119387149811), wave * DC.ar(0.7352933883667), wave * DC.ar(0.97625291347504)), 0.41073787212372 * LFNoise0.ar(wave * DC.ar(0.88913869857788), wave * DC.ar(0.14238226413727), wave * DC.ar(0.0029067993164062)), 0.35314357280731 * env * varW32Negat17454910);
varW32Negat17454913 = StandardL.ar(Lag2.ar(wave * DC.ar(0.17492163181305), wave * DC.ar(0.65200400352478), wave * DC.ar(0.34955894947052), wave * DC.ar(0.91867244243622)).exprange(1, SampleRate.ir), wave * varW32Negat17454911, varW32Negat17454910, FBSineL.ar(wave * DC.ar(0.51506268978119), wave * DC.ar(0.10356163978577), wave * DC.ar(0.90453600883484), wave * DC.ar(0.72261273860931), wave * DC.ar(0.90135109424591), wave * DC.ar(0.20967817306519), wave * DC.ar(0.73830330371857), wave * DC.ar(0.96498572826385), wave * DC.ar(0.1196676492691)), varW32Negat17454911, Silent.ar());
varW32Negat17454914 = Poll.ar(in * in, varW32Negat17454914, in * env, varW32Negat17454912 * varW32Negat1745499);
varW32Negat1745499 = BPF.ar(signal, Compander.ar(wave * DC.ar(0.59170830249786), wave * DC.ar(0.99929189682007), wave * DC.ar(0.62175953388214), wave * DC.ar(0.059877753257751), wave * DC.ar(0.52651035785675), wave * DC.ar(0.12568581104279), wave * DC.ar(0.34498238563538), wave * DC.ar(0.25849795341492), wave * DC.ar(0.52783536911011)).exprange(1, SampleRate.ir), varW32Negat17454911 * varW32Negat17454913, 0.9998171221758 * wave * env, Silent.ar());
varW32Negat17454910 = Gendy2.ar(t_trig, wave * gateEnv, BufDelayC.ar(Array.fill(2.pow(16), { |i| rrand(-1, 1) }).as(LocalBuf), varW32Negat17454913 * modX, env * varW32Negat17454911, 0.96269359128269 * modZ * env, Silent.ar()).lag2ud(wave * DC.ar(0.9622585773468), wave * DC.ar(0.28256440162659)), bufnum, DelTapRd.ar(wave * DC.ar(0.63585233688354), wave * DC.ar(0.14560675621033), wave * DC.ar(0.84751904010773), wave * DC.ar(0.005846381187439), wave * DC.ar(0.15322196483612), wave * DC.ar(0.75564360618591)).exprange(1, SampleRate.ir), signal * signal, modZ, varW32Negat1745499, Sieve1.ar(Array.fill(2.pow(10), { |i| rrand(-1, 1) }).as(LocalBuf), 0.908651471138 * varW32Negat17454910 * varW32Negat1745499, varW32Negat17454913 * varW32Negat17454913, 0.9892798867731 * varW32Negat17454910, Silent.ar()), env, varW32Negat17454911 * in, x, varW32Negat17454914, Silent.ar());
varW32Negat17454911 = WaveTerrain.ar(wave * DC.ar(0.14167273044586), wave * DC.ar(0.81750011444092), wave * DC.ar(0.10439765453339), wave * DC.ar(0.49670684337616), wave * DC.ar(0.66008913516998), wave * DC.ar(0.48189580440521), wave * DC.ar(0.57489120960236));
varW32Negat17454912 = TwoZero.ar(varW32Negat17454912 * varW32Negat17454910, varW32Negat1745499 * env, varW32Negat1745499, varW32Negat1745499, Silent.ar());
varW32Negat17454913 = MoogLadder.ar(wave * DC.ar(0.76559901237488), wave * DC.ar(0.49723529815674), wave * DC.ar(0.21543097496033), wave * DC.ar(0.98690462112427), wave * DC.ar(0.8881139755249));
varW32Negat17454914 = BBandPass.ar(BPZ2.ar(wave * DC.ar(0.10994732379913), wave * DC.ar(0.56503677368164), wave * DC.ar(0.847247838974)), modX, 0.13178336620331 * varW32Negat17454914 * varW32Negat17454914, env, Silent.ar());

signal = varW32Negat17454914;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// Die.800174551
/////////////////////////////////////////////////////////

SynthDef.new("Die.800174551", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varDie8001745519, varDie80017455110, varDie80017455111, varDie80017455112, varDie80017455113;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varDie8001745519 = varDie80017455110 = varDie80017455111 = varDie80017455112 = varDie80017455113 = K2A.ar(t_trig).dup;
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
varDie8001745519 = FreeVerb.ar(varDie8001745519 * varDie80017455110, varDie80017455113 * varDie80017455111, 0.9680517911911 * modZ, env * in, 0.99962671461909 * modZ, Silent.ar());
varDie80017455110 = AllpassL.ar(varDie8001745519 * modX, gateEnv * modX, modZ * modY, gate, 0.99998930733067 * varDie80017455113, Silent.ar());
varDie80017455111 = Saw.ar(varDie80017455113, OSTrunc8.ar(wave * DC.ar(0.65283632278442), wave * DC.ar(0.72032058238983)).lag2ud(wave * DC.ar(0.10664093494415), wave * DC.ar(0.2218325138092)), Silent.ar());
varDie80017455112 = BLBufRd.ar(Array.fill(2.pow(13), { |i| rrand(-1, 1) }).as(LocalBuf), signal * gateEnv, 0.7500821352005 * in * signal);
varDie80017455113 = LPF1.ar(varDie8001745519 * wave, env * signal);
varDie8001745519 = NTube.ar(wave * DC.ar(0.68790531158447), wave * DC.ar(0.39137780666351), wave * DC.ar(0.77013731002808), wave * DC.ar(0.023624062538147), wave * DC.ar(0.8263373374939), wave * DC.ar(0.9121515750885));
varDie80017455110 = Compander.ar(varDie80017455111 * signal, t_trig, 0.81269872188568 * varDie80017455110, in * env, varDie80017455111 * modY, varDie80017455111, varDie8001745519, 0.9550895692703 * BRZ2.ar(wave * DC.ar(0.50691032409668), wave * DC.ar(0.01953125), wave * DC.ar(0.91961455345154)), Silent.ar());
varDie80017455111 = OffsetOut.ar((80 + (island * 2)), [FoaRotate.ar(wave * DC.ar(0.82430601119995), wave * DC.ar(0.4242639541626), wave * DC.ar(0.29807543754578), wave * DC.ar(0.43106842041016)), Spreader.ar(wave * DC.ar(0.28768515586853), wave * DC.ar(0.71501135826111), wave * DC.ar(0.042488574981689), wave * DC.ar(0.26093149185181), wave * DC.ar(0.075311660766602))]);
varDie80017455112 = BBandStop.ar(wave, signal * modZ, 0.91399681568146 * wave * signal, varDie80017455113, Silent.ar());
varDie80017455113 = StkMoog.ar(wave * DC.ar(0.30222940444946), wave * DC.ar(0.9702490568161), wave * DC.ar(0.27410042285919), wave * DC.ar(0.86263310909271), wave * DC.ar(0.12795376777649), wave * DC.ar(0.71318411827087), wave * DC.ar(0.16656184196472), wave * DC.ar(0.68954241275787), wave * DC.ar(0.0020530223846436));

signal = varDie80017455113;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// W32.Asid174552
/////////////////////////////////////////////////////////

SynthDef.new("W32.Asid174552", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varW32Asid1745529, varW32Asid17455210, varW32Asid17455211;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varW32Asid1745529 = varW32Asid17455210 = varW32Asid17455211 = K2A.ar(t_trig).dup;
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
varW32Asid1745529 = MostChange.ar(y, modZ);
varW32Asid17455210 = NL2.ar(wave * in, Array.fill(2.pow(15), { |i| rrand(-1, 1) }).as(LocalBuf), 0.096580624580383 * modZ * gateEnv, z, Atari2600.ar(modX * gateEnv, varW32Asid17455210 * modX, varW32Asid17455211 * modZ, modX, env * in.bipolar(wave * DC.ar(0.94544076919556)), gateEnv, in), varW32Asid1745529, 0.99853186350051 * Logistic.ar(wave * DC.ar(0.74156022071838), wave * DC.ar(0.96412825584412), wave * DC.ar(0.44513154029846), wave * DC.ar(0.84596753120422), wave * DC.ar(0.97326147556305)), Silent.ar());
varW32Asid17455211 = MZPokey.ar(gate, env * in, 0.5568425655365 * modX * modY, wave, t_trig, modZ * gateEnv, varW32Asid1745529 * varW32Asid17455211, x, varW32Asid17455210 * modY);
varW32Asid1745529 = StkSaxofony.ar(wave * DC.ar(0.16979897022247), wave * DC.ar(0.19037389755249), wave * DC.ar(0.83529853820801), wave * DC.ar(0.21162664890289), wave * DC.ar(0.98933017253876), wave * DC.ar(0.54174494743347), wave * DC.ar(0.86501955986023), wave * DC.ar(0.55165350437164), wave * DC.ar(0.015673279762268), wave * DC.ar(0.63158297538757), wave * DC.ar(0.1205747127533));
varW32Asid17455210 = RunningSum.ar(wave * DC.ar(0.23376178741455), wave * DC.ar(0.93413209915161));
varW32Asid17455211 = FitzHughNagumo.ar(wave * DC.ar(0.22760331630707), wave * DC.ar(0.1556361913681), wave * DC.ar(0.53357195854187), wave * DC.ar(0.84806835651398), wave * DC.ar(0.57317769527435), wave * DC.ar(0.49078726768494), wave * DC.ar(0.32167303562164), wave * DC.ar(0.64167547225952), wave * DC.ar(0.53454303741455));

signal = varW32Asid17455211;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// XM.Laroux.AW174552
/////////////////////////////////////////////////////////

SynthDef.new("XM.Laroux.AW174552", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varXMLarouxAW1745529, varXMLarouxAW17455210, varXMLarouxAW17455211, varXMLarouxAW17455212, varXMLarouxAW17455213, varXMLarouxAW17455214;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varXMLarouxAW1745529 = varXMLarouxAW17455210 = varXMLarouxAW17455211 = varXMLarouxAW17455212 = varXMLarouxAW17455213 = varXMLarouxAW17455214 = K2A.ar(t_trig).dup;
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
varXMLarouxAW1745529 = B2UHJ.ar(gateEnv * modY, island.bitAnd(CrossoverDistortion.ar(wave * DC.ar(0.40307414531708), wave * DC.ar(0.66019344329834), wave * DC.ar(0.2879467010498), wave * DC.ar(0.64067244529724), wave * DC.ar(0.96526849269867))), varXMLarouxAW17455210 * varXMLarouxAW17455212);
varXMLarouxAW17455210 = Pan4.ar(in * signal, bufnum, varXMLarouxAW17455212 * varXMLarouxAW17455210, gateEnv);
varXMLarouxAW17455211 = LPFVS6.ar(varXMLarouxAW17455210, varXMLarouxAW17455211 * varXMLarouxAW17455211, varXMLarouxAW17455211);
varXMLarouxAW17455212 = Clipper32.ar(varXMLarouxAW17455211, gateEnv, varXMLarouxAW17455210 * in);
varXMLarouxAW17455213 = LFPulse.ar(wave, signal, 0.29782772064209 * varXMLarouxAW17455211 * signal, 0.9983693898057 * signal * wave, Silent.ar());
varXMLarouxAW17455214 = GrayNoise.ar(0.99421144749106 * env, Silent.ar());
varXMLarouxAW1745529 = LFDNoise3.ar(RMEQ.ar(wave * DC.ar(0.71301281452179), wave * DC.ar(0.14868021011353), wave * DC.ar(0.75577771663666), wave * DC.ar(0.96431529521942), wave * DC.ar(0.95656549930573), wave * DC.ar(0.96977460384369)).exprange(1, SampleRate.ir), 0.99998769588189 * varXMLarouxAW17455214 * modX, Silent.ar());
varXMLarouxAW17455210 = Pan4.ar(t_trig, env * varXMLarouxAW1745529.slew(wave * DC.ar(0.28531002998352), wave * DC.ar(0.60750675201416)), varXMLarouxAW1745529 * varXMLarouxAW17455213, modY);
varXMLarouxAW17455211 = MarkovSynth.ar(modX, varXMLarouxAW1745529 * modZ, modX, modX);
varXMLarouxAW17455212 = BFDecode1.ar(wave * DC.ar(0.84473621845245), wave * DC.ar(0.46450817584991), wave * DC.ar(0.27351260185242), wave * DC.ar(0.16728067398071), wave * DC.ar(0.10158228874207), wave * DC.ar(0.79209363460541), wave * DC.ar(0.77574396133423), wave * DC.ar(0.72986221313477), wave * DC.ar(0.6497049331665));
varXMLarouxAW17455213 = MZPokey.ar(modZ * wave, varXMLarouxAW17455212 * varXMLarouxAW17455214, 0.48323631286621 * StkMandolin.ar(wave * DC.ar(0.82279276847839), wave * DC.ar(0.48385775089264), wave * DC.ar(0.74435687065125), wave * DC.ar(0.19236302375793), wave * DC.ar(0.7786773443222), wave * DC.ar(0.14048278331757), wave * DC.ar(0.61336886882782), wave * DC.ar(0.22426187992096), wave * DC.ar(0.13400197029114)), modZ * varXMLarouxAW17455210, varXMLarouxAW17455213, varXMLarouxAW17455212, y, signal, in * varXMLarouxAW1745529);
varXMLarouxAW17455214 = BinData.ar(Array.fill(2.pow(12), { |i| rrand(-1, 1) }).as(LocalBuf), varXMLarouxAW17455213, modZ);

signal = varXMLarouxAW17455214;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// XM.Laroux.AW1745521
/////////////////////////////////////////////////////////

SynthDef.new("XM.Laroux.AW1745521", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varXMLarouxAW1745529, varXMLarouxAW17455210, varXMLarouxAW17455211, varXMLarouxAW17455212, varXMLarouxAW17455213, varXMLarouxAW17455214, varXMLarouxAW174552115, varXMLarouxAW174552116;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varXMLarouxAW1745529 = varXMLarouxAW17455210 = varXMLarouxAW17455211 = varXMLarouxAW17455212 = varXMLarouxAW17455213 = varXMLarouxAW17455214 = varXMLarouxAW174552115 = varXMLarouxAW174552116 = K2A.ar(t_trig).dup;
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
varXMLarouxAW1745529 = LFBrownNoise1.ar(BAllPass.ar(wave * DC.ar(0.26465857028961), wave * DC.ar(0.36484229564667), wave * DC.ar(0.84217894077301), wave * DC.ar(0.68245100975037), wave * DC.ar(0.68324744701385)).exprange(1, SampleRate.ir), varXMLarouxAW174552115, varXMLarouxAW174552116 * varXMLarouxAW17455212.bitOr(StkPluck.ar(wave * DC.ar(0.76344227790833), wave * DC.ar(0.23219394683838), wave * DC.ar(0.54987704753876), wave * DC.ar(0.71272933483124))), 0.38351361456087 * varXMLarouxAW174552115.min(FincoSprottL.ar(wave * DC.ar(0.034963607788086), wave * DC.ar(0.32774877548218), wave * DC.ar(0.53618943691254), wave * DC.ar(0.70918154716492), wave * DC.ar(0.8039630651474), wave * DC.ar(0.89337623119354), wave * DC.ar(0.93643069267273), wave * DC.ar(0.46046662330627))), Silent.ar());
varXMLarouxAW17455210 = IndexL.ar(Array.fill(2.pow(14), { |i| rrand(-1, 1) }).as(LocalBuf), 0.78480315208435 * varXMLarouxAW17455212 * modX, YigClifford3DC.ar(wave * DC.ar(0.54856383800507), wave * DC.ar(0.0010277032852173), wave * DC.ar(0.32236683368683), wave * DC.ar(0.91583514213562), wave * DC.ar(0.99030554294586), wave * DC.ar(0.03997278213501), wave * DC.ar(0.55380713939667), wave * DC.ar(0.77613317966461), wave * DC.ar(0.67340612411499), wave * DC.ar(0.2224360704422)), Silent.ar());
varXMLarouxAW17455211 = Logistic.ar(island, varXMLarouxAW1745529 * modX, varXMLarouxAW17455212, 0.77157969364153 * varXMLarouxAW17455213 * varXMLarouxAW17455213, Silent.ar());
varXMLarouxAW17455212 = MonoGrainBF.ar(island, varXMLarouxAW17455213 * in, modZ.thresh(BufWr.ar(wave * DC.ar(0.31239676475525), wave * DC.ar(0.096073150634766), wave * DC.ar(0.66589093208313), wave * DC.ar(0.78510391712189))), modX, varXMLarouxAW174552115 * varXMLarouxAW1745529, varXMLarouxAW17455210 * varXMLarouxAW17455212, env, 0.43697512149811 * modX * varXMLarouxAW17455212, varXMLarouxAW17455211 * varXMLarouxAW1745529, 0.99959529204777 * TIRand.ar(wave * DC.ar(0.24673521518707), wave * DC.ar(0.13343894481659), wave * DC.ar(0.93028473854065)), Silent.ar());
varXMLarouxAW17455213 = AllpassL.ar(0.82088971138 * modZ * modY, gate, modZ, modZ, varXMLarouxAW1745529, Silent.ar());
varXMLarouxAW17455214 = Standard2DL.ar(varXMLarouxAW17455213 * env, modY, bufnum, varXMLarouxAW17455214, modZ, wave, Silent.ar());
varXMLarouxAW1745529 = Schmidt.ar(wave * DC.ar(0.5505359172821), wave * DC.ar(0.20382273197174), wave * DC.ar(0.2172247171402));
varXMLarouxAW17455210 = APF.ar(wave * DC.ar(0.45620429515839), wave * DC.ar(0.50310575962067), wave * DC.ar(0.5865730047226), wave * DC.ar(0.25106513500214), wave * DC.ar(0.36939442157745));
varXMLarouxAW17455211 = Rotate.ar(wave * DC.ar(0.89032185077667), wave * DC.ar(0.73113334178925), wave * DC.ar(0.83910238742828), wave * DC.ar(0.71292328834534), wave * DC.ar(0.73917460441589));
varXMLarouxAW17455212 = WeaklyNonlinear.ar(env * varXMLarouxAW17455212, varXMLarouxAW174552116 * gateEnv, bufnum, t_trig, varXMLarouxAW17455211 * signal, modZ, modY * modX, wave, varXMLarouxAW17455211, varXMLarouxAW17455211, gateEnv * signal, Lag.ar(wave * DC.ar(0.9460117816925), wave * DC.ar(0.46239924430847), wave * DC.ar(0.41441285610199), wave * DC.ar(0.011973261833191)), Silent.ar());
varXMLarouxAW17455213 = TBrownRand.ar(wave * DC.ar(0.36432218551636), wave * DC.ar(0.80109655857086), wave * DC.ar(0.14480018615723), wave * DC.ar(0.63334095478058), wave * DC.ar(0.78655087947845), wave * DC.ar(0.94123375415802), wave * DC.ar(0.061168432235718));
varXMLarouxAW17455214 = FoaRotate.ar(wave * DC.ar(0.65237617492676), wave * DC.ar(0.36879444122314), wave * DC.ar(0.74316132068634), wave * DC.ar(0.5869528055191));
// Variation test code
varXMLarouxAW174552115 = VDiskIn.ar(2, Array.fill(2.pow(10), { |i| rrand(-1, 1) }).as(LocalBuf), 0.66008043289185 * varXMLarouxAW17455212 * gateEnv, 0.24357974529266 * varXMLarouxAW17455211 * varXMLarouxAW17455214, modZ * varXMLarouxAW17455214);
varXMLarouxAW174552116 = TGrains2.ar(2, env * modY, Array.fill(2.pow(10), { |i| rrand(-1, 1) }).as(LocalBuf), z, Balance.ar(gate, varXMLarouxAW17455211 * env, varXMLarouxAW17455210 * varXMLarouxAW17455214, modZ, 0.38633282275313 * varXMLarouxAW17455213 * modX, Silent.ar()), 0.079005002975464 * varXMLarouxAW174552115 * env, wave * varXMLarouxAW1745529, varXMLarouxAW17455214 * varXMLarouxAW17455212, amp, LFDNoise0.ar(RMEQ.ar(varXMLarouxAW17455210 * DC.ar(0.2751202583313), varXMLarouxAW17455211 * DC.ar(0.37989902496338), varXMLarouxAW1745529 * DC.ar(0.74553871154785), varXMLarouxAW17455211 * DC.ar(0.63489389419556), varXMLarouxAW17455211 * DC.ar(0.14262211322784), varXMLarouxAW17455211 * DC.ar(0.19288289546967)).exprange(1, SampleRate.ir), 0.94507796457812 * modX * varXMLarouxAW17455211, DoubleWell.ar(varXMLarouxAW17455212 * DC.ar(0.66106331348419), varXMLarouxAW17455213 * DC.ar(0.65216052532196), varXMLarouxAW1745529 * DC.ar(0.46342134475708), varXMLarouxAW17455210 * DC.ar(0.71972966194153), varXMLarouxAW17455214 * DC.ar(0.9361515045166), varXMLarouxAW1745529 * DC.ar(0.23753345012665), varXMLarouxAW17455211 * DC.ar(0.43472421169281), varXMLarouxAW17455212 * DC.ar(0.56038308143616), varXMLarouxAW17455211 * DC.ar(0.80780506134033), varXMLarouxAW1745529 * DC.ar(0.79539549350739))), modY * varXMLarouxAW17455212);
varXMLarouxAW174552115 = BufGrain.ar(modZ * in, in * modZ, bufnum, 0.90930700302124 * varXMLarouxAW17455210 * varXMLarouxAW17455211, varXMLarouxAW17455214 * varXMLarouxAW17455214, modX * in, 0.53126260449322 * varXMLarouxAW17455210 * modX, Silent.ar());
varXMLarouxAW174552116 = Rotate.ar(varXMLarouxAW17455213 * varXMLarouxAW17455214, amp, modX, t_trig, varXMLarouxAW174552116 * varXMLarouxAW17455211);
varXMLarouxAW174552115 = Delay2.ar(modY * wave, 0.95229847241688 * in, Silent.ar());
varXMLarouxAW174552116 = PulseCount.ar(modY, varXMLarouxAW1745529 * varXMLarouxAW17455211);

signal = varXMLarouxAW174552116;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// W97M.Caligula.D174552
/////////////////////////////////////////////////////////

SynthDef.new("W97M.Caligula.D174552", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varW97MCaligulaD1745529, varW97MCaligulaD17455210, varW97MCaligulaD17455211, varW97MCaligulaD17455212, varW97MCaligulaD17455213;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varW97MCaligulaD1745529 = varW97MCaligulaD17455210 = varW97MCaligulaD17455211 = varW97MCaligulaD17455212 = varW97MCaligulaD17455213 = K2A.ar(t_trig).dup;
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
varW97MCaligulaD1745529 = Pulse.ar(LagUD.ar(wave * DC.ar(0.44755876064301), wave * DC.ar(0.536661028862), wave * DC.ar(0.99923741817474), wave * DC.ar(0.64754974842072), wave * DC.ar(0.59603536128998)).exprange(1, SampleRate.ir), gateEnv * modY, 0.99972674828113 * env * wave.hypot(Duty.ar(wave * DC.ar(0.28861558437347), wave * DC.ar(0.58040225505829), wave * DC.ar(0.94052743911743), wave * DC.ar(0.078196167945862))), Silent.ar());
varW97MCaligulaD17455210 = SoftClipAmp4.ar(varW97MCaligulaD1745529 * signal, modY, RedPhasor.ar(wave * DC.ar(0.69778490066528), wave * DC.ar(0.72634947299957), wave * DC.ar(0.45864403247833), wave * DC.ar(0.26406848430634), wave * DC.ar(0.42753183841705), wave * DC.ar(0.66194784641266), wave * DC.ar(0.6634281873703)), Silent.ar());
varW97MCaligulaD17455211 = SawDPW.ar(varW97MCaligulaD17455213, env * varW97MCaligulaD17455211, 0.99998837610363 * Blip.ar(wave * DC.ar(0.68238747119904), wave * DC.ar(0.32125771045685), wave * DC.ar(0.49486982822418), wave * DC.ar(0.011364936828613)), Silent.ar());
varW97MCaligulaD17455212 = RandSeed.ar(signal * gateEnv, varW97MCaligulaD1745529);
varW97MCaligulaD17455213 = BrownNoise.ar(0.99735407093208 * varW97MCaligulaD17455213 * varW97MCaligulaD17455211, Silent.ar());
varW97MCaligulaD1745529 = LFBrownNoise0.ar(varW97MCaligulaD17455211 * varW97MCaligulaD17455211, varW97MCaligulaD17455211 * in, varW97MCaligulaD1745529 * varW97MCaligulaD1745529, 0.41908889649882 * modY * modY, Silent.ar());
varW97MCaligulaD17455210 = DoubleWell.ar(bufnum, in * modZ, modX, 0.79572570323944 * varW97MCaligulaD17455213 * wave, t_trig, varW97MCaligulaD17455211 * varW97MCaligulaD17455212, env * varW97MCaligulaD17455212, gate, Ringz.ar(wave * DC.ar(0.77538394927979), wave * DC.ar(0.62454617023468), wave * DC.ar(0.44932842254639), wave * DC.ar(0.60815107822418), wave * DC.ar(0.77332413196564)), FoaFocusY.ar(wave * DC.ar(0.2765531539917), wave * DC.ar(0.89493834972382), wave * DC.ar(0.16330826282501), wave * DC.ar(0.18589746952057)));
varW97MCaligulaD17455211 = CuspL.ar(gateEnv * wave, island, gateEnv * varW97MCaligulaD17455210, z, AtsNoiSynth.ar(wave * DC.ar(0.75587105751038), wave * DC.ar(0.6164790391922), wave * DC.ar(0.40425515174866), wave * DC.ar(0.4100227355957), wave * DC.ar(0.75996136665344), wave * DC.ar(0.76254713535309), wave * DC.ar(0.92253983020782), wave * DC.ar(0.75748991966248), wave * DC.ar(0.58169972896576), wave * DC.ar(0.43617331981659), wave * DC.ar(0.33209633827209), wave * DC.ar(0.12419748306274), wave * DC.ar(0.043493151664734), wave * DC.ar(0.43026006221771)), Silent.ar().lag3(wave * DC.ar(0.084986448287964), wave * DC.ar(0.11016619205475)));
varW97MCaligulaD17455212 = LPF18.ar(gateEnv, signal * signal, amp, env * varW97MCaligulaD17455211);
varW97MCaligulaD17455213 = Hasher.ar(wave * DC.ar(0.31625425815582), wave * DC.ar(0.12714815139771), wave * DC.ar(0.28204274177551));

signal = varW97MCaligulaD17455213;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// W32.Poison.Worm1745531
/////////////////////////////////////////////////////////

SynthDef.new("W32.Poison.Worm1745531", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varW32PoisonWorm1745539, varW32PoisonWorm17455310, varW32PoisonWorm17455311, varW32PoisonWorm17455312, varW32PoisonWorm17455313, varW32PoisonWorm17455314, varW32PoisonWorm17455315, varW32PoisonWorm174553116;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varW32PoisonWorm1745539 = varW32PoisonWorm17455310 = varW32PoisonWorm17455311 = varW32PoisonWorm17455312 = varW32PoisonWorm17455313 = varW32PoisonWorm17455314 = varW32PoisonWorm17455315 = varW32PoisonWorm174553116 = K2A.ar(t_trig).dup;
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
varW32PoisonWorm1745539 = PanB2.ar(modZ, x, varW32PoisonWorm17455311 * wave);
varW32PoisonWorm17455310 = Convolution3.ar(varW32PoisonWorm1745539 * varW32PoisonWorm17455311, varW32PoisonWorm17455313.lag(wave * DC.ar(0.4850537776947), wave * DC.ar(0.42749893665314)), varW32PoisonWorm17455313, varW32PoisonWorm17455312 * modX, signal, Silent.ar());
varW32PoisonWorm17455311 = PSinGrain.ar(modZ, 0.71828305721283 * varW32PoisonWorm17455315 * varW32PoisonWorm174553116, y);
varW32PoisonWorm17455312 = AudioMSG.ar(modZ * env, gate, 0.71072257408755 * varW32PoisonWorm17455313 * modZ, Silent.ar());
varW32PoisonWorm17455313 = GravityGrid.ar(modX, varW32PoisonWorm1745539 * env, 0.80510675907135 * gateEnv * gateEnv, island, Array.fill(2.pow(15), { |i| rrand(-1, 1) }).as(LocalBuf), 0.86692004512626 * modZ * varW32PoisonWorm17455311, Silent.ar());
varW32PoisonWorm17455314 = PanX2D.ar(2, 2, z.madd(wave * DC.ar(0.14629936218262), wave * DC.ar(0.85633850097656)), FreeVerb2.ar(wave * DC.ar(0.095077633857727), wave * DC.ar(0.44990170001984), wave * DC.ar(0.81603264808655), wave * DC.ar(0.011131763458252), wave * DC.ar(0.9688206911087), wave * DC.ar(0.88161027431488), wave * DC.ar(0.85766530036926)), varW32PoisonWorm17455312, varW32PoisonWorm17455312, varW32PoisonWorm17455311 * varW32PoisonWorm174553116, env);
varW32PoisonWorm17455315 = Slope.ar(t_trig, varW32PoisonWorm17455312, Silent.ar());
varW32PoisonWorm1745539 = LatoocarfianC.ar(varW32PoisonWorm174553116 * varW32PoisonWorm17455313, z, x, varW32PoisonWorm17455315 * modX, modX * varW32PoisonWorm17455312, island, GbmanTrig.ar(env, in * varW32PoisonWorm174553116, wave * modZ.wrap2(WaveTerrain.ar(wave * DC.ar(0.44566524028778), wave * DC.ar(0.53323566913605), wave * DC.ar(0.7619127035141), wave * DC.ar(0.02110743522644), wave * DC.ar(0.31619644165039), wave * DC.ar(0.34025681018829), wave * DC.ar(0.57206213474274))), varW32PoisonWorm17455314, 0.030141885405603 * varW32PoisonWorm17455311 * varW32PoisonWorm1745539, Silent.ar()), AllpassN.ar(wave * DC.ar(0.2444840669632), wave * DC.ar(0.63488495349884), wave * DC.ar(0.15347170829773), wave * DC.ar(0.72940003871918), wave * DC.ar(0.9506641626358), wave * DC.ar(0.22529637813568)), Silent.ar());
varW32PoisonWorm17455310 = MoogLadder.ar(varW32PoisonWorm17455311 * varW32PoisonWorm17455312, HPZ2.ar(wave * DC.ar(0.54349029064178), wave * DC.ar(0.17494654655457), wave * DC.ar(0.86720407009125)).exprange(1, SampleRate.ir), varW32PoisonWorm17455313 * varW32PoisonWorm17455310, 0.99983388265342 * modZ, Silent.ar());
varW32PoisonWorm17455311 = FMGrain.ar(varW32PoisonWorm174553116 * varW32PoisonWorm17455312, modZ, LFPulse.ar(wave * DC.ar(0.13046050071716), wave * DC.ar(0.2821296453476), wave * DC.ar(0.46837794780731), wave * DC.ar(0.24197852611542), wave * DC.ar(0.072205305099487)).exprange(1, SampleRate.ir), modZ * wave, 0.056975364685059 * gateEnv * varW32PoisonWorm17455315, varW32PoisonWorm17455315, Silent.ar());
varW32PoisonWorm17455312 = VOSIM.ar(Index.ar(wave * DC.ar(0.3755704164505), wave * DC.ar(0.91178858280182), wave * DC.ar(0.15707349777222), wave * DC.ar(0.67089116573334)), varW32PoisonWorm17455312, y, Nes2.ar(modX * varW32PoisonWorm17455313, varW32PoisonWorm17455315 * varW32PoisonWorm17455313, PanB2.ar(wave * DC.ar(0.3957839012146), wave * DC.ar(0.92669260501862), wave * DC.ar(0.45048081874847)), LPZ2.ar(wave * DC.ar(0.83243131637573), wave * DC.ar(0.38707554340363), wave * DC.ar(0.65666353702545)), in * varW32PoisonWorm17455314, modY, TwoTube.ar(wave * DC.ar(0.97458970546722), wave * DC.ar(0.45085942745209), wave * DC.ar(0.96582293510437), wave * DC.ar(0.41777217388153), wave * DC.ar(0.63956260681152), wave * DC.ar(0.56539785861969), wave * DC.ar(0.49338531494141)), 0.89608728885651 * varW32PoisonWorm17455310 * env, modX * modZ, varW32PoisonWorm1745539 * env, varW32PoisonWorm17455315 * varW32PoisonWorm174553116, varW32PoisonWorm17455312 * in, amp, in * varW32PoisonWorm1745539.explin(wave * DC.ar(0.38599288463593), wave * DC.ar(0.16734731197357), wave * DC.ar(0.24004364013672), wave * DC.ar(0.82203769683838), wave * DC.ar(0.16588020324707)), 0.0023760795593262 * in * modY, varW32PoisonWorm1745539 * varW32PoisonWorm174553116, modY, varW32PoisonWorm17455313 * varW32PoisonWorm17455312, varW32PoisonWorm1745539, varW32PoisonWorm17455314 * varW32PoisonWorm17455313), SanityCheck2.ar(wave * DC.ar(0.71781229972839)), Silent.ar());
varW32PoisonWorm17455313 = SinGrain.ar(wave * DC.ar(0.62696218490601), wave * DC.ar(0.48500716686249), wave * DC.ar(0.26777720451355), wave * DC.ar(0.11237502098083), wave * DC.ar(0.38255000114441));
varW32PoisonWorm17455314 = FoaDominateY.ar(varW32PoisonWorm1745539, amp, modX, Silent.ar());
varW32PoisonWorm17455315 = OnePole.ar(varW32PoisonWorm17455315, env * varW32PoisonWorm17455312, 0.99997700871694 * varW32PoisonWorm17455311, Silent.ar());
// Variation test code
varW32PoisonWorm174553116 = SetResetFF.ar(signal * varW32PoisonWorm17455313, in);
varW32PoisonWorm174553116 = PulseCount.ar(Latoocarfian2DL.ar(varW32PoisonWorm17455310 * DC.ar(0.82684051990509), varW32PoisonWorm17455314 * DC.ar(0.95803070068359), varW32PoisonWorm17455315 * DC.ar(0.49298357963562), varW32PoisonWorm17455312 * DC.ar(0.49034118652344), varW32PoisonWorm17455313 * DC.ar(0.69730067253113), varW32PoisonWorm17455311 * DC.ar(0.57363307476044), varW32PoisonWorm17455312 * DC.ar(0.12841248512268), varW32PoisonWorm17455310 * DC.ar(0.93450224399567), varW32PoisonWorm17455313 * DC.ar(0.35255873203278), varW32PoisonWorm17455313 * DC.ar(0.0093222856521606)), 0.0098119974136353 * varW32PoisonWorm17455312 * modX);
varW32PoisonWorm174553116 = BufAllpassL.ar(Array.fill(2.pow(14), { |i| rrand(-1, 1) }).as(LocalBuf), varW32PoisonWorm174553116 * varW32PoisonWorm17455313, wave * varW32PoisonWorm17455310, varW32PoisonWorm1745539 * signal, Formant.ar(varW32PoisonWorm1745539 * DC.ar(0.91441071033478), varW32PoisonWorm1745539 * DC.ar(0.31670248508453), varW32PoisonWorm17455310 * DC.ar(0.45632815361023), varW32PoisonWorm17455312 * DC.ar(0.95526039600372), varW32PoisonWorm1745539 * DC.ar(0.033110380172729)), Silent.ar());

signal = varW32PoisonWorm174553116;
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
varTankar23617455412 = LFDNoise3.ar(SinGrainBF.ar(wave * DC.ar(0.011183381080627), wave * DC.ar(0.69635450839996), wave * DC.ar(0.21296381950378), wave * DC.ar(0.27083957195282), wave * DC.ar(0.35072445869446), wave * DC.ar(0.83553266525269), wave * DC.ar(0.68829834461212), wave * DC.ar(0.74669861793518), wave * DC.ar(0.63463866710663)).exprange(1, SampleRate.ir), 0.9919814256649 * signal * varTankar2361745549, Silent.ar());
// Variation test code
varTankar236174554113 = LPCError.ar(0.25648045539856 * in * modX, modX * varTankar23617455410, Fhn2DN.ar(varTankar23617455411 * DC.ar(0.75736403465271), varTankar23617455410 * DC.ar(0.40779840946198), varTankar2361745549 * DC.ar(0.64779913425446), varTankar23617455411 * DC.ar(0.59023201465607), varTankar2361745549 * DC.ar(0.76430177688599), varTankar23617455412 * DC.ar(0.14542174339294), varTankar23617455411 * DC.ar(0.11447072029114), varTankar2361745549 * DC.ar(0.51483821868896), varTankar23617455411 * DC.ar(0.48495256900787), varTankar2361745549 * DC.ar(0.34539675712585), varTankar23617455411 * DC.ar(0.90273785591125)), Silent.ar());
varTankar236174554114 = BMoog.ar(modX, env * varTankar236174554115, gate, modY * varTankar23617455412, y, SinGrainBBF.ar(varTankar23617455411 * DC.ar(0.017170667648315), varTankar23617455411 * DC.ar(0.63261067867279), varTankar23617455412 * DC.ar(0.623002409935), varTankar23617455412 * DC.ar(0.22908186912537), varTankar23617455411 * DC.ar(0.3731335401535), varTankar2361745549 * DC.ar(0.70567083358765), varTankar2361745549 * DC.ar(0.84529149532318), varTankar23617455411 * DC.ar(0.0028386116027832), varTankar23617455412 * DC.ar(0.67220962047577), varTankar23617455412 * DC.ar(0.0126713514328)), BFEncode2.ar(varTankar2361745549 * DC.ar(0.82538783550262), varTankar23617455412 * DC.ar(0.60066282749176), varTankar23617455410 * DC.ar(0.41804087162018), varTankar23617455410 * DC.ar(0.18105614185333), varTankar2361745549 * DC.ar(0.50679993629456), varTankar2361745549 * DC.ar(0.034576058387756)).madd(varTankar23617455411 * DC.ar(0.84607136249542), varTankar2361745549 * DC.ar(0.87186515331268)));
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
// WM.Nop.C:De1745541
/////////////////////////////////////////////////////////

SynthDef.new("WM.Nop.C:De1745541", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varWMNopCDe1745549, varWMNopCDe17455410, varWMNopCDe174554111, varWMNopCDe174554112;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varWMNopCDe1745549 = varWMNopCDe17455410 = varWMNopCDe174554111 = varWMNopCDe174554112 = K2A.ar(t_trig).dup;
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
varWMNopCDe1745549 = StkBlowHole.ar(MarkovSynth.ar(wave * DC.ar(0.17808902263641), wave * DC.ar(0.95593857765198), wave * DC.ar(0.9817328453064), wave * DC.ar(0.21631515026093)).exprange(1, SampleRate.ir), signal * varWMNopCDe17455410, signal * varWMNopCDe17455410, gateEnv, t_trig, varWMNopCDe17455410 * varWMNopCDe174554111, 0.99762301456548 * signal * varWMNopCDe17455410, Silent.ar());
varWMNopCDe17455410 = FMGrain.ar(varWMNopCDe1745549 * modY, modY * in, gateEnv * env, wave, varWMNopCDe1745549, ChuaL.ar(wave * DC.ar(0.83742666244507), wave * DC.ar(0.54861676692963), wave * DC.ar(0.22491800785065), wave * DC.ar(0.78154706954956), wave * DC.ar(0.11799192428589), wave * DC.ar(0.66170358657837), wave * DC.ar(0.38172221183777), wave * DC.ar(0.21472525596619), wave * DC.ar(0.95588672161102), wave * DC.ar(0.096283912658691), wave * DC.ar(0.42482018470764), wave * DC.ar(0.12553083896637)), Silent.ar());
varWMNopCDe1745549 = SinGrainBF.ar(modY * modZ, Changed.ar(varWMNopCDe174554111, env), BHiShelf.ar(wave * DC.ar(0.27757179737091), wave * DC.ar(0.40293216705322), wave * DC.ar(0.50746929645538), wave * DC.ar(0.072531819343567), wave * DC.ar(0.79134356975555), wave * DC.ar(0.2706743478775)).exprange(1, SampleRate.ir), varWMNopCDe174554111 * modY, gate, amp, varWMNopCDe174554111 * varWMNopCDe174554111, 0.99336108913296 * varWMNopCDe17455410 * in, Silent.ar());
varWMNopCDe17455410 = TGrains2.ar(2, wave, Array.fill(2.pow(15), { |i| rrand(-1, 1) }).as(LocalBuf), x, varWMNopCDe17455410 * modY, signal, amp, in, varWMNopCDe17455410 * wave, in, Standard2DL.ar(DoubleWell3.ar(wave * DC.ar(0.021157145500183), wave * DC.ar(0.20790350437164), wave * DC.ar(0.29625368118286), wave * DC.ar(0.37251210212708), wave * DC.ar(0.23524594306946), wave * DC.ar(0.10957264900208), wave * DC.ar(0.18454897403717), wave * DC.ar(0.97335970401764)).exprange(1, SampleRate.ir), signal * gateEnv, modX * varWMNopCDe17455410, varWMNopCDe174554112, modX, OscN.ar(wave * DC.ar(0.5128835439682), wave * DC.ar(0.85307240486145), wave * DC.ar(0.88564825057983), wave * DC.ar(0.01499617099762), wave * DC.ar(0.65667951107025)), Silent.ar()));
// Variation test code
varWMNopCDe174554111 = RedPhasor2.ar(modY * modY, varWMNopCDe17455410 * gateEnv, gate, bufnum, 0.61524426937103 * modZ * wave, modY * varWMNopCDe174554111, modY);
varWMNopCDe174554112 = Instruction.ar(Array.fill(2.pow(11), { |i| rrand(-1, 1) }).as(LocalBuf), 0.94705236266577 * modY * in, Silent.ar());
varWMNopCDe174554111 = OnePole.ar(signal * gateEnv, island, 0.99660185929276 * varWMNopCDe17455410 * modZ, Silent.ar());
varWMNopCDe174554112 = MarkovSynth.ar(modX * wave, bufnum, modX * varWMNopCDe174554112, 0.90090501308441 * gateEnv * wave);
varWMNopCDe174554111 = RedDPCMdecode.ar(modY * signal);
varWMNopCDe174554112 = PlayBuf.ar(2, Array.fill(2.pow(14), { |i| rrand(-1, 1) }).as(LocalBuf).bipolar(varWMNopCDe1745549 * DC.ar(0.62756907939911)), bufnum, varWMNopCDe17455410 * in, varWMNopCDe174554111 * varWMNopCDe17455410, amp, x);

signal = varWMNopCDe174554112;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// Youc.1648174555
/////////////////////////////////////////////////////////

SynthDef.new("Youc.1648174555", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varYouc16481745559, varYouc164817455510;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varYouc16481745559 = varYouc164817455510 = K2A.ar(t_trig).dup;
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
varYouc16481745559 = FoaPressY.ar(modX * modX, modZ * env, modZ, Silent.ar());
varYouc164817455510 = RosslerResL.ar(varYouc164817455510, gate, WaveTerrain.ar(wave * DC.ar(0.8463339805603), wave * DC.ar(0.40975940227509), wave * DC.ar(0.94975447654724), wave * DC.ar(0.96756589412689), wave * DC.ar(0.63890600204468), wave * DC.ar(0.2009516954422), wave * DC.ar(0.2207053899765)).exprange(1, SampleRate.ir), env, varYouc164817455510, 0.83969449996948 * modY * modY, varYouc16481745559 * modY, 0.45891678333282 * signal * wave, varYouc16481745559 * wave, modY * env, 0.98775005816427 * modY * modY, Silent.ar());
varYouc16481745559 = FincoSprottM.ar(env * signal, 0.1770646572113 * modY * varYouc16481745559, t_trig, varYouc164817455510 * varYouc16481745559, modZ * signal, island, in, MoogVCF.ar(wave * DC.ar(0.55676007270813), wave * DC.ar(0.67110598087311), wave * DC.ar(0.88146042823792), wave * DC.ar(0.17775857448578), wave * DC.ar(0.46000635623932)), Silent.ar());
varYouc164817455510 = SID6581f.ar(wave * DC.ar(0.96167528629303), wave * DC.ar(0.66351127624512), wave * DC.ar(0.34502112865448), wave * DC.ar(0.47390401363373), wave * DC.ar(0.068666815757751), wave * DC.ar(0.77682459354401), wave * DC.ar(0.058058738708496), wave * DC.ar(0.30646967887878), wave * DC.ar(0.70508706569672), wave * DC.ar(0.43336498737335), wave * DC.ar(0.30183911323547), wave * DC.ar(0.045578122138977), wave * DC.ar(0.30986154079437), wave * DC.ar(0.41729044914246), wave * DC.ar(0.61662864685059), wave * DC.ar(0.2322074174881), wave * DC.ar(0.6463840007782), wave * DC.ar(0.26215064525604), wave * DC.ar(0.75024735927582), wave * DC.ar(0.13243079185486), wave * DC.ar(0.25501656532288), wave * DC.ar(0.75413429737091), wave * DC.ar(0.064090967178345), wave * DC.ar(0.31595480442047), wave * DC.ar(0.012027025222778), wave * DC.ar(0.28327596187592));

signal = varYouc164817455510;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// Youc.16481745551
/////////////////////////////////////////////////////////

SynthDef.new("Youc.16481745551", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varYouc16481745559, varYouc164817455510, varYouc1648174555111, varYouc1648174555112, varYouc1648174555113, varYouc1648174555114;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varYouc16481745559 = varYouc164817455510 = varYouc1648174555111 = varYouc1648174555112 = varYouc1648174555113 = varYouc1648174555114 = K2A.ar(t_trig).dup;
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
varYouc16481745559 = SMS.ar(modY, island, varYouc1648174555114 * modZ, amp, env * varYouc1648174555111, 0.99993150642999 * XLine.ar(wave * DC.ar(0.44514405727386), wave * DC.ar(0.78759670257568), wave * DC.ar(0.69858634471893), wave * DC.ar(0.23082220554352), wave * DC.ar(0.56951487064362), wave * DC.ar(0.95359694957733)), Silent.ar(), env * varYouc16481745559, t_trig, 0.96932682516018 * signal * wave, Array.fill(2.pow(11), { |i| rrand(-1, 1) }).as(LocalBuf), 0.99994270503348 * modY * in, Silent.ar());
varYouc164817455510 = StkClarinet.ar(varYouc1648174555111 * varYouc1648174555112, modY, varYouc1648174555111, modY * varYouc1648174555112, modZ, modZ * varYouc1648174555113, StereoConvolution2L.ar(wave * DC.ar(0.69074475765228), wave * DC.ar(0.055500507354736), wave * DC.ar(0.84831142425537), wave * DC.ar(0.55689585208893), wave * DC.ar(0.96667742729187), wave * DC.ar(0.60363960266113), wave * DC.ar(0.17532444000244), wave * DC.ar(0.67524373531342)), varYouc1648174555111, Silent.ar());
varYouc16481745559 = AllpassN.ar(x, varYouc1648174555114 * varYouc16481745559.lag3(wave * DC.ar(0.34818601608276), wave * DC.ar(0.94178414344788)), in * modY, modX * env, modY, LFPar.ar(wave * DC.ar(0.62536525726318), wave * DC.ar(0.024266719818115), wave * DC.ar(0.93579280376434), wave * DC.ar(0.046855688095093)));
varYouc164817455510 = BufGrain.ar(varYouc16481745559 * signal, modX, bufnum, varYouc16481745559, varYouc164817455510, env, 0.9996894436114 * varYouc164817455510 * modY, Silent.ar());
// Variation test code
varYouc1648174555111 = MonoGrainBF.ar(varYouc16481745559, modZ * varYouc1648174555114, varYouc1648174555112, 0.26537275314331 * signal * varYouc164817455510, wave, in * env, varYouc1648174555114 * signal, amp, y, MidEQ.ar(varYouc164817455510 * DC.ar(0.82409691810608), varYouc16481745559 * DC.ar(0.043960690498352), varYouc164817455510 * DC.ar(0.22855114936829), varYouc164817455510 * DC.ar(0.58295154571533), varYouc16481745559 * DC.ar(0.21768569946289), varYouc164817455510 * DC.ar(0.25659430027008)), Silent.ar());
varYouc1648174555112 = NestedAllpassN.ar(y, signal * modX, varYouc164817455510, varYouc1648174555112 * modX, varYouc164817455510 * gateEnv, in, modY * gateEnv, 0.99994366902076 * modX * varYouc16481745559, Silent.ar());
varYouc1648174555113 = RMShelf2.ar(in * modX, wave, varYouc1648174555112 * varYouc1648174555113, 0.99756912463494 * FMHEncode2.ar(varYouc16481745559 * DC.ar(0.095921516418457), varYouc164817455510 * DC.ar(0.74683201313019), varYouc16481745559 * DC.ar(0.018603682518005), varYouc164817455510 * DC.ar(0.30980277061462), varYouc16481745559 * DC.ar(0.29759740829468), varYouc16481745559 * DC.ar(0.69440948963165)), Silent.ar());
varYouc1648174555114 = CombLP.ar(env * in, Concat.ar(varYouc1648174555111 * varYouc1648174555114, modY * signal, varYouc164817455510 * varYouc16481745559, in * in, varYouc1648174555111, amp, modZ, y, signal * wave, varYouc164817455510 * varYouc1648174555112, varYouc1648174555112 * varYouc1648174555114, signal * modX, 0.99707665524996 * varYouc1648174555113 * varYouc1648174555113, Silent.ar()), varYouc1648174555111, modZ * varYouc1648174555111, modX * env, wave * modY, 0.99922354720008 * varYouc1648174555112 * varYouc1648174555113, Silent.ar());
varYouc1648174555111 = TPV.ar(island, x, gate, varYouc1648174555112 * varYouc164817455510.lag2ud(varYouc164817455510 * DC.ar(0.5206470489502), varYouc16481745559 * DC.ar(0.44497835636139)), 0.44426846504211 * varYouc1648174555114 * modZ, 0.99541995131438 * varYouc1648174555111, signal, 0.60514974594116 * modY * env, SinGrainIBF.ar(varYouc16481745559 * DC.ar(0.16223967075348), varYouc164817455510 * DC.ar(0.51469266414642), varYouc16481745559 * DC.ar(0.66262936592102), varYouc16481745559 * DC.ar(0.036669135093689), varYouc164817455510 * DC.ar(0.52913641929626), varYouc16481745559 * DC.ar(0.4161274433136), varYouc164817455510 * DC.ar(0.48308181762695), varYouc164817455510 * DC.ar(0.99821043014526), varYouc16481745559 * DC.ar(0.67540907859802), varYouc164817455510 * DC.ar(0.20759809017181), varYouc16481745559 * DC.ar(0.34104466438293), varYouc16481745559 * DC.ar(0.79333710670471)), Silent.ar());
varYouc1648174555112 = WaveTerrain.ar(Array.fill(2.pow(11), { |i| rrand(-1, 1) }).as(LocalBuf), varYouc1648174555114, SoftClipper8.ar(island), bufnum, modX, modY, Silent.ar());
varYouc1648174555113 = DoubleNestedAllpassN.ar(varYouc164817455510 * modY, modX, varYouc1648174555114 * varYouc1648174555113, 0.86412823200226 * varYouc1648174555111 * modZ, 0.8281112909317 * varYouc1648174555113 * signal, signal * varYouc1648174555113, island, x, t_trig, gate, varYouc1648174555112, Silent.ar());
varYouc1648174555114 = AtsNoiSynth.ar(Array.fill(2.pow(12), { |i| rrand(-1, 1) }).as(LocalBuf), varYouc164817455510 * modZ, gate, varYouc164817455510, 0.87670958042145 * env, Blip.ar(modZ * varYouc1648174555112, varYouc1648174555112 * signal, Pokey.ar(varYouc164817455510 * DC.ar(0.57645440101624), varYouc16481745559 * DC.ar(0.77752315998077), varYouc164817455510 * DC.ar(0.64545810222626), varYouc164817455510 * DC.ar(0.13226842880249), varYouc164817455510 * DC.ar(0.57934463024139), varYouc164817455510 * DC.ar(0.17823922634125), varYouc164817455510 * DC.ar(0.020235419273376), varYouc16481745559 * DC.ar(0.78648507595062), varYouc164817455510 * DC.ar(0.90311503410339)), Silent.ar()), in * varYouc1648174555111, modZ * gateEnv, varYouc164817455510, gate, gateEnv, modZ * signal, 0.99913241601564 * modY * env, Silent.ar());
varYouc1648174555111 = Spring.ar(BBandPass.ar(varYouc1648174555114, Friction.ar(varYouc164817455510 * DC.ar(0.21163582801819), varYouc16481745559 * DC.ar(0.61626529693604), varYouc16481745559 * DC.ar(0.44106531143188), varYouc164817455510 * DC.ar(0.0077658891677856), varYouc16481745559 * DC.ar(0.74357283115387), varYouc16481745559 * DC.ar(0.5598121881485), varYouc16481745559 * DC.ar(0.53279030323029), varYouc16481745559 * DC.ar(0.63696765899658)).exprange(1, SampleRate.ir), varYouc164817455510 * varYouc1648174555111, 0.99702120677349 * varYouc1648174555111 * signal, Silent.ar()), Dust.ar(z, Phasor.ar(varYouc164817455510 * DC.ar(0.4725900888443), varYouc16481745559 * DC.ar(0.43854904174805), varYouc16481745559 * DC.ar(0.25894927978516), varYouc16481745559 * DC.ar(0.99490165710449), varYouc16481745559 * DC.ar(0.71046912670135)), Silent.ar()), varYouc1648174555114 * varYouc164817455510);
varYouc1648174555112 = SortBuf.ar(Array.fill(2.pow(16), { |i| rrand(-1, 1) }).as(LocalBuf), varYouc16481745559, signal * wave);
varYouc1648174555113 = SkipNeedle.ar(gateEnv * varYouc1648174555113, 0.77307140827179 * varYouc16481745559 * modX, in);
varYouc1648174555114 = Tap.ar(Array.fill(2.pow(12), { |i| rrand(-1, 1) }).as(LocalBuf), 2, t_trig);

signal = varYouc1648174555114;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// XM.Laroux.AM:Jp174556
/////////////////////////////////////////////////////////

SynthDef.new("XM.Laroux.AM:Jp174556", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varXMLarouxAMJp1745569, varXMLarouxAMJp17455610, varXMLarouxAMJp17455611;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varXMLarouxAMJp1745569 = varXMLarouxAMJp17455610 = varXMLarouxAMJp17455611 = K2A.ar(t_trig).dup;
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
varXMLarouxAMJp1745569 = Gbman2DN.ar(modX * env, FitzHughNagumo.ar(wave * DC.ar(0.37945199012756), wave * DC.ar(0.15891373157501), wave * DC.ar(0.36797201633453), wave * DC.ar(0.53460228443146), wave * DC.ar(0.74866044521332), wave * DC.ar(0.86029064655304), wave * DC.ar(0.73619019985199), wave * DC.ar(0.14646184444427), wave * DC.ar(0.70716965198517)).exprange(1, SampleRate.ir), x, modY, 0.97316491358148 * gateEnv, Silent.ar());
varXMLarouxAMJp17455610 = ArrayMax.ar([Latch.ar(wave * DC.ar(0.44084143638611), wave * DC.ar(0.54362070560455)), GrayNoise.ar(wave * DC.ar(0.93192434310913), wave * DC.ar(0.67086601257324))]);
varXMLarouxAMJp17455611 = DelTapWr.ar(Array.fill(2.pow(11), { |i| rrand(-1, 1) }).as(LocalBuf).ring2(LFPulse.ar(wave * DC.ar(0.57868659496307), wave * DC.ar(0.79208517074585), wave * DC.ar(0.80518078804016), wave * DC.ar(0.36238396167755), wave * DC.ar(0.66016805171967))), varXMLarouxAMJp17455611 * modZ);
varXMLarouxAMJp1745569 = BFEncodeSter.ar(0.88219428062439 * varXMLarouxAMJp17455611 * modX, varXMLarouxAMJp1745569, 0.20811057090759 * varXMLarouxAMJp17455610 * env, QuadC.ar(BufAllpassN.ar(wave * DC.ar(0.693932056427), wave * DC.ar(0.60556268692017), wave * DC.ar(0.14341616630554), wave * DC.ar(0.94477462768555), wave * DC.ar(0.8487640619278), wave * DC.ar(0.3790887594223)).exprange(1, SampleRate.ir).lag2ud(wave * DC.ar(0.11332559585571), wave * DC.ar(0.61033225059509)), z, y, env * wave, varXMLarouxAMJp17455610 * wave, 0.95171651398455 * signal * varXMLarouxAMJp1745569, RosslerResL.ar(wave * DC.ar(0.82284879684448), wave * DC.ar(0.51076686382294), wave * DC.ar(0.54820346832275), wave * DC.ar(0.53893899917603), wave * DC.ar(0.19490551948547), wave * DC.ar(0.23788392543793), wave * DC.ar(0.12742340564728), wave * DC.ar(0.37010741233826), wave * DC.ar(0.7446905374527), wave * DC.ar(0.60290920734406), wave * DC.ar(0.26656985282898), wave * DC.ar(0.62761855125427))), modZ, modY, AtsPartial.ar(Array.fill(2.pow(16), { |i| rrand(-1, 1) }).as(LocalBuf), modX, modZ * modY, Timer.ar(wave * DC.ar(0.5964183807373)).exprange(1, SampleRate.ir), Blip.ar(wave * DC.ar(0.69027876853943), wave * DC.ar(0.43732964992523), wave * DC.ar(0.91480767726898), wave * DC.ar(0.55116856098175)).exprange(1, SampleRate.ir), modZ, Silent.ar()), modX * modY);
varXMLarouxAMJp17455610 = BPZ2.ar(wave * DC.ar(0.21347260475159), wave * DC.ar(0.74234533309937), wave * DC.ar(0.41512155532837));
varXMLarouxAMJp17455611 = LFGauss.ar(wave * DC.ar(0.73852169513702), wave * DC.ar(0.39635837078094), wave * DC.ar(0.69888389110565), wave * DC.ar(0.0109623670578), wave * DC.ar(0.065298914909363));

signal = varXMLarouxAMJp17455611;
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
varXMLarouxAMJp1745569 = AtsParInfo.ar(Array.fill(2.pow(13), { |i| rrand(-1, 1) }).as(LocalBuf), varXMLarouxAMJp17455611 * varXMLarouxAMJp174556114, varXMLarouxAMJp174556113, gateEnv, Silent.ar());
varXMLarouxAMJp17455610 = OSTrunc4.ar(varXMLarouxAMJp174556113 * modY, varXMLarouxAMJp1745569 * env);
varXMLarouxAMJp17455611 = LFDNoise1.ar(varXMLarouxAMJp1745569 * wave.lag(wave * DC.ar(0.39445745944977), wave * DC.ar(0.23823487758636)), varXMLarouxAMJp174556114.bipolar(wave * DC.ar(0.52581918239594)), Silent.ar());
varXMLarouxAMJp1745569 = Maxamp.ar(t_trig, varXMLarouxAMJp17455610 * modX);
varXMLarouxAMJp17455610 = OSTrunc4.ar(0.35065793991089 * env * signal, varXMLarouxAMJp174556112);
varXMLarouxAMJp17455611 = LFBrownNoise0.ar(varXMLarouxAMJp17455610 * in, 0.56941378116608 * signal * in, wave, 0.98373700866809 * varXMLarouxAMJp174556114 * modX, Silent.ar());
// Variation test code
varXMLarouxAMJp174556112 = BFEncode2.ar(modZ, varXMLarouxAMJp174556113 * gateEnv, in, 0.17224204540253 * CombC.ar(varXMLarouxAMJp17455611 * DC.ar(0.15721344947815), varXMLarouxAMJp17455610 * DC.ar(0.69817626476288), varXMLarouxAMJp17455610 * DC.ar(0.11392998695374), varXMLarouxAMJp1745569 * DC.ar(0.12659931182861), varXMLarouxAMJp17455610 * DC.ar(0.22474205493927), varXMLarouxAMJp17455611 * DC.ar(0.85394215583801)), varXMLarouxAMJp17455611, varXMLarouxAMJp1745569);
varXMLarouxAMJp174556113 = GrainSin.ar(2, modZ, varXMLarouxAMJp17455611 * varXMLarouxAMJp174556112, FoaTilt.ar(varXMLarouxAMJp1745569 * DC.ar(0.010325908660889), varXMLarouxAMJp17455611 * DC.ar(0.52912938594818), varXMLarouxAMJp17455610 * DC.ar(0.60909461975098), varXMLarouxAMJp1745569 * DC.ar(0.50148725509644)).exprange(1, SampleRate.ir), varXMLarouxAMJp1745569 * gateEnv, bufnum, 0.47285389900208 * modX, 0.99929689358285 * signal * varXMLarouxAMJp17455611, Silent.ar());
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
// W32.Tasmer.46395174558
/////////////////////////////////////////////////////////

SynthDef.new("W32.Tasmer.46395174558", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varW32Tasmer463951745589;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varW32Tasmer463951745589 = K2A.ar(t_trig).dup;
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
varW32Tasmer463951745589 = BufGrainBF.ar(modZ * modY, signal * gateEnv, bufnum, gate, signal * env, env, modY * gateEnv, varW32Tasmer463951745589 * modY.ring2(Hasher.ar(wave * DC.ar(0.98698973655701), wave * DC.ar(0.81284320354462), wave * DC.ar(0.65280449390411))), in, varW32Tasmer463951745589 * modX, 0.88970718430372 * modY * signal, SinGrainBF.ar(wave * DC.ar(0.057965755462646), wave * DC.ar(0.036986708641052), wave * DC.ar(0.7927793264389), wave * DC.ar(0.7222158908844), wave * DC.ar(0.80410921573639), wave * DC.ar(0.2283433675766), wave * DC.ar(0.91340243816376), wave * DC.ar(0.70028221607208), wave * DC.ar(0.37378334999084)).unipolar(wave * DC.ar(0.4293338060379)));
varW32Tasmer463951745589 = NLFiltL.ar(y, varW32Tasmer463951745589 * varW32Tasmer463951745589, wave * signal, modY * in, amp, in * env, CheckBadValues.ar(wave * DC.ar(0.66157019138336), wave * DC.ar(0.54065370559692), wave * DC.ar(0.85677433013916)), Silent.ar());

signal = varW32Tasmer463951745589;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// W32.Frogot174558
/////////////////////////////////////////////////////////

SynthDef.new("W32.Frogot174558", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varW32Frogot1745589, varW32Frogot17455810, varW32Frogot17455811, varW32Frogot17455812;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varW32Frogot1745589 = varW32Frogot17455810 = varW32Frogot17455811 = varW32Frogot17455812 = K2A.ar(t_trig).dup;
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
varW32Frogot1745589 = FoaNFC.ar(x, bufnum, modY, Silent.ar());
varW32Frogot17455810 = FoaDirectX.ar(varW32Frogot17455810, island, modY, Silent.ar());
varW32Frogot17455811 = FoaZoomY.ar(0.23809540271759 * wave * varW32Frogot1745589, varW32Frogot17455810, 0.99776232415358 * modX * in, Silent.ar());
varW32Frogot17455812 = MembraneCircle.ar(y, amp, varW32Frogot1745589 * modX, 0.81746662855409 * signal * in, Silent.ar());
varW32Frogot1745589 = SoftClipAmp4.ar(wave, modZ, varW32Frogot17455811, Silent.ar());
varW32Frogot17455810 = TextVU.ar(GlitchRHPF.ar(wave * DC.ar(0.044165134429932), wave * DC.ar(0.5763623714447), wave * DC.ar(0.91012895107269), wave * DC.ar(0.86908674240112), wave * DC.ar(0.71017253398895)), modX * varW32Frogot17455812, modY * modZ, in * in.pow(BRZ2.ar(wave * DC.ar(0.13753092288971), wave * DC.ar(0.58097159862518), wave * DC.ar(0.52001857757568))), modY * varW32Frogot17455812, modZ * wave);
varW32Frogot17455811 = Pan4.ar(varW32Frogot17455810 * varW32Frogot17455811, gate, y, gateEnv);
varW32Frogot17455812 = YigMandelbulbN.ar(env * varW32Frogot1745589, in * wave.lag3ud(wave * DC.ar(0.56789529323578), wave * DC.ar(0.037094831466675)), modY, modX * wave, x, env, Silent.ar());

signal = varW32Frogot17455812;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// Atenfor.2515174559
/////////////////////////////////////////////////////////

SynthDef.new("Atenfor.2515174559", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varAtenfor25151745599, varAtenfor251517455910, varAtenfor251517455911, varAtenfor251517455912, varAtenfor251517455913, varAtenfor251517455914;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varAtenfor25151745599 = varAtenfor251517455910 = varAtenfor251517455911 = varAtenfor251517455912 = varAtenfor251517455913 = varAtenfor251517455914 = K2A.ar(t_trig).dup;
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
varAtenfor25151745599 = FoaPanB.ar(signal, varAtenfor251517455913 * modY, wave, 0.99998057048863 * modY * modZ, Silent.ar());
varAtenfor251517455910 = PanX.ar(2, wave, 0.90215122699738 * varAtenfor25151745599 * varAtenfor251517455910, signal * varAtenfor251517455913, MidEQ.ar(wave * DC.ar(0.99136066436768), wave * DC.ar(0.41580545902252), wave * DC.ar(0.11830484867096), wave * DC.ar(0.41032660007477), wave * DC.ar(0.42969036102295), wave * DC.ar(0.37475633621216)));
varAtenfor251517455911 = CrossoverDistortion.ar(env * varAtenfor251517455911, x, varAtenfor251517455910, 0.99433608452987 * varAtenfor251517455913, Silent.ar());
varAtenfor251517455912 = AtsPartial.ar(Array.fill(2.pow(15), { |i| rrand(-1, 1) }).as(LocalBuf), modX * varAtenfor25151745599, wave, OSTrunc4.ar(wave * DC.ar(0.59112453460693), wave * DC.ar(0.77640247344971)).exprange(1, SampleRate.ir), in * gateEnv, env, AtsParInfo.ar(wave * DC.ar(0.38812339305878), wave * DC.ar(0.4080411195755), wave * DC.ar(0.87701082229614), wave * DC.ar(0.29337012767792), wave * DC.ar(0.17068898677826)));
varAtenfor251517455913 = MembraneHexagon.ar(modX, modZ * varAtenfor251517455911, modY, 0.65410950781636 * modX * varAtenfor251517455912, Silent.ar());
varAtenfor251517455914 = RedLbyl.ar(modY, 0.62201833724976 * in * gateEnv.linlin(wave * DC.ar(0.23494350910187), wave * DC.ar(0.7036828994751), wave * DC.ar(0.022769808769226), wave * DC.ar(0.42905282974243), wave * DC.ar(0.86361491680145)), z);
varAtenfor25151745599 = Latoocarfian2DN.ar(modX, varAtenfor251517455912 * varAtenfor251517455914, 0.10598182678223 * varAtenfor25151745599 * in, modZ * modZ, 0.26440572738647 * modX * signal, t_trig, 0.87355983257294 * MonoGrainBF.ar(wave * DC.ar(0.56574559211731), wave * DC.ar(0.84532952308655), wave * DC.ar(0.96907758712769), wave * DC.ar(0.67776215076447), wave * DC.ar(0.13802111148834), wave * DC.ar(0.19051933288574), wave * DC.ar(0.13694059848785), wave * DC.ar(0.080048322677612), wave * DC.ar(0.27860045433044), wave * DC.ar(0.51011335849762), wave * DC.ar(0.95234251022339)), modZ.lcm(MonoGrain.ar(wave * DC.ar(0.67002475261688), wave * DC.ar(0.90607511997223), wave * DC.ar(0.20372140407562), wave * DC.ar(0.61819458007812), wave * DC.ar(0.10291576385498), wave * DC.ar(0.90118765830994))), 0.9041728544179 * varAtenfor251517455914 * wave, Silent.ar());
varAtenfor251517455910 = BufGrainBBF.ar(BufGrainI.ar(wave * DC.ar(0.084875583648682), wave * DC.ar(0.16633999347687), wave * DC.ar(0.30985260009766), wave * DC.ar(0.31656849384308), wave * DC.ar(0.63122570514679), wave * DC.ar(0.78695380687714), wave * DC.ar(0.32397103309631), wave * DC.ar(0.094122529029846), wave * DC.ar(0.085317134857178), wave * DC.ar(0.2589316368103), wave * DC.ar(0.61133205890656)), env, bufnum, 0.56326603889465 * varAtenfor251517455911 * gateEnv.linexp(wave * DC.ar(0.26459002494812), wave * DC.ar(0.53516674041748), wave * DC.ar(0.24023115634918), wave * DC.ar(0.24577355384827), wave * DC.ar(0.3146036863327)), OnePole.ar(x, varAtenfor251517455914, StkBowed.ar(wave * DC.ar(0.25934016704559), wave * DC.ar(0.27789723873138), wave * DC.ar(0.23270535469055), wave * DC.ar(0.39802181720734), wave * DC.ar(0.93424701690674), wave * DC.ar(0.1049633026123), wave * DC.ar(0.22221839427948), wave * DC.ar(0.98053252696991), wave * DC.ar(0.31424522399902), wave * DC.ar(0.21664226055145), wave * DC.ar(0.52138423919678)), Silent.ar()), bufnum, amp, varAtenfor251517455911, modX, t_trig, 0.74256503582001 * varAtenfor251517455912 * varAtenfor251517455914, 0.92461139010131 * signal * varAtenfor25151745599, Silent.ar());
varAtenfor251517455911 = BHiShelf.ar(modY * varAtenfor251517455914, Brusselator.ar(wave * DC.ar(0.44024109840393), wave * DC.ar(0.52945899963379), wave * DC.ar(0.1948881149292), wave * DC.ar(0.99507319927216), wave * DC.ar(0.20436799526215), wave * DC.ar(0.93934690952301), wave * DC.ar(0.52204990386963), wave * DC.ar(0.92706286907196)).exprange(1, SampleRate.ir), modY * gateEnv, varAtenfor251517455914 * wave, 0.99980924964887 * varAtenfor25151745599 * in, Silent.ar());
varAtenfor251517455912 = FoaTumble.ar(varAtenfor251517455914 * modY, modX * varAtenfor251517455910, varAtenfor251517455912, Silent.ar());
varAtenfor251517455913 = LoopBuf.ar(2, Array.fill(2.pow(10), { |i| rrand(-1, 1) }).as(LocalBuf), y, t_trig, modY * varAtenfor251517455912, varAtenfor251517455913, modX * varAtenfor25151745599, varAtenfor251517455914 * signal);
varAtenfor251517455914 = BinData.ar(Array.fill(2.pow(11), { |i| rrand(-1, 1) }).as(LocalBuf), modX, y);

signal = varAtenfor251517455914;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// MtE.Groove174600
/////////////////////////////////////////////////////////

SynthDef.new("MtE.Groove174600", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varMtEGroove1746009, varMtEGroove17460010;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varMtEGroove1746009 = varMtEGroove17460010 = K2A.ar(t_trig).dup;
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
varMtEGroove1746009 = TPV.ar(modX * gateEnv, modZ, varMtEGroove17460010 * wave, gateEnv * env, modY * modY, LFClipNoise.ar(wave * DC.ar(0.63634037971497), wave * DC.ar(0.64262235164642), wave * DC.ar(0.10524952411652)), modY, z, LFBrownNoise2.ar(wave * DC.ar(0.53802645206451), wave * DC.ar(0.71712005138397), wave * DC.ar(0.61533439159393), wave * DC.ar(0.94886541366577), wave * DC.ar(0.67637705802917)), Silent.ar());
varMtEGroove17460010 = TBrownRand.ar(varMtEGroove1746009 * modY, 0.32931506633759 * modX * varMtEGroove17460010, 0.11998808383942 * in * env, island, modX * varMtEGroove17460010, 0.35376755298471 * varMtEGroove17460010 * varMtEGroove17460010, Silent.ar());
varMtEGroove1746009 = PSinGrain.ar(SanityCheck.ar(wave * DC.ar(0.92237544059753)).exprange(1, SampleRate.ir), 0.6778906583786 * signal * modZ, modX * varMtEGroove17460010);
varMtEGroove17460010 = FMGrainI.ar(signal * wave, gateEnv * modY, wave * signal, gateEnv, modX * varMtEGroove1746009, bufnum, bufnum, modZ * modZ, varMtEGroove1746009, Silent.ar());

signal = varMtEGroove17460010;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// MtE.Groove1746001
/////////////////////////////////////////////////////////

SynthDef.new("MtE.Groove1746001", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varMtEGroove1746009, varMtEGroove17460010, varMtEGroove174600111, varMtEGroove174600112, varMtEGroove174600113;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varMtEGroove1746009 = varMtEGroove17460010 = varMtEGroove174600111 = varMtEGroove174600112 = varMtEGroove174600113 = K2A.ar(t_trig).dup;
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
varMtEGroove1746009 = EnvFollow.ar(0.42454290390015 * Concat.ar(wave * DC.ar(0.66018950939178), wave * DC.ar(0.82830440998077), wave * DC.ar(0.98878145217896), wave * DC.ar(0.93422341346741), wave * DC.ar(0.69746804237366), wave * DC.ar(0.34512269496918), wave * DC.ar(0.96143329143524), wave * DC.ar(0.78753042221069), wave * DC.ar(0.019590497016907), wave * DC.ar(0.84886431694031), wave * DC.ar(0.96058869361877), wave * DC.ar(0.81962907314301), wave * DC.ar(0.57349276542664), wave * DC.ar(0.36789786815643)), in, StkBlowHole.ar(wave * DC.ar(0.66454577445984), wave * DC.ar(0.44873690605164), wave * DC.ar(0.86068880558014), wave * DC.ar(0.50862741470337), wave * DC.ar(0.29385435581207), wave * DC.ar(0.79291272163391), wave * DC.ar(0.46649861335754), wave * DC.ar(0.46654558181763)), WaveLoss.ar(wave * DC.ar(0.082882761955261), wave * DC.ar(0.2476818561554), wave * DC.ar(0.049816131591797), wave * DC.ar(0.57741844654083), wave * DC.ar(0.33374726772308), wave * DC.ar(0.0075250864028931)));
varMtEGroove17460010 = FoaRotate.ar(bufnum, modZ * gateEnv, 0.99536814709194 * modX * modY, Silent.ar());
varMtEGroove1746009 = RedPhasor.ar(wave * signal, wave, y, varMtEGroove174600113 * env, varMtEGroove1746009 * modY, varMtEGroove174600111 * modY, varMtEGroove17460010 * modZ);
varMtEGroove17460010 = SoftClipper4.ar(modZ * wave);
// Variation test code
varMtEGroove174600111 = DoubleNestedAllpassC.ar(varMtEGroove17460010, varMtEGroove1746009 * varMtEGroove174600113, env, gateEnv, TBrownRand.ar(modY * modY, varMtEGroove174600111, t_trig, island, varMtEGroove17460010 * varMtEGroove174600111, 0.082250188320751 * MoogVCF.ar(varMtEGroove17460010 * DC.ar(0.50702154636383), varMtEGroove1746009 * DC.ar(0.39720833301544), varMtEGroove1746009 * DC.ar(0.29216873645782), varMtEGroove17460010 * DC.ar(0.29745876789093), varMtEGroove17460010 * DC.ar(0.45210933685303)), RandSeed.ar(varMtEGroove17460010 * DC.ar(0.076718091964722), varMtEGroove1746009 * DC.ar(0.26001310348511))), in * varMtEGroove1746009.slew(varMtEGroove1746009 * DC.ar(0.16737818717957), varMtEGroove17460010 * DC.ar(0.10784780979156)), in * varMtEGroove17460010, env, Wrap.ar(gateEnv, varMtEGroove1746009 * gateEnv.hypotApx(Pluck.ar(varMtEGroove1746009 * DC.ar(0.16214656829834), varMtEGroove17460010 * DC.ar(0.068625211715698), varMtEGroove17460010 * DC.ar(0.84828150272369), varMtEGroove17460010 * DC.ar(0.41087055206299), varMtEGroove1746009 * DC.ar(0.94453287124634), varMtEGroove1746009 * DC.ar(0.39784359931946), varMtEGroove17460010 * DC.ar(0.35629332065582), varMtEGroove1746009 * DC.ar(0.79710459709167))), signal * wave), wave * signal, 0.98710723535147 * AtsBand.ar(varMtEGroove17460010 * DC.ar(0.96068382263184), varMtEGroove1746009 * DC.ar(0.52230620384216), varMtEGroove1746009 * DC.ar(0.75275313854218), varMtEGroove17460010 * DC.ar(0.86658370494843), varMtEGroove1746009 * DC.ar(0.76465511322021)), Silent.ar());
varMtEGroove174600112 = Tilt.ar(0.78787231445312 * wave * env, wave * varMtEGroove174600111, in, varMtEGroove174600112, varMtEGroove174600113 * varMtEGroove1746009);
varMtEGroove174600113 = Resonz.ar(env * varMtEGroove174600112, varMtEGroove174600113 * modX, 0.75867664813995 * in * modX, varMtEGroove1746009, Silent.ar());
varMtEGroove174600111 = RunningSum.ar(varMtEGroove17460010 * varMtEGroove174600112, modZ * varMtEGroove174600112);
varMtEGroove174600112 = PanX.ar(2, signal, z, env * varMtEGroove174600113, gate);
varMtEGroove174600113 = SOS.ar(gate, modY, varMtEGroove1746009 * modX, 0.3798314332962 * wave * varMtEGroove174600111, varMtEGroove174600111 * varMtEGroove174600112, modY * signal, 0.99948324434656 * modZ * varMtEGroove174600113, Silent.ar());
varMtEGroove174600111 = InGrainB.ar(env * modX.linexp(varMtEGroove17460010 * DC.ar(0.49681174755096), varMtEGroove17460010 * DC.ar(0.4841947555542), varMtEGroove17460010 * DC.ar(0.016498446464539), varMtEGroove1746009 * DC.ar(0.77243673801422), varMtEGroove17460010 * DC.ar(0.66570615768433)), Gbman2DN.ar(Sieve1.ar(varMtEGroove1746009 * DC.ar(0.2529262304306), varMtEGroove1746009 * DC.ar(0.80755734443665), varMtEGroove17460010 * DC.ar(0.96088075637817), varMtEGroove1746009 * DC.ar(0.82458901405334), varMtEGroove17460010 * DC.ar(0.56817615032196)).exprange(1, SampleRate.ir), gateEnv, YigMandelbulbN.ar(varMtEGroove17460010 * DC.ar(0.42007029056549), varMtEGroove17460010 * DC.ar(0.53221118450165), varMtEGroove1746009 * DC.ar(0.20331227779388), varMtEGroove1746009 * DC.ar(0.86011826992035), varMtEGroove1746009 * DC.ar(0.15835082530975), varMtEGroove1746009 * DC.ar(0.86559855937958), varMtEGroove1746009 * DC.ar(0.4888072013855)), t_trig, varMtEGroove17460010, Silent.ar().linexp(varMtEGroove1746009 * DC.ar(0.77322626113892), varMtEGroove1746009 * DC.ar(0.19714617729187), varMtEGroove17460010 * DC.ar(0.88878583908081), varMtEGroove17460010 * DC.ar(0.099361777305603), varMtEGroove1746009 * DC.ar(0.3861323595047))), varMtEGroove174600111, bufnum, 0.0078432650844291 * SanityCheck2.ar(varMtEGroove17460010 * DC.ar(0.5924551486969)), Silent.ar());
varMtEGroove174600112 = Beep.ar(gateEnv * env, bufnum);
varMtEGroove174600113 = BBandPass.ar(modY, in * env, 0.50746023654938 * FoaNFC.ar(varMtEGroove1746009 * DC.ar(0.20166444778442), varMtEGroove1746009 * DC.ar(0.25574970245361), varMtEGroove17460010 * DC.ar(0.92418098449707), varMtEGroove17460010 * DC.ar(0.039876818656921)), 0.98440293669881 * modX, Silent.ar());

signal = varMtEGroove174600113;
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
// _330174601
/////////////////////////////////////////////////////////

SynthDef.new("_330174601", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, var_3301746019, var_33017460110;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = var_3301746019 = var_33017460110 = K2A.ar(t_trig).dup;
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
var_3301746019 = Astrocade.ar(VOsc3.ar(Array.fill(2.pow(13), { |i| rrand(-1, 1) }).as(LocalBuf), gateEnv, modX * signal, signal, 0.36710034373649 * var_3301746019 * modZ, Silent.ar()), 0.15822517871857 * signal * env, in * var_3301746019, modY * modX, amp, var_3301746019 * modY, amp, signal * gateEnv);
var_33017460110 = Decay.ar(env * modX, z, in.lincurve(wave * DC.ar(0.4251846075058), wave * DC.ar(0.55752182006836), wave * DC.ar(0.68379557132721), wave * DC.ar(0.44607925415039), wave * DC.ar(0.55643117427826), wave * DC.ar(0.88553905487061)), Silent.ar());
var_3301746019 = Rotate.ar(wave * DC.ar(0.30188536643982), wave * DC.ar(0.39970624446869), wave * DC.ar(0.70356822013855), wave * DC.ar(0.89640319347382), wave * DC.ar(0.94948649406433));
var_33017460110 = AllpassC.ar(wave * DC.ar(0.80885565280914), wave * DC.ar(0.089092135429382), wave * DC.ar(0.73725891113281), wave * DC.ar(0.16861581802368), wave * DC.ar(0.58861088752747), wave * DC.ar(0.95331716537476));

signal = var_33017460110;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// _3301746011
/////////////////////////////////////////////////////////

SynthDef.new("_3301746011", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, var_3301746019, var_33017460110, var_330174601111, var_330174601112, var_330174601113, var_330174601114, var_330174601115;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = var_3301746019 = var_33017460110 = var_330174601111 = var_330174601112 = var_330174601113 = var_330174601114 = var_330174601115 = K2A.ar(t_trig).dup;
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
var_3301746019 = XFadeRotate.ar(var_330174601112 * gateEnv.max(QuadC.ar(wave * DC.ar(0.8616281747818), wave * DC.ar(0.041447162628174), wave * DC.ar(0.0098390579223633), wave * DC.ar(0.32689547538757), wave * DC.ar(0.80415832996368), wave * DC.ar(0.71611392498016), wave * DC.ar(0.19862234592438))), bufnum.curvelin(wave * DC.ar(0.76088082790375), wave * DC.ar(0.42635607719421), wave * DC.ar(0.66731929779053), wave * DC.ar(0.67352867126465), wave * DC.ar(0.4981369972229), wave * DC.ar(0.15062499046326)));
var_33017460110 = OSTrunc8.ar(z, XLine.ar(var_330174601113, Convolution3.ar(wave * DC.ar(0.37217283248901), wave * DC.ar(0.6530350446701), wave * DC.ar(0.69963729381561), wave * DC.ar(0.30548334121704), wave * DC.ar(0.56216263771057), wave * DC.ar(0.5561695098877)), modX * modX, modY, Silent.ar(), gateEnv));
var_3301746019 = QuadL.ar(wave * DC.ar(0.97247290611267), wave * DC.ar(0.22081613540649), wave * DC.ar(0.45031297206879), wave * DC.ar(0.71530592441559), wave * DC.ar(0.5465681552887), wave * DC.ar(0.21622335910797), wave * DC.ar(0.48754990100861));
var_33017460110 = StandardN.ar(modZ * modY, var_330174601112 * var_330174601113, x, modY * gateEnv, CombL.ar(wave * DC.ar(0.77586877346039), wave * DC.ar(0.40458178520203), wave * DC.ar(0.84747624397278), wave * DC.ar(0.071991205215454), wave * DC.ar(0.22029340267181), wave * DC.ar(0.21456480026245)), Silent.ar());
// Variation test code
var_330174601111 = RunningSum.ar(signal * var_33017460110.ring3(WrapSummer.ar(var_33017460110 * DC.ar(0.2321103811264), var_3301746019 * DC.ar(0.13831281661987), var_3301746019 * DC.ar(0.19791054725647), var_33017460110 * DC.ar(0.14417684078217), var_33017460110 * DC.ar(0.31622111797333), var_3301746019 * DC.ar(0.9755482673645))), var_330174601112 * in);
var_330174601112 = Saw.ar(var_330174601112 * var_330174601113, TermanWang.ar(var_33017460110 * DC.ar(0.14765477180481), var_33017460110 * DC.ar(0.062669277191162), var_3301746019 * DC.ar(0.55114507675171), var_3301746019 * DC.ar(0.76234233379364), var_33017460110 * DC.ar(0.93615126609802), var_33017460110 * DC.ar(0.12584817409515), var_33017460110 * DC.ar(0.99217867851257), var_33017460110 * DC.ar(0.6405166387558), var_33017460110 * DC.ar(0.10201120376587), var_3301746019 * DC.ar(0.43965840339661), var_33017460110 * DC.ar(0.012471675872803)), Silent.ar());
var_330174601113 = MeanTriggered.ar(gateEnv, var_330174601114 * var_330174601111, wave * in, Index.ar(var_3301746019 * DC.ar(0.52196955680847), var_33017460110 * DC.ar(0.96600019931793), var_3301746019 * DC.ar(0.50162076950073), var_33017460110 * DC.ar(0.6258898973465)), Silent.ar());
var_330174601114 = PulseCount.ar(var_33017460110 * var_330174601115, var_330174601113);
var_330174601115 = VOsc3.ar(Array.fill(2.pow(10), { |i| rrand(-1, 1) }).as(LocalBuf), var_3301746019 * signal, QuadL.ar(var_3301746019 * DC.ar(0.98799431324005), var_3301746019 * DC.ar(0.40912508964539), var_33017460110 * DC.ar(0.80851864814758), var_33017460110 * DC.ar(0.82119059562683), var_33017460110 * DC.ar(0.59019136428833), var_33017460110 * DC.ar(0.77611243724823), var_3301746019 * DC.ar(0.30028748512268)).exprange(1, SampleRate.ir), var_330174601111, wave, Silent.ar());
var_330174601111 = Lorenz2DN.ar(var_330174601114 * var_330174601115, env, modX, 0.95062351226807 * gateEnv * var_330174601113, signal, wave * wave, 0.602175116539 * in * var_330174601113, modY * var_3301746019, var_330174601112, 0.99979409490034 * var_330174601112 * var_330174601115, Silent.ar());
var_330174601112 = InGrainI.ar(var_33017460110, island, var_33017460110, bufnum, bufnum, var_330174601112 * in, Impulse.ar(var_3301746019 * DC.ar(0.67891526222229), var_3301746019 * DC.ar(0.58519446849823), var_33017460110 * DC.ar(0.42554903030396), var_3301746019 * DC.ar(0.47900116443634)), Silent.ar());
var_330174601113 = NLFiltC.ar(var_330174601114 * in, bufnum, z, var_330174601111 * var_330174601115, 0.49855649471283 * var_33017460110, var_330174601113 * var_33017460110, 0.99845312858969 * modX * var_330174601113, Silent.ar());
var_330174601114 = Out.ar((80 + (island * 2)), [WaveletDaub.ar(var_33017460110 * DC.ar(0.76052820682526), var_33017460110 * DC.ar(0.6235671043396), var_33017460110 * DC.ar(0.54339826107025), var_3301746019 * DC.ar(0.33867704868317), var_33017460110 * DC.ar(0.22230100631714)), AtsPartial.ar(var_3301746019 * DC.ar(0.99898517131805), var_33017460110 * DC.ar(0.71992647647858), var_33017460110 * DC.ar(0.3920990228653), var_33017460110 * DC.ar(0.52037394046783), var_33017460110 * DC.ar(0.61417078971863), var_3301746019 * DC.ar(0.7173285484314), var_33017460110 * DC.ar(0.26555371284485))]);
var_330174601115 = LFPulse.ar(env, var_330174601111, var_330174601113 * signal.lag2(var_33017460110 * DC.ar(0.46119487285614), var_33017460110 * DC.ar(0.9654688835144)), var_3301746019, Silent.ar());
var_330174601111 = XLine.ar(bufnum, var_330174601113 * in, var_330174601112 * gateEnv, 0.99964061054302 * NLFiltC.ar(var_33017460110 * DC.ar(0.91123354434967), var_33017460110 * DC.ar(0.10029077529907), var_3301746019 * DC.ar(0.90685558319092), var_3301746019 * DC.ar(0.35559165477753), var_3301746019 * DC.ar(0.80559861660004), var_33017460110 * DC.ar(0.61506366729736), var_33017460110 * DC.ar(0.40933310985565), var_3301746019 * DC.ar(0.4892646074295)), Silent.ar(), signal * in);
var_330174601112 = QuadN.ar(in * var_330174601111, var_330174601111, var_330174601114, var_330174601112, gateEnv * modX, 0.99998178727006 * gateEnv * in, Silent.ar());
var_330174601113 = LinCongL.ar(modY * var_33017460110, in, modY, var_330174601113, modX * var_33017460110, LastValue.ar(var_33017460110 * DC.ar(0.300368309021), var_3301746019 * DC.ar(0.72930061817169)), FoaZoomY.ar(var_33017460110 * DC.ar(0.6048698425293), var_33017460110 * DC.ar(0.99329006671906), var_3301746019 * DC.ar(0.75100839138031), var_33017460110 * DC.ar(0.89410269260406)));
var_330174601114 = PeakFollower.ar(var_3301746019 * wave, modY);
var_330174601115 = DelTapRd.ar(Array.fill(2.pow(13), { |i| rrand(-1, 1) }).as(LocalBuf), island, PVInfo.ar(Array.fill(2.pow(10), { |i| rrand(-1, 1) }).as(LocalBuf), var_330174601114 * wave, YigMandelbulbN.ar(var_33017460110 * DC.ar(0.73715531826019), var_33017460110 * DC.ar(0.39937007427216), var_33017460110 * DC.ar(0.56998455524445), var_3301746019 * DC.ar(0.38752973079681), var_33017460110 * DC.ar(0.31983661651611), var_33017460110 * DC.ar(0.39925360679626), var_33017460110 * DC.ar(0.47793090343475)), 0.99960583300211 * signal * modY, Silent.ar()), var_330174601113 * var_330174601113, LPZ2.ar(var_3301746019 * DC.ar(0.030928373336792), var_33017460110 * DC.ar(0.79924392700195), var_33017460110 * DC.ar(0.19679510593414)), Silent.ar());

signal = var_330174601115;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// PIF.Lys1746011
/////////////////////////////////////////////////////////

SynthDef.new("PIF.Lys1746011", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varPIFLys1746019, varPIFLys17460110, varPIFLys174601111, varPIFLys174601112;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varPIFLys1746019 = varPIFLys17460110 = varPIFLys174601111 = varPIFLys174601112 = K2A.ar(t_trig).dup;
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
varPIFLys1746019 = PeakEQ4.ar(env * env, BRF.ar(wave * DC.ar(0.29462146759033), wave * DC.ar(0.18617522716522), wave * DC.ar(0.30274045467377), wave * DC.ar(0.13147509098053), wave * DC.ar(0.062841415405273)).exprange(1, SampleRate.ir), island, modY * env);
varPIFLys17460110 = DiskOut.ar(Array.fill(2.pow(13), { |i| rrand(-1, 1) }).as(LocalBuf), [RunningMin.ar(wave * DC.ar(0.93018567562103), wave * DC.ar(0.9469301700592)), FoaPsychoShelf.ar(wave * DC.ar(0.22460043430328), wave * DC.ar(0.11472463607788), wave * DC.ar(0.11558616161346), wave * DC.ar(0.50416827201843), wave * DC.ar(0.13507771492004), wave * DC.ar(0.76416265964508))]);
varPIFLys1746019 = RedNoise.ar(0.33714163303375 * gateEnv * modY, 0.99075224157328 * in * modZ, Silent.ar());
varPIFLys17460110 = BPeakEQ.ar(bufnum, varPIFLys1746019 * modY, varPIFLys17460110 * varPIFLys174601112, env, 0.99966857339825 * gateEnv * varPIFLys17460110, CombN.ar(wave * DC.ar(0.56106603145599), wave * DC.ar(0.58134746551514), wave * DC.ar(0.34086668491364), wave * DC.ar(0.71929800510406), wave * DC.ar(0.2458301782608), wave * DC.ar(0.83422684669495)));
// Variation test code
varPIFLys174601111 = SineShaper.ar(x, x, Peak.ar(varPIFLys17460110 * DC.ar(0.77903890609741), varPIFLys17460110 * DC.ar(0.75002706050873)), Silent.ar());
varPIFLys174601112 = MedianTriggered.ar(x, ScopeOut2.ar(varPIFLys17460110 * DC.ar(0.15382325649261), varPIFLys1746019 * DC.ar(0.19194996356964), varPIFLys17460110 * DC.ar(0.59733808040619), varPIFLys17460110 * DC.ar(0.024543285369873)), signal * modZ, ArrayMin.ar(varPIFLys1746019 * DC.ar(0.73081183433533)), Silent.ar().lag2(varPIFLys17460110 * DC.ar(0.30054485797882), varPIFLys17460110 * DC.ar(0.2689151763916)));
varPIFLys174601111 = BufGrainB.ar(varPIFLys1746019 * modZ, wave, bufnum, in, FreqShift.ar(z, modZ, in * varPIFLys17460110, varPIFLys1746019.minNyquist(), Silent.ar()), bufnum, gateEnv * varPIFLys174601111.curvelin(varPIFLys17460110 * DC.ar(0.75510561466217), varPIFLys1746019 * DC.ar(0.42160844802856), varPIFLys17460110 * DC.ar(0.61136412620544), varPIFLys17460110 * DC.ar(0.7450248003006), varPIFLys1746019 * DC.ar(0.80158030986786), varPIFLys17460110 * DC.ar(0.15534722805023)), LinXFade2.ar(varPIFLys1746019 * DC.ar(0.70264375209808), varPIFLys17460110 * DC.ar(0.98214769363403), varPIFLys1746019 * DC.ar(0.64201986789703), varPIFLys1746019 * DC.ar(0.93401253223419)), Silent.ar());
varPIFLys174601112 = BufAllpassN.ar(Array.fill(2.pow(12), { |i| rrand(-1, 1) }).as(LocalBuf), env, FBSineC.ar(modZ, x, gateEnv, island, modY, RunningMax.ar(varPIFLys1746019 * DC.ar(0.96317231655121), varPIFLys1746019 * DC.ar(0.95348346233368)), modX * wave, Decimator.ar(varPIFLys17460110 * DC.ar(0.86036252975464), varPIFLys1746019 * DC.ar(0.82208561897278), varPIFLys1746019 * DC.ar(0.65605449676514), varPIFLys17460110 * DC.ar(0.25556921958923), varPIFLys1746019 * DC.ar(0.74726116657257)).excess(MidEQ.ar(varPIFLys1746019 * DC.ar(0.26660251617432), varPIFLys17460110 * DC.ar(0.47669947147369), varPIFLys1746019 * DC.ar(0.5219761133194), varPIFLys1746019 * DC.ar(0.6235591173172), varPIFLys17460110 * DC.ar(0.43966519832611), varPIFLys17460110 * DC.ar(0.2776198387146))), Silent.ar()), 0.86524248123169 * FoaFocusX.ar(varPIFLys17460110 * DC.ar(0.84571015834808), varPIFLys17460110 * DC.ar(0.70581102371216), varPIFLys17460110 * DC.ar(0.54121232032776), varPIFLys1746019 * DC.ar(0.24776744842529)), 0.9997859152097 * signal * modY, Silent.ar());
varPIFLys174601111 = HyperTerrain.ar(Array.fill(2.pow(12), { |i| rrand(-1, 1) }).as(LocalBuf), modX, bufnum, varPIFLys1746019 * modZ, Gendy2.ar(varPIFLys1746019 * DC.ar(0.78181266784668), varPIFLys1746019 * DC.ar(0.011929750442505), varPIFLys17460110 * DC.ar(0.82933878898621), varPIFLys17460110 * DC.ar(0.185879945755), varPIFLys17460110 * DC.ar(0.18897151947021), varPIFLys1746019 * DC.ar(0.9278666973114), varPIFLys17460110 * DC.ar(0.66581499576569), varPIFLys17460110 * DC.ar(0.40329241752625), varPIFLys17460110 * DC.ar(0.83409368991852), varPIFLys17460110 * DC.ar(0.23749577999115), varPIFLys1746019 * DC.ar(0.68676126003265), varPIFLys1746019 * DC.ar(0.92345809936523), varPIFLys1746019 * DC.ar(0.49549460411072), varPIFLys1746019 * DC.ar(0.86727142333984)), Silent.ar());
varPIFLys174601112 = LinCongL.ar(TTendency.ar(varPIFLys17460110 * DC.ar(0.97790217399597), varPIFLys17460110 * DC.ar(0.69240128993988), varPIFLys17460110 * DC.ar(0.48806190490723), varPIFLys17460110 * DC.ar(0.79973316192627), varPIFLys17460110 * DC.ar(0.83360373973846), varPIFLys1746019 * DC.ar(0.76502478122711)).exprange(1, SampleRate.ir), wave * gateEnv.minNyquist(), modZ * gateEnv, x, signal * varPIFLys1746019, 0.99997414941284 * wave, Silent.ar());

signal = varPIFLys174601112;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// VBS.LoveLetter.AD174601
/////////////////////////////////////////////////////////

SynthDef.new("VBS.LoveLetter.AD174601", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varVBSLoveLetterAD1746019, varVBSLoveLetterAD17460110, varVBSLoveLetterAD17460111, varVBSLoveLetterAD17460112;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varVBSLoveLetterAD1746019 = varVBSLoveLetterAD17460110 = varVBSLoveLetterAD17460111 = varVBSLoveLetterAD17460112 = K2A.ar(t_trig).dup;
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
varVBSLoveLetterAD1746019 = SoftClipAmp8.ar(0.45228135585785 * gateEnv * varVBSLoveLetterAD17460111, varVBSLoveLetterAD17460110 * modZ, 0.061067443240589 * modX, Silent.ar());
varVBSLoveLetterAD17460110 = FMGrainBF.ar(varVBSLoveLetterAD1746019, varVBSLoveLetterAD17460110 * env, SoftClipper8.ar(wave * DC.ar(0.34059000015259)).exprange(1, SampleRate.ir), PanB.ar(wave * DC.ar(0.91669905185699), wave * DC.ar(0.25862371921539), wave * DC.ar(0.20091772079468), wave * DC.ar(0.349813580513)).exprange(1, SampleRate.ir), varVBSLoveLetterAD17460110 * modX, modY, island, in, modY * modZ, 0.99996098561943 * signal, Silent.ar());
varVBSLoveLetterAD17460111 = Formant.ar(varVBSLoveLetterAD17460110 * varVBSLoveLetterAD17460111, modZ * modX, modY * wave, 0.99567982418083 * signal, Silent.ar());
varVBSLoveLetterAD17460112 = Perlin3.ar(z, varVBSLoveLetterAD17460112, env);
varVBSLoveLetterAD1746019 = NeedleRect.ar(wave * DC.ar(0.54687893390656), wave * DC.ar(0.27879214286804), wave * DC.ar(0.40025210380554), wave * DC.ar(0.40346240997314), wave * DC.ar(0.18592536449432), wave * DC.ar(0.87539267539978), wave * DC.ar(0.98008489608765));
varVBSLoveLetterAD17460110 = FMHDecode1.ar(modY * modX, island, signal, modX * in, modX, EnvGen.ar(DoubleWell3.ar(wave * DC.ar(0.71967816352844), wave * DC.ar(0.18152821063995), wave * DC.ar(0.84799540042877), wave * DC.ar(0.75841319561005), wave * DC.ar(0.70619654655457), wave * DC.ar(0.19840967655182), wave * DC.ar(0.46421897411346), wave * DC.ar(0.62139022350311)), varVBSLoveLetterAD17460110 * modY, t_trig, amp, varVBSLoveLetterAD17460110, gate), gateEnv * modY, RedDPCMencode.ar(signal * gateEnv, y), varVBSLoveLetterAD17460111 * modY, bufnum, signal * signal, modZ, Silent.ar());
varVBSLoveLetterAD17460111 = YigCliffordC.ar(wave * DC.ar(0.8355758190155), wave * DC.ar(0.79052460193634), wave * DC.ar(0.82913553714752), wave * DC.ar(0.72173285484314), wave * DC.ar(0.5896452665329), wave * DC.ar(0.80551695823669), wave * DC.ar(0.73289704322815), wave * DC.ar(0.005304217338562), wave * DC.ar(0.79286527633667));
varVBSLoveLetterAD17460112 = DetectSilence.ar(0.94073867797852 * in * modY, wave * varVBSLoveLetterAD1746019, 0.88009786605835 * varVBSLoveLetterAD17460110 * modZ, varVBSLoveLetterAD17460111);

signal = varVBSLoveLetterAD17460112;
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
// Eater.21251746041
/////////////////////////////////////////////////////////

SynthDef.new("Eater.21251746041", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varEater21251746049, varEater212517460410, varEater212517460411, varEater212517460412, varEater212517460413, varEater212517460414, varEater212517460415, varEater2125174604116, varEater2125174604117, varEater2125174604118;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varEater21251746049 = varEater212517460410 = varEater212517460411 = varEater212517460412 = varEater212517460413 = varEater212517460414 = varEater212517460415 = varEater2125174604116 = varEater2125174604117 = varEater2125174604118 = K2A.ar(t_trig).dup;
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
varEater21251746049 = ReplaceOut.ar((80 + (island * 2)), [RosslerResL.ar(wave * DC.ar(0.074781894683838), wave * DC.ar(0.48820674419403), wave * DC.ar(0.56901776790619), wave * DC.ar(0.92665338516235), wave * DC.ar(0.85126781463623), wave * DC.ar(0.93257343769073), wave * DC.ar(0.99684345722198), wave * DC.ar(0.11404347419739), wave * DC.ar(0.44472754001617), wave * DC.ar(0.83189678192139), wave * DC.ar(0.6804107427597), wave * DC.ar(0.47241818904877)), FoaTumble.ar(wave * DC.ar(0.28661608695984), wave * DC.ar(0.95521235466003), wave * DC.ar(0.70533788204193), wave * DC.ar(0.25923919677734))]);
varEater212517460410 = LFPar.ar(in * gateEnv, varEater212517460415, 0.98461207985138 * varEater212517460414 * varEater212517460410, Silent.ar());
varEater212517460411 = Median.ar(amp, varEater212517460415, FoaDirectZ.ar(wave * DC.ar(0.62081396579742), wave * DC.ar(0.20733594894409), wave * DC.ar(0.34028244018555), wave * DC.ar(0.17062520980835)), Silent.ar());
varEater212517460412 = MedianTriggered.ar(bufnum, varEater2125174604118 * varEater2125174604116, modY, 0.84131906421636 * gateEnv * varEater212517460410, Silent.ar());
varEater212517460413 = BHiShelf.ar(y, varEater2125174604118 * in, t_trig, env * varEater2125174604116, varEater212517460415, DetectSilence.ar(wave * DC.ar(0.90765404701233), wave * DC.ar(0.79844224452972), wave * DC.ar(0.29810643196106), wave * DC.ar(0.57689237594604)));
varEater212517460414 = OffsetOut.ar((80 + (island * 2)), [AllpassL.ar(wave * DC.ar(0.76524043083191), wave * DC.ar(0.051940202713013), wave * DC.ar(0.96963226795197), wave * DC.ar(0.95192408561707), wave * DC.ar(0.45767426490784), wave * DC.ar(0.1702972650528)), Latoocarfian2DL.ar(wave * DC.ar(0.78427803516388), wave * DC.ar(0.76906454563141), wave * DC.ar(0.2679762840271), wave * DC.ar(0.87095439434052), wave * DC.ar(0.92628574371338), wave * DC.ar(0.39157629013062), wave * DC.ar(0.88943719863892), wave * DC.ar(0.19776058197021), wave * DC.ar(0.094573140144348), wave * DC.ar(0.15986955165863))]);
varEater212517460415 = Oregonator.ar(varEater212517460413 * varEater212517460415, 0.78007888793945 * LatoocarfianTrig.ar(wave * DC.ar(0.30245912075043), wave * DC.ar(0.12522113323212), wave * DC.ar(0.064588308334351), wave * DC.ar(0.15010058879852), wave * DC.ar(0.11855018138885), wave * DC.ar(0.93701994419098), wave * DC.ar(0.38172388076782), wave * DC.ar(0.14792263507843), wave * DC.ar(0.067570209503174), wave * DC.ar(0.23855304718018)), gate, modX, 0.79918611049652 * varEater212517460410 * varEater2125174604117, modX * wave, varEater212517460412 * signal, z, varEater212517460412.wrap(wave * DC.ar(0.32764947414398), wave * DC.ar(0.94420611858368)), Silent.ar());
varEater21251746049 = Gendy3.ar(wave * DC.ar(0.52018439769745), wave * DC.ar(0.33336389064789), wave * DC.ar(0.61584281921387), wave * DC.ar(0.20513594150543), wave * DC.ar(0.51835453510284), wave * DC.ar(0.3969669342041), wave * DC.ar(0.76931488513947), wave * DC.ar(0.42576634883881), wave * DC.ar(0.4096759557724), wave * DC.ar(0.90751838684082), wave * DC.ar(0.9122941493988));
varEater212517460410 = PulseCount.ar(wave * varEater2125174604117, varEater212517460413);
varEater212517460411 = StkBandedWG.ar(wave * DC.ar(0.48903095722198), wave * DC.ar(0.47087800502777), wave * DC.ar(0.72992742061615), wave * DC.ar(0.56163144111633), wave * DC.ar(0.60362875461578), wave * DC.ar(0.99964916706085), wave * DC.ar(0.011841058731079), wave * DC.ar(0.1340663433075), wave * DC.ar(0.58661639690399), wave * DC.ar(0.95311367511749), wave * DC.ar(0.51497113704681));
varEater212517460412 = Limiter.ar(wave * DC.ar(0.87467586994171), wave * DC.ar(0.18405151367188), wave * DC.ar(0.92563569545746));
varEater212517460413 = Osc.ar(wave * DC.ar(0.33441841602325), wave * DC.ar(0.47884058952332), wave * DC.ar(0.88874411582947), wave * DC.ar(0.98544991016388), wave * DC.ar(0.9397908449173));
varEater212517460414 = AY8910.ar(wave * DC.ar(0.65309536457062), wave * DC.ar(0.27806198596954), wave * DC.ar(0.60120964050293), wave * DC.ar(0.085387468338013), wave * DC.ar(0.98963439464569), wave * DC.ar(0.65773344039917), wave * DC.ar(0.87933015823364), wave * DC.ar(0.65289521217346), wave * DC.ar(0.18079173564911), wave * DC.ar(0.02106761932373), wave * DC.ar(0.92757213115692), wave * DC.ar(0.454869389534), wave * DC.ar(0.6973477602005), wave * DC.ar(0.37833213806152), wave * DC.ar(0.79741454124451));
varEater212517460415 = Delay2.ar(0.38537085056305 * in * gateEnv, 0.94921019905361 * varEater212517460411 * modZ, Silent.ar().min(StkClarinet.ar(wave * DC.ar(0.20719110965729), wave * DC.ar(0.33439612388611), wave * DC.ar(0.91112041473389), wave * DC.ar(0.3608158826828), wave * DC.ar(0.87432754039764), wave * DC.ar(0.93291068077087), wave * DC.ar(0.58564269542694), wave * DC.ar(0.22841417789459), wave * DC.ar(0.79164147377014))));
// Variation test code
varEater2125174604116 = TwoZero.ar(modY * varEater2125174604116, StkBlowHole.ar(varEater212517460413 * DC.ar(0.15436828136444), varEater21251746049 * DC.ar(0.67660295963287), varEater212517460414 * DC.ar(0.71027183532715), varEater212517460413 * DC.ar(0.51109886169434), varEater212517460415 * DC.ar(0.70848047733307), varEater21251746049 * DC.ar(0.37944436073303), varEater212517460414 * DC.ar(0.40923535823822), varEater212517460414 * DC.ar(0.82437467575073)).exprange(1, SampleRate.ir), StkBeeThree.ar(modY, bufnum, z, signal, island, varEater212517460410, varEater212517460411 * in, 0.99984606024346 * varEater212517460415 * varEater2125174604116, Silent.ar()), varEater2125174604117, Silent.ar());
varEater2125174604117 = Convolution2.ar(varEater212517460414, varEater212517460415, DoubleNestedAllpassC.ar(varEater212517460412 * DC.ar(0.73160171508789), varEater212517460413 * DC.ar(0.65566408634186), varEater212517460410 * DC.ar(0.66573107242584), varEater212517460415 * DC.ar(0.40498328208923), varEater212517460410 * DC.ar(0.51075649261475), varEater21251746049 * DC.ar(0.80662381649017), varEater212517460410 * DC.ar(0.12546253204346), varEater21251746049 * DC.ar(0.99324154853821), varEater21251746049 * DC.ar(0.69157612323761), varEater212517460412 * DC.ar(0.15215229988098), varEater212517460413 * DC.ar(0.89870715141296), varEater21251746049 * DC.ar(0.084876656532288)), gateEnv, Amplitude.ar(varEater212517460412 * DC.ar(0.52951526641846), varEater212517460413 * DC.ar(0.48063683509827), varEater212517460414 * DC.ar(0.28869211673737), varEater212517460414 * DC.ar(0.96942889690399), varEater212517460411 * DC.ar(0.70694196224213)), Silent.ar());
varEater2125174604118 = DoubleNestedAllpassC.ar(amp, modY, varEater212517460410 * signal, modZ, 0.37786114215851 * signal * varEater212517460411, modY * signal, gate, island, env * gateEnv, signal * varEater21251746049, 0.98746279802346 * varEater2125174604116 * signal, Silent.ar());
varEater2125174604116 = YigCliffordN.ar(varEater212517460410, y, modY, 0.15105283260345 * wave * varEater2125174604117, 0.26286661624908 * modX * modY, in, varEater2125174604118 * varEater212517460410, 0.99995620434709 * signal * modY, Silent.ar());
varEater2125174604117 = TIRand.ar(varEater21251746049, varEater2125174604117, varEater212517460415 * varEater212517460413);
varEater2125174604118 = RedLbyl.ar(gate.lagud(varEater212517460410 * DC.ar(0.50167083740234), varEater21251746049 * DC.ar(0.39204096794128)), 0.72916197776794 * varEater212517460414 * varEater2125174604118, modX);
varEater2125174604116 = DoubleWell3.ar(varEater212517460413 * varEater212517460414, env, x, gateEnv * in, 0.36083555221558 * varEater212517460414 * in, in * varEater212517460415, signal, Silent.ar());
varEater2125174604117 = LPCVals.ar(Array.fill(2.pow(11), { |i| rrand(-1, 1) }).as(LocalBuf), varEater212517460411 * gateEnv);
varEater2125174604118 = DelayN.ar(amp, varEater212517460414 * varEater2125174604117, gate, varEater212517460410, Silent.ar());

signal = varEater2125174604118;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// CeCe174605
/////////////////////////////////////////////////////////

SynthDef.new("CeCe174605", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varCeCe1746059, varCeCe17460510, varCeCe17460511, varCeCe17460512, varCeCe17460513, varCeCe17460514, varCeCe17460515;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varCeCe1746059 = varCeCe17460510 = varCeCe17460511 = varCeCe17460512 = varCeCe17460513 = varCeCe17460514 = varCeCe17460515 = K2A.ar(t_trig).dup;
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
varCeCe1746059 = BufGrainBBF.ar(varCeCe17460514 * in, signal, bufnum, varCeCe17460515 * modX, varCeCe17460513 * varCeCe17460510, bufnum, modY * signal, x, t_trig, varCeCe17460510, 0.67670488357544 * Lag2UD.ar(wave * DC.ar(0.34514224529266), wave * DC.ar(0.54426538944244), wave * DC.ar(0.49554038047791), wave * DC.ar(0.8097528219223), wave * DC.ar(0.053831815719604)), 0.99683075175332 * varCeCe17460513 * varCeCe17460511, Silent.ar());
varCeCe17460510 = DFM1.ar(varCeCe17460514, varCeCe17460511, varCeCe17460514, varCeCe17460513 * modX, modX * signal, gate, 0.97139348059247 * varCeCe17460515 * wave, SinTone.ar(wave * DC.ar(0.2404453754425), wave * DC.ar(0.75574815273285), wave * DC.ar(0.95371878147125), wave * DC.ar(0.0036625862121582)));
varCeCe17460511 = DelayL.ar(varCeCe1746059, x, varCeCe17460515 * varCeCe17460511, 0.9759920569324 * env * varCeCe17460515, Silent.ar());
varCeCe17460512 = FoaNFC.ar(modY, varCeCe17460511 * varCeCe17460515, 0.99990987753181 * WrapSummer.ar(wave * DC.ar(0.243781208992), wave * DC.ar(0.63289701938629), wave * DC.ar(0.0027608871459961), wave * DC.ar(0.71557784080505), wave * DC.ar(0.33614325523376), wave * DC.ar(0.94232535362244)), Silent.ar());
varCeCe17460513 = DoubleWell3.ar(varCeCe17460515, VDiskIn.ar(2, Array.fill(2.pow(10), { |i| rrand(-1, 1) }).as(LocalBuf), varCeCe17460510 * varCeCe17460511, 0.0021207332611084 * RedDPCMencode.ar(wave * DC.ar(0.85260939598083), wave * DC.ar(0.39029633998871)), modY * varCeCe1746059), varCeCe17460511 * modX, modZ * signal, OSWrap4.ar(0.8543666601181 * varCeCe17460514, varCeCe17460510 * varCeCe17460511, RedDPCMencode.ar(wave * DC.ar(0.60383450984955), wave * DC.ar(0.95066010951996))), varCeCe17460512, varCeCe17460515, Silent.ar());
varCeCe17460514 = Wrap.ar(varCeCe17460514, varCeCe17460515, signal);
varCeCe17460515 = NestedAllpassN.ar(0.22578179836273 * gateEnv * wave, varCeCe17460511, gateEnv * modZ, 0.19118881225586 * signal * signal, varCeCe17460514, varCeCe17460514, env * in, 0.60597514327368 * env * varCeCe17460515, Silent.ar());
varCeCe1746059 = GbmanL.ar(varCeCe17460510 * wave, varCeCe17460510, modY * env, FoaDirectO.ar(wave * DC.ar(0.27696812152863), wave * DC.ar(0.84693312644958), wave * DC.ar(0.060488820075989), wave * DC.ar(0.18215024471283)), Silent.ar());
varCeCe17460510 = LFNoise1.ar(Allpass2.ar(wave * DC.ar(0.74433982372284), wave * DC.ar(0.36788892745972), wave * DC.ar(0.76528453826904), wave * DC.ar(0.21832311153412), wave * DC.ar(0.60606729984283)).exprange(1, SampleRate.ir), 0.99888939202214 * varCeCe17460514 * varCeCe17460511, Silent.ar());
varCeCe17460511 = Gendy3.ar(gateEnv * env, FoaAsymmetry.ar(wave * DC.ar(0.70744657516479), wave * DC.ar(0.95081734657288), wave * DC.ar(0.79883420467377), wave * DC.ar(0.40556347370148)), GaussTrig.ar(wave * DC.ar(0.30517935752869), wave * DC.ar(0.36596977710724), wave * DC.ar(0.38282179832458), wave * DC.ar(0.85167860984802)), x, varCeCe17460513, Sieve1.ar(wave * DC.ar(0.81668436527252), wave * DC.ar(0.74563086032867), wave * DC.ar(0.67980253696442), wave * DC.ar(0.74993288516998), wave * DC.ar(0.52503645420074)), varCeCe17460510 * env, varCeCe17460510 * in, bufnum, LeakDC.ar(wave * DC.ar(0.64985346794128), wave * DC.ar(0.10350668430328), wave * DC.ar(0.032645344734192), wave * DC.ar(0.59994113445282)), Silent.ar());
varCeCe17460512 = Metro.ar(env * varCeCe17460513, bufnum, 0.9999540794305 * BufCombL.ar(wave * DC.ar(0.60378396511078), wave * DC.ar(0.75409114360809), wave * DC.ar(0.80231559276581), wave * DC.ar(0.55541014671326), wave * DC.ar(0.36595869064331), wave * DC.ar(0.76311910152435)), Silent.ar().lag(wave * DC.ar(0.69703984260559), wave * DC.ar(0.60390543937683)));
varCeCe17460513 = SmoothDecimator.ar(wave * DC.ar(0.10075688362122), wave * DC.ar(0.4328533411026), wave * DC.ar(0.079618453979492), wave * DC.ar(0.51770186424255), wave * DC.ar(0.023540854454041));
varCeCe17460514 = StkShakers.ar(wave * DC.ar(0.1581779718399), wave * DC.ar(0.23674690723419), wave * DC.ar(0.60939824581146), wave * DC.ar(0.36156415939331), wave * DC.ar(0.45703446865082), wave * DC.ar(0.88954794406891), wave * DC.ar(0.92062735557556));
varCeCe17460515 = BufCombC.ar(wave * DC.ar(0.13854503631592), wave * DC.ar(0.58577716350555), wave * DC.ar(0.81456184387207), wave * DC.ar(0.70248699188232), wave * DC.ar(0.82531499862671), wave * DC.ar(0.43130087852478));

signal = varCeCe17460515;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// CeCe1746051
/////////////////////////////////////////////////////////

SynthDef.new("CeCe1746051", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varCeCe1746059, varCeCe17460510, varCeCe17460511, varCeCe17460512, varCeCe17460513, varCeCe17460514, varCeCe17460515, varCeCe174605116, varCeCe174605117, varCeCe174605118;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varCeCe1746059 = varCeCe17460510 = varCeCe17460511 = varCeCe17460512 = varCeCe17460513 = varCeCe17460514 = varCeCe17460515 = varCeCe174605116 = varCeCe174605117 = varCeCe174605118 = K2A.ar(t_trig).dup;
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
varCeCe1746059 = Lag2UD.ar(wave * env, varCeCe1746059 * varCeCe17460511, varCeCe17460513, 0.99995485092516 * wave * varCeCe17460510, InGrainIBF.ar(wave * DC.ar(0.7010794878006), wave * DC.ar(0.16677343845367), wave * DC.ar(0.044628500938416), wave * DC.ar(0.26594352722168), wave * DC.ar(0.75845563411713), wave * DC.ar(0.2251296043396), wave * DC.ar(0.033586859703064), wave * DC.ar(0.56443452835083), wave * DC.ar(0.4267657995224), wave * DC.ar(0.71344113349915), wave * DC.ar(0.69645929336548), wave * DC.ar(0.07554292678833)).clip(wave * DC.ar(0.15933847427368), wave * DC.ar(0.88265085220337)));
varCeCe17460510 = RedPhasor2.ar(Standard2DL.ar(wave * DC.ar(0.7269594669342), wave * DC.ar(0.069125175476074), wave * DC.ar(0.32853507995605), wave * DC.ar(0.53796136379242), wave * DC.ar(0.52424585819244), wave * DC.ar(0.85055541992188), wave * DC.ar(0.06747829914093)), gate, island, wave * modY, in * varCeCe17460510, varCeCe1746059, y);
varCeCe17460511 = MoogLadder.ar(in, SetResetFF.ar(wave * DC.ar(0.57398676872253), wave * DC.ar(0.96132814884186)).exprange(1, SampleRate.ir), 0.061793684959412 * in * varCeCe174605116, 0.99998505901243 * env * varCeCe17460514, APF.ar(wave * DC.ar(0.21167826652527), wave * DC.ar(0.57843136787415), wave * DC.ar(0.30235719680786), wave * DC.ar(0.99169027805328), wave * DC.ar(0.87454557418823)));
varCeCe17460512 = ClipNoise.ar(0.99904894936403 * varCeCe1746059 * gateEnv, Silent.ar());
varCeCe17460513 = DelTapWr.ar(Array.fill(2.pow(14), { |i| rrand(-1, 1) }).as(LocalBuf), island);
varCeCe17460514 = PeakFollower.ar(BLowPass.ar(modZ, varCeCe174605117 * gateEnv, varCeCe174605118 * env, 0.9999726668875 * varCeCe17460511 * varCeCe17460514, Silent.ar()), varCeCe174605117 * varCeCe174605117);
varCeCe17460515 = MantissaMask.ar(modX, env * varCeCe17460515, Beep.ar(wave * DC.ar(0.8146094083786), wave * DC.ar(0.39176344871521)), Silent.ar());
varCeCe1746059 = MantissaMask.ar(wave * DC.ar(0.33840000629425), wave * DC.ar(0.29396033287048), wave * DC.ar(0.10901081562042), wave * DC.ar(0.29879534244537));
varCeCe17460510 = LPCError.ar(amp, signal, gateEnv, Silent.ar());
varCeCe17460511 = FoaDominateZ.ar(0.45351374149323 * modY * modZ, signal * varCeCe1746059, 0.99875768294627 * varCeCe17460512 * varCeCe174605116, Silent.ar());
varCeCe17460512 = BLBufRd.ar(Array.fill(2.pow(16), { |i| rrand(-1, 1) }).as(LocalBuf), island, amp);
varCeCe17460513 = ZeroCrossing.ar(varCeCe17460513 * in);
varCeCe17460514 = Perlin3.ar(wave * DC.ar(0.74926018714905), wave * DC.ar(0.70078992843628), wave * DC.ar(0.73923909664154));
varCeCe17460515 = WaveTerrain.ar(wave * DC.ar(0.13819396495819), wave * DC.ar(0.052703261375427), wave * DC.ar(0.64209139347076), wave * DC.ar(0.85767030715942), wave * DC.ar(0.77505552768707), wave * DC.ar(0.78953897953033), wave * DC.ar(0.42721343040466));
// Variation test code
varCeCe174605116 = Fhn2DN.ar(wave * varCeCe174605116, LorenzTrig.ar(varCeCe17460510 * DC.ar(0.17902934551239), varCeCe17460512 * DC.ar(0.55385494232178), varCeCe17460515 * DC.ar(0.47353613376617), varCeCe17460510 * DC.ar(0.74257206916809), varCeCe17460515 * DC.ar(0.71976375579834), varCeCe17460510 * DC.ar(0.25172746181488), varCeCe1746059 * DC.ar(0.31745648384094), varCeCe17460515 * DC.ar(0.78476226329803), varCeCe17460515 * DC.ar(0.050708532333374), varCeCe17460513 * DC.ar(0.59359395503998), varCeCe17460510 * DC.ar(0.10878121852875)).exprange(1, SampleRate.ir), varCeCe17460515, gate, modZ * varCeCe17460514, island, varCeCe174605117 * varCeCe17460515, varCeCe174605117 * modZ, 0.045458912849426 * modZ * wave, modX, Silent.ar());
varCeCe174605117 = FoaDominateY.ar(modX * wave, env.madd(varCeCe17460514 * DC.ar(0.064942836761475), varCeCe1746059 * DC.ar(0.25634980201721)), 0.99998939500955 * modX * varCeCe17460510, Silent.ar());
varCeCe174605118 = MoogVCF.ar(varCeCe1746059, varCeCe17460511 * varCeCe17460514, env * modX, FincoSprottM.ar(varCeCe17460514 * DC.ar(0.5860503911972), varCeCe17460513 * DC.ar(0.96405160427094), varCeCe17460512 * DC.ar(0.28509163856506), varCeCe1746059 * DC.ar(0.80972385406494), varCeCe17460515 * DC.ar(0.86957931518555), varCeCe17460514 * DC.ar(0.31380414962769), varCeCe17460510 * DC.ar(0.056214809417725), varCeCe17460510 * DC.ar(0.22721219062805), varCeCe17460511 * DC.ar(0.65722966194153)), WhiteNoise.ar(varCeCe17460515 * DC.ar(0.37910437583923), varCeCe1746059 * DC.ar(0.80604684352875)));
varCeCe174605116 = DoubleNestedAllpassN.ar(varCeCe174605116, modY * wave, modX * signal, varCeCe174605117, varCeCe17460513, Delay1.ar(z, 0.50103386335337 * varCeCe17460510 * modX, Silent.ar()), y, varCeCe17460512 * varCeCe174605117, env * gateEnv, varCeCe17460511, Concat.ar(varCeCe17460511 * DC.ar(0.59455180168152), varCeCe17460514 * DC.ar(0.83830189704895), varCeCe17460512 * DC.ar(0.42192590236664), varCeCe17460513 * DC.ar(0.93945169448853), varCeCe17460515 * DC.ar(0.9127836227417), varCeCe17460512 * DC.ar(0.80814301967621), varCeCe17460515 * DC.ar(0.54732930660248), varCeCe17460514 * DC.ar(0.47044992446899), varCeCe17460510 * DC.ar(0.96503627300262), varCeCe17460511 * DC.ar(0.8210027217865), varCeCe17460510 * DC.ar(0.71954345703125), varCeCe17460511 * DC.ar(0.26211714744568), varCeCe17460514 * DC.ar(0.83052515983582), varCeCe17460515 * DC.ar(0.72538125514984)), Silent.ar());
varCeCe174605117 = Convolution2.ar(varCeCe174605118, varCeCe17460510, varCeCe174605116 * signal, island, DelayC.ar(varCeCe17460512 * DC.ar(0.012023687362671), varCeCe17460512 * DC.ar(0.63704931735992), varCeCe17460514 * DC.ar(0.71420931816101), varCeCe17460513 * DC.ar(0.80449080467224), varCeCe17460510 * DC.ar(0.014691114425659)), Silent.ar());
varCeCe174605118 = BufWr.ar([XLine.ar(varCeCe17460512 * DC.ar(0.72016787528992), varCeCe1746059 * DC.ar(0.91648495197296), varCeCe1746059 * DC.ar(0.47272157669067), varCeCe17460514 * DC.ar(0.34119498729706), varCeCe17460514 * DC.ar(0.17025899887085), varCeCe17460512 * DC.ar(0.9127379655838)), RedPhasor.ar(varCeCe17460514 * DC.ar(0.85346937179565), varCeCe17460514 * DC.ar(0.80510973930359), varCeCe17460513 * DC.ar(0.87525475025177), varCeCe17460514 * DC.ar(0.50382137298584), varCeCe17460514 * DC.ar(0.19596338272095), varCeCe17460512 * DC.ar(0.39917874336243), varCeCe17460515 * DC.ar(0.34150886535645))], Array.fill(2.pow(11), { |i| rrand(-1, 1) }).as(LocalBuf), 0.81595885753632 * modY, signal * varCeCe17460513);
varCeCe174605116 = Brusselator.ar(modZ * varCeCe174605118, varCeCe17460515 * env, modZ, t_trig, x, varCeCe174605116, 0.81097713270407 * env * modX, Silent.ar());
varCeCe174605117 = LPF18.ar(varCeCe174605117 * varCeCe17460511, varCeCe17460512 * varCeCe174605118, x, bufnum);
varCeCe174605118 = LFBrownNoise2.ar(env * varCeCe17460513, modX, varCeCe174605118, 0.82179974430263 * modX, Silent.ar());

signal = varCeCe174605118;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// Implant.6128.b174606
/////////////////////////////////////////////////////////

SynthDef.new("Implant.6128.b174606", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varImplant6128b1746069, varImplant6128b17460610, varImplant6128b17460611, varImplant6128b17460612;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varImplant6128b1746069 = varImplant6128b17460610 = varImplant6128b17460611 = varImplant6128b17460612 = K2A.ar(t_trig).dup;
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
varImplant6128b1746069 = PVSynth.ar(Array.fill(2.pow(11), { |i| rrand(-1, 1) }).as(LocalBuf), SoftClipper8.ar(y), signal * signal, varImplant6128b17460612, modX, varImplant6128b17460610 * modY, wave, 0.9434400630502 * wave, Silent.ar());
varImplant6128b17460610 = PitchShift.ar(env, y, z, t_trig, MdaPiano.ar(wave * DC.ar(0.6869375705719), wave * DC.ar(0.1941089630127), wave * DC.ar(0.30726599693298), wave * DC.ar(0.19889891147614), wave * DC.ar(0.47533988952637), wave * DC.ar(0.9691401720047), wave * DC.ar(0.20506751537323), wave * DC.ar(0.31476438045502), wave * DC.ar(0.39759981632233), wave * DC.ar(0.24028384685516), wave * DC.ar(0.26458501815796), wave * DC.ar(0.56679964065552), wave * DC.ar(0.13992834091187), wave * DC.ar(0.98608362674713), wave * DC.ar(0.82423484325409), wave * DC.ar(0.3071790933609), wave * DC.ar(0.99827122688293)), varImplant6128b1746069, Silent.ar());
varImplant6128b17460611 = OSWrap8.ar(wave * varImplant6128b1746069, 0.42033183574677 * BufGrainB.ar(wave * DC.ar(0.6340891122818), wave * DC.ar(0.10021376609802), wave * DC.ar(0.17617297172546), wave * DC.ar(0.037700295448303), wave * DC.ar(0.0512855052948), wave * DC.ar(0.63149392604828), wave * DC.ar(0.47191286087036), wave * DC.ar(0.40033757686615), wave * DC.ar(0.065517663955688)), in);
varImplant6128b17460612 = AmpComp.ar(varImplant6128b1746069, y.min(Lorenz2DN.ar(wave * DC.ar(0.093414902687073), wave * DC.ar(0.28296327590942), wave * DC.ar(0.51667273044586), wave * DC.ar(0.3779399394989), wave * DC.ar(0.61162126064301), wave * DC.ar(0.54463624954224), wave * DC.ar(0.63433909416199), wave * DC.ar(0.306401014328), wave * DC.ar(0.55298352241516), wave * DC.ar(0.031270384788513), wave * DC.ar(0.87510716915131))), varImplant6128b17460612);
varImplant6128b1746069 = LagUD.ar(gateEnv * modY, signal * wave, x, modZ, Silent.ar());
varImplant6128b17460610 = Delay1.ar(modX * gateEnv, wave, Silent.ar());
varImplant6128b17460611 = Disintegrator.ar(modY * modX, 0.10676527023315 * varImplant6128b1746069 * varImplant6128b1746069, RecordBuf.ar(wave * DC.ar(0.8073046207428), wave * DC.ar(0.52361500263214), wave * DC.ar(0.60314965248108), wave * DC.ar(0.4111316204071), wave * DC.ar(0.52780306339264), wave * DC.ar(0.21948409080505), wave * DC.ar(0.10136282444), wave * DC.ar(0.3447812795639), wave * DC.ar(0.84805691242218)), 0.77079850613635 * modZ * varImplant6128b17460611, Silent.ar());
varImplant6128b17460612 = FoaDirectZ.ar(wave * DC.ar(0.8772668838501), wave * DC.ar(0.65916931629181), wave * DC.ar(0.58515906333923), wave * DC.ar(0.16390347480774));

signal = varImplant6128b17460612;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// WM.Onyx.A:De174607
/////////////////////////////////////////////////////////

SynthDef.new("WM.Onyx.A:De174607", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varWMOnyxADe1746079, varWMOnyxADe17460710, varWMOnyxADe17460711, varWMOnyxADe17460712;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varWMOnyxADe1746079 = varWMOnyxADe17460710 = varWMOnyxADe17460711 = varWMOnyxADe17460712 = K2A.ar(t_trig).dup;
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
varWMOnyxADe1746079 = Gbman2DC.ar(varWMOnyxADe17460712 * signal, wave * varWMOnyxADe17460710, signal * varWMOnyxADe1746079, t_trig, RegaliaMitraEQ.ar(wave * DC.ar(0.90738463401794), wave * DC.ar(0.62625920772552), wave * DC.ar(0.17242300510406), wave * DC.ar(0.56631410121918), wave * DC.ar(0.52420043945312), wave * DC.ar(0.011154294013977)), Silent.ar());
varWMOnyxADe17460710 = B2Ster.ar(varWMOnyxADe17460712, modZ, modX, LatoocarfianL.ar(wave * DC.ar(0.97878479957581), wave * DC.ar(0.31384491920471), wave * DC.ar(0.67575263977051), wave * DC.ar(0.19560575485229), wave * DC.ar(0.96856808662415), wave * DC.ar(0.54137969017029), wave * DC.ar(0.70518398284912), wave * DC.ar(0.86584794521332), wave * DC.ar(0.43569326400757)), Silent.ar());
varWMOnyxADe17460711 = MoogLadder.ar(z, wave * env, varWMOnyxADe17460711 * in, OffsetOut.ar(wave * DC.ar(0.21725952625275), wave * DC.ar(0.2608038187027)), Silent.ar());
varWMOnyxADe17460712 = Select.ar(wave, [CombLP.ar(wave * DC.ar(0.60706496238708), wave * DC.ar(0.055593371391296), wave * DC.ar(0.9129490852356), wave * DC.ar(0.51479148864746), wave * DC.ar(0.14302515983582), wave * DC.ar(0.32280552387238), wave * DC.ar(0.050460696220398), wave * DC.ar(0.21466636657715)), Fhn2DL.ar(wave * DC.ar(0.58591270446777), wave * DC.ar(0.76555120944977), wave * DC.ar(0.046571850776672), wave * DC.ar(0.91868853569031), wave * DC.ar(0.9042534828186), wave * DC.ar(0.35913300514221), wave * DC.ar(0.035757303237915), wave * DC.ar(0.7257878780365), wave * DC.ar(0.11252343654633), wave * DC.ar(0.15861141681671), wave * DC.ar(0.32771670818329))]);
varWMOnyxADe1746079 = AtsNoiSynth.ar(wave * DC.ar(0.87653315067291), wave * DC.ar(0.99579441547394), wave * DC.ar(0.16499662399292), wave * DC.ar(0.013100743293762), wave * DC.ar(0.12637865543365), wave * DC.ar(0.55894660949707), wave * DC.ar(0.20631349086761), wave * DC.ar(0.93664312362671), wave * DC.ar(0.36203289031982), wave * DC.ar(0.33470833301544), wave * DC.ar(0.72748911380768), wave * DC.ar(0.10091984272003), wave * DC.ar(0.47538697719574), wave * DC.ar(0.72556257247925));
varWMOnyxADe17460710 = BufDelayL.ar(wave * DC.ar(0.52391517162323), wave * DC.ar(0.30645394325256), wave * DC.ar(0.16864049434662), wave * DC.ar(0.99793481826782), wave * DC.ar(0.081013917922974));
varWMOnyxADe17460711 = SoftClipAmp.ar(varWMOnyxADe1746079, varWMOnyxADe1746079, 0.99917722133319 * varWMOnyxADe17460710 * env, Silent.ar());
varWMOnyxADe17460712 = XLine.ar(modX, signal * env, gateEnv * in, HenonN.ar(wave * DC.ar(0.44243991374969), wave * DC.ar(0.66214919090271), wave * DC.ar(0.023124575614929), wave * DC.ar(0.13819801807404), wave * DC.ar(0.54088246822357), wave * DC.ar(0.67983281612396), wave * DC.ar(0.68828475475311)), Silent.ar(), y);

signal = varWMOnyxADe17460712;
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
// Infostealer.OneTime174607
/////////////////////////////////////////////////////////

SynthDef.new("Infostealer.OneTime174607", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varInfostealerOneTime1746079, varInfostealerOneTime17460710, varInfostealerOneTime17460711, varInfostealerOneTime17460712, varInfostealerOneTime17460713, varInfostealerOneTime17460714;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varInfostealerOneTime1746079 = varInfostealerOneTime17460710 = varInfostealerOneTime17460711 = varInfostealerOneTime17460712 = varInfostealerOneTime17460713 = varInfostealerOneTime17460714 = K2A.ar(t_trig).dup;
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
varInfostealerOneTime1746079 = BufGrainIBF.ar(varInfostealerOneTime1746079 * wave, modZ * modZ, bufnum, amp, t_trig.madd(wave * DC.ar(0.38064289093018), wave * DC.ar(0.93301236629486)), bufnum, bufnum, signal * varInfostealerOneTime17460712, t_trig, z, wave * varInfostealerOneTime17460712, env * modY, varInfostealerOneTime17460710 * varInfostealerOneTime17460710, 0.99981033603957 * modX * gateEnv, Silent.ar());
varInfostealerOneTime17460710 = SMS.ar(varInfostealerOneTime1746079, signal * modZ, 0.76728510856628 * varInfostealerOneTime17460712 * varInfostealerOneTime17460713, gate, varInfostealerOneTime1746079, 0.99997167681812 * varInfostealerOneTime17460712 * modY, LeastChange.ar(wave * DC.ar(0.15154087543488), wave * DC.ar(0.25111758708954)), modX, gate, 0.63929064906958 * signal, Array.fill(2.pow(11), { |i| rrand(-1, 1) }).as(LocalBuf), 0.99518606077962 * modY * gateEnv, Shaper.ar(wave * DC.ar(0.44471573829651), wave * DC.ar(0.12937104701996), wave * DC.ar(0.24975001811981), wave * DC.ar(0.88996016979218)));
varInfostealerOneTime17460711 = FoaDominateY.ar(modZ * modX, 0.58335995674133 * CombN.ar(wave * DC.ar(0.74963009357452), wave * DC.ar(0.18541395664215), wave * DC.ar(0.074349522590637), wave * DC.ar(0.5566211938858), wave * DC.ar(0.65103232860565), wave * DC.ar(0.77328896522522)), 0.90645549874381 * Henon2DC.ar(wave * DC.ar(0.54538512229919), wave * DC.ar(0.35072147846222), wave * DC.ar(0.20762741565704), wave * DC.ar(0.4242035150528), wave * DC.ar(0.78885138034821), wave * DC.ar(0.66767549514771), wave * DC.ar(0.82915866374969), wave * DC.ar(0.81958174705505)), Silent.ar());
varInfostealerOneTime17460712 = LinCongN.ar(gateEnv * varInfostealerOneTime17460710, t_trig, varInfostealerOneTime17460710 * modZ, modX, modY * env, 0.98736182475592 * Squiz.ar(wave * DC.ar(0.69519054889679), wave * DC.ar(0.8679062128067), wave * DC.ar(0.29391407966614), wave * DC.ar(0.235072016716), wave * DC.ar(0.89489245414734), wave * DC.ar(0.88697111606598)), Silent.ar().wrap2(AtsNoiSynth.ar(wave * DC.ar(0.74283063411713), wave * DC.ar(0.65074110031128), wave * DC.ar(0.74419665336609), wave * DC.ar(0.01863420009613), wave * DC.ar(0.039406538009644), wave * DC.ar(0.083951830863953), wave * DC.ar(0.049736142158508), wave * DC.ar(0.97979772090912), wave * DC.ar(0.19796550273895), wave * DC.ar(0.75336825847626), wave * DC.ar(0.57267844676971), wave * DC.ar(0.014438033103943), wave * DC.ar(0.97731220722198), wave * DC.ar(0.51992952823639))));
varInfostealerOneTime17460713 = QuadL.ar(CrossoverDistortion.ar(wave * DC.ar(0.050764083862305), wave * DC.ar(0.74482893943787), wave * DC.ar(0.89078593254089), wave * DC.ar(0.7251683473587), wave * DC.ar(0.094995975494385)).exprange(1, SampleRate.ir), 0.22966754436493 * varInfostealerOneTime17460713 * varInfostealerOneTime17460714, varInfostealerOneTime17460714 * varInfostealerOneTime17460714, modX, varInfostealerOneTime17460713 * varInfostealerOneTime17460710, 0.99998888307347 * SinGrain.ar(wave * DC.ar(0.95042097568512), wave * DC.ar(0.24069452285767), wave * DC.ar(0.87779486179352), wave * DC.ar(0.86062407493591), wave * DC.ar(0.79852378368378)), Silent.ar());
varInfostealerOneTime17460714 = InGrainBF.ar(modX * varInfostealerOneTime17460710, env, varInfostealerOneTime17460712 * modY, 0.96385753154755 * varInfostealerOneTime17460710 * varInfostealerOneTime17460710, amp, amp, FincoSprottL.ar(in * modY, varInfostealerOneTime17460712, amp, modX, z, varInfostealerOneTime17460712 * env, 0.95583244950808 * env * wave, Silent.ar()).clip(wave * DC.ar(0.62953543663025), wave * DC.ar(0.99772417545319)), 0.04060274705187 * in, DelayC.ar(wave * DC.ar(0.16432225704193), wave * DC.ar(0.22932875156403), wave * DC.ar(0.95431053638458), wave * DC.ar(0.16202819347382), wave * DC.ar(0.33385908603668)));
varInfostealerOneTime1746079 = LFPulse.ar(varInfostealerOneTime17460711 * modZ, signal, 0.98194766044617 * varInfostealerOneTime17460714 * in, 0.99997869218461 * modY * modZ, Silent.ar());
varInfostealerOneTime17460710 = SetResetFF.ar(wave * DC.ar(0.016985774040222), wave * DC.ar(0.074021816253662));
varInfostealerOneTime17460711 = Fhn2DC.ar(wave * DC.ar(0.32974743843079), wave * DC.ar(0.52845418453217), wave * DC.ar(0.23124718666077), wave * DC.ar(0.16284096240997), wave * DC.ar(0.60313153266907), wave * DC.ar(0.92489993572235), wave * DC.ar(0.40878915786743), wave * DC.ar(0.97864580154419), wave * DC.ar(0.96545493602753), wave * DC.ar(0.70283401012421), wave * DC.ar(0.21625506877899));
varInfostealerOneTime17460712 = BufCombN.ar(Array.fill(2.pow(11), { |i| rrand(-1, 1) }).as(LocalBuf), varInfostealerOneTime17460713, varInfostealerOneTime17460711 * wave, modX * varInfostealerOneTime17460713, varInfostealerOneTime17460713, Silent.ar());
varInfostealerOneTime17460713 = Henon2DN.ar(StereoConvolution2L.ar(wave * DC.ar(0.89651358127594), wave * DC.ar(0.08576774597168), wave * DC.ar(0.4893833398819), wave * DC.ar(0.96128761768341), wave * DC.ar(0.072582602500916), wave * DC.ar(0.90304565429688), wave * DC.ar(0.2425172328949), wave * DC.ar(0.65607810020447)).exprange(1, SampleRate.ir), varInfostealerOneTime17460711, z, varInfostealerOneTime17460711, amp, env * varInfostealerOneTime1746079.exprange(wave * DC.ar(0.3742493391037), wave * DC.ar(0.95932233333588)), 0.98925441918249 * in * modZ, Silent.ar());
varInfostealerOneTime17460714 = SineShaper.ar(gate, signal * varInfostealerOneTime17460710, varInfostealerOneTime17460712, Silent.ar());

signal = varInfostealerOneTime17460714;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// Mystic174608
/////////////////////////////////////////////////////////

SynthDef.new("Mystic174608", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varMystic1746089, varMystic17460810;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varMystic1746089 = varMystic17460810 = K2A.ar(t_trig).dup;
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
varMystic1746089 = FitzHughNagumo.ar(signal, bufnum, 0.60640001296997 * signal * modZ, modY * in, env * signal, gateEnv, AtsNoise.ar(wave * DC.ar(0.88696682453156), wave * DC.ar(0.97873187065125), wave * DC.ar(0.20676362514496), wave * DC.ar(0.28700113296509), wave * DC.ar(0.79334211349487)), 0.99998030541806 * BufAllpassC.ar(wave * DC.ar(0.67456710338593), wave * DC.ar(0.32151103019714), wave * DC.ar(0.076865673065186), wave * DC.ar(0.72953581809998), wave * DC.ar(0.31961596012115), wave * DC.ar(0.64661026000977)), Silent.ar());
varMystic17460810 = XFadeRotate.ar(gateEnv * varMystic17460810.scaleneg(NLFiltC.ar(wave * DC.ar(0.39677691459656), wave * DC.ar(0.9615159034729), wave * DC.ar(0.70178270339966), wave * DC.ar(0.51835024356842), wave * DC.ar(0.057740569114685), wave * DC.ar(0.43803787231445), wave * DC.ar(0.27699136734009), wave * DC.ar(0.35541927814484))), wave * modX);
varMystic1746089 = LFBrownNoise1.ar(wave * DC.ar(0.92250084877014), wave * DC.ar(0.63007891178131), wave * DC.ar(0.91022109985352), wave * DC.ar(0.93665015697479), wave * DC.ar(0.11066865921021));
varMystic17460810 = SVF.ar(signal * env, env * gateEnv, wave * modY, gateEnv, varMystic1746089 * modX, modZ * in, 0.89717173576355 * modX, varMystic1746089 * gateEnv, Logistic.ar(wave * DC.ar(0.36670088768005), wave * DC.ar(0.35608863830566), wave * DC.ar(0.53791749477386), wave * DC.ar(0.33279800415039), wave * DC.ar(0.66476356983185)), Silent.ar());

signal = varMystic17460810;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// WM.ME(gen)174610
/////////////////////////////////////////////////////////

SynthDef.new("WM.ME(gen)174610", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varWMMEgen1746109, varWMMEgen17461010, varWMMEgen17461011;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varWMMEgen1746109 = varWMMEgen17461010 = varWMMEgen17461011 = K2A.ar(t_trig).dup;
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
varWMMEgen1746109 = UHJ2B.ar(0.048662543296814 * varWMMEgen17461011 * in, modX * modZ);
varWMMEgen17461010 = FreeVerb2.ar(varWMMEgen1746109, bufnum, varWMMEgen1746109, z, y, 0.98667605783885 * modZ * varWMMEgen17461010, Silent.ar());
varWMMEgen17461011 = MeanTriggered.ar(varWMMEgen17461010 * modZ.bipolar(wave * DC.ar(0.45308005809784)), signal * varWMMEgen17461010, signal, 0.99998361379745 * signal * varWMMEgen17461011, Silent.ar());
varWMMEgen1746109 = StkVoicForm.ar(wave * modZ, wave * in, env * wave, RedPhasor2.ar(wave * DC.ar(0.45615386962891), wave * DC.ar(0.534264087677), wave * DC.ar(0.66286718845367), wave * DC.ar(0.73673951625824), wave * DC.ar(0.39060735702515), wave * DC.ar(0.48351657390594), wave * DC.ar(0.6898318529129)).exprange(1, SampleRate.ir), y, amp, in, wave, Silent.ar());
varWMMEgen17461010 = GrayNoise.ar(wave * DC.ar(0.73167932033539), wave * DC.ar(0.44745278358459));
varWMMEgen17461011 = LeastChange.ar(varWMMEgen17461011, varWMMEgen1746109 * signal);

signal = varWMMEgen17461011;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// WM.Concept.AO1746131
/////////////////////////////////////////////////////////

SynthDef.new("WM.Concept.AO1746131", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varWMConceptAO1746139, varWMConceptAO17461310, varWMConceptAO17461311, varWMConceptAO174613112;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varWMConceptAO1746139 = varWMConceptAO17461310 = varWMConceptAO17461311 = varWMConceptAO174613112 = K2A.ar(t_trig).dup;
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
varWMConceptAO1746139 = RedPhasor2.ar(wave, in, modZ, gateEnv * in, x, env * varWMConceptAO17461311, gateEnv * modZ);
varWMConceptAO17461310 = AtsNoise.ar(Array.fill(2.pow(16), { |i| rrand(-1, 1) }).as(LocalBuf), Ball.ar(modX * varWMConceptAO174613112, varWMConceptAO17461310, env, env), modY * signal, FoaDominateY.ar(wave * DC.ar(0.42167663574219), wave * DC.ar(0.49829280376434), wave * DC.ar(0.23514497280121), wave * DC.ar(0.80149388313293)), Silent.ar());
varWMConceptAO17461311 = XOut.ar((80 + (island * 2)), modZ * env, [BRZ2.ar(wave * DC.ar(0.81020832061768), wave * DC.ar(0.77727794647217), wave * DC.ar(0.40913951396942)), Peak.ar(wave * DC.ar(0.88137817382812), wave * DC.ar(0.7742360830307))]);
varWMConceptAO1746139 = BufAllpassN.ar(Array.fill(2.pow(16), { |i| rrand(-1, 1) }).as(LocalBuf), varWMConceptAO1746139, bufnum, amp, 0.97192564775076 * Decay.ar(wave * DC.ar(0.33736145496368), wave * DC.ar(0.032570481300354), wave * DC.ar(0.15648484230042), wave * DC.ar(0.51045000553131)), Silent.ar());
varWMConceptAO17461310 = BeatWarper.ar(2, Array.fill(2.pow(16), { |i| rrand(-1, 1) }).as(LocalBuf), island, varWMConceptAO174613112, varWMConceptAO17461311, signal, gateEnv, amp, SVF.ar(wave * DC.ar(0.78693068027496), wave * DC.ar(0.11977434158325), wave * DC.ar(0.65677416324615), wave * DC.ar(0.96265614032745), wave * DC.ar(0.6160227060318), wave * DC.ar(0.66338133811951), wave * DC.ar(0.31518447399139), wave * DC.ar(0.81567430496216), wave * DC.ar(0.13074636459351), wave * DC.ar(0.3244024515152)), Silent.ar());
varWMConceptAO17461311 = SoftClipAmp8.ar(modY, z, 0.62009836093137 * varWMConceptAO17461310 * in, Silent.ar());
// Variation test code
varWMConceptAO174613112 = RMShelf2.ar(modX, modZ * modZ, varWMConceptAO1746139 * env, 0.94173999828765 * varWMConceptAO17461310 * varWMConceptAO17461310, Silent.ar());
varWMConceptAO174613112 = MembraneCircle.ar(modY * varWMConceptAO17461311, varWMConceptAO1746139, amp, varWMConceptAO1746139, Silent.ar());
varWMConceptAO174613112 = Fhn2DN.ar(varWMConceptAO17461310, LPFVS6.ar(varWMConceptAO17461311 * DC.ar(0.59820818901062), varWMConceptAO17461310 * DC.ar(0.80781185626984), varWMConceptAO17461311 * DC.ar(0.12150895595551)).exprange(1, SampleRate.ir), varWMConceptAO17461310 * modZ, in, varWMConceptAO1746139, 0.23246932029724 * signal * modZ, modY * varWMConceptAO17461311, y, x, varWMConceptAO17461311, Silent.ar());

signal = varWMConceptAO174613112;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// W97M.Class.U174613
/////////////////////////////////////////////////////////

SynthDef.new("W97M.Class.U174613", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varW97MClassU1746139, varW97MClassU17461310, varW97MClassU17461311, varW97MClassU17461312, varW97MClassU17461313;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varW97MClassU1746139 = varW97MClassU17461310 = varW97MClassU17461311 = varW97MClassU17461312 = varW97MClassU17461313 = K2A.ar(t_trig).dup;
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
varW97MClassU1746139 = LFSaw.ar(varW97MClassU17461313, gate, varW97MClassU17461313, Silent.ar());
varW97MClassU17461310 = StkVoicForm.ar(ArrayMax.ar(wave * DC.ar(0.091303944587708)).exprange(1, SampleRate.ir), env * in, in * varW97MClassU17461310, modY * varW97MClassU17461311, island, signal * modZ, modZ * env, FBSineL.ar(wave * DC.ar(0.47340393066406), wave * DC.ar(0.032928466796875), wave * DC.ar(0.3633064031601), wave * DC.ar(0.84908092021942), wave * DC.ar(0.63038575649261), wave * DC.ar(0.038784384727478), wave * DC.ar(0.60394358634949), wave * DC.ar(0.4435042142868), wave * DC.ar(0.67170119285583)), Silent.ar().excess(RunningMax.ar(wave * DC.ar(0.41481184959412), wave * DC.ar(0.21880066394806))));
varW97MClassU17461311 = OscN.ar(Array.fill(2.pow(11), { |i| rrand(-1, 1) }).as(LocalBuf), BPZ2.ar(wave * DC.ar(0.6723940372467), wave * DC.ar(0.18477463722229), wave * DC.ar(0.67369627952576)).exprange(1, SampleRate.ir), modZ, signal, Silent.ar());
varW97MClassU17461312 = YigClifford3DC.ar(OSFold8.ar(wave * DC.ar(0.76405775547028), wave * DC.ar(0.82633697986603), wave * DC.ar(0.15598034858704)).exprange(1, SampleRate.ir), gateEnv, 0.76128506660461 * Lorenz2DN.ar(wave * DC.ar(0.0093667507171631), wave * DC.ar(0.35420346260071), wave * DC.ar(0.79225277900696), wave * DC.ar(0.90041089057922), wave * DC.ar(0.82466495037079), wave * DC.ar(0.45579588413239), wave * DC.ar(0.34254491329193), wave * DC.ar(0.44189441204071), wave * DC.ar(0.83704447746277), wave * DC.ar(0.051044464111328), wave * DC.ar(0.50317561626434)), y, wave, 0.12291193008423 * in * varW97MClassU17461312, wave * modX, varW97MClassU17461313, 0.94948136761687 * varW97MClassU17461311 * gateEnv, Silent.ar());
varW97MClassU17461313 = FoaPanB.ar(varW97MClassU17461313, in, modX * wave, DoubleNestedAllpassC.ar(wave * DC.ar(0.1574615240097), wave * DC.ar(0.54411113262177), wave * DC.ar(0.71806704998016), wave * DC.ar(0.88578903675079), wave * DC.ar(0.41853177547455), wave * DC.ar(0.53764510154724), wave * DC.ar(0.30519080162048), wave * DC.ar(0.4380316734314), wave * DC.ar(0.69059431552887), wave * DC.ar(0.24698066711426), wave * DC.ar(0.86142432689667), wave * DC.ar(0.79004406929016)), Silent.ar());
varW97MClassU1746139 = B2A.ar(varW97MClassU17461313 * varW97MClassU17461313, BPF.ar(modZ * modX, wave, amp, 0.93532155816472 * wave * varW97MClassU17461310, Silent.ar()), varW97MClassU17461312, varW97MClassU17461313 * varW97MClassU17461313);
varW97MClassU17461310 = Lag3.ar(gateEnv * in, signal * varW97MClassU1746139, 0.99990322539273 * varW97MClassU17461310 * modX, Silent.ar());
varW97MClassU17461311 = FMHEncode1.ar(wave * DC.ar(0.58972299098969), wave * DC.ar(0.083194732666016), wave * DC.ar(0.10091137886047), wave * DC.ar(0.59514927864075), wave * DC.ar(0.33102691173553), wave * DC.ar(0.57596325874329));
varW97MClassU17461312 = InRange.ar(env, modX * varW97MClassU17461311, varW97MClassU17461311);
varW97MClassU17461313 = MdaPiano.ar(wave * DC.ar(0.32168352603912), wave * DC.ar(0.50247156620026), wave * DC.ar(0.51139211654663), wave * DC.ar(0.24155735969543), wave * DC.ar(0.91123151779175), wave * DC.ar(0.51667284965515), wave * DC.ar(0.8943806886673), wave * DC.ar(0.37153446674347), wave * DC.ar(0.71074318885803), wave * DC.ar(0.21856653690338), wave * DC.ar(0.27729845046997), wave * DC.ar(0.93479228019714), wave * DC.ar(0.3268096446991), wave * DC.ar(0.46796751022339), wave * DC.ar(0.22642540931702), wave * DC.ar(0.52660644054413), wave * DC.ar(0.064078330993652));

signal = varW97MClassU17461313;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// W95.Yurn.11671746131
/////////////////////////////////////////////////////////

SynthDef.new("W95.Yurn.11671746131", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varW95Yurn11671746139, varW95Yurn116717461310, varW95Yurn116717461311, varW95Yurn116717461312, varW95Yurn116717461313, varW95Yurn116717461314, varW95Yurn116717461315, varW95Yurn1167174613116, varW95Yurn1167174613117, varW95Yurn1167174613118, varW95Yurn1167174613119, varW95Yurn1167174613120;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varW95Yurn11671746139 = varW95Yurn116717461310 = varW95Yurn116717461311 = varW95Yurn116717461312 = varW95Yurn116717461313 = varW95Yurn116717461314 = varW95Yurn116717461315 = varW95Yurn1167174613116 = varW95Yurn1167174613117 = varW95Yurn1167174613118 = varW95Yurn1167174613119 = varW95Yurn1167174613120 = K2A.ar(t_trig).dup;
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
varW95Yurn11671746139 = AllpassN.ar(0.55065476894379 * varW95Yurn11671746139 * modY, TRand.ar(wave * DC.ar(0.49995279312134), wave * DC.ar(0.19588470458984), wave * DC.ar(0.65940129756927)), amp, gateEnv, 0.99995047806206 * in * varW95Yurn116717461313, Silent.ar());
varW95Yurn116717461310 = PartConv.ar(varW95Yurn1167174613120 * varW95Yurn1167174613119, x, Array.fill(2.pow(16), { |i| rrand(-1, 1) }).as(LocalBuf), 0.99524310393795 * varW95Yurn1167174613117 * varW95Yurn116717461310, LatoocarfianC.ar(wave * DC.ar(0.25159966945648), wave * DC.ar(0.59518659114838), wave * DC.ar(0.15076768398285), wave * DC.ar(0.71744453907013), wave * DC.ar(0.9103809595108), wave * DC.ar(0.042980670928955), wave * DC.ar(0.15194380283356), wave * DC.ar(0.30714404582977), wave * DC.ar(0.85543489456177)));
varW95Yurn116717461311 = DiskOut.ar(Array.fill(2.pow(16), { |i| rrand(-1, 1) }).as(LocalBuf).curvelin(wave * DC.ar(0.14227283000946), wave * DC.ar(0.95788013935089), wave * DC.ar(0.20564007759094), wave * DC.ar(0.40029406547546), wave * DC.ar(0.48837447166443), wave * DC.ar(0.98659765720367)), [Latoocarfian2DN.ar(wave * DC.ar(0.17408740520477), wave * DC.ar(0.82792341709137), wave * DC.ar(0.16572260856628), wave * DC.ar(0.71134448051453), wave * DC.ar(0.026321530342102), wave * DC.ar(0.0049777030944824), wave * DC.ar(0.040621995925903), wave * DC.ar(0.15927577018738), wave * DC.ar(0.86863362789154), wave * DC.ar(0.66326534748077)), Delay2.ar(wave * DC.ar(0.79780125617981), wave * DC.ar(0.75582647323608), wave * DC.ar(0.52779102325439))]);
varW95Yurn116717461312 = IEnvGen.ar(modZ * varW95Yurn1167174613119, varW95Yurn116717461310, varW95Yurn1167174613120, Silent.ar());
varW95Yurn116717461313 = LFDNoise0.ar(Lag3.ar(wave * DC.ar(0.60647428035736), wave * DC.ar(0.59591174125671), wave * DC.ar(0.84263288974762), wave * DC.ar(0.78540897369385)).exprange(1, SampleRate.ir), Dust2.ar(wave * DC.ar(0.37627518177032), wave * DC.ar(0.56617450714111), wave * DC.ar(0.10041928291321)), Silent.ar());
varW95Yurn116717461314 = StkBowed.ar(varW95Yurn1167174613117 * in, 0.30701076984406 * varW95Yurn116717461314 * varW95Yurn116717461314, 0.49175012111664 * varW95Yurn116717461311 * env, varW95Yurn1167174613116 * env, 0.80055749416351 * wave * varW95Yurn116717461313, varW95Yurn1167174613120, t_trig, varW95Yurn1167174613120 * signal, t_trig, 0.98334377172061 * varW95Yurn11671746139 * varW95Yurn116717461311, Silent.ar());
varW95Yurn116717461315 = InGrain.ar(LastValue.ar(wave * DC.ar(0.30882477760315), wave * DC.ar(0.10615980625153)), bufnum, varW95Yurn116717461314 * varW95Yurn1167174613120, Dust.ar(wave * DC.ar(0.68062210083008), wave * DC.ar(0.71412861347198), wave * DC.ar(0.90589308738708)), Silent.ar());
varW95Yurn11671746139 = StkBandedWG.ar(wave * DC.ar(0.28724765777588), wave * DC.ar(0.55986261367798), wave * DC.ar(0.6320458650589), wave * DC.ar(0.88484847545624), wave * DC.ar(0.26192581653595), wave * DC.ar(0.98656213283539), wave * DC.ar(0.52542924880981), wave * DC.ar(0.29323196411133), wave * DC.ar(0.67672407627106), wave * DC.ar(0.59243834018707), wave * DC.ar(0.057675719261169));
varW95Yurn116717461310 = LatoocarfianC.ar(varW95Yurn1167174613118, modZ, modX, y, gateEnv * varW95Yurn1167174613118, varW95Yurn1167174613119 * signal, gateEnv * in, LPCAnalyzer.ar(wave * DC.ar(0.20219540596008), wave * DC.ar(0.67288529872894), wave * DC.ar(0.013718366622925), wave * DC.ar(0.41945493221283), wave * DC.ar(0.72034633159637), wave * DC.ar(0.56922161579132), wave * DC.ar(0.80144035816193), wave * DC.ar(0.53493595123291), wave * DC.ar(0.74630057811737)), Silent.ar());
varW95Yurn116717461311 = TwoZero.ar(wave * DC.ar(0.23567509651184), wave * DC.ar(0.0023329257965088), wave * DC.ar(0.030458331108093), wave * DC.ar(0.12919175624847), wave * DC.ar(0.093645691871643));
varW95Yurn116717461312 = TextVU.ar(wave * DC.ar(0.53846418857574), wave * DC.ar(0.10254037380219), wave * DC.ar(0.5117312669754), wave * DC.ar(0.13805818557739), wave * DC.ar(0.66891515254974), wave * DC.ar(0.88039648532867));
varW95Yurn116717461313 = Normalizer.ar(gateEnv, x, bufnum);
varW95Yurn116717461314 = APF.ar(modX * modY, varW95Yurn1167174613119, modY, 0.99201093048985 * modZ * signal, Silent.ar());
varW95Yurn116717461315 = BBandPass.ar(wave * DC.ar(0.77986812591553), wave * DC.ar(0.81537628173828), wave * DC.ar(0.40591704845428), wave * DC.ar(0.8440545797348), wave * DC.ar(0.92397403717041));
// Variation test code
varW95Yurn1167174613116 = GrainBuf.ar(2, modZ * varW95Yurn1167174613117, varW95Yurn1167174613116 * modY, bufnum, varW95Yurn1167174613116 * varW95Yurn116717461314, varW95Yurn116717461310, signal, varW95Yurn116717461312 * env, bufnum, modY, 0.99996790267841 * varW95Yurn116717461315 * varW95Yurn116717461310, TDuty.ar(varW95Yurn11671746139 * DC.ar(0.10846519470215), varW95Yurn116717461313 * DC.ar(0.058864116668701), varW95Yurn116717461312 * DC.ar(0.39773857593536), varW95Yurn11671746139 * DC.ar(0.22827470302582), varW95Yurn11671746139 * DC.ar(0.91448950767517)));
varW95Yurn1167174613117 = RunningMin.ar(0.95400059223175 * modZ * varW95Yurn116717461311, varW95Yurn116717461314 * modZ);
varW95Yurn1167174613118 = BPF.ar(x.hypotApx(SMS.ar(varW95Yurn116717461312 * DC.ar(0.27470314502716), varW95Yurn116717461310 * DC.ar(0.51243948936462), varW95Yurn116717461313 * DC.ar(0.33337640762329), varW95Yurn116717461313 * DC.ar(0.99719226360321), varW95Yurn116717461311 * DC.ar(0.98299598693848), varW95Yurn116717461310 * DC.ar(0.76961493492126), varW95Yurn116717461310 * DC.ar(0.98878598213196), varW95Yurn11671746139 * DC.ar(0.48946058750153), varW95Yurn11671746139 * DC.ar(0.7714227437973), varW95Yurn116717461310 * DC.ar(0.40037405490875), varW95Yurn116717461315 * DC.ar(0.06680691242218), varW95Yurn116717461313 * DC.ar(0.56571209430695), varW95Yurn116717461311 * DC.ar(0.28838157653809))), varW95Yurn116717461314, varW95Yurn116717461311, 0.89539982813945 * gateEnv * varW95Yurn116717461310, Silent.ar());
varW95Yurn1167174613119 = Slope.ar(signal * varW95Yurn116717461312, 0.9997550567751 * modX * varW95Yurn1167174613119, Silent.ar());
varW95Yurn1167174613120 = Schmidt.ar(varW95Yurn116717461311 * modX, bufnum, varW95Yurn116717461315 * gateEnv);
varW95Yurn1167174613116 = Lag3UD.ar(varW95Yurn1167174613120 * varW95Yurn1167174613118, 0.76909971237183 * env * env, t_trig, BufAllpassL.ar(varW95Yurn116717461313 * DC.ar(0.88962090015411), varW95Yurn116717461315 * DC.ar(0.12340652942657), varW95Yurn11671746139 * DC.ar(0.83094084262848), varW95Yurn11671746139 * DC.ar(0.046478867530823), varW95Yurn116717461313 * DC.ar(0.57151806354523), varW95Yurn116717461313 * DC.ar(0.59066724777222)), Silent.ar());
varW95Yurn1167174613117 = PosRatio.ar(gate, 0.6411018371582 * env * varW95Yurn116717461313, modZ * varW95Yurn1167174613119);
varW95Yurn1167174613118 = Ball.ar(varW95Yurn116717461312 * signal, varW95Yurn1167174613119, varW95Yurn1167174613120 * varW95Yurn1167174613118, signal);
varW95Yurn1167174613119 = SOS.ar(signal * varW95Yurn11671746139, wave * modY, t_trig, varW95Yurn1167174613116 * gateEnv, varW95Yurn1167174613117 * varW95Yurn116717461311.difsqr(B2A.ar(varW95Yurn116717461315 * DC.ar(0.65188217163086), varW95Yurn116717461314 * DC.ar(0.78222751617432), varW95Yurn11671746139 * DC.ar(0.87769424915314), varW95Yurn116717461315 * DC.ar(0.033467888832092))), varW95Yurn116717461314 * signal, 0.62525054158421 * varW95Yurn116717461311 * modX, Silent.ar());
varW95Yurn1167174613120 = Clip.ar(modZ, StkShakers.ar(varW95Yurn1167174613117 * varW95Yurn1167174613118, varW95Yurn1167174613119 * varW95Yurn116717461310, in * signal, wave, GrayNoise.ar(varW95Yurn116717461311 * DC.ar(0.60323977470398), varW95Yurn116717461312 * DC.ar(0.82816791534424)).exprange(1, SampleRate.ir), 0.79412986207914 * varW95Yurn1167174613118 * varW95Yurn1167174613116, Silent.ar()), varW95Yurn116717461313 * varW95Yurn116717461310);
varW95Yurn1167174613116 = TBrownRand.ar(bufnum, 0.8983428478241 * varW95Yurn116717461311 * varW95Yurn1167174613120, y, varW95Yurn1167174613118, varW95Yurn116717461314 * varW95Yurn1167174613116, Gbman2DL.ar(varW95Yurn116717461314 * DC.ar(0.5957396030426), varW95Yurn116717461311 * DC.ar(0.52740681171417), varW95Yurn116717461310 * DC.ar(0.58410263061523), varW95Yurn116717461312 * DC.ar(0.77777743339539), varW95Yurn116717461314 * DC.ar(0.13275170326233), varW95Yurn116717461311 * DC.ar(0.36038053035736)), Silent.ar());
varW95Yurn1167174613117 = BufGrain.ar(env * in, varW95Yurn11671746139, bufnum, varW95Yurn116717461314, varW95Yurn1167174613116, 0.619424700737 * varW95Yurn11671746139 * varW95Yurn116717461311, Gendy1.ar(varW95Yurn11671746139 * DC.ar(0.3565639257431), varW95Yurn116717461315 * DC.ar(0.02587902545929), varW95Yurn116717461311 * DC.ar(0.80235517024994), varW95Yurn116717461312 * DC.ar(0.091094136238098), varW95Yurn11671746139 * DC.ar(0.47885203361511), varW95Yurn116717461312 * DC.ar(0.11937546730042), varW95Yurn116717461312 * DC.ar(0.16639888286591), varW95Yurn116717461313 * DC.ar(0.67092287540436), varW95Yurn116717461313 * DC.ar(0.42813146114349), varW95Yurn116717461311 * DC.ar(0.58828663825989), varW95Yurn116717461311 * DC.ar(0.68660414218903), varW95Yurn116717461312 * DC.ar(0.34084796905518)), Silent.ar());
varW95Yurn1167174613118 = RHPF.ar(varW95Yurn116717461312 * varW95Yurn116717461311, in, 0.11688911914825 * varW95Yurn1167174613117 * varW95Yurn1167174613117, 0.96182747095276 * varW95Yurn116717461312, Silent.ar());
varW95Yurn1167174613119 = SawDPW.ar(varW95Yurn116717461312, gate.lag2(varW95Yurn116717461311 * DC.ar(0.29616987705231), varW95Yurn116717461311 * DC.ar(0.49224257469177)), FoaFocusX.ar(varW95Yurn116717461312 * DC.ar(0.40171885490417), varW95Yurn116717461313 * DC.ar(0.77759182453156), varW95Yurn116717461313 * DC.ar(0.23194885253906), varW95Yurn116717461315 * DC.ar(0.31221115589142)), Silent.ar());
varW95Yurn1167174613120 = FreeVerb2.ar(modZ * env.explin(varW95Yurn116717461313 * DC.ar(0.0016622543334961), varW95Yurn116717461315 * DC.ar(0.4158079624176), varW95Yurn116717461314 * DC.ar(0.89313209056854), varW95Yurn116717461312 * DC.ar(0.23343014717102), varW95Yurn116717461311 * DC.ar(0.27603209018707)), in, varW95Yurn116717461314 * varW95Yurn1167174613119, OSWrap4.ar(varW95Yurn1167174613118, modZ * varW95Yurn1167174613116, modY * env), varW95Yurn1167174613117, 0.78701551771243 * varW95Yurn116717461313 * gateEnv, Silent.ar());

signal = varW95Yurn1167174613120;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// PS-MPC.955174614
/////////////////////////////////////////////////////////

SynthDef.new("PS-MPC.955174614", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varPSMPC9551746149, varPSMPC95517461410, varPSMPC95517461411, varPSMPC95517461412;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varPSMPC9551746149 = varPSMPC95517461410 = varPSMPC95517461411 = varPSMPC95517461412 = K2A.ar(t_trig).dup;
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
varPSMPC9551746149 = Standard2DN.ar(LinCongC.ar(wave * DC.ar(0.33153605461121), wave * DC.ar(0.15615999698639), wave * DC.ar(0.20358622074127), wave * DC.ar(0.9506561756134), wave * DC.ar(0.72602868080139), wave * DC.ar(0.52845418453217), wave * DC.ar(0.54253160953522)).exprange(1, SampleRate.ir), Decay.ar(wave * DC.ar(0.15578782558441), wave * DC.ar(0.17568755149841), wave * DC.ar(0.13405203819275), wave * DC.ar(0.30494928359985)).exprange(1, SampleRate.ir), varPSMPC95517461410, varPSMPC95517461410, varPSMPC9551746149, 0.991760540678 * Gendy4.ar(wave * DC.ar(0.047087907791138), wave * DC.ar(0.37405812740326), wave * DC.ar(0.31236863136292), wave * DC.ar(0.93195462226868), wave * DC.ar(0.52611196041107), wave * DC.ar(0.92559123039246), wave * DC.ar(0.66406917572021), wave * DC.ar(0.1933856010437), wave * DC.ar(0.20836985111237), wave * DC.ar(0.9044291973114), wave * DC.ar(0.073622465133667), wave * DC.ar(0.47534310817719)), Silent.ar());
varPSMPC95517461410 = YigCliffordC.ar(varPSMPC95517461412 * wave, gateEnv * modZ, env, modY * varPSMPC9551746149, x, varPSMPC95517461411 * modX, Decimator.ar(wave * DC.ar(0.99436616897583), wave * DC.ar(0.88870620727539), wave * DC.ar(0.27112591266632), wave * DC.ar(0.55294597148895), wave * DC.ar(0.34497535228729)), 0.99396141623675 * varPSMPC95517461411 * gateEnv, Silent.ar());
varPSMPC95517461411 = QuadN.ar(modZ * in, signal * signal, varPSMPC9551746149 * wave, signal, in * modZ, 0.99988650198169 * env * env, Silent.ar());
varPSMPC95517461412 = FMHEncode2.ar(signal * gateEnv, LPF.ar(modY * in, signal * env, modX, Silent.ar()), modZ * varPSMPC95517461410, modY * varPSMPC95517461410, modX, x);
varPSMPC9551746149 = VDiskIn.ar(2, Array.fill(2.pow(14), { |i| rrand(-1, 1) }).as(LocalBuf), gate, amp, wave * varPSMPC95517461411);
varPSMPC95517461410 = LatoocarfianL.ar(varPSMPC95517461410 * varPSMPC95517461411, in, modZ, bufnum, varPSMPC95517461412, MoogLadder.ar(varPSMPC95517461411 * varPSMPC95517461410, modZ * modZ, gate, OSFold8.ar(wave * DC.ar(0.66355967521667), wave * DC.ar(0.47120273113251), wave * DC.ar(0.22934460639954)), Silent.ar()), 0.5226743221283 * gateEnv * modX, 0.99041008010346 * modZ * wave, Silent.ar());
varPSMPC95517461411 = Instruction.ar(Array.fill(2.pow(11), { |i| rrand(-1, 1) }).as(LocalBuf), 0.99136613450929 * modX * env, Silent.ar());
varPSMPC95517461412 = OSTrunc8.ar(wave * DC.ar(0.62634134292603), wave * DC.ar(0.68870306015015));

signal = varPSMPC95517461412;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// W32.Pilleuz!gen3174615
/////////////////////////////////////////////////////////

SynthDef.new("W32.Pilleuz!gen3174615", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varW32Pilleuzgen31746159, varW32Pilleuzgen317461510;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varW32Pilleuzgen31746159 = varW32Pilleuzgen317461510 = K2A.ar(t_trig).dup;
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
varW32Pilleuzgen31746159 = Fhn2DC.ar(modY * modZ, VarSaw.ar(wave * DC.ar(0.86192393302917), wave * DC.ar(0.53073394298553), wave * DC.ar(0.26513135433197), wave * DC.ar(0.60572040081024), wave * DC.ar(0.60876941680908)).exprange(1, SampleRate.ir), varW32Pilleuzgen317461510, modZ, varW32Pilleuzgen31746159, env * varW32Pilleuzgen317461510, 0.11000955104828 * gateEnv, signal * varW32Pilleuzgen31746159, 0.97208094596863 * gateEnv * modY, gateEnv, Silent.ar());
varW32Pilleuzgen317461510 = PulseCount.ar(modX * signal, 0.95526516437531 * varW32Pilleuzgen31746159 * gateEnv);
varW32Pilleuzgen31746159 = FMGrainBBF.ar(modY, bufnum, gateEnv, in * varW32Pilleuzgen31746159, modX * modX, bufnum, gate, modZ * modY, DFM1.ar(wave * DC.ar(0.37264740467072), wave * DC.ar(0.13323032855988), wave * DC.ar(0.39999580383301), wave * DC.ar(0.59541928768158), wave * DC.ar(0.14437901973724), wave * DC.ar(0.22261810302734), wave * DC.ar(0.44111454486847), wave * DC.ar(0.6863112449646)), modX * wave, 0.99996597979679 * signal * gateEnv, Silent.ar());
varW32Pilleuzgen317461510 = IEnvGen.ar(in, modZ, Slew.ar(wave * DC.ar(0.54671514034271), wave * DC.ar(0.073446989059448), wave * DC.ar(0.88251805305481), wave * DC.ar(0.79798030853271), wave * DC.ar(0.88374447822571)), Silent.ar());

signal = varW32Pilleuzgen317461510;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// NRLG174615
/////////////////////////////////////////////////////////

SynthDef.new("NRLG174615", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varNRLG1746159;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varNRLG1746159 = K2A.ar(t_trig).dup;
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
varNRLG1746159 = Dust2.ar(island, 0.16009713151444 * varNRLG1746159, WrapIndex.ar(wave * DC.ar(0.40070009231567), wave * DC.ar(0.012580275535583), wave * DC.ar(0.90660059452057), wave * DC.ar(0.72835445404053)));
varNRLG1746159 = SpruceBudworm.ar(wave * DC.ar(0.61700129508972), wave * DC.ar(0.78170621395111), wave * DC.ar(0.0048263072967529), wave * DC.ar(0.58228898048401), wave * DC.ar(0.89522445201874), wave * DC.ar(0.87961339950562), wave * DC.ar(0.51884531974792), wave * DC.ar(0.21936118602753), wave * DC.ar(0.34211683273315), wave * DC.ar(0.61569023132324), wave * DC.ar(0.1902107000351), wave * DC.ar(0.47962439060211));

signal = varNRLG1746159;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// W32.Forever.B.Worm174617
/////////////////////////////////////////////////////////

SynthDef.new("W32.Forever.B.Worm174617", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varW32ForeverBWorm1746179, varW32ForeverBWorm17461710;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varW32ForeverBWorm1746179 = varW32ForeverBWorm17461710 = K2A.ar(t_trig).dup;
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
varW32ForeverBWorm1746179 = Dust2.ar(signal * gateEnv, Amplitude.ar(wave * DC.ar(0.032560348510742), wave * DC.ar(0.76165366172791), wave * DC.ar(0.11059272289276), wave * DC.ar(0.69699609279633), wave * DC.ar(0.320840716362)), Silent.ar());
varW32ForeverBWorm17461710 = Fold.ar(0.82253861427307 * modY * env, gate, varW32ForeverBWorm17461710 * env);
varW32ForeverBWorm1746179 = NLFiltN.ar(bufnum, in * in, modY, modY, signal, varW32ForeverBWorm1746179 * signal, 0.99055167201753 * wave * varW32ForeverBWorm1746179, Silent.ar());
varW32ForeverBWorm17461710 = VOSIM.ar(wave * varW32ForeverBWorm17461710, modZ * wave, NLFiltL.ar(wave * DC.ar(0.65290212631226), wave * DC.ar(0.49330770969391), wave * DC.ar(0.52134275436401), wave * DC.ar(0.55885970592499), wave * DC.ar(0.20097470283508), wave * DC.ar(0.76803529262543), wave * DC.ar(0.15120947360992), wave * DC.ar(0.14519023895264)), bufnum, 0.99985043645872 * modY * signal, Silent.ar().fold2(TBrownRand.ar(wave * DC.ar(0.83621120452881), wave * DC.ar(0.84580934047699), wave * DC.ar(0.50108659267426), wave * DC.ar(0.74730777740479), wave * DC.ar(0.5106840133667), wave * DC.ar(0.87986159324646), wave * DC.ar(0.46977710723877))));

signal = varW32ForeverBWorm17461710;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// Lamah.563(3)174617
/////////////////////////////////////////////////////////

SynthDef.new("Lamah.563(3)174617", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varLamah56331746179, varLamah563317461710;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varLamah56331746179 = varLamah563317461710 = K2A.ar(t_trig).dup;
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
varLamah56331746179 = PosRatio.ar(env * modY, varLamah563317461710 * in, env * signal);
varLamah563317461710 = HPF.ar(in, VarSaw.ar(wave * DC.ar(0.92810475826263), wave * DC.ar(0.015505075454712), wave * DC.ar(0.47757339477539), wave * DC.ar(0.64604353904724), wave * DC.ar(0.52905797958374)).exprange(1, SampleRate.ir), 0.99937686894159 * in * gateEnv, Silent.ar());
varLamah56331746179 = DegreeToKey.ar(Array.fill(2.pow(15), { |i| rrand(-1, 1) }).as(LocalBuf), island, modZ, 0.99763021753643 * varLamah563317461710, Silent.ar());
varLamah563317461710 = LorenzL.ar(env, signal * signal, wave * modY, signal, z, t_trig, PVInfo.ar(Array.fill(2.pow(11), { |i| rrand(-1, 1) }).as(LocalBuf), WaveletDaub.ar(wave * DC.ar(0.054990768432617), wave * DC.ar(0.26460695266724), wave * DC.ar(0.55041086673737), wave * DC.ar(0.30199801921844), wave * DC.ar(0.82541632652283)), 0.47273337841034 * modZ * varLamah56331746179, modX, FoaPushX.ar(wave * DC.ar(0.49358463287354), wave * DC.ar(0.025791645050049), wave * DC.ar(0.65108871459961), wave * DC.ar(0.079339027404785))), x, 0.99910496414673 * signal * in, Silent.ar());

signal = varLamah563317461710;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// Champaigne.445174618
/////////////////////////////////////////////////////////

SynthDef.new("Champaigne.445174618", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varChampaigne4451746189, varChampaigne44517461810, varChampaigne44517461811;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varChampaigne4451746189 = varChampaigne44517461810 = varChampaigne44517461811 = K2A.ar(t_trig).dup;
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
varChampaigne4451746189 = BLBufRd.ar(Array.fill(2.pow(11), { |i| rrand(-1, 1) }).as(LocalBuf), gateEnv * gateEnv, modY * varChampaigne4451746189);
varChampaigne44517461810 = FSinOsc.ar(modY * signal, varChampaigne44517461811 * modY, wave, Silent.ar());
varChampaigne44517461811 = OffsetOut.ar((80 + (island * 2)), [IFFT.ar(wave * DC.ar(0.6525102853775), wave * DC.ar(0.7475608587265), wave * DC.ar(0.33755457401276)), BBandPass.ar(wave * DC.ar(0.30870938301086), wave * DC.ar(0.42115890979767), wave * DC.ar(0.52055954933167), wave * DC.ar(0.96876072883606), wave * DC.ar(0.71676170825958))]);
varChampaigne4451746189 = Oregonator.ar(varChampaigne4451746189, varChampaigne44517461810, signal * in, varChampaigne4451746189, gateEnv * modY, amp, modZ * signal, wave, 0.42515218636133 * FMHDecode1.ar(wave * DC.ar(0.107173204422), wave * DC.ar(0.0025625228881836), wave * DC.ar(0.66042518615723), wave * DC.ar(0.63031721115112), wave * DC.ar(0.29764306545258), wave * DC.ar(0.74280250072479), wave * DC.ar(0.40316879749298), wave * DC.ar(0.6269246339798), wave * DC.ar(0.48333311080933), wave * DC.ar(0.74298703670502), wave * DC.ar(0.2685604095459), wave * DC.ar(0.16658961772919), wave * DC.ar(0.71061706542969)).exprange(wave * DC.ar(0.92356145381927), wave * DC.ar(0.51561522483826)), Silent.ar());
varChampaigne44517461810 = LatoocarfianN.ar(varChampaigne44517461810 * modY, wave, in * gateEnv, MembraneHexagon.ar(signal, Atari2600.ar(wave * DC.ar(0.39480030536652), wave * DC.ar(0.34715807437897), wave * DC.ar(0.43987381458282), wave * DC.ar(0.050295114517212), wave * DC.ar(0.68488395214081), wave * DC.ar(0.59300708770752), wave * DC.ar(0.86109864711761)), in * in, wave, Silent.ar()), signal * varChampaigne44517461810, signal * in, varChampaigne44517461810, 0.99993486073645 * varChampaigne44517461810 * varChampaigne4451746189, Silent.ar());
varChampaigne44517461811 = OSWrap8.ar(0.85572290420532 * env * wave, modY, modX);

signal = varChampaigne44517461811;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// Champaigne.4451746181
/////////////////////////////////////////////////////////

SynthDef.new("Champaigne.4451746181", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varChampaigne4451746189, varChampaigne44517461810, varChampaigne44517461811, varChampaigne445174618112, varChampaigne445174618113, varChampaigne445174618114, varChampaigne445174618115, varChampaigne445174618116;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varChampaigne4451746189 = varChampaigne44517461810 = varChampaigne44517461811 = varChampaigne445174618112 = varChampaigne445174618113 = varChampaigne445174618114 = varChampaigne445174618115 = varChampaigne445174618116 = K2A.ar(t_trig).dup;
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
varChampaigne4451746189 = BFEncodeSter.ar(signal * varChampaigne44517461810, varChampaigne445174618116, varChampaigne4451746189, wave, gate, varChampaigne445174618112 * env, modX, env * wave);
varChampaigne44517461810 = SN76489.ar(modZ * in, bufnum, wave, modZ, varChampaigne445174618113 * varChampaigne445174618113, island, 0.95997333526611 * varChampaigne4451746189, varChampaigne445174618116, varChampaigne44517461810 * modZ);
varChampaigne44517461811 = LPCVals.ar(Array.fill(2.pow(12), { |i| rrand(-1, 1) }).as(LocalBuf), bufnum.lincurve(wave * DC.ar(0.25137412548065), wave * DC.ar(0.49728906154633), wave * DC.ar(0.94813549518585), wave * DC.ar(0.19461071491241), wave * DC.ar(0.042416214942932), wave * DC.ar(0.071954488754272)));
varChampaigne4451746189 = OneZero.ar(varChampaigne445174618114, gateEnv, 0.98099314550916 * wave * varChampaigne445174618114, Silent.ar());
varChampaigne44517461810 = AmplitudeMod.ar(wave * DC.ar(0.096652746200562), wave * DC.ar(0.49810600280762), wave * DC.ar(0.015659332275391), wave * DC.ar(0.65337669849396), wave * DC.ar(0.96630442142487));
varChampaigne44517461811 = Pan2.ar(z, amp, varChampaigne4451746189 * signal);
// Variation test code
varChampaigne445174618112 = DetectSilence.ar(signal * signal, Friction.ar(t_trig, Timer.ar(varChampaigne44517461810 * DC.ar(0.93734002113342)), 0.12216448783875 * varChampaigne445174618115 * varChampaigne445174618112, modY, wave * modY, varChampaigne445174618116 * varChampaigne44517461810, wave, Silent.ar()), gateEnv, y);
varChampaigne445174618113 = FoaDominateX.ar(y, varChampaigne445174618115 * gateEnv, modZ, Silent.ar());
varChampaigne445174618114 = WhiteNoise.ar(0.94301811803962 * modZ * in, Silent.ar());
varChampaigne445174618115 = OnePole.ar(varChampaigne4451746189, modY, 0.99996119126116 * modY * varChampaigne445174618112, Silent.ar());
varChampaigne445174618116 = FoaPressZ.ar(varChampaigne44517461811, varChampaigne445174618115, 0.99748755207302 * signal * modZ, Silent.ar());
varChampaigne445174618112 = Friction.ar(varChampaigne445174618114 * varChampaigne445174618114, wave * modY, StkBowed.ar(varChampaigne4451746189 * varChampaigne445174618116, modZ * modZ, amp, gateEnv * varChampaigne445174618112, x, island, gateEnv, varChampaigne44517461810 * signal, varChampaigne44517461810 * env, HilbertFIR.ar(varChampaigne4451746189 * DC.ar(0.11821055412292), varChampaigne44517461810 * DC.ar(0.20499897003174)), Silent.ar()), modZ * in.lag2ud(varChampaigne4451746189 * DC.ar(0.30753993988037), varChampaigne44517461810 * DC.ar(0.088406682014465)), modY * modZ, 0.32775056362152 * env * varChampaigne445174618114, 0.99647005797028 * in * varChampaigne445174618113, Silent.ar());
varChampaigne445174618113 = Rotate2.ar(modX * varChampaigne4451746189, varChampaigne445174618113 * env, varChampaigne44517461811 * varChampaigne4451746189);
varChampaigne445174618114 = K2A.ar(modY * in);
varChampaigne445174618115 = Fhn2DC.ar(varChampaigne445174618116, env * varChampaigne44517461811, Fold.ar(gate, varChampaigne44517461810 * varChampaigne44517461810, gate), modY, varChampaigne445174618115, varChampaigne445174618112 * varChampaigne445174618116, varChampaigne445174618113 * modZ, varChampaigne445174618114 * in, t_trig, LinCongC.ar(varChampaigne44517461810 * DC.ar(0.87946128845215), varChampaigne44517461810 * DC.ar(0.88857638835907), varChampaigne44517461811 * DC.ar(0.058552384376526), varChampaigne4451746189 * DC.ar(0.058923244476318), varChampaigne4451746189 * DC.ar(0.27212524414062), varChampaigne44517461810 * DC.ar(0.62819314002991), varChampaigne4451746189 * DC.ar(0.42261898517609)), Silent.ar());
varChampaigne445174618116 = BBlockerBuf.ar(LinCongN.ar(varChampaigne44517461810 * DC.ar(0.98737132549286), varChampaigne4451746189 * DC.ar(0.86084258556366), varChampaigne4451746189 * DC.ar(0.12165868282318), varChampaigne4451746189 * DC.ar(0.29145431518555), varChampaigne44517461810 * DC.ar(0.72120797634125), varChampaigne4451746189 * DC.ar(0.77164816856384), varChampaigne4451746189 * DC.ar(0.30966639518738)).exprange(1, SampleRate.ir), Array.fill(2.pow(14), { |i| rrand(-1, 1) }).as(LocalBuf), varChampaigne44517461810);
varChampaigne445174618112 = MembraneCircle.ar(varChampaigne4451746189, varChampaigne44517461811 * varChampaigne445174618112, varChampaigne445174618112 * modZ, 0.99340929824859 * varChampaigne4451746189, Silent.ar());
varChampaigne445174618113 = TGrains.ar(2, varChampaigne445174618112 * env, Array.fill(2.pow(10), { |i| rrand(-1, 1) }).as(LocalBuf).excess(Wrap.ar(varChampaigne4451746189 * DC.ar(0.83301305770874), varChampaigne44517461810 * DC.ar(0.70181500911713), varChampaigne4451746189 * DC.ar(0.34935545921326))), varChampaigne445174618113, in * varChampaigne44517461810, 0.35085332393646 * varChampaigne4451746189 * gateEnv, PanX2D.ar(2, 2, varChampaigne44517461810, z, bufnum, gateEnv * varChampaigne44517461810, in * gateEnv, island), varChampaigne445174618116 * varChampaigne445174618115, varChampaigne445174618113);
varChampaigne445174618114 = Gendy4.ar(varChampaigne4451746189, modZ * modZ, varChampaigne445174618112, modY * modZ, varChampaigne445174618113 * varChampaigne4451746189, gateEnv * varChampaigne44517461810, z, t_trig, varChampaigne445174618112 * modZ, bufnum, 0.9999876171395 * env * varChampaigne445174618112, Silent.ar());
varChampaigne445174618115 = LPCSynth.ar(Array.fill(2.pow(16), { |i| rrand(-1, 1) }).as(LocalBuf), varChampaigne4451746189, varChampaigne445174618113 * wave, 0.9988630831435 * wave * varChampaigne445174618113, Silent.ar());
varChampaigne445174618116 = SelectL.ar(t_trig, [PinkNoise.ar(varChampaigne44517461810 * DC.ar(0.65161430835724), varChampaigne44517461811 * DC.ar(0.77821326255798)), SinGrain.ar(varChampaigne4451746189 * DC.ar(0.24057912826538), varChampaigne44517461811 * DC.ar(0.91150307655334), varChampaigne4451746189 * DC.ar(0.51337039470673), varChampaigne4451746189 * DC.ar(0.53090679645538), varChampaigne44517461810 * DC.ar(0.96699523925781))]);

signal = varChampaigne445174618116;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// Trivial.173174619
/////////////////////////////////////////////////////////

SynthDef.new("Trivial.173174619", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varTrivial1731746199;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varTrivial1731746199 = K2A.ar(t_trig).dup;
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
varTrivial1731746199 = Brusselator.ar(x, TPV.ar(wave * DC.ar(0.54718339443207), wave * DC.ar(0.14131689071655), wave * DC.ar(0.26211941242218), wave * DC.ar(0.83502650260925), wave * DC.ar(0.26020705699921), wave * DC.ar(0.047286987304688), wave * DC.ar(0.45998978614807), wave * DC.ar(0.49465119838715), wave * DC.ar(0.82709753513336), wave * DC.ar(0.64291882514954)), env, signal * varTrivial1731746199, gateEnv * modX, in, 0.99730608831132 * signal, Silent.ar());
varTrivial1731746199 = Timer.ar(wave * DC.ar(0.11130499839783));

signal = varTrivial1731746199;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// WM.Colors.AX1746201
/////////////////////////////////////////////////////////

SynthDef.new("WM.Colors.AX1746201", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varWMColorsAX1746209, varWMColorsAX17462010, varWMColorsAX17462011, varWMColorsAX17462012, varWMColorsAX174620113, varWMColorsAX174620114;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varWMColorsAX1746209 = varWMColorsAX17462010 = varWMColorsAX17462011 = varWMColorsAX17462012 = varWMColorsAX174620113 = varWMColorsAX174620114 = K2A.ar(t_trig).dup;
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
varWMColorsAX1746209 = BufDelayN.ar(Array.fill(2.pow(16), { |i| rrand(-1, 1) }).as(LocalBuf), BFDecode1.ar(gateEnv * signal, modY, varWMColorsAX1746209, 0.32591831684113 * env, wave * env, modX, 0.38111019134521 * StkBowed.ar(wave * DC.ar(0.064780831336975), wave * DC.ar(0.08897340297699), wave * DC.ar(0.67177557945251), wave * DC.ar(0.1923201084137), wave * DC.ar(0.2203471660614), wave * DC.ar(0.86192893981934), wave * DC.ar(0.16723310947418), wave * DC.ar(0.53669595718384), wave * DC.ar(0.39138519763947), wave * DC.ar(0.33845746517181), wave * DC.ar(0.008615255355835)), 0.99995016882855 * varWMColorsAX1746209 * varWMColorsAX1746209, Silent.ar()), in * varWMColorsAX174620114, 0.99775786686927 * env * varWMColorsAX17462012, Silent.ar());
varWMColorsAX17462010 = LFBrownNoise0.ar(varWMColorsAX174620114, BufGrainBF.ar(in, varWMColorsAX17462011 * varWMColorsAX174620114, bufnum, island, gateEnv * varWMColorsAX17462010, amp, gateEnv, OSFold8.ar(wave * DC.ar(0.30275523662567), wave * DC.ar(0.049157619476318), wave * DC.ar(0.34755122661591)), wave, x, FoaPushX.ar(wave * DC.ar(0.43044459819794), wave * DC.ar(0.18978440761566), wave * DC.ar(0.97383606433868), wave * DC.ar(0.87153089046478)), Silent.ar()), x, modX, Silent.ar().leftShift(AtsFreq.ar(wave * DC.ar(0.23835480213165), wave * DC.ar(0.7521870136261), wave * DC.ar(0.92209255695343), wave * DC.ar(0.76651501655579), wave * DC.ar(0.1100549697876))));
varWMColorsAX17462011 = FoaPressZ.ar(varWMColorsAX17462010 * varWMColorsAX1746209, env * modX, BFEncodeSter.ar(wave * DC.ar(0.77515649795532), wave * DC.ar(0.98149979114532), wave * DC.ar(0.56899964809418), wave * DC.ar(0.67430198192596), wave * DC.ar(0.73138070106506), wave * DC.ar(0.091002702713013), wave * DC.ar(0.015305995941162), wave * DC.ar(0.82413959503174)), Silent.ar());
varWMColorsAX17462012 = GrayNoise.ar(0.99299683619568 * XOut.ar(wave * DC.ar(0.37674188613892), wave * DC.ar(0.24049377441406), wave * DC.ar(0.99965560436249)), Silent.ar());
varWMColorsAX1746209 = Henon2DN.ar(modY * signal, varWMColorsAX17462010 * varWMColorsAX17462011, varWMColorsAX17462012, varWMColorsAX174620113, varWMColorsAX174620114 * signal, modY * varWMColorsAX17462012, 0.9845586004039 * in * modY, Silent.ar());
varWMColorsAX17462010 = HilbertFIR.ar(modZ, Array.fill(2.pow(14), { |i| rrand(-1, 1) }).as(LocalBuf));
varWMColorsAX17462011 = Clip.ar(signal * signal, island, modX * varWMColorsAX174620113);
varWMColorsAX17462012 = ArrayMin.ar([NLFiltL.ar(wave * DC.ar(0.49166178703308), wave * DC.ar(0.52713346481323), wave * DC.ar(0.41558706760406), wave * DC.ar(0.23047387599945), wave * DC.ar(0.95448911190033), wave * DC.ar(0.71450340747833), wave * DC.ar(0.76533794403076), wave * DC.ar(0.4566056728363)), FincoSprottM.ar(wave * DC.ar(0.26001036167145), wave * DC.ar(0.93620884418488), wave * DC.ar(0.50335192680359), wave * DC.ar(0.40946471691132), wave * DC.ar(0.012630820274353), wave * DC.ar(0.61711525917053), wave * DC.ar(0.99645018577576), wave * DC.ar(0.18488264083862), wave * DC.ar(0.7398841381073))]);
// Variation test code
varWMColorsAX174620113 = PSinGrain.ar(varWMColorsAX174620114, bufnum, y);
varWMColorsAX174620114 = LPFVS6.ar(0.10179340839386 * varWMColorsAX1746209 * modX, varWMColorsAX17462011, LPF18.ar(varWMColorsAX17462011 * gateEnv, SoftClipAmp.ar(varWMColorsAX17462012 * DC.ar(0.71965444087982), varWMColorsAX17462011 * DC.ar(0.80978870391846), varWMColorsAX17462011 * DC.ar(0.98173677921295), varWMColorsAX17462010 * DC.ar(0.8208771944046)).exprange(1, SampleRate.ir), FMGrainI.ar(varWMColorsAX1746209 * DC.ar(0.54629302024841), varWMColorsAX17462010 * DC.ar(0.2126190662384), varWMColorsAX1746209 * DC.ar(0.046033978462219), varWMColorsAX17462012 * DC.ar(0.64383435249329), varWMColorsAX17462010 * DC.ar(0.54077923297882), varWMColorsAX1746209 * DC.ar(0.71403229236603), varWMColorsAX17462010 * DC.ar(0.064985513687134), varWMColorsAX17462012 * DC.ar(0.46677386760712), varWMColorsAX17462011 * DC.ar(0.20831382274628), varWMColorsAX1746209 * DC.ar(0.82129561901093)), Convolution2L.ar(varWMColorsAX17462011 * DC.ar(0.79190993309021), varWMColorsAX17462010 * DC.ar(0.83790123462677), varWMColorsAX1746209 * DC.ar(0.038777828216553), varWMColorsAX17462010 * DC.ar(0.21200144290924), varWMColorsAX17462010 * DC.ar(0.29060244560242), varWMColorsAX17462012 * DC.ar(0.70926332473755), varWMColorsAX17462011 * DC.ar(0.29149079322815))).bitOr(Balance.ar(varWMColorsAX17462012 * DC.ar(0.57771265506744), varWMColorsAX17462010 * DC.ar(0.16002547740936), varWMColorsAX17462011 * DC.ar(0.25008237361908), varWMColorsAX17462010 * DC.ar(0.91251039505005), varWMColorsAX17462012 * DC.ar(0.2825710773468), varWMColorsAX1746209 * DC.ar(0.52216410636902))));
varWMColorsAX174620113 = TGrains.ar(2, varWMColorsAX17462011 * modX, Array.fill(2.pow(11), { |i| rrand(-1, 1) }).as(LocalBuf), modX * varWMColorsAX174620114, varWMColorsAX17462010 * varWMColorsAX17462011, signal, varWMColorsAX17462011 * signal, island, 0.97649037837982 * varWMColorsAX17462011 * varWMColorsAX17462010);
varWMColorsAX174620114 = Rotate2.ar(gateEnv * env, varWMColorsAX174620113 * varWMColorsAX174620114, varWMColorsAX17462010 * wave);
varWMColorsAX174620113 = GravityGrid.ar(varWMColorsAX17462012, varWMColorsAX174620113 * modZ, varWMColorsAX17462011 * env, varWMColorsAX174620113 * gateEnv, Array.fill(2.pow(10), { |i| rrand(-1, 1) }).as(LocalBuf), 0.99468485241104 * varWMColorsAX174620113 * varWMColorsAX17462010, Silent.ar());
varWMColorsAX174620114 = QuadN.ar(Vibrato.ar(varWMColorsAX17462011 * DC.ar(0.21474468708038), varWMColorsAX17462012 * DC.ar(0.95126748085022), varWMColorsAX1746209 * DC.ar(0.99097299575806), varWMColorsAX17462010 * DC.ar(0.18654680252075), varWMColorsAX17462011 * DC.ar(0.46173989772797), varWMColorsAX17462011 * DC.ar(0.32201302051544), varWMColorsAX1746209 * DC.ar(0.34317004680634), varWMColorsAX17462011 * DC.ar(0.59205615520477)).exprange(1, SampleRate.ir), modX * varWMColorsAX17462010, env, varWMColorsAX1746209 * varWMColorsAX17462010, FoaDominateX.ar(gateEnv * modZ, wave * varWMColorsAX174620114, in, Silent.ar()), QuadL.ar(varWMColorsAX17462010 * DC.ar(0.65136134624481), varWMColorsAX17462012 * DC.ar(0.6510796546936), varWMColorsAX1746209 * DC.ar(0.29534637928009), varWMColorsAX17462011 * DC.ar(0.22262561321259), varWMColorsAX17462012 * DC.ar(0.21327114105225), varWMColorsAX1746209 * DC.ar(0.6228893995285), varWMColorsAX17462011 * DC.ar(0.022457957267761)), ClipNoise.ar(varWMColorsAX17462010 * DC.ar(0.055295467376709), varWMColorsAX17462010 * DC.ar(0.30411338806152)));

signal = varWMColorsAX174620114;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// StinkFoot.2.B174620
/////////////////////////////////////////////////////////

SynthDef.new("StinkFoot.2.B174620", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varStinkFoot2B1746209;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varStinkFoot2B1746209 = K2A.ar(t_trig).dup;
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
varStinkFoot2B1746209 = Median.ar(x, gate.range(wave * DC.ar(0.69367218017578), wave * DC.ar(0.20688033103943)), 0.78420880990043 * MembraneCircle.ar(wave * DC.ar(0.3047708272934), wave * DC.ar(0.94670760631561), wave * DC.ar(0.42124533653259), wave * DC.ar(0.41467344760895), wave * DC.ar(0.98259007930756)), Silent.ar());
varStinkFoot2B1746209 = NL.ar(x, Array.fill(2.pow(15), { |i| rrand(-1, 1) }).as(LocalBuf), Array.fill(2.pow(12), { |i| rrand(-1, 1) }).as(LocalBuf), FoaZoomY.ar(wave * DC.ar(0.94023704528809), wave * DC.ar(0.47859847545624), wave * DC.ar(0.69584822654724), wave * DC.ar(0.52628350257874)), Crackle.ar(wave * DC.ar(0.32070636749268), wave * DC.ar(0.56359004974365), wave * DC.ar(0.72032642364502)), BFEncode2.ar(wave * DC.ar(0.39065456390381), wave * DC.ar(0.51158595085144), wave * DC.ar(0.85117375850677), wave * DC.ar(0.95154452323914), wave * DC.ar(0.46951675415039), wave * DC.ar(0.46677374839783)), Silent.ar());

signal = varStinkFoot2B1746209;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// StinkFoot.2.B1746201
/////////////////////////////////////////////////////////

SynthDef.new("StinkFoot.2.B1746201", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varStinkFoot2B1746209, varStinkFoot2B174620110, varStinkFoot2B174620111;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varStinkFoot2B1746209 = varStinkFoot2B174620110 = varStinkFoot2B174620111 = K2A.ar(t_trig).dup;
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
varStinkFoot2B1746209 = SelectL.ar(env, [Poll.ar(wave * DC.ar(0.36207473278046), wave * DC.ar(0.70253455638885), wave * DC.ar(0.60089945793152), wave * DC.ar(0.20322215557098)), Resonz.ar(wave * DC.ar(0.29045701026917), wave * DC.ar(0.92531168460846), wave * DC.ar(0.0035054683685303), wave * DC.ar(0.53553986549377), wave * DC.ar(0.63130676746368))].blend(wave * DC.ar(0.95168888568878), wave * DC.ar(0.38267302513123)));
varStinkFoot2B1746209 = Slub.ar(SoftClipAmp4.ar(wave * DC.ar(0.073638796806335), wave * DC.ar(0.56688034534454), wave * DC.ar(0.59273242950439), wave * DC.ar(0.9395170211792)), signal * gateEnv);
// Variation test code
varStinkFoot2B174620110 = Lorenz2DN.ar(Trig1.ar(varStinkFoot2B1746209 * DC.ar(0.58158612251282), varStinkFoot2B1746209 * DC.ar(0.54992258548737)).exprange(1, SampleRate.ir), env, modX * modY, modY, signal * wave, 0.28200900554657 * env * env, env.unipolar(varStinkFoot2B1746209 * DC.ar(0.087013244628906)), signal * varStinkFoot2B174620110, modY * env, 0.86701058959944 * modY * varStinkFoot2B174620110, Silent.ar());
varStinkFoot2B174620111 = Henon2DN.ar(modZ, in * varStinkFoot2B1746209, signal * modY, island, amp, gate, 0.99995274835383 * SoftClipAmp8.ar(varStinkFoot2B1746209 * DC.ar(0.38816106319427), varStinkFoot2B1746209 * DC.ar(0.26948213577271), varStinkFoot2B1746209 * DC.ar(0.19020080566406), varStinkFoot2B1746209 * DC.ar(0.062005043029785)), YigCliffordC.ar(varStinkFoot2B1746209 * DC.ar(0.81375586986542), varStinkFoot2B1746209 * DC.ar(0.41104257106781), varStinkFoot2B1746209 * DC.ar(0.36264932155609), varStinkFoot2B1746209 * DC.ar(0.30989301204681), varStinkFoot2B1746209 * DC.ar(0.37626087665558), varStinkFoot2B1746209 * DC.ar(0.61391067504883), varStinkFoot2B1746209 * DC.ar(0.89025092124939), varStinkFoot2B1746209 * DC.ar(0.71700656414032), varStinkFoot2B1746209 * DC.ar(0.5630886554718)));
varStinkFoot2B174620110 = WhiteNoise.ar(in, Silent.ar());
varStinkFoot2B174620111 = SinOscFB.ar(signal * wave, island, env, Silent.ar());
varStinkFoot2B174620110 = FoaPressY.ar(env, gateEnv, LatoocarfianL.ar(varStinkFoot2B1746209 * DC.ar(0.13663184642792), varStinkFoot2B1746209 * DC.ar(0.19915986061096), varStinkFoot2B1746209 * DC.ar(0.47071945667267), varStinkFoot2B1746209 * DC.ar(0.20813655853271), varStinkFoot2B1746209 * DC.ar(0.7007611989975), varStinkFoot2B1746209 * DC.ar(0.40958762168884), varStinkFoot2B1746209 * DC.ar(0.45822131633759), varStinkFoot2B1746209 * DC.ar(0.59212303161621), varStinkFoot2B1746209 * DC.ar(0.019575953483582)), Silent.ar());
varStinkFoot2B174620111 = Dust.ar(0.34205496311188 * modZ * modZ, modZ, Silent.ar());

signal = varStinkFoot2B174620111;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// VBS.Aphex174620
/////////////////////////////////////////////////////////

SynthDef.new("VBS.Aphex174620", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varVBSAphex1746209, varVBSAphex17462010;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varVBSAphex1746209 = varVBSAphex17462010 = K2A.ar(t_trig).dup;
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
varVBSAphex1746209 = Henon2DN.ar(BBandPass.ar(wave * DC.ar(0.33544421195984), wave * DC.ar(0.068459510803223), wave * DC.ar(0.059982776641846), wave * DC.ar(0.38722538948059), wave * DC.ar(0.30703508853912)).exprange(1, SampleRate.ir), wave * varVBSAphex1746209, gate, gateEnv * varVBSAphex17462010, in * varVBSAphex17462010.expexp(wave * DC.ar(0.80352067947388), wave * DC.ar(0.77191472053528), wave * DC.ar(0.49434590339661), wave * DC.ar(0.45530271530151), wave * DC.ar(0.67050886154175)), varVBSAphex1746209 * varVBSAphex17462010, 0.99965469040768 * modZ * wave, Silent.ar());
varVBSAphex17462010 = DoubleWell3.ar(in * in, env * gateEnv, signal, varVBSAphex17462010, varVBSAphex1746209 * modZ, gateEnv * varVBSAphex1746209, Breakcore.ar(wave * DC.ar(0.86423683166504), wave * DC.ar(0.11175215244293), wave * DC.ar(0.90800261497498), wave * DC.ar(0.74520993232727), wave * DC.ar(0.051822662353516)), Silent.ar());
varVBSAphex1746209 = APF.ar(modZ, Ramp.ar(wave * DC.ar(0.38463819026947), wave * DC.ar(0.93834495544434), wave * DC.ar(0.36188292503357), wave * DC.ar(0.3359797000885)).exprange(1, SampleRate.ir), env, 0.94094580729546 * env * in, Silent.ar());
varVBSAphex17462010 = MarkovSynth.ar(0.22865355014801 * varVBSAphex1746209 * wave, 0.33861565589905 * signal * modX, gateEnv * wave, y);

signal = varVBSAphex17462010;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// FCL.2044174621
/////////////////////////////////////////////////////////

SynthDef.new("FCL.2044174621", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varFCL20441746219, varFCL204417462110, varFCL204417462111, varFCL204417462112;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varFCL20441746219 = varFCL204417462110 = varFCL204417462111 = varFCL204417462112 = K2A.ar(t_trig).dup;
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
varFCL20441746219 = LPCError.ar(varFCL204417462112 * varFCL204417462112, 0.67911028862 * varFCL204417462112 * varFCL204417462112, 0.9999840877315 * BufGrainI.ar(wave * DC.ar(0.98350155353546), wave * DC.ar(0.85852932929993), wave * DC.ar(0.89437031745911), wave * DC.ar(0.042834758758545), wave * DC.ar(0.51647317409515), wave * DC.ar(0.95723009109497), wave * DC.ar(0.87121570110321), wave * DC.ar(0.35454833507538), wave * DC.ar(0.78290176391602), wave * DC.ar(0.32072639465332), wave * DC.ar(0.48062109947205)), Silent.ar());
varFCL204417462110 = HenonL.ar(StkBlowHole.ar(wave * DC.ar(0.3586984872818), wave * DC.ar(0.46228814125061), wave * DC.ar(0.95566177368164), wave * DC.ar(0.79692542552948), wave * DC.ar(0.55723989009857), wave * DC.ar(0.60386180877686), wave * DC.ar(0.77064800262451), wave * DC.ar(0.98602497577667)).exprange(1, SampleRate.ir), modZ * modY, in, signal, varFCL204417462112, Clip.ar(wave * DC.ar(0.029257297515869), wave * DC.ar(0.17736148834229), wave * DC.ar(0.25601840019226)), Silent.ar());
varFCL204417462111 = ArrayMin.ar([CompanderD.ar(wave * DC.ar(0.6227331161499), wave * DC.ar(0.68286466598511), wave * DC.ar(0.17859053611755), wave * DC.ar(0.77835595607758), wave * DC.ar(0.61084794998169), wave * DC.ar(0.14316439628601), wave * DC.ar(0.51223754882812), wave * DC.ar(0.33253479003906)), BufGrainIBF.ar(wave * DC.ar(0.65731966495514), wave * DC.ar(0.67575252056122), wave * DC.ar(0.11497223377228), wave * DC.ar(0.46706485748291), wave * DC.ar(0.04223644733429), wave * DC.ar(0.045344233512878), wave * DC.ar(0.69985330104828), wave * DC.ar(0.81642508506775), wave * DC.ar(0.63857018947601), wave * DC.ar(0.78999626636505), wave * DC.ar(0.24169397354126), wave * DC.ar(0.22038817405701), wave * DC.ar(0.78698754310608), wave * DC.ar(0.36246430873871), wave * DC.ar(0.97665143013))]);
varFCL204417462112 = Lag.ar(signal * modX, wave, 0.99998754891047 * varFCL204417462112 * wave, Silent.ar());
varFCL20441746219 = BRZ2.ar(varFCL204417462112, 0.99998936555591 * varFCL204417462112 * in, Silent.ar());
varFCL204417462110 = FoaTumble.ar(0.31946742534637 * KmeansToBPSet1.ar(wave * DC.ar(0.41547524929047), wave * DC.ar(0.53977286815643), wave * DC.ar(0.20234477519989), wave * DC.ar(0.67961382865906), wave * DC.ar(0.67417800426483), wave * DC.ar(0.39960813522339), wave * DC.ar(0.59560191631317), wave * DC.ar(0.88843953609467), wave * DC.ar(0.083301663398743), wave * DC.ar(0.8795417547226)), varFCL204417462112 * gateEnv, 0.9990905330463 * wave * varFCL204417462112, Silent.ar());
varFCL204417462111 = TwoPole.ar(varFCL20441746219, modX * in, 0.3161336183548 * modY * varFCL204417462112, 0.95107045257353 * modX * in.exprange(wave * DC.ar(0.2726081609726), wave * DC.ar(0.94881868362427)), Silent.ar());
varFCL204417462112 = FoaNFC.ar(wave * DC.ar(0.8470184803009), wave * DC.ar(0.20050799846649), wave * DC.ar(0.85990762710571), wave * DC.ar(0.37503206729889));

signal = varFCL204417462112;
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
varWhitey1746229 = DoubleWell2.ar(z, x, x, modY * wave, varWhitey1746229.gcd(BufGrainBBF.ar(wave * DC.ar(0.41559541225433), wave * DC.ar(0.26944899559021), wave * DC.ar(0.27266442775726), wave * DC.ar(0.59751307964325), wave * DC.ar(0.069399118423462), wave * DC.ar(0.36663901805878), wave * DC.ar(0.1769415140152), wave * DC.ar(0.3077152967453), wave * DC.ar(0.9012907743454), wave * DC.ar(0.95442759990692), wave * DC.ar(0.69382750988007), wave * DC.ar(0.25538218021393), wave * DC.ar(0.13940584659576))), in * modZ, in, env, 0.95634301399457 * in * in, Silent.ar());
varWhitey17462210 = BBandStop.ar(y, signal * in, SinGrain.ar(modY * modY, z, FSinOsc.ar(wave * DC.ar(0.11727023124695), wave * DC.ar(0.58982181549072), wave * DC.ar(0.59484720230103), wave * DC.ar(0.44105982780457)).exprange(1, SampleRate.ir), Stepper.ar(wave * DC.ar(0.84831595420837), wave * DC.ar(0.71499347686768), wave * DC.ar(0.4348578453064), wave * DC.ar(0.55864524841309), wave * DC.ar(0.50092339515686), wave * DC.ar(0.82441711425781)), Atari2600.ar(wave * DC.ar(0.64605057239532), wave * DC.ar(0.82487964630127), wave * DC.ar(0.43744003772736), wave * DC.ar(0.078419804573059), wave * DC.ar(0.93294966220856), wave * DC.ar(0.31238901615143), wave * DC.ar(0.90780973434448))), FSinOsc.ar(wave * DC.ar(0.26759302616119), wave * DC.ar(0.96864783763885), wave * DC.ar(0.24364054203033), wave * DC.ar(0.49881160259247)), Silent.ar());
varWhitey1746229 = YigClifford3DN.ar(LFBrownNoise1.ar(wave * DC.ar(0.50349497795105), wave * DC.ar(0.72244954109192), wave * DC.ar(0.010698437690735), wave * DC.ar(0.54242789745331), wave * DC.ar(0.95562553405762)).exprange(1, SampleRate.ir), signal, y, wave * signal, 0.51280474662781 * wave * modZ, modY, signal, modZ * wave, 0.99975444162577 * modX * in, Silent.ar());
varWhitey17462210 = GbmanL.ar(wave * DC.ar(0.35945796966553), wave * DC.ar(0.015637397766113), wave * DC.ar(0.040817618370056), wave * DC.ar(0.69066298007965), wave * DC.ar(0.37221038341522));

signal = varWhitey17462210;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// No174623
/////////////////////////////////////////////////////////

SynthDef.new("No174623", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varNo1746239;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varNo1746239 = K2A.ar(t_trig).dup;
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
varNo1746239 = DelTapWr.ar(Array.fill(2.pow(11), { |i| rrand(-1, 1) }).as(LocalBuf), Atari2600.ar(wave * DC.ar(0.72897446155548), wave * DC.ar(0.081536769866943), wave * DC.ar(0.033486247062683), wave * DC.ar(0.137091755867), wave * DC.ar(0.066311597824097), wave * DC.ar(0.35178351402283), wave * DC.ar(0.55900967121124)));
varNo1746239 = TGrains2.ar(2, gateEnv * signal, Array.fill(2.pow(14), { |i| rrand(-1, 1) }).as(LocalBuf), varNo1746239 * in, 0.72468459606171 * SoftClipper4.ar(wave * DC.ar(0.41480505466461)), modX, 0.58298099040985 * modX * wave, bufnum, modZ * signal, FBSineN.ar(wave * DC.ar(0.71522867679596), wave * DC.ar(0.12923264503479), wave * DC.ar(0.0087615251541138), wave * DC.ar(0.36813938617706), wave * DC.ar(0.10825109481812), wave * DC.ar(0.9310177564621), wave * DC.ar(0.49132990837097), wave * DC.ar(0.58749997615814), wave * DC.ar(0.73449563980103)), modX * modY);

signal = varNo1746239;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// Omud174623
/////////////////////////////////////////////////////////

SynthDef.new("Omud174623", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varOmud1746239, varOmud17462310, varOmud17462311, varOmud17462312;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varOmud1746239 = varOmud17462310 = varOmud17462311 = varOmud17462312 = K2A.ar(t_trig).dup;
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
varOmud1746239 = FoaPushX.ar(signal, modZ.linexp(wave * DC.ar(0.84043323993683), wave * DC.ar(0.21651220321655), wave * DC.ar(0.64640772342682), wave * DC.ar(0.78338944911957), wave * DC.ar(0.78807270526886)), wave, Silent.ar());
varOmud17462310 = AmpComp.ar(FoaPanB.ar(wave * DC.ar(0.67594707012177), wave * DC.ar(0.45592141151428), wave * DC.ar(0.52594864368439), wave * DC.ar(0.71126413345337), wave * DC.ar(0.23231792449951)).exprange(1, SampleRate.ir), gateEnv * varOmud17462310, t_trig);
varOmud17462311 = PlayBuf.ar(2, Array.fill(2.pow(15), { |i| rrand(-1, 1) }).as(LocalBuf), amp, varOmud17462310 * modZ, gateEnv * wave.clip2(FoaDirectX.ar(wave * DC.ar(0.55511748790741), wave * DC.ar(0.58802175521851), wave * DC.ar(0.8241400718689), wave * DC.ar(0.92309021949768))), 0.82058238983154 * varOmud17462311 * env, varOmud17462312 * gateEnv);
varOmud17462312 = Crackle.ar(wave * varOmud1746239, modZ, Silent.ar());
varOmud1746239 = Convolution.ar(modY, modY, signal, Breakcore.ar(wave * DC.ar(0.20400154590607), wave * DC.ar(0.99932706356049), wave * DC.ar(0.1147723197937), wave * DC.ar(0.0076907873153687), wave * DC.ar(0.22249901294708)), Silent.ar());
varOmud17462310 = SVF.ar(wave * DC.ar(0.6054402589798), wave * DC.ar(0.55348384380341), wave * DC.ar(0.92921328544617), wave * DC.ar(0.39399933815002), wave * DC.ar(0.046202063560486), wave * DC.ar(0.33740592002869), wave * DC.ar(0.52709257602692), wave * DC.ar(0.86106979846954), wave * DC.ar(0.11210978031158), wave * DC.ar(0.28463876247406));
varOmud17462311 = InGrainB.ar(wave * DC.ar(0.066737413406372), wave * DC.ar(0.76513600349426), wave * DC.ar(0.97491228580475), wave * DC.ar(0.42068088054657), wave * DC.ar(0.086920261383057), wave * DC.ar(0.31130158901215));
varOmud17462312 = RegaliaMitraEQ.ar(amp, AtsPartial.ar(wave * DC.ar(0.25080275535583), wave * DC.ar(0.52218568325043), wave * DC.ar(0.36707007884979), wave * DC.ar(0.26467275619507), wave * DC.ar(0.71367037296295), wave * DC.ar(0.96635127067566), wave * DC.ar(0.53695726394653)).exprange(1, SampleRate.ir), t_trig, gate, SoftClipAmp4.ar(wave * DC.ar(0.44250690937042), wave * DC.ar(0.93406188488007), wave * DC.ar(0.1781439781189), wave * DC.ar(0.41188287734985)), Silent.ar());

signal = varOmud17462312;
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
// HLLP.DEMO.10105174625
/////////////////////////////////////////////////////////

SynthDef.new("HLLP.DEMO.10105174625", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varHLLPDEMO101051746259, varHLLPDEMO1010517462510, varHLLPDEMO1010517462511, varHLLPDEMO1010517462512, varHLLPDEMO1010517462513;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varHLLPDEMO101051746259 = varHLLPDEMO1010517462510 = varHLLPDEMO1010517462511 = varHLLPDEMO1010517462512 = varHLLPDEMO1010517462513 = K2A.ar(t_trig).dup;
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
varHLLPDEMO101051746259 = UHJ2B.ar(modY * varHLLPDEMO1010517462512, 0.92195188999176 * varHLLPDEMO101051746259 * varHLLPDEMO1010517462512);
varHLLPDEMO1010517462510 = Klang.ar(`[[LinCongL.ar(wave * DC.ar(0.3532258272171), wave * DC.ar(0.67171859741211), wave * DC.ar(0.21680378913879), wave * DC.ar(0.21602022647858), wave * DC.ar(0.31408834457397), wave * DC.ar(0.40098166465759), wave * DC.ar(0.81893813610077)), LatoocarfianL.ar(wave * DC.ar(0.11359536647797), wave * DC.ar(0.13222575187683), wave * DC.ar(0.29549217224121), wave * DC.ar(0.2411744594574), wave * DC.ar(0.58029532432556), wave * DC.ar(0.51013386249542), wave * DC.ar(0.52211630344391), wave * DC.ar(0.062056422233582), wave * DC.ar(0.48117733001709))], [OneZero.ar(wave * DC.ar(0.26632380485535), wave * DC.ar(0.60654044151306), wave * DC.ar(0.48273825645447), wave * DC.ar(0.076465249061584)), IEnvGen.ar(wave * DC.ar(0.8104921579361), wave * DC.ar(0.36792981624603), wave * DC.ar(0.93074905872345), wave * DC.ar(0.54728162288666))], [BrownNoise.ar(wave * DC.ar(0.58545684814453), wave * DC.ar(0.29008519649506)), Gate.ar(wave * DC.ar(0.45980191230774), wave * DC.ar(0.69113028049469))]], wave, in);
varHLLPDEMO1010517462511 = SoftClipper8.ar(in * varHLLPDEMO1010517462513);
varHLLPDEMO1010517462512 = Lag3.ar(bufnum, 0.29029524326324 * varHLLPDEMO1010517462513 * varHLLPDEMO1010517462510, 0.83179610731178 * modX * varHLLPDEMO1010517462512, Silent.ar());
varHLLPDEMO1010517462513 = Duty.ar(x, signal * env, modZ * signal, 0.37960076332092 * LFPar.ar(wave * DC.ar(0.82691514492035), wave * DC.ar(0.77775752544403), wave * DC.ar(0.59566926956177), wave * DC.ar(0.89995741844177)));
varHLLPDEMO101051746259 = Balance.ar(varHLLPDEMO1010517462511 * modY, in, z, signal, 0.98117511155099 * varHLLPDEMO1010517462512 * varHLLPDEMO1010517462510, Silent.ar());
varHLLPDEMO1010517462510 = Resonz.ar(wave.hypot(FoaDirectZ.ar(wave * DC.ar(0.61959755420685), wave * DC.ar(0.96382462978363), wave * DC.ar(0.32496762275696), wave * DC.ar(0.30371999740601))), SN76489.ar(wave * DC.ar(0.083477258682251), wave * DC.ar(0.022746562957764), wave * DC.ar(0.22478044033051), wave * DC.ar(0.45810186862946), wave * DC.ar(0.2487735748291), wave * DC.ar(0.76791775226593), wave * DC.ar(0.27659726142883), wave * DC.ar(0.065794587135315), wave * DC.ar(0.27800691127777)).exprange(1, SampleRate.ir), y, varHLLPDEMO101051746259, Silent.ar());
varHLLPDEMO1010517462511 = StkClarinet.ar(BufGrainI.ar(wave * DC.ar(0.369025349617), wave * DC.ar(0.75352001190186), wave * DC.ar(0.56815457344055), wave * DC.ar(0.48805677890778), wave * DC.ar(0.91465926170349), wave * DC.ar(0.95082235336304), wave * DC.ar(0.55494284629822), wave * DC.ar(0.30305242538452), wave * DC.ar(0.24523627758026), wave * DC.ar(0.98128688335419), wave * DC.ar(0.92694330215454)).exprange(1, SampleRate.ir), 0.28084897994995 * varHLLPDEMO1010517462510 * modX, modZ * wave, wave * wave, modX * signal, in, varHLLPDEMO1010517462510, BHiShelf.ar(wave * DC.ar(0.42087197303772), wave * DC.ar(0.93088579177856), wave * DC.ar(0.95663368701935), wave * DC.ar(0.40274322032928), wave * DC.ar(0.25337016582489), wave * DC.ar(0.17542493343353)).lag3ud(wave * DC.ar(0.91324484348297), wave * DC.ar(0.41007745265961)), Silent.ar());
varHLLPDEMO1010517462512 = InGrainBBF.ar(wave * DC.ar(0.16665840148926), wave * DC.ar(0.7991338968277), wave * DC.ar(0.89297735691071), wave * DC.ar(0.43000984191895), wave * DC.ar(0.25611388683319), wave * DC.ar(0.64325559139252), wave * DC.ar(0.51957201957703), wave * DC.ar(0.49763739109039), wave * DC.ar(0.13293731212616), wave * DC.ar(0.66808199882507));
varHLLPDEMO1010517462513 = SetResetFF.ar(ClipNoise.ar(wave * DC.ar(0.48947489261627), wave * DC.ar(0.77403020858765)), env);

signal = varHLLPDEMO1010517462513;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// PS-MPC.Screen_Save1746251
/////////////////////////////////////////////////////////

SynthDef.new("PS-MPC.Screen_Save1746251", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varPSMPCScreen_Save1746259, varPSMPCScreen_Save17462510, varPSMPCScreen_Save17462511, varPSMPCScreen_Save17462512, varPSMPCScreen_Save174625113, varPSMPCScreen_Save174625114;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varPSMPCScreen_Save1746259 = varPSMPCScreen_Save17462510 = varPSMPCScreen_Save17462511 = varPSMPCScreen_Save17462512 = varPSMPCScreen_Save174625113 = varPSMPCScreen_Save174625114 = K2A.ar(t_trig).dup;
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
varPSMPCScreen_Save1746259 = Standard2DC.ar(modX * env, modZ * varPSMPCScreen_Save174625113, signal * varPSMPCScreen_Save17462510, varPSMPCScreen_Save17462511, RedPhasor2.ar(wave * DC.ar(0.0343416929245), wave * DC.ar(0.93947637081146), wave * DC.ar(0.014407634735107), wave * DC.ar(0.52947866916656), wave * DC.ar(0.95872020721436), wave * DC.ar(0.95709478855133), wave * DC.ar(0.75196778774261)), 0.92817496169562 * gateEnv * modZ, Silent.ar());
varPSMPCScreen_Save17462510 = FMHEncode0.ar(in, signal, varPSMPCScreen_Save174625113, gateEnv * modX.curvelin(wave * DC.ar(0.3241503238678), wave * DC.ar(0.38579738140106), wave * DC.ar(0.5337530374527), wave * DC.ar(0.24810743331909), wave * DC.ar(0.52564978599548), wave * DC.ar(0.66383421421051)));
varPSMPCScreen_Save17462511 = Oregonator.ar(Dust2.ar(y, FoaPushY.ar(wave * DC.ar(0.60549008846283), wave * DC.ar(0.66632854938507), wave * DC.ar(0.68907642364502), wave * DC.ar(0.1764178276062)), Silent.ar()), env * modY, gateEnv, varPSMPCScreen_Save17462512 * modX, modX * signal, BufGrainB.ar(varPSMPCScreen_Save174625114 * modX, env, bufnum, signal * varPSMPCScreen_Save174625113, modZ, bufnum, amp, 0.99438321979591 * in, Silent.ar()), bufnum, modZ, varPSMPCScreen_Save1746259, Silent.ar());
varPSMPCScreen_Save17462512 = FoaPressZ.ar(island, modY * modZ.hypot(InRange.ar(wave * DC.ar(0.71087849140167), wave * DC.ar(0.80661571025848), wave * DC.ar(0.84358096122742))), 0.91456779199278 * gateEnv * varPSMPCScreen_Save17462511, Silent.ar());
varPSMPCScreen_Save1746259 = StereoConvolution2L.ar(amp, t_trig, varPSMPCScreen_Save17462511 * varPSMPCScreen_Save174625114, LorenzTrig.ar(wave * DC.ar(0.20930576324463), wave * DC.ar(0.26935911178589), wave * DC.ar(0.78682088851929), wave * DC.ar(0.11939549446106), wave * DC.ar(0.30137479305267), wave * DC.ar(0.79055082798004), wave * DC.ar(0.39730322360992), wave * DC.ar(0.068811058998108), wave * DC.ar(0.59951496124268), wave * DC.ar(0.74873733520508), wave * DC.ar(0.58451306819916)), x, modZ, 0.99733086184188 * varPSMPCScreen_Save174625114 * gateEnv, Silent.ar());
varPSMPCScreen_Save17462510 = BufAllpassN.ar(wave * DC.ar(0.23457288742065), wave * DC.ar(0.52453505992889), wave * DC.ar(0.35932075977325), wave * DC.ar(0.13716351985931), wave * DC.ar(0.68683362007141), wave * DC.ar(0.01225209236145));
varPSMPCScreen_Save17462511 = GrainSin.ar(2, varPSMPCScreen_Save17462510 * wave, env * modZ.expexp(wave * DC.ar(0.55429244041443), wave * DC.ar(0.51235198974609), wave * DC.ar(0.31074190139771), wave * DC.ar(0.28178882598877), wave * DC.ar(0.26998364925385)), env, bufnum, bufnum, x, 0.99977024174859 * varPSMPCScreen_Save1746259, Silent.ar());
varPSMPCScreen_Save17462512 = Fhn2DN.ar(gateEnv * gateEnv, modZ * varPSMPCScreen_Save17462511, in, signal, z, env, varPSMPCScreen_Save17462512, signal, wave * varPSMPCScreen_Save1746259, 0.98081217801811 * FoaPressZ.ar(wave * DC.ar(0.53746604919434), wave * DC.ar(0.072229266166687), wave * DC.ar(0.91251969337463), wave * DC.ar(0.41155481338501)), Silent.ar());
// Variation test code
varPSMPCScreen_Save174625113 = Balance2.ar(z, varPSMPCScreen_Save17462512, y, bufnum);
varPSMPCScreen_Save174625114 = BBandPass.ar(gate, PulseDivider.ar(varPSMPCScreen_Save17462511 * DC.ar(0.53209960460663), varPSMPCScreen_Save17462512 * DC.ar(0.26413810253143), varPSMPCScreen_Save1746259 * DC.ar(0.60378694534302)).exprange(1, SampleRate.ir), varPSMPCScreen_Save174625114, 0.99947684366012 * LFDNoise1.ar(varPSMPCScreen_Save17462510 * DC.ar(0.18547439575195), varPSMPCScreen_Save17462512 * DC.ar(0.95713651180267), varPSMPCScreen_Save17462510 * DC.ar(0.94515144824982)), Silent.ar());
varPSMPCScreen_Save174625113 = BufGrainBBF.ar(LFDNoise0.ar(varPSMPCScreen_Save1746259 * DC.ar(0.59818720817566), varPSMPCScreen_Save17462510 * DC.ar(0.55037140846252), varPSMPCScreen_Save1746259 * DC.ar(0.16581130027771)), varPSMPCScreen_Save174625113 * varPSMPCScreen_Save17462510, bufnum, Lag3.ar(modX, modX, varPSMPCScreen_Save17462512, Silent.ar()), 0.95662772655487 * Vibrato.ar(varPSMPCScreen_Save17462510 * DC.ar(0.45703303813934), varPSMPCScreen_Save17462512 * DC.ar(0.22156882286072), varPSMPCScreen_Save17462512 * DC.ar(0.69595265388489), varPSMPCScreen_Save17462512 * DC.ar(0.90233826637268), varPSMPCScreen_Save17462511 * DC.ar(0.43826639652252), varPSMPCScreen_Save17462512 * DC.ar(0.75712454319), varPSMPCScreen_Save1746259 * DC.ar(0.84848034381866), varPSMPCScreen_Save17462512 * DC.ar(0.28072845935822)), bufnum, varPSMPCScreen_Save17462510, gate, modX * wave, 0.9328773021698 * varPSMPCScreen_Save17462510 * wave, modY, 0.99859506049877 * modY * in, Silent.ar());
varPSMPCScreen_Save174625114 = Decay.ar(x.exprange(varPSMPCScreen_Save17462510 * DC.ar(0.77236270904541), varPSMPCScreen_Save17462512 * DC.ar(0.17666625976562)), bufnum.linexp(varPSMPCScreen_Save17462512 * DC.ar(0.57930541038513), varPSMPCScreen_Save17462511 * DC.ar(0.98766112327576), varPSMPCScreen_Save17462510 * DC.ar(0.42210233211517), varPSMPCScreen_Save17462512 * DC.ar(0.57220411300659), varPSMPCScreen_Save1746259 * DC.ar(0.55972802639008)), modY, Silent.ar());
varPSMPCScreen_Save174625113 = Gbman2DN.ar(varPSMPCScreen_Save17462511, wave * wave, signal, modX * varPSMPCScreen_Save17462512, modY, Silent.ar());
varPSMPCScreen_Save174625114 = FoaDirectZ.ar(bufnum, ToggleFF.ar(in * modZ), FreeVerb.ar(varPSMPCScreen_Save17462512 * DC.ar(0.38374888896942), varPSMPCScreen_Save17462511 * DC.ar(0.42391860485077), varPSMPCScreen_Save17462512 * DC.ar(0.11721765995026), varPSMPCScreen_Save1746259 * DC.ar(0.45532011985779), varPSMPCScreen_Save17462510 * DC.ar(0.16665530204773), varPSMPCScreen_Save17462512 * DC.ar(0.73129713535309)), Silent.ar());

signal = varPSMPCScreen_Save174625114;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");


/////////////////////////////////////////////////////////
// Enmity.808174628
/////////////////////////////////////////////////////////

SynthDef.new("Enmity.808174628", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varEnmity8081746289;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varEnmity8081746289 = K2A.ar(t_trig).dup;
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
varEnmity8081746289 = ChuaL.ar(modY, wave * in, modY * signal, in * wave, env * modX, wave, wave * gateEnv, t_trig, 0.45913171768188 * FoaDominateX.ar(wave * DC.ar(0.10327255725861), wave * DC.ar(0.80402302742004), wave * DC.ar(0.6206967830658), wave * DC.ar(0.1854772567749)), t_trig, 0.99852935894037 * in * wave, Silent.ar());
varEnmity8081746289 = Pluck.ar(wave * in, env, modX, modY, modX, y, SinGrainBBF.ar(wave * DC.ar(0.11854374408722), wave * DC.ar(0.14737069606781), wave * DC.ar(0.029984951019287), wave * DC.ar(0.81738877296448), wave * DC.ar(0.69297170639038), wave * DC.ar(0.19167709350586), wave * DC.ar(0.59668183326721), wave * DC.ar(0.37687814235687), wave * DC.ar(0.029142379760742), wave * DC.ar(0.52367174625397)), Silent.ar());

signal = varEnmity8081746289;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// XM.Laroux.AR174629
/////////////////////////////////////////////////////////

SynthDef.new("XM.Laroux.AR174629", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varXMLarouxAR1746299, varXMLarouxAR17462910;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varXMLarouxAR1746299 = varXMLarouxAR17462910 = K2A.ar(t_trig).dup;
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
varXMLarouxAR1746299 = RMAFoodChainL.ar(DoubleWell3.ar(wave * DC.ar(0.077544212341309), wave * DC.ar(0.28655219078064), wave * DC.ar(0.06781530380249), wave * DC.ar(0.64792156219482), wave * DC.ar(0.99979627132416), wave * DC.ar(0.80657649040222), wave * DC.ar(0.21425998210907), wave * DC.ar(0.91880643367767)).exprange(1, SampleRate.ir), modY * wave, varXMLarouxAR1746299, 0.048897743225098 * FoaFocusY.ar(wave * DC.ar(0.79212200641632), wave * DC.ar(0.15565097332001), wave * DC.ar(0.92650556564331), wave * DC.ar(0.79352021217346)), modY, modX * in, 0.32868838310242 * varXMLarouxAR17462910 * in, gate, varXMLarouxAR17462910, modY * signal, PinkNoise.ar(wave * DC.ar(0.57153010368347), wave * DC.ar(0.72821915149689)), 0.70640170574188 * in * env, 0.18902134895325 * varXMLarouxAR1746299 * gateEnv, modZ, Silent.ar());
varXMLarouxAR17462910 = YigCliffordL.ar(modX, in * gateEnv, env * modZ, modY, env * in, modY, varXMLarouxAR1746299, 0.99997375433115 * in * wave, Silent.ar());
varXMLarouxAR1746299 = BRZ2.ar(gateEnv * modZ, 0.99715048084252 * TGaussRand.ar(wave * DC.ar(0.26592373847961), wave * DC.ar(0.94632136821747), wave * DC.ar(0.3101190328598), wave * DC.ar(0.2491888999939), wave * DC.ar(0.72228670120239)), Silent.ar());
varXMLarouxAR17462910 = SetResetFF.ar(env * varXMLarouxAR17462910, gateEnv * modY);

signal = varXMLarouxAR17462910;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// Hera.1445174630
/////////////////////////////////////////////////////////

SynthDef.new("Hera.1445174630", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varHera14451746309, varHera144517463010, varHera144517463011;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varHera14451746309 = varHera144517463010 = varHera144517463011 = K2A.ar(t_trig).dup;
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
varHera14451746309 = BFEncode2.ar(0.41408109664917 * varHera144517463010 * modZ, gateEnv.lag2(wave * DC.ar(0.90403437614441), wave * DC.ar(0.30026507377625)), x, modY.lag2ud(wave * DC.ar(0.013811826705933), wave * DC.ar(0.53065896034241)), modY, modY * env);
varHera144517463010 = AtsFreq.ar(Array.fill(2.pow(15), { |i| rrand(-1, 1) }).as(LocalBuf), bufnum, signal * in, 0.97634333894743 * varHera144517463010 * signal, Silent.ar());
varHera144517463011 = ChuaL.ar(in.wrap2(QuadC.ar(wave * DC.ar(0.64651799201965), wave * DC.ar(0.028748273849487), wave * DC.ar(0.23621797561646), wave * DC.ar(0.75963425636292), wave * DC.ar(0.14443671703339), wave * DC.ar(0.11534571647644), wave * DC.ar(0.97211194038391))), 0.46180725097656 * Convolution.ar(wave * DC.ar(0.16828048229218), wave * DC.ar(0.83580899238586), wave * DC.ar(0.50123059749603), wave * DC.ar(0.10636794567108), wave * DC.ar(0.85558760166168)), varHera14451746309 * modY, gate, gateEnv, gateEnv, bufnum, LFBrownNoise2.ar(wave * DC.ar(0.51937782764435), wave * DC.ar(0.60851180553436), wave * DC.ar(0.61318325996399), wave * DC.ar(0.2903265953064), wave * DC.ar(0.18970131874084)), modZ * modY, wave * varHera14451746309, HPF.ar(wave * DC.ar(0.36604702472687), wave * DC.ar(0.34112596511841), wave * DC.ar(0.10709154605865), wave * DC.ar(0.2649827003479)), Silent.ar());
varHera14451746309 = YigClifford3DC.ar(wave * DC.ar(0.93523836135864), wave * DC.ar(0.93658137321472), wave * DC.ar(0.95971190929413), wave * DC.ar(0.89086222648621), wave * DC.ar(0.88714146614075), wave * DC.ar(0.28068614006042), wave * DC.ar(0.79296672344208), wave * DC.ar(0.69827628135681), wave * DC.ar(0.10439503192902), wave * DC.ar(0.76276433467865));
varHera144517463010 = LFSaw.ar(wave * DC.ar(0.56759107112885), wave * DC.ar(0.63598585128784), wave * DC.ar(0.56245350837708), wave * DC.ar(0.66827023029327));
varHera144517463011 = VOsc3.ar(wave * DC.ar(0.2021826505661), wave * DC.ar(0.93482112884521), wave * DC.ar(0.89115357398987), wave * DC.ar(0.79267120361328), wave * DC.ar(0.15859806537628), wave * DC.ar(0.58786356449127));

signal = varHera144517463011;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// Hera.14451746301
/////////////////////////////////////////////////////////

SynthDef.new("Hera.14451746301", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varHera14451746309, varHera144517463010, varHera144517463011, varHera1445174630112, varHera1445174630113, varHera1445174630114;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varHera14451746309 = varHera144517463010 = varHera144517463011 = varHera1445174630112 = varHera1445174630113 = varHera1445174630114 = K2A.ar(t_trig).dup;
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
varHera14451746309 = FoaDirectZ.ar(varHera14451746309, varHera1445174630114 * modY, modY, Silent.ar());
varHera144517463010 = PartConv.ar(in, varHera1445174630112, Array.fill(2.pow(13), { |i| rrand(-1, 1) }).as(LocalBuf), FoaPressZ.ar(wave * DC.ar(0.013921737670898), wave * DC.ar(0.21415996551514), wave * DC.ar(0.4793039560318), wave * DC.ar(0.30344295501709)), Silent.ar());
varHera144517463011 = Concat2.ar(in * varHera144517463011, island, wave * gateEnv, DegreeToKey.ar(wave * DC.ar(0.6033878326416), wave * DC.ar(0.89137518405914), wave * DC.ar(0.74341833591461), wave * DC.ar(0.646688580513), wave * DC.ar(0.51280975341797)), varHera144517463011 * varHera1445174630112, K2A.ar(wave * DC.ar(0.81040871143341)), amp, wave * signal, wave * signal, varHera1445174630112 * varHera1445174630112, varHera144517463011 * varHera1445174630113, wave * env, wave * env, modX, Silent.ar());
varHera14451746309 = ArrayMax.ar(wave * DC.ar(0.39115977287292));
varHera144517463010 = FhnTrig.ar(SyncSaw.ar(wave * DC.ar(0.96845459938049), wave * DC.ar(0.32627904415131), wave * DC.ar(0.91435825824738), wave * DC.ar(0.073347926139832)).exprange(1, SampleRate.ir), FoaFocusX.ar(wave * DC.ar(0.64945507049561), wave * DC.ar(0.30459892749786), wave * DC.ar(0.033446669578552), wave * DC.ar(0.52002823352814)).exprange(1, SampleRate.ir), modX, modY, z, island, varHera14451746309 * gateEnv, varHera1445174630114, wave, LPCAnalyzer.ar(wave * DC.ar(0.0068199634552002), wave * DC.ar(0.94569063186646), wave * DC.ar(0.46800017356873), wave * DC.ar(0.48746526241302), wave * DC.ar(0.14067387580872), wave * DC.ar(0.66058933734894), wave * DC.ar(0.90780746936798), wave * DC.ar(0.63877153396606), wave * DC.ar(0.30045855045319)), Silent.ar());
varHera144517463011 = XLine.ar(wave * DC.ar(0.95728671550751), wave * DC.ar(0.51398825645447), wave * DC.ar(0.10807287693024), wave * DC.ar(0.58921051025391), wave * DC.ar(0.15308499336243), wave * DC.ar(0.18829965591431));
// Variation test code
varHera1445174630112 = Oregonator.ar(0.55611097812653 * Rotate2.ar(varHera144517463010 * DC.ar(0.98405504226685), varHera144517463011 * DC.ar(0.71763265132904), varHera144517463010 * DC.ar(0.56337058544159)), varHera1445174630114 * in, 0.2522931098938 * in.fold2(HilbertFIR.ar(varHera14451746309 * DC.ar(0.71237468719482), varHera14451746309 * DC.ar(0.87090909481049))), x, varHera1445174630112 * varHera144517463011, 0.76558470726013 * gateEnv * modX, t_trig, varHera144517463010 * modX, varHera1445174630114, Silent.ar());
varHera1445174630113 = ToggleFF.ar(wave * varHera1445174630113);
varHera1445174630114 = AY.ar(gate, varHera14451746309 * wave, modZ, wave * varHera14451746309, signal * wave, varHera144517463011 * gateEnv, signal * signal, bufnum, env, gateEnv * wave, bufnum, Friction.ar(varHera144517463011 * DC.ar(0.52948248386383), varHera14451746309 * DC.ar(0.59214842319489), varHera14451746309 * DC.ar(0.16196405887604), varHera14451746309 * DC.ar(0.21873414516449), varHera144517463010 * DC.ar(0.50958478450775), varHera144517463011 * DC.ar(0.1066757440567), varHera144517463010 * DC.ar(0.73295164108276), varHera144517463011 * DC.ar(0.34418034553528)), Silent.ar());
varHera1445174630112 = BBandPass.ar(varHera1445174630113 * varHera1445174630112, modY * varHera1445174630112, 0.45806670188904 * varHera144517463011 * modX, varHera1445174630113, Silent.ar());
varHera1445174630113 = RandSeed.ar(varHera1445174630114 * modY, t_trig);
varHera1445174630114 = Lag.ar(gate, FoaDirectZ.ar(0.27240931987762 * varHera14451746309 * gateEnv, varHera1445174630112 * modZ, wave, Silent.ar()), 0.97916848164948 * gateEnv * varHera1445174630112, Silent.ar());
varHera1445174630112 = StkBeeThree.ar(gateEnv * env.bipolar(varHera144517463011 * DC.ar(0.35667383670807)), modZ, signal, env * varHera1445174630113, bufnum, env * wave, modX * varHera144517463011, 0.99996994000767 * varHera1445174630113 * gateEnv, Silent.ar());
varHera1445174630113 = SinGrainIBF.ar(varHera144517463010 * signal, bufnum, SinGrain.ar(varHera144517463010 * DC.ar(0.15631222724915), varHera14451746309 * DC.ar(0.86484444141388), varHera144517463010 * DC.ar(0.12024402618408), varHera14451746309 * DC.ar(0.69257187843323), varHera14451746309 * DC.ar(0.42409598827362)).exprange(1, SampleRate.ir), bufnum, bufnum, gate, modX, env, env * varHera1445174630113, varHera1445174630113 * gateEnv, 0.44338568685508 * varHera1445174630112 * env, Silent.ar());
varHera1445174630114 = Gendy2.ar(wave * wave, modZ, varHera144517463011 * gateEnv, in * varHera14451746309, varHera1445174630113 * varHera1445174630113, gateEnv, gateEnv * varHera1445174630114, varHera144517463011, 0.98142778873444 * env * varHera144517463011, varHera144517463010, gateEnv * varHera144517463010, varHera1445174630113, 0.99956288052174 * OffsetOut.ar(varHera144517463011 * DC.ar(0.13522410392761), varHera14451746309 * DC.ar(0.95211255550385)), Silent.ar());

signal = varHera1445174630114;
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
varBadBoy1000K17463111 = AtsFreq.ar(wave * DC.ar(0.13134849071503), wave * DC.ar(0.060417056083679), wave * DC.ar(0.78543865680695), wave * DC.ar(0.65081262588501), wave * DC.ar(0.24450325965881));

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
varVerwolf3202b1746319 = TermanWang.ar(signal, wave, varVerwolf3202b1746319, 0.95128262042999 * env * signal, y, z, modZ * signal, signal * varVerwolf3202b1746319, 0.24664628505707 * modX * modX, 0.99989117951284 * modX * in, MdaPiano.ar(wave * DC.ar(0.09086012840271), wave * DC.ar(0.052047729492188), wave * DC.ar(0.94298470020294), wave * DC.ar(0.075202822685242), wave * DC.ar(0.80482971668243), wave * DC.ar(0.61143279075623), wave * DC.ar(0.4414826631546), wave * DC.ar(0.73099744319916), wave * DC.ar(0.1133873462677), wave * DC.ar(0.040165662765503), wave * DC.ar(0.72670364379883), wave * DC.ar(0.83932864665985), wave * DC.ar(0.36771833896637), wave * DC.ar(0.89230358600616), wave * DC.ar(0.18979859352112), wave * DC.ar(0.7217720746994), wave * DC.ar(0.93714141845703)));

signal = varVerwolf3202b1746319;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// Verwolf.3202.b1746311
/////////////////////////////////////////////////////////

SynthDef.new("Verwolf.3202.b1746311", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varVerwolf3202b1746319, varVerwolf3202b174631110;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varVerwolf3202b1746319 = varVerwolf3202b174631110 = K2A.ar(t_trig).dup;
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
varVerwolf3202b1746319 = ZeroCrossing.ar(amp);
varVerwolf3202b1746319 = AY.ar(signal * env, wave, signal * signal, in, wave * in, gateEnv, IndexInBetween.ar(Array.fill(2.pow(15), { |i| rrand(-1, 1) }).as(LocalBuf), WaveTerrain.ar(wave * DC.ar(0.80873942375183), wave * DC.ar(0.46053194999695), wave * DC.ar(0.54500567913055), wave * DC.ar(0.026500225067139), wave * DC.ar(0.41319227218628), wave * DC.ar(0.22506892681122), wave * DC.ar(0.022641181945801)), modY, Silent.ar()), 0.15402138233185 * gateEnv * modX, signal * signal, modY * varVerwolf3202b174631110, modY, modY, Silent.ar().slew(wave * DC.ar(0.84785807132721), wave * DC.ar(0.38086342811584)));
// Variation test code
varVerwolf3202b174631110 = AtsPartial.ar(Array.fill(2.pow(13), { |i| rrand(-1, 1) }).as(LocalBuf), varVerwolf3202b1746319 * modZ, in, modX * signal, signal, 0.99996020004739 * varVerwolf3202b1746319 * env, Silent.ar());
varVerwolf3202b174631110 = ToggleFF.ar(varVerwolf3202b1746319 * in);
varVerwolf3202b174631110 = LFDNoise1.ar(in * modX, 0.96085213292783 * wave * varVerwolf3202b174631110, Silent.ar());

signal = varVerwolf3202b174631110;
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
// HLLP.9320174632
/////////////////////////////////////////////////////////

SynthDef.new("HLLP.9320174632", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varHLLP93201746329, varHLLP932017463210, varHLLP932017463211, varHLLP932017463212;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varHLLP93201746329 = varHLLP932017463210 = varHLLP932017463211 = varHLLP932017463212 = K2A.ar(t_trig).dup;
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
varHLLP93201746329 = TGrains.ar(2, env * varHLLP93201746329, Array.fill(2.pow(13), { |i| rrand(-1, 1) }).as(LocalBuf), 0.47149896621704 * env * modY, gateEnv * varHLLP932017463212, varHLLP932017463211, modX * in, y, varHLLP932017463211);
varHLLP932017463210 = DiskOut.ar(Array.fill(2.pow(15), { |i| rrand(-1, 1) }).as(LocalBuf), [BFEncode2.ar(wave * DC.ar(0.55809414386749), wave * DC.ar(0.46521520614624), wave * DC.ar(0.56743717193604), wave * DC.ar(0.86859738826752), wave * DC.ar(0.57921755313873), wave * DC.ar(0.40726542472839)), DoubleNestedAllpassC.ar(wave * DC.ar(0.23550248146057), wave * DC.ar(0.55240118503571), wave * DC.ar(0.56603848934174), wave * DC.ar(0.95599722862244), wave * DC.ar(0.50665557384491), wave * DC.ar(0.63884150981903), wave * DC.ar(0.60554873943329), wave * DC.ar(0.39295780658722), wave * DC.ar(0.48091244697571), wave * DC.ar(0.34629786014557), wave * DC.ar(0.29433751106262), wave * DC.ar(0.22669577598572))]);
varHLLP932017463211 = Blip.ar(env * varHLLP932017463212, x, 0.99997905714231 * wave * modY, Silent.ar().max(Lag3.ar(wave * DC.ar(0.74128925800323), wave * DC.ar(0.64460456371307), wave * DC.ar(0.019170880317688), wave * DC.ar(0.96359860897064))));
varHLLP932017463212 = BinData.ar(Array.fill(2.pow(15), { |i| rrand(-1, 1) }).as(LocalBuf), signal, env);
varHLLP93201746329 = BFManipulate.ar(bufnum, env, amp, varHLLP932017463210 * modY, wave * env, signal * varHLLP932017463212, 0.049922466278076 * varHLLP93201746329 * in);
varHLLP932017463210 = FincoSprottM.ar(varHLLP932017463211 * modX, 0.20334899425507 * env * in, 0.95000731945038 * modX, 0.59335696697235 * wave * signal, gateEnv, varHLLP932017463212 * varHLLP932017463210, x, 0.99989028521505 * LocalOut.ar(wave * DC.ar(0.067925810813904)), Silent.ar());
varHLLP932017463211 = TextVU.ar(modZ * varHLLP932017463211, island, modY * wave, gate, wave * in, wave);
varHLLP932017463212 = QuadC.ar(env * gateEnv, in * wave, modZ * wave.slew(wave * DC.ar(0.62481367588043), wave * DC.ar(0.80433547496796)), varHLLP932017463212, varHLLP93201746329 * modY, Tumble.ar(wave * DC.ar(0.044385433197021), wave * DC.ar(0.76857399940491), wave * DC.ar(0.21349155902863), wave * DC.ar(0.54728639125824), wave * DC.ar(0.3563084602356)), Silent.ar());

signal = varHLLP932017463212;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// IRC.Silver.A174633
/////////////////////////////////////////////////////////

SynthDef.new("IRC.Silver.A174633", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varIRCSilverA1746339, varIRCSilverA17463310, varIRCSilverA17463311, varIRCSilverA17463312, varIRCSilverA17463313;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varIRCSilverA1746339 = varIRCSilverA17463310 = varIRCSilverA17463311 = varIRCSilverA17463312 = varIRCSilverA17463313 = K2A.ar(t_trig).dup;
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
varIRCSilverA1746339 = NL.ar(y, Array.fill(2.pow(14), { |i| rrand(-1, 1) }).as(LocalBuf), Array.fill(2.pow(11), { |i| rrand(-1, 1) }).as(LocalBuf), modY, 0.38754165172577 * varIRCSilverA1746339 * varIRCSilverA17463311, 0.99998128666811 * env * modZ, Silent.ar());
varIRCSilverA17463310 = TwoTube.ar(gateEnv, varIRCSilverA17463311, varIRCSilverA17463312 * varIRCSilverA1746339.madd(wave * DC.ar(0.25498044490814), wave * DC.ar(0.11565613746643)), 0.10041010379791 * gateEnv * modX, modY * modX, FoaPanB.ar(wave * DC.ar(0.39711213111877), wave * DC.ar(0.75218033790588), wave * DC.ar(0.99153137207031), wave * DC.ar(0.86848974227905), wave * DC.ar(0.52227282524109)), Silent.ar());
varIRCSilverA17463311 = RedDPCMdecode.ar(varIRCSilverA17463310 * modY);
varIRCSilverA17463312 = LFCub.ar(varIRCSilverA17463310 * modY, x, 0.99976672350314 * varIRCSilverA17463313 * varIRCSilverA1746339, Ringz.ar(wave * DC.ar(0.17346036434174), wave * DC.ar(0.78458988666534), wave * DC.ar(0.82072460651398), wave * DC.ar(0.029816389083862), wave * DC.ar(0.17153334617615)));
varIRCSilverA17463313 = Vibrato.ar(modX * gateEnv, 0.99836099147797 * PitchShift.ar(wave * DC.ar(0.89548802375793), wave * DC.ar(0.45119345188141), wave * DC.ar(0.060713171958923), wave * DC.ar(0.58116698265076), wave * DC.ar(0.65307557582855), wave * DC.ar(0.78116834163666), wave * DC.ar(0.18082392215729)), modX * gateEnv.lag3ud(wave * DC.ar(0.82384300231934), wave * DC.ar(0.77406013011932)), varIRCSilverA1746339, 0.92561626434326 * varIRCSilverA17463310 * in, env * varIRCSilverA17463313, island, gateEnv);
varIRCSilverA1746339 = DoubleWell.ar(wave * DC.ar(0.05048930644989), wave * DC.ar(0.84209847450256), wave * DC.ar(0.79622578620911), wave * DC.ar(0.29292035102844), wave * DC.ar(0.057049512863159), wave * DC.ar(0.62006962299347), wave * DC.ar(0.20573437213898), wave * DC.ar(0.47928416728973), wave * DC.ar(0.42215180397034), wave * DC.ar(0.68261027336121));
varIRCSilverA17463310 = Delay2.ar(wave * gateEnv, 0.83110560441624 * modY * varIRCSilverA17463312, LinCongL.ar(wave * DC.ar(0.06240451335907), wave * DC.ar(0.48895227909088), wave * DC.ar(0.197918176651), wave * DC.ar(0.33697164058685), wave * DC.ar(0.99458146095276), wave * DC.ar(0.046549916267395), wave * DC.ar(0.94824385643005)));
varIRCSilverA17463311 = AtsAmp.ar(wave * DC.ar(0.30292856693268), wave * DC.ar(0.49065482616425), wave * DC.ar(0.2265841960907), wave * DC.ar(0.74652755260468), wave * DC.ar(0.165731549263));
varIRCSilverA17463312 = DecodeB2.ar(2, modZ, env * varIRCSilverA17463313, InGrainBBF.ar(wave * DC.ar(0.83355903625488), wave * DC.ar(0.46087551116943), wave * DC.ar(0.98426151275635), wave * DC.ar(0.18638825416565), wave * DC.ar(0.63497424125671), wave * DC.ar(0.51540410518646), wave * DC.ar(0.9464590549469), wave * DC.ar(0.17679369449615), wave * DC.ar(0.98684656620026), wave * DC.ar(0.056032419204712)), signal * varIRCSilverA1746339);
varIRCSilverA17463313 = Lag2UD.ar(wave * DC.ar(0.17558431625366), wave * DC.ar(0.014593005180359), wave * DC.ar(0.60993981361389), wave * DC.ar(0.039997935295105), wave * DC.ar(0.022343397140503));

signal = varIRCSilverA17463313;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// X97M.Nor174634
/////////////////////////////////////////////////////////

SynthDef.new("X97M.Nor174634", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varX97MNor1746349, varX97MNor17463410, varX97MNor17463411, varX97MNor17463412;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varX97MNor1746349 = varX97MNor17463410 = varX97MNor17463411 = varX97MNor17463412 = K2A.ar(t_trig).dup;
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
varX97MNor1746349 = Logistic.ar(t_trig, gateEnv * in, varX97MNor1746349, 0.99609505461482 * varX97MNor17463412 * in, Silent.ar());
varX97MNor17463410 = DC.ar(island);
varX97MNor17463411 = FoaTilt.ar(x, in * wave, AudioMSG.ar(wave * DC.ar(0.020209908485413), wave * DC.ar(0.51977860927582), wave * DC.ar(0.73167014122009), wave * DC.ar(0.93465888500214)), Silent.ar());
varX97MNor17463412 = Spreader.ar(varX97MNor17463412 * in, varX97MNor1746349 * varX97MNor17463411, varX97MNor17463412 * modY.excess(WalshHadamard.ar(wave * DC.ar(0.068292856216431), wave * DC.ar(0.40887033939362), wave * DC.ar(0.020812153816223), wave * DC.ar(0.91010594367981))), 0.99998981379412 * modX * varX97MNor17463412, Silent.ar());
varX97MNor1746349 = TWindex.ar(MostChange.ar(varX97MNor17463411, modZ * varX97MNor17463412), [Logistic.ar(wave * DC.ar(0.8775520324707), wave * DC.ar(0.75776815414429), wave * DC.ar(0.97367751598358), wave * DC.ar(0.78340661525726), wave * DC.ar(0.19299173355103)), OscN.ar(wave * DC.ar(0.18230831623077), wave * DC.ar(0.29860019683838), wave * DC.ar(0.65051913261414), wave * DC.ar(0.64041769504547), wave * DC.ar(0.7610776424408))], modX * varX97MNor1746349);
varX97MNor17463410 = ChuaL.ar(wave * DC.ar(0.38292336463928), wave * DC.ar(0.99005401134491), wave * DC.ar(0.5405113697052), wave * DC.ar(0.67974948883057), wave * DC.ar(0.178830742836), wave * DC.ar(0.44326937198639), wave * DC.ar(0.11113083362579), wave * DC.ar(0.11540198326111), wave * DC.ar(0.91820406913757), wave * DC.ar(0.71518385410309), wave * DC.ar(0.23855769634247), wave * DC.ar(0.66851258277893));
varX97MNor17463411 = LPCSynth.ar(wave * DC.ar(0.61250460147858), wave * DC.ar(0.97547733783722), wave * DC.ar(0.42064452171326), wave * DC.ar(0.39210176467896), wave * DC.ar(0.23064541816711));
varX97MNor17463412 = NTube.ar(varX97MNor1746349, [CombLP.ar(wave * DC.ar(0.36030030250549), wave * DC.ar(0.20615434646606), wave * DC.ar(0.54622864723206), wave * DC.ar(0.48376560211182), wave * DC.ar(0.6225266456604), wave * DC.ar(0.81155753135681), wave * DC.ar(0.37296497821808), wave * DC.ar(0.67975866794586)), AmpComp.ar(wave * DC.ar(0.14352285861969), wave * DC.ar(0.16191232204437), wave * DC.ar(0.26267719268799))], [IndexL.ar(wave * DC.ar(0.24508035182953), wave * DC.ar(0.029094815254211), wave * DC.ar(0.34801387786865), wave * DC.ar(0.76845705509186)), WhiteNoise.ar(wave * DC.ar(0.51888346672058), wave * DC.ar(0.95743584632874))], [BufAllpassC.ar(wave * DC.ar(0.4690945148468), wave * DC.ar(0.62523257732391), wave * DC.ar(0.71574151515961), wave * DC.ar(0.97617769241333), wave * DC.ar(0.67011976242065), wave * DC.ar(0.18456792831421)), DoubleWell3.ar(wave * DC.ar(0.9994193315506), wave * DC.ar(0.4641033411026), wave * DC.ar(0.69097793102264), wave * DC.ar(0.13290667533875), wave * DC.ar(0.8317699432373), wave * DC.ar(0.67410969734192), wave * DC.ar(0.71122789382935), wave * DC.ar(0.81558775901794))], 0.82098823803614 * signal * varX97MNor17463412, Silent.ar());

signal = varX97MNor17463412;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// X97M.Nor1746341
/////////////////////////////////////////////////////////

SynthDef.new("X97M.Nor1746341", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varX97MNor1746349, varX97MNor17463410, varX97MNor17463411, varX97MNor17463412, varX97MNor174634113, varX97MNor174634114, varX97MNor174634115, varX97MNor174634116;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varX97MNor1746349 = varX97MNor17463410 = varX97MNor17463411 = varX97MNor17463412 = varX97MNor174634113 = varX97MNor174634114 = varX97MNor174634115 = varX97MNor174634116 = K2A.ar(t_trig).dup;
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
varX97MNor1746349 = Decay2.ar(varX97MNor174634113 * in, varX97MNor17463412, varX97MNor1746349 * varX97MNor174634115, Gbman2DL.ar(wave * DC.ar(0.55708229541779), wave * DC.ar(0.81088256835938), wave * DC.ar(0.16860008239746), wave * DC.ar(0.36549365520477), wave * DC.ar(0.48238742351532), wave * DC.ar(0.29049324989319)), Silent.ar().blend(wave * DC.ar(0.80398631095886), wave * DC.ar(0.96836483478546)));
varX97MNor17463410 = StandardL.ar(varX97MNor17463412 * gateEnv, amp, in * varX97MNor174634113, x, 0.99945815376737 * varX97MNor17463412 * modY, Silent.ar());
varX97MNor17463411 = OSTrunc8.ar(env, varX97MNor174634115);
varX97MNor17463412 = AmpComp.ar(in, varX97MNor17463411, varX97MNor174634113);
varX97MNor1746349 = InGrainB.ar(wave * DC.ar(0.99089956283569), wave * DC.ar(0.52025473117828), wave * DC.ar(0.11497366428375), wave * DC.ar(0.4604252576828), wave * DC.ar(0.42320847511292), wave * DC.ar(0.37370634078979));
varX97MNor17463410 = RHPF.ar(wave * DC.ar(0.91293621063232), wave * DC.ar(0.31363987922668), wave * DC.ar(0.99568748474121), wave * DC.ar(0.55757987499237), wave * DC.ar(0.065598964691162));
varX97MNor17463411 = LPZ1.ar(wave * DC.ar(0.25270068645477), wave * DC.ar(0.52146649360657), wave * DC.ar(0.40665531158447));
varX97MNor17463412 = Metro.ar(wave * DC.ar(0.69970178604126), wave * DC.ar(0.41853070259094), wave * DC.ar(0.82292914390564), wave * DC.ar(0.23116362094879));
// Variation test code
varX97MNor174634113 = BeatWarper.ar(2, Array.fill(2.pow(12), { |i| rrand(-1, 1) }).as(LocalBuf), gateEnv * signal, varX97MNor17463410, varX97MNor1746349 * varX97MNor174634113, bufnum, varX97MNor1746349, y, varX97MNor17463411, Silent.ar());
varX97MNor174634114 = Balance.ar(varX97MNor174634114 * varX97MNor174634114.bipolar(varX97MNor17463411 * DC.ar(0.88393473625183)), varX97MNor174634113 * env, wave, 0.88551235198975 * varX97MNor17463410 * varX97MNor17463412, 0.99993559223373 * wave * modZ, Silent.ar());
varX97MNor174634115 = LPFVS6.ar(varX97MNor17463410 * varX97MNor174634116, varX97MNor17463412, varX97MNor174634116);
varX97MNor174634116 = GrayNoise.ar(0.87272345227987 * Pulse.ar(varX97MNor17463411 * DC.ar(0.58154106140137), varX97MNor17463412 * DC.ar(0.43486630916595), varX97MNor1746349 * DC.ar(0.87836849689484), varX97MNor1746349 * DC.ar(0.957106590271)), AmplitudeMod.ar(varX97MNor1746349 * DC.ar(0.34250926971436), varX97MNor1746349 * DC.ar(0.63015270233154), varX97MNor17463412 * DC.ar(0.97646975517273), varX97MNor1746349 * DC.ar(0.43456602096558), varX97MNor17463411 * DC.ar(0.81602501869202)));
varX97MNor174634113 = Hilbert.ar(varX97MNor174634114, StandardTrig.ar(varX97MNor17463410 * DC.ar(0.64166402816772), varX97MNor17463412 * DC.ar(0.65013015270233), varX97MNor17463411 * DC.ar(0.32617723941803), varX97MNor17463412 * DC.ar(0.63495683670044), varX97MNor17463410 * DC.ar(0.99566900730133), varX97MNor17463410 * DC.ar(0.56127190589905), varX97MNor17463410 * DC.ar(0.93776845932007)).unsignedRightShift(LTI.ar(varX97MNor1746349 * DC.ar(0.078208208084106), varX97MNor17463411 * DC.ar(0.81014955043793), varX97MNor17463412 * DC.ar(0.53706645965576), varX97MNor17463410 * DC.ar(0.39909136295319), varX97MNor17463412 * DC.ar(0.71737253665924))), Silent.ar());
varX97MNor174634114 = EnvDetect.ar(varX97MNor174634115, modY * modZ, env);
varX97MNor174634115 = TDuty.ar(gateEnv * env, signal, varX97MNor174634115, varX97MNor1746349 * modX, gate);
varX97MNor174634116 = BrownNoise.ar(TermanWang.ar(varX97MNor17463412 * DC.ar(0.092315912246704), varX97MNor17463410 * DC.ar(0.19661593437195), varX97MNor17463412 * DC.ar(0.20797097682953), varX97MNor17463412 * DC.ar(0.80008745193481), varX97MNor1746349 * DC.ar(0.64403688907623), varX97MNor17463411 * DC.ar(0.55255270004272), varX97MNor17463412 * DC.ar(0.55824732780457), varX97MNor17463410 * DC.ar(0.27849876880646), varX97MNor17463412 * DC.ar(0.039108395576477), varX97MNor17463410 * DC.ar(0.15746963024139), varX97MNor17463411 * DC.ar(0.20273840427399)), Silent.ar());
varX97MNor174634113 = AnalyseEvents2.ar(modZ * modX, Array.fill(2.pow(15), { |i| rrand(-1, 1) }).as(LocalBuf), 0.83615303039551 * varX97MNor174634114, varX97MNor17463412 * modZ, env * varX97MNor17463411, varX97MNor1746349);
varX97MNor174634114 = RLPF.ar(varX97MNor174634114, varX97MNor1746349, y, Integrator.ar(varX97MNor17463412 * DC.ar(0.3816282749176), varX97MNor1746349 * DC.ar(0.14742171764374), varX97MNor17463412 * DC.ar(0.40185117721558), varX97MNor17463411 * DC.ar(0.11573612689972)), Silent.ar());
varX97MNor174634115 = WeaklyNonlinear2.ar(gate, 0.90536773204803 * varX97MNor174634114 * varX97MNor17463412, t_trig, y, VOSIM.ar(varX97MNor17463410 * DC.ar(0.13013505935669), varX97MNor17463412 * DC.ar(0.59704518318176), varX97MNor17463412 * DC.ar(0.76004874706268), varX97MNor17463410 * DC.ar(0.059320211410522), varX97MNor17463411 * DC.ar(0.063449621200562), varX97MNor17463411 * DC.ar(0.60953545570374)).exprange(1, SampleRate.ir).lag2(varX97MNor17463410 * DC.ar(0.79087257385254), varX97MNor17463410 * DC.ar(0.34599673748016)), varX97MNor17463411, modZ * signal, varX97MNor1746349, varX97MNor17463412, varX97MNor1746349 * gateEnv, x, 0.99993887221608 * modX * varX97MNor17463410, Silent.ar());
varX97MNor174634116 = StkMandolin.ar(varX97MNor174634115, amp, in * varX97MNor17463410, OSWrap8.ar(env, varX97MNor174634114 * modZ, in), amp, varX97MNor174634115 * modY, varX97MNor174634114 * modX, SinGrain.ar(varX97MNor17463412 * DC.ar(0.51651334762573), varX97MNor17463410 * DC.ar(0.088189601898193), varX97MNor17463412 * DC.ar(0.36433851718903), varX97MNor17463411 * DC.ar(0.35251939296722), varX97MNor1746349 * DC.ar(0.1328809261322)), Silent.ar());

signal = varX97MNor174634116;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// O97M.Hopper.K174634
/////////////////////////////////////////////////////////

SynthDef.new("O97M.Hopper.K174634", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varO97MHopperK1746349, varO97MHopperK17463410;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varO97MHopperK1746349 = varO97MHopperK17463410 = K2A.ar(t_trig).dup;
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
varO97MHopperK1746349 = TwoTube.ar(signal, signal * modZ, varO97MHopperK17463410 * modY, varO97MHopperK1746349 * env, gateEnv * varO97MHopperK1746349, 0.97729508825836 * env * modZ, YigCliffordC.ar(wave * DC.ar(0.21545958518982), wave * DC.ar(0.10722744464874), wave * DC.ar(0.22770071029663), wave * DC.ar(0.32408010959625), wave * DC.ar(0.73437404632568), wave * DC.ar(0.54666125774384), wave * DC.ar(0.60567259788513), wave * DC.ar(0.68826603889465), wave * DC.ar(0.22343444824219)));
varO97MHopperK17463410 = Blip.ar(Standard2DL.ar(wave * DC.ar(0.7262237071991), wave * DC.ar(0.22647273540497), wave * DC.ar(0.3844438791275), wave * DC.ar(0.32844209671021), wave * DC.ar(0.65642750263214), wave * DC.ar(0.14485466480255), wave * DC.ar(0.21068501472473)).exprange(1, SampleRate.ir), MoogVCF.ar(wave * DC.ar(0.6102306842804), wave * DC.ar(0.16999864578247), wave * DC.ar(0.78714728355408), wave * DC.ar(0.93687152862549), wave * DC.ar(0.66015839576721)), 0.99616853218352 * GlitchHPF.ar(wave * DC.ar(0.24783611297607), wave * DC.ar(0.94261753559113), wave * DC.ar(0.71736454963684), wave * DC.ar(0.32469606399536)), Silent.ar());
varO97MHopperK1746349 = WaveletDaub.ar(gateEnv * varO97MHopperK17463410, 0.93120968341827 * gateEnv * modX, modX * varO97MHopperK1746349.lagud(wave * DC.ar(0.70640099048615), wave * DC.ar(0.061988353729248)), signal, Silent.ar());
varO97MHopperK17463410 = Streson.ar(in * modX, modX * varO97MHopperK17463410, varO97MHopperK17463410, modX, Silent.ar());

signal = varO97MHopperK17463410;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// W97M.Tips.E174635
/////////////////////////////////////////////////////////

SynthDef.new("W97M.Tips.E174635", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varW97MTipsE1746359, varW97MTipsE17463510, varW97MTipsE17463511;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varW97MTipsE1746359 = varW97MTipsE17463510 = varW97MTipsE17463511 = K2A.ar(t_trig).dup;
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
varW97MTipsE1746359 = Delay2.ar(0.95218026638031 * env * modX, varW97MTipsE17463510, Friction.ar(wave * DC.ar(0.061975359916687), wave * DC.ar(0.18555235862732), wave * DC.ar(0.61722576618195), wave * DC.ar(0.65097856521606), wave * DC.ar(0.79846131801605), wave * DC.ar(0.4507120847702), wave * DC.ar(0.53334152698517), wave * DC.ar(0.50989580154419)));
varW97MTipsE17463510 = PulseCount.ar(varW97MTipsE1746359 * varW97MTipsE17463510, island);
varW97MTipsE17463511 = LFNoise1.ar(gateEnv * in, varW97MTipsE17463510, Silent.ar());
varW97MTipsE1746359 = GbmanN.ar(wave * DC.ar(0.93674123287201), wave * DC.ar(0.53155338764191), wave * DC.ar(0.014777302742004), wave * DC.ar(0.40146291255951), wave * DC.ar(0.44554841518402));
varW97MTipsE17463510 = GVerb.ar(modX, 0.065220475196838 * modZ * varW97MTipsE17463511, modX * modY, varW97MTipsE17463510 * gateEnv, x, modZ * in, gateEnv * gateEnv, varW97MTipsE17463511, wave, signal * modX, varW97MTipsE1746359, Silent.ar());
varW97MTipsE17463511 = StereoConvolution2L.ar(wave * DC.ar(0.95930731296539), wave * DC.ar(0.36741507053375), wave * DC.ar(0.28562414646149), wave * DC.ar(0.84233736991882), wave * DC.ar(0.56862699985504), wave * DC.ar(0.98156476020813), wave * DC.ar(0.65739047527313), wave * DC.ar(0.3715283870697));

signal = varW97MTipsE17463511;
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
varAOSReaper6291746369 = InGrainBF.ar(MoogLadder.ar(wave * DC.ar(0.2026698589325), wave * DC.ar(0.69402885437012), wave * DC.ar(0.31487262248993), wave * DC.ar(0.50308895111084), wave * DC.ar(0.949258685112)), modZ, 0.66345846652985 * in * varAOSReaper62917463610, varAOSReaper6291746369 * gateEnv, signal * wave, FhnTrig.ar(wave * DC.ar(0.21991968154907), wave * DC.ar(0.095365762710571), wave * DC.ar(0.95671093463898), wave * DC.ar(0.50320112705231), wave * DC.ar(0.90032947063446), wave * DC.ar(0.89542675018311), wave * DC.ar(0.90705990791321), wave * DC.ar(0.41636192798615), wave * DC.ar(0.50506246089935), wave * DC.ar(0.15991961956024), wave * DC.ar(0.52471244335175)), signal * in, 0.93290921424655 * modY * varAOSReaper6291746369, Silent.ar());
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
// Eumel.347.D(2)174637
/////////////////////////////////////////////////////////

SynthDef.new("Eumel.347.D(2)174637", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varEumel347D21746379, varEumel347D217463710, varEumel347D217463711, varEumel347D217463712;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varEumel347D21746379 = varEumel347D217463710 = varEumel347D217463711 = varEumel347D217463712 = K2A.ar(t_trig).dup;
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
varEumel347D21746379 = BinData.ar(Array.fill(2.pow(15), { |i| rrand(-1, 1) }).as(LocalBuf), signal * varEumel347D217463711.lag2ud(wave * DC.ar(0.42797672748566), wave * DC.ar(0.95142018795013)), varEumel347D21746379 * gateEnv);
varEumel347D217463710 = StkShakers.ar(varEumel347D217463710 * in, in, modX, varEumel347D217463711 * modX, signal, in, Silent.ar());
varEumel347D217463711 = Brusselator.ar(modX * modZ, varEumel347D217463711 * varEumel347D217463711, wave * modY, island, in, 0.2910418510437 * varEumel347D21746379 * modZ, 0.83864209607032 * wave * modY, Silent.ar());
varEumel347D217463712 = CombC.ar(wave, y, 0.9136506319046 * modY * signal, env * in, varEumel347D217463710, Silent.ar());
varEumel347D21746379 = FoaDirectX.ar(y, gate, 0.99994365369458 * modZ * varEumel347D21746379, Silent.ar());
varEumel347D217463710 = RedPhasor.ar(modX * gateEnv, 0.93661487102509 * varEumel347D21746379 * modZ, signal * varEumel347D21746379, wave * modX.curvelin(wave * DC.ar(0.17267334461212), wave * DC.ar(0.5543999671936), wave * DC.ar(0.94050943851471), wave * DC.ar(0.95347881317139), wave * DC.ar(0.68830502033234), wave * DC.ar(0.70221650600433)), varEumel347D217463711 * varEumel347D217463710, modX, gateEnv);
varEumel347D217463711 = Gbman2DN.ar(wave * DC.ar(0.22859179973602), wave * DC.ar(0.28236424922943), wave * DC.ar(0.84882616996765), wave * DC.ar(0.32360196113586), wave * DC.ar(0.60452270507812), wave * DC.ar(0.61559081077576));
varEumel347D217463712 = RedDPCMencode.ar(varEumel347D217463710 * in, z);

signal = varEumel347D217463712;
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
varBATGoodByA1746399 = BufGrainI.ar(varBATGoodByA17463910 * varBATGoodByA17463911, env, bufnum, modZ * signal, in * in, bufnum, bufnum, modZ * varBATGoodByA1746399, varBATGoodByA17463910 * modZ, OSTrunc8.ar(wave * DC.ar(0.55028998851776), wave * DC.ar(0.40519785881042)), Silent.ar());
varBATGoodByA17463910 = RedLbyl.ar(varBATGoodByA17463911, modZ * modX, modY);
varBATGoodByA17463911 = MoogFF.ar(modX * modY, varBATGoodByA1746399, y, gateEnv * varBATGoodByA1746399, 0.99972051267137 * varBATGoodByA1746399 * signal, Silent.ar());

signal = varBATGoodByA17463911;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// Knight174639
/////////////////////////////////////////////////////////

SynthDef.new("Knight174639", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varKnight1746399, varKnight17463910;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varKnight1746399 = varKnight17463910 = K2A.ar(t_trig).dup;
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
varKnight1746399 = AtsParInfo.ar(Array.fill(2.pow(11), { |i| rrand(-1, 1) }).as(LocalBuf), 0.49239349365234 * env * wave, modY * modZ, 0.99917636912675 * Henon2DC.ar(wave * DC.ar(0.47479689121246), wave * DC.ar(0.61142063140869), wave * DC.ar(0.99314451217651), wave * DC.ar(0.95487523078918), wave * DC.ar(0.32130098342896), wave * DC.ar(0.93174922466278), wave * DC.ar(0.66188430786133), wave * DC.ar(0.43529272079468)), Silent.ar());
varKnight17463910 = Tilt.ar(in * modX, z, wave * env, modZ, LFBrownNoise0.ar(signal * wave, MeanTriggered.ar(wave * DC.ar(0.29738330841064), wave * DC.ar(0.028842687606812), wave * DC.ar(0.2073460817337), wave * DC.ar(0.82063543796539), wave * DC.ar(0.60056829452515)), modX * in, Squiz.ar(wave * DC.ar(0.86119079589844), wave * DC.ar(0.42812585830688), wave * DC.ar(0.72202599048615), wave * DC.ar(0.91182422637939), wave * DC.ar(0.79913806915283), wave * DC.ar(0.48116767406464)), Silent.ar()));
varKnight1746399 = FoaPanB.ar(wave * DC.ar(0.46362972259521), wave * DC.ar(0.62927484512329), wave * DC.ar(0.31859922409058), wave * DC.ar(0.82373952865601), wave * DC.ar(0.88393425941467));
varKnight17463910 = OSWrap8.ar(in * signal, signal * modZ, island);

signal = varKnight17463910;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// XM.Laroux.GZ1746401
/////////////////////////////////////////////////////////

SynthDef.new("XM.Laroux.GZ1746401", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varXMLarouxGZ1746409, varXMLarouxGZ17464010, varXMLarouxGZ17464011, varXMLarouxGZ17464012, varXMLarouxGZ17464013, varXMLarouxGZ17464014, varXMLarouxGZ174640115;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varXMLarouxGZ1746409 = varXMLarouxGZ17464010 = varXMLarouxGZ17464011 = varXMLarouxGZ17464012 = varXMLarouxGZ17464013 = varXMLarouxGZ17464014 = varXMLarouxGZ174640115 = K2A.ar(t_trig).dup;
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
varXMLarouxGZ1746409 = LPF1.ar(varXMLarouxGZ17464010 * gateEnv, signal);
varXMLarouxGZ17464010 = GrainIn.ar(2, Convolution.ar(wave * DC.ar(0.66908144950867), wave * DC.ar(0.022552013397217), wave * DC.ar(0.45768237113953), wave * DC.ar(0.088897347450256), wave * DC.ar(0.79755735397339)), modZ * signal, modX * modX, varXMLarouxGZ17464010, bufnum, 0.21512949466705 * varXMLarouxGZ17464014, varXMLarouxGZ17464014, Silent.ar());
varXMLarouxGZ17464011 = SMS.ar(z, modY * varXMLarouxGZ1746409, env * wave, varXMLarouxGZ17464014 * modX, varXMLarouxGZ17464012 * gateEnv, varXMLarouxGZ17464014, Silent.ar(), in * modY, modY, 0.99995828629527 * varXMLarouxGZ1746409 * gateEnv, Array.fill(2.pow(14), { |i| rrand(-1, 1) }).as(LocalBuf), 0.9824792936164 * signal, Silent.ar().wrap(wave * DC.ar(0.41926634311676), wave * DC.ar(0.54940891265869)));
varXMLarouxGZ17464012 = BufAllpassC.ar(Array.fill(2.pow(14), { |i| rrand(-1, 1) }).as(LocalBuf), env * env, z, varXMLarouxGZ174640115, MonoGrain.ar(wave * DC.ar(0.76062202453613), wave * DC.ar(0.59242260456085), wave * DC.ar(0.71665036678314), wave * DC.ar(0.74741733074188), wave * DC.ar(0.61655616760254), wave * DC.ar(0.99037706851959)), Silent.ar());
varXMLarouxGZ17464013 = Saw.ar(signal * env, XLine.ar(wave * DC.ar(0.24945032596588), wave * DC.ar(0.70681834220886), wave * DC.ar(0.57873892784119), wave * DC.ar(0.46195185184479), wave * DC.ar(0.31256592273712), wave * DC.ar(0.069216012954712)), Silent.ar());
varXMLarouxGZ17464014 = DelayL.ar(varXMLarouxGZ17464011, gate, in, 0.99031162456586 * env * wave, Silent.ar());
varXMLarouxGZ1746409 = PVInfo.ar(wave * DC.ar(0.89379990100861), wave * DC.ar(0.15447056293488), wave * DC.ar(0.5446605682373), wave * DC.ar(0.83924090862274), wave * DC.ar(0.65255236625671));
varXMLarouxGZ17464010 = GrainSin.ar(2, in * varXMLarouxGZ17464010, modX * varXMLarouxGZ174640115, signal * varXMLarouxGZ17464013, gate, bufnum, env * varXMLarouxGZ17464014, 0.99998576371726 * varXMLarouxGZ174640115 * modX, Silent.ar());
varXMLarouxGZ17464011 = SinGrainI.ar(varXMLarouxGZ174640115 * signal, varXMLarouxGZ17464014.range(wave * DC.ar(0.71516788005829), wave * DC.ar(0.47717809677124)), env * env, bufnum, bufnum, modZ * varXMLarouxGZ17464010, 0.9999513875918 * signal * modZ, Silent.ar());
varXMLarouxGZ17464012 = Instruction.ar(wave * DC.ar(0.44570803642273), wave * DC.ar(0.70313310623169), wave * DC.ar(0.1574147939682));
varXMLarouxGZ17464013 = UHJ2B.ar(0.17468881607056 * in * varXMLarouxGZ1746409, signal * gateEnv);
varXMLarouxGZ17464014 = SmoothDecimator.ar(x, env * varXMLarouxGZ17464013, modX * wave, 0.99965160641334 * signal * varXMLarouxGZ17464011, Silent.ar());
// Variation test code
varXMLarouxGZ174640115 = StkVoicForm.ar(varXMLarouxGZ174640115 * in, in, varXMLarouxGZ17464011 * modY, modX, island, modX * varXMLarouxGZ17464011, modZ * wave, 0.99962990681157 * varXMLarouxGZ17464012 * in, Silent.ar());
varXMLarouxGZ174640115 = Standard2DN.ar(Latoocarfian2DN.ar(varXMLarouxGZ17464011 * DC.ar(0.030763268470764), varXMLarouxGZ17464010 * DC.ar(0.58180129528046), varXMLarouxGZ1746409 * DC.ar(0.69477021694183), varXMLarouxGZ17464010 * DC.ar(0.87798130512238), varXMLarouxGZ17464010 * DC.ar(0.19959342479706), varXMLarouxGZ17464011 * DC.ar(0.099283695220947), varXMLarouxGZ17464010 * DC.ar(0.34484279155731), varXMLarouxGZ1746409 * DC.ar(0.73720121383667), varXMLarouxGZ17464014 * DC.ar(0.95836639404297), varXMLarouxGZ17464014 * DC.ar(0.54429566860199)).exprange(1, SampleRate.ir), varXMLarouxGZ17464012, y, env, varXMLarouxGZ1746409, varXMLarouxGZ17464012, Silent.ar());
varXMLarouxGZ174640115 = MedianTriggered.ar(in * varXMLarouxGZ17464014, modY * signal, varXMLarouxGZ17464011 * varXMLarouxGZ174640115, 0.99949292451432 * signal * modZ, Silent.ar());

signal = varXMLarouxGZ174640115;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// HLLO.9999174641
/////////////////////////////////////////////////////////

SynthDef.new("HLLO.9999174641", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varHLLO99991746419, varHLLO999917464110, varHLLO999917464111, varHLLO999917464112, varHLLO999917464113, varHLLO999917464114, varHLLO999917464115;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varHLLO99991746419 = varHLLO999917464110 = varHLLO999917464111 = varHLLO999917464112 = varHLLO999917464113 = varHLLO999917464114 = varHLLO999917464115 = K2A.ar(t_trig).dup;
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
varHLLO99991746419 = DriveNoise.ar(in, varHLLO999917464111 * modZ, 0.99367129685503 * varHLLO99991746419 * varHLLO999917464111);
varHLLO999917464110 = Ringz.ar(island.fold2(AllpassC.ar(wave * DC.ar(0.22310292720795), wave * DC.ar(0.17604064941406), wave * DC.ar(0.19666349887848), wave * DC.ar(0.02678120136261), wave * DC.ar(0.20603954792023), wave * DC.ar(0.40298318862915))), varHLLO999917464114, modY * varHLLO999917464111, 0.99990841262018 * Friction.ar(wave * DC.ar(0.64212000370026), wave * DC.ar(0.83444404602051), wave * DC.ar(0.42416250705719), wave * DC.ar(0.4723596572876), wave * DC.ar(0.80747592449188), wave * DC.ar(0.60161912441254), wave * DC.ar(0.69076633453369), wave * DC.ar(0.0092799663543701)), Silent.ar());
varHLLO999917464111 = Shaper.ar(Array.fill(2.pow(10), { |i| rrand(-1, 1) }).as(LocalBuf), varHLLO999917464112, LTI.ar(wave * DC.ar(0.51455986499786), wave * DC.ar(0.97665750980377), wave * DC.ar(0.65637755393982), wave * DC.ar(0.6946702003479), wave * DC.ar(0.10476660728455)), Silent.ar());
varHLLO999917464112 = PeakEQ4.ar(t_trig, varHLLO999917464113 * varHLLO999917464110, varHLLO999917464113, varHLLO999917464115);
varHLLO999917464113 = Henon2DL.ar(varHLLO999917464110 * varHLLO999917464114, modZ, varHLLO99991746419 * wave, varHLLO999917464114, HilbertFIR.ar(wave * DC.ar(0.18641829490662), wave * DC.ar(0.022659182548523)), modX * varHLLO999917464110.bipolar(wave * DC.ar(0.28125417232513)), TwoTube.ar(wave * DC.ar(0.96568763256073), wave * DC.ar(0.43754816055298), wave * DC.ar(0.87829661369324), wave * DC.ar(0.3384952545166), wave * DC.ar(0.31354510784149), wave * DC.ar(0.94853901863098), wave * DC.ar(0.8030401468277)), Silent.ar());
varHLLO999917464114 = Slope.ar(env, 0.99972413749353 * wave * varHLLO999917464113, Silent.ar());
varHLLO999917464115 = Standard2DC.ar(BufDelayN.ar(wave * DC.ar(0.24142754077911), wave * DC.ar(0.88509953022003), wave * DC.ar(0.06177282333374), wave * DC.ar(0.11217367649078), wave * DC.ar(0.11491358280182)).exprange(1, SampleRate.ir), modX * varHLLO999917464115, varHLLO999917464110, SMS.ar(wave * DC.ar(0.38880062103271), wave * DC.ar(0.81562399864197), wave * DC.ar(0.99147069454193), wave * DC.ar(0.32341265678406), wave * DC.ar(0.68180131912231), wave * DC.ar(0.58076357841492), wave * DC.ar(0.51452922821045), wave * DC.ar(0.24584829807281), wave * DC.ar(0.17693138122559), wave * DC.ar(0.051283955574036), wave * DC.ar(0.35707581043243), wave * DC.ar(0.17902266979218), wave * DC.ar(0.47429645061493)), varHLLO999917464113 * varHLLO999917464111, 0.99985107948808 * varHLLO999917464113 * gateEnv, Silent.ar());
varHLLO99991746419 = Standard2DN.ar(wave * DC.ar(0.72597777843475), wave * DC.ar(0.62328505516052), wave * DC.ar(0.28391015529633), wave * DC.ar(0.18873167037964), wave * DC.ar(0.83821904659271), wave * DC.ar(0.66567468643188), wave * DC.ar(0.85850620269775));
varHLLO999917464110 = NestedAllpassL.ar(varHLLO99991746419, in, varHLLO999917464110, bufnum, varHLLO999917464114 * varHLLO999917464114, 0.22885954380035 * varHLLO999917464111, 0.7310676574707 * in * varHLLO999917464112, WeaklyNonlinear2.ar(wave * DC.ar(0.6443932056427), wave * DC.ar(0.67104268074036), wave * DC.ar(0.60929214954376), wave * DC.ar(0.541752576828), wave * DC.ar(0.76800310611725), wave * DC.ar(0.051994562149048), wave * DC.ar(0.014691829681396), wave * DC.ar(0.13938701152802), wave * DC.ar(0.86360657215118), wave * DC.ar(0.38525521755219), wave * DC.ar(0.52505350112915), wave * DC.ar(0.343217253685), wave * DC.ar(0.23867702484131)), Silent.ar());
varHLLO999917464111 = RunningMax.ar(signal, StkClarinet.ar(wave * DC.ar(0.10915815830231), wave * DC.ar(0.40984356403351), wave * DC.ar(0.44568991661072), wave * DC.ar(0.93140995502472), wave * DC.ar(0.6756306886673), wave * DC.ar(0.10453402996063), wave * DC.ar(0.41535985469818), wave * DC.ar(0.65278542041779), wave * DC.ar(0.95641839504242)));
varHLLO999917464112 = Decimator.ar(0.40257525444031 * wave * varHLLO999917464113, modY * varHLLO999917464114, y, 0.99931077978245 * varHLLO999917464112 * modX, Silent.ar());
varHLLO999917464113 = Lag3.ar(modY * env, varHLLO999917464113, 0.99996718252353 * in * varHLLO999917464114, Silent.ar());
varHLLO999917464114 = Peak.ar(wave * DC.ar(0.21870028972626), wave * DC.ar(0.18354415893555));
varHLLO999917464115 = Gendy4.ar(wave * DC.ar(0.95668065547943), wave * DC.ar(0.8540403842926), wave * DC.ar(0.54572582244873), wave * DC.ar(0.47435629367828), wave * DC.ar(0.37757074832916), wave * DC.ar(0.86962962150574), wave * DC.ar(0.68168795108795), wave * DC.ar(0.25933635234833), wave * DC.ar(0.62021434307098), wave * DC.ar(0.25289559364319), wave * DC.ar(0.048799157142639), wave * DC.ar(0.77058792114258));

signal = varHLLO999917464115;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// JACOV.531174642
/////////////////////////////////////////////////////////

SynthDef.new("JACOV.531174642", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varJACOV5311746429;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varJACOV5311746429 = K2A.ar(t_trig).dup;
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
varJACOV5311746429 = Formant.ar(in, in, Beep.ar(wave * DC.ar(0.13382565975189), wave * DC.ar(0.91378486156464)).exprange(1, SampleRate.ir), 0.99979350053221 * UHJ2B.ar(wave * DC.ar(0.94231605529785), wave * DC.ar(0.029932379722595)), Silent.ar());
varJACOV5311746429 = AtsAmp.ar(Array.fill(2.pow(16), { |i| rrand(-1, 1) }).as(LocalBuf), bufnum, x, 0.96878961790475 * modX * modZ, Silent.ar());

signal = varJACOV5311746429;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// Vien.Dr1746431
/////////////////////////////////////////////////////////

SynthDef.new("Vien.Dr1746431", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varVienDr1746439, varVienDr17464310, varVienDr17464311, varVienDr17464312, varVienDr17464313, varVienDr174643114;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varVienDr1746439 = varVienDr17464310 = varVienDr17464311 = varVienDr17464312 = varVienDr17464313 = varVienDr174643114 = K2A.ar(t_trig).dup;
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
varVienDr1746439 = DelTapWr.ar(Array.fill(2.pow(15), { |i| rrand(-1, 1) }).as(LocalBuf), varVienDr1746439);
varVienDr17464310 = LastValue.ar(t_trig, varVienDr17464313);
varVienDr17464311 = BLowShelf.ar(x, varVienDr17464312, KmeansToBPSet1.ar(wave * DC.ar(0.21580123901367), wave * DC.ar(0.93846690654755), wave * DC.ar(0.9679092168808), wave * DC.ar(0.28872263431549), wave * DC.ar(0.13991677761078), wave * DC.ar(0.60071766376495), wave * DC.ar(0.6330189704895), wave * DC.ar(0.39965558052063), wave * DC.ar(0.18729364871979), wave * DC.ar(0.48913276195526)), signal, MoogFF.ar(wave * DC.ar(0.40476548671722), wave * DC.ar(0.99361097812653), wave * DC.ar(0.62828052043915), wave * DC.ar(0.15402007102966), wave * DC.ar(0.42524361610413), wave * DC.ar(0.13805365562439)), Silent.ar());
varVienDr17464312 = LPCAnalyzer.ar(modX * signal, varVienDr17464310 * varVienDr17464311, 0.94279277324677 * varVienDr1746439 * wave, env * signal, 0.42481768131256 * varVienDr17464310 * modZ, varVienDr17464312 * env.curvelin(wave * DC.ar(0.48748695850372), wave * DC.ar(0.5265896320343), wave * DC.ar(0.43658649921417), wave * DC.ar(0.59798586368561), wave * DC.ar(0.28510165214539), wave * DC.ar(0.065440058708191)), t_trig, varVienDr17464313, Silent.ar());
varVienDr17464313 = SoftClipAmp.ar(bufnum, amp, 0.89380521109058 * varVienDr1746439 * varVienDr17464312, Silent.ar());
varVienDr1746439 = Limiter.ar(0.69815564155579 * env, varVienDr17464312 * gateEnv, gateEnv * varVienDr17464310);
varVienDr17464310 = FoaPsychoShelf.ar(modZ, varVienDr17464313 * env.linexp(wave * DC.ar(0.69817471504211), wave * DC.ar(0.26376271247864), wave * DC.ar(0.063573837280273), wave * DC.ar(0.23224854469299), wave * DC.ar(0.65618133544922)), x, 0.74835515022278 * modY * modY, LFSaw.ar(wave * DC.ar(0.84342730045319), wave * DC.ar(0.45957016944885), wave * DC.ar(0.84347629547119), wave * DC.ar(0.30127596855164)), Silent.ar());
varVienDr17464311 = QuadL.ar(varVienDr17464312, island, z, varVienDr17464313, varVienDr1746439 * modX.curvelin(wave * DC.ar(0.17269968986511), wave * DC.ar(0.41694891452789), wave * DC.ar(0.26275622844696), wave * DC.ar(0.89062750339508), wave * DC.ar(0.085580825805664), wave * DC.ar(0.50390005111694)), 0.99665872276664 * env * modZ, Allpass2.ar(wave * DC.ar(0.63284993171692), wave * DC.ar(0.56977343559265), wave * DC.ar(0.68115770816803), wave * DC.ar(0.43457818031311), wave * DC.ar(0.15543699264526)));
varVienDr17464312 = XFadeRotate.ar(varVienDr1746439 * varVienDr17464310, x);
varVienDr17464313 = TBall.ar(gateEnv * gateEnv, varVienDr17464313 * modY, 0.4673593044281 * Integrator.ar(wave * DC.ar(0.36539041996002), wave * DC.ar(0.6201947927475), wave * DC.ar(0.33753657341003), wave * DC.ar(0.63651144504547)), 0.6672455072403 * wave * modX);
// Variation test code
varVienDr174643114 = Resonz.ar(varVienDr174643114 * in, FoaDirectY.ar(varVienDr17464310 * DC.ar(0.10023260116577), varVienDr17464310 * DC.ar(0.015154361724854), varVienDr17464313 * DC.ar(0.22510159015656), varVienDr17464313 * DC.ar(0.50870740413666)).exprange(1, SampleRate.ir), gate, 0.99974576257566 * gateEnv * in, Silent.ar());
varVienDr174643114 = OneZero.ar(in, modZ, 0.9999272633999 * varVienDr17464313 * varVienDr17464310, Silent.ar());
varVienDr174643114 = Klang.ar(`[[LPF18.ar(varVienDr17464311 * DC.ar(0.26759481430054), varVienDr17464313 * DC.ar(0.22279632091522), varVienDr17464313 * DC.ar(0.29679298400879), varVienDr17464312 * DC.ar(0.30022537708282)), WhiteNoise.ar(varVienDr17464312 * DC.ar(0.3688907623291), varVienDr1746439 * DC.ar(0.25166702270508))], [FBSineL.ar(varVienDr1746439 * DC.ar(0.45991516113281), varVienDr17464310 * DC.ar(0.75115191936493), varVienDr17464312 * DC.ar(0.11483132839203), varVienDr17464311 * DC.ar(0.9908287525177), varVienDr17464312 * DC.ar(0.76166260242462), varVienDr1746439 * DC.ar(0.71781992912292), varVienDr17464312 * DC.ar(0.10215210914612), varVienDr17464311 * DC.ar(0.97695791721344), varVienDr17464312 * DC.ar(0.76972246170044)), MantissaMask.ar(varVienDr17464313 * DC.ar(0.051783204078674), varVienDr17464312 * DC.ar(0.39265656471252), varVienDr17464313 * DC.ar(0.15460073947906), varVienDr17464313 * DC.ar(0.46075701713562))], [BPeakEQ.ar(varVienDr1746439 * DC.ar(0.010358452796936), varVienDr17464311 * DC.ar(0.22316718101501), varVienDr17464312 * DC.ar(0.28171348571777), varVienDr17464310 * DC.ar(0.96307909488678), varVienDr17464313 * DC.ar(0.055817246437073), varVienDr17464310 * DC.ar(0.98192775249481)), RandSeed.ar(varVienDr17464311 * DC.ar(0.32917153835297), varVienDr1746439 * DC.ar(0.2866507768631))]], modX * varVienDr1746439, modY * signal);

signal = varVienDr174643114;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// W32.Inrar174644
/////////////////////////////////////////////////////////

SynthDef.new("W32.Inrar174644", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varW32Inrar1746449, varW32Inrar17464410, varW32Inrar17464411;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varW32Inrar1746449 = varW32Inrar17464410 = varW32Inrar17464411 = K2A.ar(t_trig).dup;
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
varW32Inrar1746449 = StkFlute.ar(gateEnv, t_trig, 0.70872175693512 * in * env, gate, 0.97512175957764 * modZ * varW32Inrar17464410, Silent.ar());
varW32Inrar17464410 = Latch.ar(varW32Inrar1746449 * varW32Inrar17464410, signal * wave);
varW32Inrar17464411 = SawDPW.ar(CrossoverDistortion.ar(wave * DC.ar(0.33446371555328), wave * DC.ar(0.45989012718201), wave * DC.ar(0.56589329242706), wave * DC.ar(0.34159636497498), wave * DC.ar(0.71754992008209)).exprange(1, SampleRate.ir), z, SyncSaw.ar(wave * DC.ar(0.96554529666901), wave * DC.ar(0.52059710025787), wave * DC.ar(0.058939576148987), wave * DC.ar(0.75310552120209)), Silent.ar());
varW32Inrar1746449 = LFNoise0.ar(wave * DC.ar(0.25917232036591), wave * DC.ar(0.40693688392639), wave * DC.ar(0.99801969528198));
varW32Inrar17464410 = Dust2.ar(0.22432208061218 * modZ * in, Balance.ar(wave * DC.ar(0.21974396705627), wave * DC.ar(0.52145612239838), wave * DC.ar(0.85176694393158), wave * DC.ar(0.093258857727051), wave * DC.ar(0.82334041595459), wave * DC.ar(0.8149961233139)), Silent.ar());
varW32Inrar17464411 = Streson.ar(OSFold8.ar(modZ, varW32Inrar17464410, varW32Inrar17464411), varW32Inrar17464410 * modZ, Stepper.ar(modY, y, in * modX, varW32Inrar17464411, in, ZeroCrossing.ar(wave * DC.ar(0.70013272762299))), signal, Silent.ar());

signal = varW32Inrar17464411;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// Galiza.1202174644
/////////////////////////////////////////////////////////

SynthDef.new("Galiza.1202174644", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varGaliza12021746449, varGaliza120217464410, varGaliza120217464411, varGaliza120217464412;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varGaliza12021746449 = varGaliza120217464410 = varGaliza120217464411 = varGaliza120217464412 = K2A.ar(t_trig).dup;
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
varGaliza12021746449 = FMGrain.ar(varGaliza120217464412 * gateEnv, varGaliza12021746449.clip2(FoaDominateZ.ar(wave * DC.ar(0.3453414440155), wave * DC.ar(0.090519666671753), wave * DC.ar(0.11912870407104), wave * DC.ar(0.42626011371613))), gateEnv * gateEnv, in * varGaliza120217464412, 0.015861392021179 * wave * varGaliza12021746449, Tumble.ar(wave * DC.ar(0.9866691827774), wave * DC.ar(0.49603271484375), wave * DC.ar(0.14466714859009), wave * DC.ar(0.55670011043549), wave * DC.ar(0.42306411266327)), Silent.ar());
varGaliza120217464410 = Demand.ar(Lag3.ar(wave * DC.ar(0.89426803588867), wave * DC.ar(0.90582990646362), wave * DC.ar(0.73289275169373), wave * DC.ar(0.051815986633301)), 0.49789571762085 * OSFold8.ar(wave * DC.ar(0.64806318283081), wave * DC.ar(0.64173793792725), wave * DC.ar(0.82802212238312)), wave * varGaliza120217464410);
varGaliza120217464411 = CombL.ar(in * varGaliza12021746449, y, x, env * modY, modX, Silent.ar());
varGaliza120217464412 = AtsSynth.ar(Array.fill(2.pow(15), { |i| rrand(-1, 1) }).as(LocalBuf), varGaliza120217464411 * varGaliza120217464410, modZ, varGaliza120217464411, Squiz.ar(wave * DC.ar(0.34368872642517), wave * DC.ar(0.79323852062225), wave * DC.ar(0.60040640830994), wave * DC.ar(0.87877583503723), wave * DC.ar(0.50613915920258), wave * DC.ar(0.12264502048492)), BFEncodeSter.ar(wave * DC.ar(0.045220971107483), wave * DC.ar(0.9414656162262), wave * DC.ar(0.94150602817535), wave * DC.ar(0.74243438243866), wave * DC.ar(0.69858384132385), wave * DC.ar(0.79743432998657), wave * DC.ar(0.222940325737), wave * DC.ar(0.11372113227844)).exprange(1, SampleRate.ir).bitHammingDistance(AtsParInfo.ar(wave * DC.ar(0.59885382652283), wave * DC.ar(0.13061606884003), wave * DC.ar(0.17935931682587), wave * DC.ar(0.15154647827148), wave * DC.ar(0.30885398387909))), LFBrownNoise1.ar(wave * DC.ar(0.61595714092255), wave * DC.ar(0.36038148403168), wave * DC.ar(0.67890083789825), wave * DC.ar(0.57962715625763), wave * DC.ar(0.48367142677307)).exprange(1, SampleRate.ir), modY, Silent.ar());
varGaliza12021746449 = FSinOsc.ar(wave * DC.ar(0.94306182861328), wave * DC.ar(0.64907121658325), wave * DC.ar(0.23976123332977), wave * DC.ar(0.0090281963348389));
varGaliza120217464410 = Dust2.ar(y, 0.46281702851015 * CuspL.ar(wave * DC.ar(0.28243434429169), wave * DC.ar(0.25873649120331), wave * DC.ar(0.11526441574097), wave * DC.ar(0.75157284736633), wave * DC.ar(0.63757169246674), wave * DC.ar(0.76630175113678)), Silent.ar());
varGaliza120217464411 = InGrain.ar(wave * DC.ar(0.99887228012085), wave * DC.ar(0.79708898067474), wave * DC.ar(0.8986291885376), wave * DC.ar(0.66524922847748), wave * DC.ar(0.1717289686203));
varGaliza120217464412 = LFDNoise3.ar(modY * wave, 0.99997603689143 * wave * varGaliza120217464412, Silent.ar());

signal = varGaliza120217464412;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// Backdoor.ICQ.Trojan1746451
/////////////////////////////////////////////////////////

SynthDef.new("Backdoor.ICQ.Trojan1746451", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varBackdoorICQTrojan1746459, varBackdoorICQTrojan17464510, varBackdoorICQTrojan174645111;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varBackdoorICQTrojan1746459 = varBackdoorICQTrojan17464510 = varBackdoorICQTrojan174645111 = K2A.ar(t_trig).dup;
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
varBackdoorICQTrojan1746459 = LinCongL.ar(modZ, in, 0.4199401140213 * NLFiltN.ar(wave * DC.ar(0.37778353691101), wave * DC.ar(0.81577455997467), wave * DC.ar(0.21312665939331), wave * DC.ar(0.59818661212921), wave * DC.ar(0.2089307308197), wave * DC.ar(0.65512609481812), wave * DC.ar(0.29296910762787), wave * DC.ar(0.87851476669312)), y, modY * varBackdoorICQTrojan1746459, 0.48938401144618 * wave * signal, Silent.ar());
varBackdoorICQTrojan17464510 = Select.ar(Clipper4.ar(modX, modZ * env, signal), [Convolution.ar(wave * DC.ar(0.010747313499451), wave * DC.ar(0.10600209236145), wave * DC.ar(0.94525957107544), wave * DC.ar(0.21063363552094), wave * DC.ar(0.98359549045563)), RunningMax.ar(wave * DC.ar(0.86619198322296), wave * DC.ar(0.69715344905853))]);
varBackdoorICQTrojan1746459 = Resonz.ar(wave * DC.ar(0.37569427490234), wave * DC.ar(0.60762071609497), wave * DC.ar(0.46013534069061), wave * DC.ar(0.77391672134399), wave * DC.ar(0.12571001052856));
varBackdoorICQTrojan17464510 = RedLbyl.ar(wave * DC.ar(0.014400124549866), wave * DC.ar(0.53907799720764), wave * DC.ar(0.77808737754822));
// Variation test code
varBackdoorICQTrojan174645111 = RosslerResL.ar(0.58901572227478 * varBackdoorICQTrojan174645111, modZ, env * varBackdoorICQTrojan1746459, RandSeed.ar(varBackdoorICQTrojan1746459 * varBackdoorICQTrojan1746459, in), modX * env, in * modX, varBackdoorICQTrojan174645111 * varBackdoorICQTrojan1746459, varBackdoorICQTrojan174645111 * varBackdoorICQTrojan1746459, gateEnv, t_trig.linexp(varBackdoorICQTrojan1746459 * DC.ar(0.15923666954041), varBackdoorICQTrojan17464510 * DC.ar(0.66042923927307), varBackdoorICQTrojan17464510 * DC.ar(0.16844820976257), varBackdoorICQTrojan1746459 * DC.ar(0.19122445583344), varBackdoorICQTrojan17464510 * DC.ar(0.8392618894577)), 0.32231024076318 * in * varBackdoorICQTrojan1746459, Silent.ar());
varBackdoorICQTrojan174645111 = LFDNoise0.ar(modZ * wave, 0.99866352830831 * modX, Silent.ar());
varBackdoorICQTrojan174645111 = AtsPartial.ar(Array.fill(2.pow(11), { |i| rrand(-1, 1) }).as(LocalBuf), WaveletDaub.ar(FMHEncode1.ar(varBackdoorICQTrojan1746459 * DC.ar(0.24987685680389), varBackdoorICQTrojan17464510 * DC.ar(0.42595398426056), varBackdoorICQTrojan1746459 * DC.ar(0.42277014255524), varBackdoorICQTrojan1746459 * DC.ar(0.10697627067566), varBackdoorICQTrojan17464510 * DC.ar(0.88944721221924), varBackdoorICQTrojan1746459 * DC.ar(0.89048683643341)), 0.61594271659851 * varBackdoorICQTrojan174645111 * gateEnv, CoinGate.ar(varBackdoorICQTrojan1746459 * DC.ar(0.83701705932617), varBackdoorICQTrojan1746459 * DC.ar(0.66284656524658)), modY, Silent.ar()), signal * modX, InGrainBF.ar(varBackdoorICQTrojan17464510 * DC.ar(0.71080386638641), varBackdoorICQTrojan1746459 * DC.ar(0.9899308681488), varBackdoorICQTrojan1746459 * DC.ar(0.20370543003082), varBackdoorICQTrojan1746459 * DC.ar(0.94710397720337), varBackdoorICQTrojan1746459 * DC.ar(0.525994181633), varBackdoorICQTrojan1746459 * DC.ar(0.94303894042969), varBackdoorICQTrojan17464510 * DC.ar(0.26797044277191), varBackdoorICQTrojan1746459 * DC.ar(0.90839004516602), varBackdoorICQTrojan1746459 * DC.ar(0.58190143108368)).exprange(1, SampleRate.ir), modY * varBackdoorICQTrojan17464510, modY, Silent.ar());

signal = varBackdoorICQTrojan174645111;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// Offspring.1555174645
/////////////////////////////////////////////////////////

SynthDef.new("Offspring.1555174645", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varOffspring15551746459, varOffspring155517464510, varOffspring155517464511, varOffspring155517464512;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varOffspring15551746459 = varOffspring155517464510 = varOffspring155517464511 = varOffspring155517464512 = K2A.ar(t_trig).dup;
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
varOffspring15551746459 = BeatWarper.ar(2, Array.fill(2.pow(15), { |i| rrand(-1, 1) }).as(LocalBuf), wave * gateEnv, modZ, x, y, varOffspring15551746459 * modX, varOffspring155517464511 * wave, RandSeed.ar(wave * DC.ar(0.47970151901245), wave * DC.ar(0.35020983219147)), Silent.ar());
varOffspring155517464510 = YigCliffordC.ar(varOffspring155517464510 * modX, x, signal, varOffspring155517464512, 0.077809691429138 * modY * env, env, gateEnv, 0.99940129671707 * signal, Silent.ar().lcm(OnePole.ar(wave * DC.ar(0.044353723526001), wave * DC.ar(0.17906010150909), wave * DC.ar(0.50912940502167), wave * DC.ar(0.2410169839859))));
varOffspring155517464511 = TDelay.ar(varOffspring155517464512 * varOffspring155517464511, modX);
varOffspring155517464512 = BPeakEQ.ar(in * varOffspring155517464511, env * signal, modY, varOffspring155517464510, wave, Silent.ar());
varOffspring15551746459 = Maxamp.ar(wave * DC.ar(0.15744972229004), wave * DC.ar(0.83916938304901));
varOffspring155517464510 = AudioMSG.ar(wave * DC.ar(0.33116638660431), wave * DC.ar(0.71338176727295), wave * DC.ar(0.99098634719849), wave * DC.ar(0.96235418319702));
varOffspring155517464511 = BufAllpassL.ar(Array.fill(2.pow(15), { |i| rrand(-1, 1) }).as(LocalBuf), gateEnv * varOffspring155517464510, env, in * modX, 0.99683912379247 * BFEncode2.ar(wave * DC.ar(0.84583902359009), wave * DC.ar(0.2120703458786), wave * DC.ar(0.76256597042084), wave * DC.ar(0.45610725879669), wave * DC.ar(0.57666528224945), wave * DC.ar(0.28402245044708)), Silent.ar());
varOffspring155517464512 = BBandStop.ar(gateEnv * signal, modX * in, wave * varOffspring155517464511, env, FoaPressZ.ar(wave * DC.ar(0.68484365940094), wave * DC.ar(0.17787992954254), wave * DC.ar(0.47774922847748), wave * DC.ar(0.64877557754517)));

signal = varOffspring155517464512;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// PS-MPC.533174646
/////////////////////////////////////////////////////////

SynthDef.new("PS-MPC.533174646", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varPSMPC5331746469, varPSMPC53317464610;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varPSMPC5331746469 = varPSMPC53317464610 = K2A.ar(t_trig).dup;
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
varPSMPC5331746469 = FoaAsymmetry.ar(varPSMPC53317464610 * varPSMPC5331746469, modX, FoaDominateX.ar(wave * DC.ar(0.67188239097595), wave * DC.ar(0.96052658557892), wave * DC.ar(0.96843683719635), wave * DC.ar(0.80034708976746)), Silent.ar());
varPSMPC53317464610 = StereoConvolution2L.ar(modY * gateEnv, in * varPSMPC53317464610, x, modZ * modY, in * wave, island, 0.98462528015045 * in * varPSMPC5331746469, Silent.ar().mod(LagUD.ar(wave * DC.ar(0.27592837810516), wave * DC.ar(0.84851622581482), wave * DC.ar(0.3503851890564), wave * DC.ar(0.65040028095245), wave * DC.ar(0.089457392692566))));
varPSMPC5331746469 = Standard2DC.ar(wave * DC.ar(0.27062845230103), wave * DC.ar(0.69878756999969), wave * DC.ar(0.73228573799133), wave * DC.ar(0.72653877735138), wave * DC.ar(0.59827160835266), wave * DC.ar(0.27752220630646), wave * DC.ar(0.79055833816528));
varPSMPC53317464610 = LFPar.ar(modX * signal, varPSMPC53317464610 * modX, 0.99777236840596 * modY * wave, Silent.ar());

signal = varPSMPC53317464610;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// Miny.333174646
/////////////////////////////////////////////////////////

SynthDef.new("Miny.333174646", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varMiny3331746469, varMiny33317464610, varMiny33317464611, varMiny33317464612, varMiny33317464613, varMiny33317464614, varMiny33317464615;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varMiny3331746469 = varMiny33317464610 = varMiny33317464611 = varMiny33317464612 = varMiny33317464613 = varMiny33317464614 = varMiny33317464615 = K2A.ar(t_trig).dup;
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
varMiny3331746469 = Gendy2.ar(modX, t_trig, 0.68668746948242 * varMiny3331746469 * gateEnv, gateEnv * signal, signal, ArrayMax.ar(wave * DC.ar(0.68547523021698)).exprange(1, SampleRate.ir), in * varMiny33317464613, varMiny33317464611 * modX, SanityCheck.ar(varMiny3331746469), t_trig, 0.89571344852448 * in * varMiny33317464610, varMiny33317464615, env, Silent.ar());
varMiny33317464610 = GrainIn.ar(2, in * in, t_trig, varMiny33317464614 * env, varMiny33317464614, bufnum, gate, Lag.ar(wave * DC.ar(0.99085259437561), wave * DC.ar(0.11654162406921), wave * DC.ar(0.98528456687927), wave * DC.ar(0.97784066200256)), HPZ2.ar(wave * DC.ar(0.38680982589722), wave * DC.ar(0.30798780918121), wave * DC.ar(0.60419642925262)));
varMiny33317464611 = Convolution.ar(x, varMiny33317464612 * varMiny33317464610.wrap(wave * DC.ar(0.19029724597931), wave * DC.ar(0.89655518531799)), wave * env, 0.98306945164221 * varMiny33317464612, Balance.ar(wave * DC.ar(0.55042934417725), wave * DC.ar(0.091925501823425), wave * DC.ar(0.93797957897186), wave * DC.ar(0.80647325515747), wave * DC.ar(0.51463317871094), wave * DC.ar(0.21013975143433)));
varMiny33317464612 = StkMoog.ar(env * wave, varMiny33317464611 * varMiny33317464611, gateEnv * varMiny33317464615, signal, z, modX, wave * signal, varMiny33317464615, Silent.ar());
varMiny33317464613 = CombC.ar(modZ, island, in * modZ, varMiny33317464612 * varMiny33317464611, in, Silent.ar());
varMiny33317464614 = TWindex.ar(modY * varMiny33317464615, [LPZ2.ar(wave * DC.ar(0.89086365699768), wave * DC.ar(0.57341706752777), wave * DC.ar(0.20743584632874)), XFade2.ar(wave * DC.ar(0.60058009624481), wave * DC.ar(0.15825116634369), wave * DC.ar(0.93008661270142), wave * DC.ar(0.37242078781128))], gate);
varMiny33317464615 = CrossoverDistortion.ar(varMiny33317464613, in * varMiny33317464613, amp, 0.59676713452944 * FincoSprottS.ar(wave * DC.ar(0.61699521541595), wave * DC.ar(0.97667813301086), wave * DC.ar(0.82610499858856), wave * DC.ar(0.55611300468445), wave * DC.ar(0.14258027076721), wave * DC.ar(0.063466429710388), wave * DC.ar(0.37428450584412), wave * DC.ar(0.32973170280457), wave * DC.ar(0.48665070533752)), Blip.ar(wave * DC.ar(0.94430494308472), wave * DC.ar(0.15877985954285), wave * DC.ar(0.29445445537567), wave * DC.ar(0.78205215930939)));
varMiny3331746469 = FMHDecode1.ar(varMiny33317464615, varMiny33317464614, gate, bufnum, 0.35841166973114 * modX * signal.thresh(SOS.ar(wave * DC.ar(0.23844933509827), wave * DC.ar(0.12072932720184), wave * DC.ar(0.63585317134857), wave * DC.ar(0.097757816314697), wave * DC.ar(0.49589157104492), wave * DC.ar(0.81101608276367), wave * DC.ar(0.74060881137848), wave * DC.ar(0.29403209686279))), 0.85501837730408 * varMiny33317464610 * gateEnv, varMiny3331746469, env, varMiny33317464613, y, varMiny33317464611 * varMiny33317464610, 0.99969430714865 * wave * gateEnv, Silent.ar());
varMiny33317464610 = OneZero.ar(z, z, SmoothDecimator.ar(wave * DC.ar(0.57099151611328), wave * DC.ar(0.41228210926056), wave * DC.ar(0.12583470344543), wave * DC.ar(0.3065630197525), wave * DC.ar(0.93767523765564)), Decimator.ar(wave * DC.ar(0.77603006362915), wave * DC.ar(0.71034157276154), wave * DC.ar(0.011140465736389), wave * DC.ar(0.57532250881195), wave * DC.ar(0.084549903869629)));
varMiny33317464611 = Pan2.ar(amp, varMiny33317464610 * modZ, modY);
varMiny33317464612 = DelayC.ar(wave * DC.ar(0.30798637866974), wave * DC.ar(0.74763345718384), wave * DC.ar(0.30441749095917), wave * DC.ar(0.12543749809265), wave * DC.ar(0.33670055866241));
varMiny33317464613 = SID6581f.ar(wave * DC.ar(0.14889860153198), wave * DC.ar(0.25818395614624), wave * DC.ar(0.82462573051453), wave * DC.ar(0.79105281829834), wave * DC.ar(0.26440703868866), wave * DC.ar(0.061387777328491), wave * DC.ar(0.35435831546783), wave * DC.ar(0.15069615840912), wave * DC.ar(0.4597384929657), wave * DC.ar(0.32323229312897), wave * DC.ar(0.95998048782349), wave * DC.ar(0.45785677433014), wave * DC.ar(0.23785960674286), wave * DC.ar(0.32806169986725), wave * DC.ar(0.94035577774048), wave * DC.ar(0.041439890861511), wave * DC.ar(0.95954561233521), wave * DC.ar(0.48498642444611), wave * DC.ar(0.58520257472992), wave * DC.ar(0.9849511384964), wave * DC.ar(0.25362753868103), wave * DC.ar(0.032990455627441), wave * DC.ar(0.85223531723022), wave * DC.ar(0.94521164894104), wave * DC.ar(0.24323189258575), wave * DC.ar(0.92797613143921));
varMiny33317464614 = Dust.ar(varMiny3331746469 * modZ, modY, Silent.ar());
varMiny33317464615 = Hasher.ar(gate, 0.89381752228007 * modZ * modZ, Silent.ar());

signal = varMiny33317464615;
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
// Proto.17991746471
/////////////////////////////////////////////////////////

SynthDef.new("Proto.17991746471", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varProto17991746479, varProto179917464710, varProto179917464711, varProto1799174647112, varProto1799174647113, varProto1799174647114, varProto1799174647115;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varProto17991746479 = varProto179917464710 = varProto179917464711 = varProto1799174647112 = varProto1799174647113 = varProto1799174647114 = varProto1799174647115 = K2A.ar(t_trig).dup;
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
varProto17991746479 = Gendy4.ar(wave * varProto179917464710, Crackle.ar(wave * DC.ar(0.18168127536774), wave * DC.ar(0.91589283943176), wave * DC.ar(0.33205497264862)), varProto1799174647113 * wave, env * varProto179917464711, signal * varProto1799174647112.fold(wave * DC.ar(0.10294938087463), wave * DC.ar(0.88088309764862)), signal, island, varProto179917464711 * modY, env * signal, y, varProto17991746479, Silent.ar());
varProto179917464710 = GlitchHPF.ar(varProto179917464710 * varProto1799174647113, varProto179917464710, SMS.ar(wave * DC.ar(0.15284383296967), wave * DC.ar(0.63899195194244), wave * DC.ar(0.09410834312439), wave * DC.ar(0.80063843727112), wave * DC.ar(0.55879545211792), wave * DC.ar(0.99530076980591), wave * DC.ar(0.58941185474396), wave * DC.ar(0.23601770401001), wave * DC.ar(0.33727419376373), wave * DC.ar(0.20135259628296), wave * DC.ar(0.37881326675415), wave * DC.ar(0.68662774562836), wave * DC.ar(0.30615162849426)), Silent.ar());
varProto179917464711 = LFNoise0.ar(modY * varProto179917464710, modY, Silent.ar());
varProto17991746479 = AllpassC.ar(modZ * modZ, modY * modZ, bufnum, modX, 0.99995701852737 * varProto1799174647114 * varProto1799174647114, Silent.ar());
varProto179917464710 = Decimator.ar(wave * DC.ar(0.77514016628265), wave * DC.ar(0.95116829872131), wave * DC.ar(0.12418019771576), wave * DC.ar(0.20375895500183), wave * DC.ar(0.10738217830658));
varProto179917464711 = EnvFollow.ar(wave * DC.ar(0.53936815261841), wave * DC.ar(0.52190470695496), wave * DC.ar(0.49423336982727), wave * DC.ar(0.20567739009857));
// Variation test code
varProto1799174647112 = PitchShift.ar(z.madd(varProto179917464711 * DC.ar(0.12872433662415), varProto179917464711 * DC.ar(0.55247628688812)), Normalizer.ar(t_trig, 0.83930099010468 * varProto179917464711 * modZ, 0.54506313800812 * modZ * varProto179917464710), 0.42647135257721 * varProto1799174647113 * varProto1799174647114, t_trig, varProto179917464710 * modX, gateEnv, Silent.ar());
varProto1799174647113 = WalshHadamard.ar(varProto1799174647114 * varProto1799174647112, x, varProto17991746479, Silent.ar());
varProto1799174647114 = IFFT.ar(Array.fill(2.pow(13), { |i| rrand(-1, 1) }).as(LocalBuf), modY, 0.3474942445755 * wave * varProto1799174647114);
varProto1799174647115 = RLPFD.ar(t_trig, WaveLoss.ar(varProto179917464710 * DC.ar(0.19871401786804), varProto17991746479 * DC.ar(0.42350172996521), varProto17991746479 * DC.ar(0.93405163288116), varProto179917464710 * DC.ar(0.66677224636078), varProto179917464710 * DC.ar(0.075713634490967), varProto179917464711 * DC.ar(0.69533431529999)).exprange(1, SampleRate.ir), modX * varProto1799174647115, varProto1799174647114, 0.99994474859674 * varProto179917464711 * modX.wrap2(YigCliffordC.ar(varProto179917464711 * DC.ar(0.10416579246521), varProto179917464711 * DC.ar(0.29915368556976), varProto179917464710 * DC.ar(0.49519205093384), varProto179917464711 * DC.ar(0.13407516479492), varProto179917464711 * DC.ar(0.41087806224823), varProto179917464711 * DC.ar(0.2477867603302), varProto179917464710 * DC.ar(0.30514430999756), varProto179917464711 * DC.ar(0.06760561466217), varProto179917464711 * DC.ar(0.033683300018311))), SID6581f.ar(varProto179917464711 * DC.ar(0.66242372989655), varProto179917464711 * DC.ar(0.76475381851196), varProto179917464710 * DC.ar(0.82069504261017), varProto179917464711 * DC.ar(0.68855655193329), varProto17991746479 * DC.ar(0.12363374233246), varProto179917464710 * DC.ar(0.65193521976471), varProto179917464710 * DC.ar(0.59869968891144), varProto17991746479 * DC.ar(0.76189541816711), varProto17991746479 * DC.ar(0.063437104225159), varProto17991746479 * DC.ar(0.19866859912872), varProto179917464711 * DC.ar(0.10261118412018), varProto17991746479 * DC.ar(0.82412910461426), varProto179917464711 * DC.ar(0.85042977333069), varProto179917464710 * DC.ar(0.83891928195953), varProto17991746479 * DC.ar(0.38832581043243), varProto179917464710 * DC.ar(0.48107182979584), varProto17991746479 * DC.ar(0.83838617801666), varProto179917464710 * DC.ar(0.9768670797348), varProto17991746479 * DC.ar(0.7751396894455), varProto179917464710 * DC.ar(0.041392683982849), varProto17991746479 * DC.ar(0.24861013889313), varProto179917464711 * DC.ar(0.25291085243225), varProto17991746479 * DC.ar(0.64560759067535), varProto17991746479 * DC.ar(0.5245635509491), varProto179917464711 * DC.ar(0.03263247013092), varProto179917464711 * DC.ar(0.039652585983276)));
varProto1799174647112 = GrainIn.ar(2, in * varProto179917464711, modX * varProto179917464711, x, env, bufnum, z, varProto17991746479, Silent.ar().max(FoaPushZ.ar(varProto179917464710 * DC.ar(0.3211578130722), varProto179917464711 * DC.ar(0.53596365451813), varProto17991746479 * DC.ar(0.22636544704437), varProto179917464710 * DC.ar(0.19580256938934))));
varProto1799174647113 = NL2.ar(signal * modX, Array.fill(2.pow(11), { |i| rrand(-1, 1) }).as(LocalBuf), gate, modX * gateEnv, 0.59499001502991 * wave, amp, 0.99686139802233 * varProto17991746479 * gateEnv, Silent.ar());
varProto1799174647114 = BRZ2.ar(modY * wave, 0.90237074727816 * varProto179917464710 * varProto179917464711, Silent.ar());
varProto1799174647115 = RMEQ.ar(gateEnv * gateEnv, wave * varProto17991746479, modY, gate, 0.99878756586301 * varProto1799174647112 * modX, PVInfo.ar(varProto179917464711 * DC.ar(0.81820106506348), varProto179917464710 * DC.ar(0.81541681289673), varProto17991746479 * DC.ar(0.99681007862091), varProto179917464711 * DC.ar(0.48858022689819), varProto179917464711 * DC.ar(0.39428448677063)));
varProto1799174647112 = Gendy4.ar(varProto1799174647112 * varProto1799174647115, varProto179917464710, 0.97932481765747 * env * modZ, 0.97900688648224 * varProto179917464710 * wave, varProto179917464710 * modZ, in * varProto1799174647113, Pluck.ar(varProto1799174647115 * wave, modZ * env, varProto179917464710, y, signal * varProto179917464711, 0.36077582836151 * varProto1799174647114 * varProto17991746479, CuspL.ar(varProto179917464710 * DC.ar(0.47211444377899), varProto179917464710 * DC.ar(0.044506907463074), varProto179917464710 * DC.ar(0.36474072933197), varProto179917464711 * DC.ar(0.088707685470581), varProto179917464710 * DC.ar(0.76202762126923), varProto17991746479 * DC.ar(0.15534520149231)), Silent.ar()), wave * varProto1799174647114, modZ * wave, varProto179917464710 * modZ, 0.88683024502345 * varProto1799174647114 * in, Silent.ar());
varProto1799174647113 = LFBrownNoise0.ar(signal * modZ, signal * varProto1799174647113, gateEnv * varProto17991746479, YigClifford3DN.ar(varProto179917464711 * DC.ar(0.74574255943298), varProto17991746479 * DC.ar(0.5655859708786), varProto179917464711 * DC.ar(0.063777685165405), varProto179917464711 * DC.ar(0.81212866306305), varProto17991746479 * DC.ar(0.49436128139496), varProto17991746479 * DC.ar(0.91226851940155), varProto179917464710 * DC.ar(0.47837519645691), varProto179917464711 * DC.ar(0.62932002544403), varProto17991746479 * DC.ar(0.35280179977417), varProto179917464711 * DC.ar(0.78343689441681)), Silent.ar());
varProto1799174647114 = Perlin3.ar(varProto1799174647112 * varProto17991746479, env, amp);
varProto1799174647115 = BufAllpassC.ar(Array.fill(2.pow(10), { |i| rrand(-1, 1) }).as(LocalBuf), varProto17991746479, t_trig, 0.50232183933258 * varProto1799174647113 * signal, 0.99904929272498 * varProto1799174647113 * modY, Silent.ar());

signal = varProto1799174647115;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// HLLP.5872174647
/////////////////////////////////////////////////////////

SynthDef.new("HLLP.5872174647", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varHLLP58721746479, varHLLP587217464710;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varHLLP58721746479 = varHLLP587217464710 = K2A.ar(t_trig).dup;
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
varHLLP58721746479 = Schmidt.ar(modZ, modY * varHLLP58721746479, island);
varHLLP587217464710 = OSTrunc4.ar(modY * wave, env);
varHLLP58721746479 = DetectIndex.ar(wave * DC.ar(0.72477996349335), wave * DC.ar(0.70857834815979), wave * DC.ar(0.018001198768616), wave * DC.ar(0.27268004417419));
varHLLP587217464710 = Rotate.ar(gateEnv, in * gateEnv, 0.13427090644836 * modZ * signal, island, 0.63999450206757 * AnalyseEvents2.ar(wave * DC.ar(0.38265550136566), wave * DC.ar(0.68204045295715), wave * DC.ar(0.55106484889984), wave * DC.ar(0.14844989776611), wave * DC.ar(0.23802542686462), wave * DC.ar(0.04874861240387)));

signal = varHLLP587217464710;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// Infector.600174647
/////////////////////////////////////////////////////////

SynthDef.new("Infector.600174647", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varInfector6001746479;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varInfector6001746479 = K2A.ar(t_trig).dup;
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
varInfector6001746479 = Convolution2.ar(varInfector6001746479 * modY, varInfector6001746479 * varInfector6001746479, BufGrainI.ar(wave * DC.ar(0.4602837562561), wave * DC.ar(0.23714363574982), wave * DC.ar(0.32846903800964), wave * DC.ar(0.082571506500244), wave * DC.ar(0.46563673019409), wave * DC.ar(0.40602397918701), wave * DC.ar(0.05452024936676), wave * DC.ar(0.89419782161713), wave * DC.ar(0.61380052566528), wave * DC.ar(0.97594821453094), wave * DC.ar(0.22377908229828)), wave, signal, Silent.ar());
varInfector6001746479 = LFDNoise0.ar(wave * DC.ar(0.874955534935), wave * DC.ar(0.26374042034149), wave * DC.ar(0.36000907421112));

signal = varInfector6001746479;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// KeyPress.1003174648
/////////////////////////////////////////////////////////

SynthDef.new("KeyPress.1003174648", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varKeyPress10031746489;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varKeyPress10031746489 = K2A.ar(t_trig).dup;
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
varKeyPress10031746489 = Nes2.ar(FoaPushX.ar(wave * DC.ar(0.92802536487579), wave * DC.ar(0.57392060756683), wave * DC.ar(0.3447368144989), wave * DC.ar(0.27396428585052)), env * gateEnv, wave * signal, in, 0.20146858692169 * modY * modX, gateEnv, varKeyPress10031746489 * env, gateEnv * in, gateEnv, signal * varKeyPress10031746489, env, y, x, varKeyPress10031746489, in * modZ, varKeyPress10031746489, modY * in, t_trig, gateEnv, varKeyPress10031746489);
varKeyPress10031746489 = VOSIM.ar(wave * modX, modY * env, signal, 0.11237978935242 * modX * in, 0.9928978820145 * modX * env, Silent.ar());

signal = varKeyPress10031746489;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// KeyPress.10031746481
/////////////////////////////////////////////////////////

SynthDef.new("KeyPress.10031746481", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varKeyPress10031746489, varKeyPress1003174648110, varKeyPress1003174648111, varKeyPress1003174648112;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varKeyPress10031746489 = varKeyPress1003174648110 = varKeyPress1003174648111 = varKeyPress1003174648112 = K2A.ar(t_trig).dup;
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
varKeyPress10031746489 = VOSIM.ar(VOsc.ar(wave * DC.ar(0.65168333053589), wave * DC.ar(0.86674225330353), wave * DC.ar(0.85884582996368), wave * DC.ar(0.64600849151611), wave * DC.ar(0.70017302036285)), varKeyPress1003174648110 * modZ, 0.49439191818237 * env * modZ, gate, 0.9999872227663 * ArrayMax.ar(wave * DC.ar(0.63887584209442)), Silent.ar());
varKeyPress10031746489 = LPCVals.ar(Array.fill(2.pow(13), { |i| rrand(-1, 1) }).as(LocalBuf), modX * varKeyPress1003174648110);
// Variation test code
varKeyPress1003174648110 = ScopeOut.ar([DFM1.ar(varKeyPress10031746489 * DC.ar(0.78121769428253), varKeyPress10031746489 * DC.ar(0.62707829475403), varKeyPress10031746489 * DC.ar(0.87747049331665), varKeyPress10031746489 * DC.ar(0.79910516738892), varKeyPress10031746489 * DC.ar(0.017798542976379), varKeyPress10031746489 * DC.ar(0.99101841449738), varKeyPress10031746489 * DC.ar(0.7700080871582), varKeyPress10031746489 * DC.ar(0.16431641578674)), Osc.ar(varKeyPress10031746489 * DC.ar(0.52746951580048), varKeyPress10031746489 * DC.ar(0.44753587245941), varKeyPress10031746489 * DC.ar(0.076271176338196), varKeyPress10031746489 * DC.ar(0.057204484939575), varKeyPress10031746489 * DC.ar(0.81276035308838))], Array.fill(2.pow(11), { |i| rrand(-1, 1) }).as(LocalBuf));
varKeyPress1003174648111 = RegaliaMitraEQ.ar(in * varKeyPress1003174648111, env * varKeyPress1003174648112, wave * env, varKeyPress1003174648112, varKeyPress1003174648111, Silent.ar());
varKeyPress1003174648112 = LFPulse.ar(gateEnv * env, modY * varKeyPress1003174648112, t_trig, wave, Silent.ar());
varKeyPress1003174648110 = BufAllpassL.ar(Array.fill(2.pow(15), { |i| rrand(-1, 1) }).as(LocalBuf), modX * varKeyPress10031746489, island, varKeyPress10031746489 * modX, CuspL.ar(varKeyPress10031746489 * DC.ar(0.76185464859009), varKeyPress10031746489 * DC.ar(0.074775338172913), varKeyPress10031746489 * DC.ar(0.25820922851562), varKeyPress10031746489 * DC.ar(0.2955379486084), varKeyPress10031746489 * DC.ar(0.54019105434418), varKeyPress10031746489 * DC.ar(0.92225337028503)).unipolar(varKeyPress10031746489 * DC.ar(0.70636034011841)), Silent.ar());
varKeyPress1003174648111 = PanX2D.ar(2, 2, varKeyPress1003174648110, modX, in.minNyquist(), varKeyPress1003174648110 * in, amp, env * varKeyPress1003174648112);
varKeyPress1003174648112 = BinData.ar(Array.fill(2.pow(13), { |i| rrand(-1, 1) }).as(LocalBuf).fold(varKeyPress10031746489 * DC.ar(0.018883109092712), varKeyPress10031746489 * DC.ar(0.793252825737)), signal * modY, env * varKeyPress1003174648111);
varKeyPress1003174648110 = LPZ1.ar(modY, 0.99979542660832 * varKeyPress1003174648112, Silent.ar());
varKeyPress1003174648111 = SID6581f.ar(modZ, varKeyPress1003174648112, modY * env, x, gateEnv.linlin(varKeyPress10031746489 * DC.ar(0.18120682239532), varKeyPress10031746489 * DC.ar(0.68462860584259), varKeyPress10031746489 * DC.ar(0.35169064998627), varKeyPress10031746489 * DC.ar(0.28413987159729), varKeyPress10031746489 * DC.ar(0.52850151062012)), x, modX * varKeyPress10031746489, Concat.ar(varKeyPress10031746489 * DC.ar(0.77484977245331), varKeyPress10031746489 * DC.ar(0.034643530845642), varKeyPress10031746489 * DC.ar(0.15558731555939), varKeyPress10031746489 * DC.ar(0.88538956642151), varKeyPress10031746489 * DC.ar(0.75548088550568), varKeyPress10031746489 * DC.ar(0.59726774692535), varKeyPress10031746489 * DC.ar(0.19663119316101), varKeyPress10031746489 * DC.ar(0.24913382530212), varKeyPress10031746489 * DC.ar(0.32255923748016), varKeyPress10031746489 * DC.ar(0.70673406124115), varKeyPress10031746489 * DC.ar(0.1941055059433), varKeyPress10031746489 * DC.ar(0.50489521026611), varKeyPress10031746489 * DC.ar(0.92127919197083), varKeyPress10031746489 * DC.ar(0.92395448684692)).exprange(1, SampleRate.ir), signal * env, modX, z, in, modY, t_trig, signal * varKeyPress1003174648110, varKeyPress1003174648110 * env, bufnum, island, modY, varKeyPress1003174648111 * varKeyPress10031746489, varKeyPress10031746489, in * varKeyPress1003174648111, 0.951420545578 * varKeyPress1003174648111, signal * signal, y, modX);
varKeyPress1003174648112 = Pulse.ar(modZ, varKeyPress1003174648112, 0.97644749039662 * varKeyPress1003174648112 * wave, Silent.ar());

signal = varKeyPress1003174648112;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// Linux.DoS.tfn2k.td174648
/////////////////////////////////////////////////////////

SynthDef.new("Linux.DoS.tfn2k.td174648", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varLinuxDoStfn2ktd1746489, varLinuxDoStfn2ktd17464810, varLinuxDoStfn2ktd17464811, varLinuxDoStfn2ktd17464812, varLinuxDoStfn2ktd17464813;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varLinuxDoStfn2ktd1746489 = varLinuxDoStfn2ktd17464810 = varLinuxDoStfn2ktd17464811 = varLinuxDoStfn2ktd17464812 = varLinuxDoStfn2ktd17464813 = K2A.ar(t_trig).dup;
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
varLinuxDoStfn2ktd1746489 = PulseCount.ar(modZ * modZ, bufnum);
varLinuxDoStfn2ktd17464810 = Perlin3.ar(modX * modY, signal, varLinuxDoStfn2ktd17464813);
varLinuxDoStfn2ktd17464811 = LatoocarfianTrig.ar(varLinuxDoStfn2ktd17464810, signal * signal, x, gateEnv * varLinuxDoStfn2ktd17464813, varLinuxDoStfn2ktd17464811 * signal, varLinuxDoStfn2ktd17464813, varLinuxDoStfn2ktd1746489 * in, gateEnv * modX, LatoocarfianN.ar(wave * DC.ar(0.0028854608535767), wave * DC.ar(0.95340085029602), wave * DC.ar(0.63313114643097), wave * DC.ar(0.14339447021484), wave * DC.ar(0.72599935531616), wave * DC.ar(0.8541088104248), wave * DC.ar(0.55987286567688), wave * DC.ar(0.3137012720108), wave * DC.ar(0.92582321166992)), Silent.ar());
varLinuxDoStfn2ktd17464812 = FoaTilt.ar(varLinuxDoStfn2ktd17464810, varLinuxDoStfn2ktd17464812 * varLinuxDoStfn2ktd17464813, IIRFilter.ar(wave * DC.ar(0.85355710983276), wave * DC.ar(0.96460330486298), wave * DC.ar(0.84374630451202), wave * DC.ar(0.32988333702087), wave * DC.ar(0.025797128677368)), Silent.ar());
varLinuxDoStfn2ktd17464813 = Squiz.ar(varLinuxDoStfn2ktd17464813 * varLinuxDoStfn2ktd17464811, varLinuxDoStfn2ktd17464813 * wave, modZ, varLinuxDoStfn2ktd17464811 * signal, 0.99989557933161 * gateEnv, StkBandedWG.ar(wave * DC.ar(0.20449864864349), wave * DC.ar(0.71396338939667), wave * DC.ar(0.17974781990051), wave * DC.ar(0.445760846138), wave * DC.ar(0.43411803245544), wave * DC.ar(0.48944234848022), wave * DC.ar(0.76188313961029), wave * DC.ar(0.34170389175415), wave * DC.ar(0.97928237915039), wave * DC.ar(0.76922035217285), wave * DC.ar(0.99654114246368)));
varLinuxDoStfn2ktd1746489 = DemandEnvGen.ar(island, signal * modZ, modY, wave * env, 0.045690298080444 * ArrayMax.ar(wave * DC.ar(0.15728151798248)), x, modX * varLinuxDoStfn2ktd1746489, varLinuxDoStfn2ktd17464812, 0.62092399597168 * signal * signal, modY);
varLinuxDoStfn2ktd17464810 = FMGrainBBF.ar(wave * DC.ar(0.1016640663147), wave * DC.ar(0.21087312698364), wave * DC.ar(0.95336699485779), wave * DC.ar(0.76809501647949), wave * DC.ar(0.99224758148193), wave * DC.ar(0.090088367462158), wave * DC.ar(0.31781005859375), wave * DC.ar(0.87103450298309), wave * DC.ar(0.29592335224152), wave * DC.ar(0.839106798172), wave * DC.ar(0.7640368938446), wave * DC.ar(0.8248827457428));
varLinuxDoStfn2ktd17464811 = CoinGate.ar(wave * DC.ar(0.65752589702606), wave * DC.ar(0.0085327625274658));
varLinuxDoStfn2ktd17464812 = FoaPressZ.ar(wave * DC.ar(0.79479682445526), wave * DC.ar(0.84757089614868), wave * DC.ar(0.81195104122162), wave * DC.ar(0.46982848644257));
varLinuxDoStfn2ktd17464813 = SawDPW.ar(modX * in, varLinuxDoStfn2ktd17464812 * in, 0.9965649182608 * modX * varLinuxDoStfn2ktd1746489, Silent.ar());

signal = varLinuxDoStfn2ktd17464813;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// Sebal.2134174649
/////////////////////////////////////////////////////////

SynthDef.new("Sebal.2134174649", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varSebal21341746499, varSebal213417464910, varSebal213417464911;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varSebal21341746499 = varSebal213417464910 = varSebal213417464911 = K2A.ar(t_trig).dup;
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
varSebal21341746499 = OSWrap4.ar(varSebal213417464911 * gateEnv, modX * varSebal213417464910, varSebal213417464911 * modY);
varSebal213417464910 = CompanderD.ar(varSebal213417464910, varSebal213417464911 * env, modX * gateEnv, modY * signal, in, varSebal213417464911, in, Silent.ar());
varSebal213417464911 = GrainSin.ar(2, FoaRotate.ar(wave * DC.ar(0.45005559921265), wave * DC.ar(0.1685483455658), wave * DC.ar(0.55597615242004), wave * DC.ar(0.89770293235779)), signal * modY, signal * varSebal213417464910, signal * modZ, bufnum, wave, 0.26205197052571 * wave * gateEnv, Silent.ar());
varSebal21341746499 = BufGrainB.ar(wave * DC.ar(0.67246091365814), wave * DC.ar(0.95732414722443), wave * DC.ar(0.49464440345764), wave * DC.ar(0.17093753814697), wave * DC.ar(0.81009411811829), wave * DC.ar(0.46619772911072), wave * DC.ar(0.16287648677826), wave * DC.ar(0.16707265377045), wave * DC.ar(0.3836807012558));
varSebal213417464910 = SinOsc.ar(signal * varSebal213417464910, y, 0.84059324099696 * in * gateEnv, Silent.ar());
varSebal213417464911 = IndexInBetween.ar(Array.fill(2.pow(10), { |i| rrand(-1, 1) }).as(LocalBuf), gateEnv * varSebal21341746499, 0.9997525253444 * in * modY, Silent.ar());

signal = varSebal213417464911;
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
// Genc.1000174649
/////////////////////////////////////////////////////////

SynthDef.new("Genc.1000174649", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varGenc10001746499, varGenc100017464910, varGenc100017464911, varGenc100017464912, varGenc100017464913, varGenc100017464914;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varGenc10001746499 = varGenc100017464910 = varGenc100017464911 = varGenc100017464912 = varGenc100017464913 = varGenc100017464914 = K2A.ar(t_trig).dup;
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
varGenc10001746499 = NTube.ar(0.95437932014465 * varGenc10001746499 * modY, [FMHEncode0.ar(wave * DC.ar(0.62182009220123), wave * DC.ar(0.99149489402771), wave * DC.ar(0.950523853302), wave * DC.ar(0.98825359344482)), LFGauss.ar(wave * DC.ar(0.35661041736603), wave * DC.ar(0.99440479278564), wave * DC.ar(0.21843361854553), wave * DC.ar(0.36359095573425), wave * DC.ar(0.56278586387634))].fold(wave * DC.ar(0.61290466785431), wave * DC.ar(0.6944864988327)), [HenonN.ar(wave * DC.ar(0.44267272949219), wave * DC.ar(0.81841576099396), wave * DC.ar(0.87084329128265), wave * DC.ar(0.4955050945282), wave * DC.ar(0.92361223697662), wave * DC.ar(0.92359805107117), wave * DC.ar(0.030103445053101)), StkBandedWG.ar(wave * DC.ar(0.83390438556671), wave * DC.ar(0.014185070991516), wave * DC.ar(0.22621965408325), wave * DC.ar(0.76638567447662), wave * DC.ar(0.4863383769989), wave * DC.ar(0.40901756286621), wave * DC.ar(0.94358944892883), wave * DC.ar(0.78922724723816), wave * DC.ar(0.93803262710571), wave * DC.ar(0.57616221904755), wave * DC.ar(0.028525590896606))], [DoubleNestedAllpassN.ar(wave * DC.ar(0.3595073223114), wave * DC.ar(0.38041722774506), wave * DC.ar(0.99569940567017), wave * DC.ar(0.64751517772675), wave * DC.ar(0.89463722705841), wave * DC.ar(0.21888566017151), wave * DC.ar(0.50488114356995), wave * DC.ar(0.12775015830994), wave * DC.ar(0.68921768665314), wave * DC.ar(0.29468774795532), wave * DC.ar(0.54523301124573), wave * DC.ar(0.17802238464355)), Gendy4.ar(wave * DC.ar(0.9832022190094), wave * DC.ar(0.11443364620209), wave * DC.ar(0.81114792823792), wave * DC.ar(0.36383867263794), wave * DC.ar(0.83966207504272), wave * DC.ar(0.9441659450531), wave * DC.ar(0.30363345146179), wave * DC.ar(0.87540185451508), wave * DC.ar(0.2562563419342), wave * DC.ar(0.89183413982391), wave * DC.ar(0.25307643413544), wave * DC.ar(0.36618971824646))], WaveTerrain.ar(wave * DC.ar(0.79539108276367), wave * DC.ar(0.55945420265198), wave * DC.ar(0.39866089820862), wave * DC.ar(0.79141306877136), wave * DC.ar(0.35968220233917), wave * DC.ar(0.99670577049255), wave * DC.ar(0.49438142776489)), Silent.ar());
varGenc100017464910 = FoaDirectX.ar(varGenc100017464913 * varGenc100017464910, amp, ZeroCrossing.ar(wave * DC.ar(0.97381353378296)), Silent.ar());
varGenc100017464911 = Breakcore.ar(Array.fill(2.pow(16), { |i| rrand(-1, 1) }).as(LocalBuf), t_trig, varGenc100017464912 * in, varGenc10001746499 * gateEnv, wave * env);
varGenc100017464912 = Rotate2.ar(gateEnv * signal, varGenc100017464910, gate);
varGenc100017464913 = BufAllpassL.ar(Array.fill(2.pow(10), { |i| rrand(-1, 1) }).as(LocalBuf).lagud(wave * DC.ar(0.48754131793976), wave * DC.ar(0.57039034366608)), varGenc100017464913, varGenc100017464912, varGenc10001746499 * gateEnv, LFClipNoise.ar(wave * DC.ar(0.64238107204437), wave * DC.ar(0.018818974494934), wave * DC.ar(0.53284668922424)), Silent.ar());
varGenc100017464914 = ZeroCrossing.ar(signal * gateEnv);
varGenc10001746499 = AtsBand.ar(wave * DC.ar(0.19046998023987), wave * DC.ar(0.092389225959778), wave * DC.ar(0.35330426692963), wave * DC.ar(0.51918065547943), wave * DC.ar(0.85964107513428));
varGenc100017464910 = SMS.ar(wave * DC.ar(0.45491635799408), wave * DC.ar(0.66667544841766), wave * DC.ar(0.11691522598267), wave * DC.ar(0.50127029418945), wave * DC.ar(0.94159030914307), wave * DC.ar(0.18209910392761), wave * DC.ar(0.77901244163513), wave * DC.ar(0.70151841640472), wave * DC.ar(0.54968655109406), wave * DC.ar(0.42561256885529), wave * DC.ar(0.56794214248657), wave * DC.ar(0.18028604984283), wave * DC.ar(0.39257562160492));
varGenc100017464911 = LPF1.ar(island, varGenc100017464914);
varGenc100017464912 = LocalIn.ar(2, bufnum);
varGenc100017464913 = RedPhasor.ar(WaveletDaub.ar(wave * DC.ar(0.76562964916229), wave * DC.ar(0.99934136867523), wave * DC.ar(0.0011537075042725), wave * DC.ar(0.52330160140991), wave * DC.ar(0.24656999111176)), varGenc100017464914 * in, env * modZ, varGenc100017464914, z, 0.17818701267242 * modZ * varGenc100017464914, t_trig);
varGenc100017464914 = DelayL.ar(wave * DC.ar(0.52807569503784), wave * DC.ar(0.047939300537109), wave * DC.ar(0.67499732971191), wave * DC.ar(0.1553567647934), wave * DC.ar(0.6081075668335));

signal = varGenc100017464914;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// Script.HE.Flys174650
/////////////////////////////////////////////////////////

SynthDef.new("Script.HE.Flys174650", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varScriptHEFlys1746509, varScriptHEFlys17465010;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varScriptHEFlys1746509 = varScriptHEFlys17465010 = K2A.ar(t_trig).dup;
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
varScriptHEFlys1746509 = PosRatio.ar(env * modY, y, varScriptHEFlys1746509);
varScriptHEFlys17465010 = CircleRamp.ar(IIRFilter.ar(amp, gateEnv * gateEnv, FoaZoomZ.ar(wave * DC.ar(0.040477633476257), wave * DC.ar(0.96800184249878), wave * DC.ar(0.69893491268158), wave * DC.ar(0.93411231040955)), RosslerResL.ar(wave * DC.ar(0.67449700832367), wave * DC.ar(0.26981234550476), wave * DC.ar(0.66786813735962), wave * DC.ar(0.75505471229553), wave * DC.ar(0.44438397884369), wave * DC.ar(0.56408882141113), wave * DC.ar(0.76076126098633), wave * DC.ar(0.96219289302826), wave * DC.ar(0.99633753299713), wave * DC.ar(0.24693262577057), wave * DC.ar(0.55267977714539), wave * DC.ar(0.51546454429626)), UHJ2B.ar(wave * DC.ar(0.03165876865387), wave * DC.ar(0.16919100284576))), TGrains.ar(2, modX * modX, Array.fill(2.pow(14), { |i| rrand(-1, 1) }).as(LocalBuf), gate, 0.78937160968781 * LFNoise0.ar(wave * DC.ar(0.891397356987), wave * DC.ar(0.54102110862732), wave * DC.ar(0.27715134620667)), gateEnv, DC.ar(wave * DC.ar(0.15231490135193)).clip2(Slope.ar(wave * DC.ar(0.76144468784332), wave * DC.ar(0.23764276504517), wave * DC.ar(0.54205584526062))), modY * modZ, modY * modX), in, amp, gateEnv, Silent.ar());
varScriptHEFlys1746509 = XFade2.ar(wave * in, modX, BufDelayL.ar(wave * DC.ar(0.14965808391571), wave * DC.ar(0.52469456195831), wave * DC.ar(0.77051603794098), wave * DC.ar(0.30690908432007), wave * DC.ar(0.51195514202118)), modZ * modZ);
varScriptHEFlys17465010 = DelayC.ar(varScriptHEFlys1746509 * modX, z, modX * modX, env, Silent.ar());

signal = varScriptHEFlys17465010;
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
varBATCom448174651111 = SinGrainIBF.ar(varBATCom448174651112 * varBATCom448174651114, modZ * varBATCom448174651115, env * env, bufnum, bufnum, varBATCom44817465110, in * in, varBATCom4481746519 * varBATCom448174651115, varBATCom448174651113, modY * varBATCom448174651113, AudioMSG.ar(varBATCom4481746519 * DC.ar(0.3825306892395), varBATCom4481746519 * DC.ar(0.84196424484253), varBATCom44817465110 * DC.ar(0.91836655139923), varBATCom44817465110 * DC.ar(0.07641613483429)), Silent.ar());
varBATCom448174651112 = StandardN.ar(modX * wave, 0.32622003555298 * wave * varBATCom448174651111, wave * wave, gate, varBATCom44817465110, Silent.ar());
varBATCom448174651113 = Ramp.ar(gateEnv * modZ, varBATCom448174651114 * varBATCom448174651113, 0.99988006724105 * varBATCom448174651114 * varBATCom448174651112, Silent.ar());
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
// Oxana.747174652
/////////////////////////////////////////////////////////

SynthDef.new("Oxana.747174652", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varOxana7471746529;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varOxana7471746529 = K2A.ar(t_trig).dup;
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
varOxana7471746529 = FBSineC.ar(varOxana7471746529, gateEnv, SinGrainBBF.ar(wave * DC.ar(0.086632966995239), wave * DC.ar(0.79347920417786), wave * DC.ar(0.47607910633087), wave * DC.ar(0.79475212097168), wave * DC.ar(0.81036865711212), wave * DC.ar(0.75353181362152), wave * DC.ar(0.20596420764923), wave * DC.ar(0.77125370502472), wave * DC.ar(0.96136903762817), wave * DC.ar(0.28715538978577)), env * signal, modX * wave, varOxana7471746529 * wave, env * modZ, 0.99724869165104 * modZ, LFClipNoise.ar(wave * DC.ar(0.73751676082611), wave * DC.ar(0.77702462673187), wave * DC.ar(0.024452805519104)));
varOxana7471746529 = OneZero.ar(wave * DC.ar(0.81474733352661), wave * DC.ar(0.1258590221405), wave * DC.ar(0.73721122741699), wave * DC.ar(0.9756418466568));

signal = varOxana7471746529;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// Oxana.7471746521
/////////////////////////////////////////////////////////

SynthDef.new("Oxana.7471746521", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varOxana7471746529, varOxana747174652110;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varOxana7471746529 = varOxana747174652110 = K2A.ar(t_trig).dup;
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
varOxana7471746529 = SineShaper.ar(varOxana7471746529 * env, gateEnv * wave, DriveNoise.ar(wave * DC.ar(0.82879960536957), wave * DC.ar(0.91680824756622), wave * DC.ar(0.24399101734161)), Silent.ar());
varOxana7471746529 = AudioMSG.ar(varOxana7471746529, env, LPF.ar(wave * DC.ar(0.015712141990662), wave * DC.ar(0.91961514949799), wave * DC.ar(0.88877463340759), wave * DC.ar(0.38296627998352)), Silent.ar());
// Variation test code
varOxana747174652110 = AtsPartial.ar(Array.fill(2.pow(12), { |i| rrand(-1, 1) }).as(LocalBuf), varOxana7471746529, modX * env, wave * env, varOxana747174652110 * gateEnv, varOxana747174652110, Silent.ar());
varOxana747174652110 = EnvFollow.ar(z, SoftClipAmp4.ar(in * modY, gateEnv * varOxana747174652110, varOxana7471746529, Silent.ar()), 0.91337492299392 * modX * signal, Silent.ar());
varOxana747174652110 = QuadL.ar(varOxana747174652110 * in.bipolar(varOxana7471746529 * DC.ar(0.047455430030823)), wave * modX, varOxana747174652110 * env, signal, modZ * gateEnv, modZ, LFTri.ar(varOxana7471746529 * DC.ar(0.45111405849457), varOxana7471746529 * DC.ar(0.38834035396576), varOxana7471746529 * DC.ar(0.71916246414185), varOxana7471746529 * DC.ar(0.087513566017151)));

signal = varOxana747174652110;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// WM.Rapi.AM174652
/////////////////////////////////////////////////////////

SynthDef.new("WM.Rapi.AM174652", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varWMRapiAM1746529, varWMRapiAM17465210, varWMRapiAM17465211, varWMRapiAM17465212, varWMRapiAM17465213, varWMRapiAM17465214;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varWMRapiAM1746529 = varWMRapiAM17465210 = varWMRapiAM17465211 = varWMRapiAM17465212 = varWMRapiAM17465213 = varWMRapiAM17465214 = K2A.ar(t_trig).dup;
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
varWMRapiAM1746529 = BLBufRd.ar(Array.fill(2.pow(11), { |i| rrand(-1, 1) }).as(LocalBuf), varWMRapiAM17465213, gateEnv * in);
varWMRapiAM17465210 = LocalOut.ar([Saw.ar(wave * DC.ar(0.15108478069305), wave * DC.ar(0.2088942527771), wave * DC.ar(0.62474846839905)), FMHEncode1.ar(wave * DC.ar(0.33005464076996), wave * DC.ar(0.36848545074463), wave * DC.ar(0.45370328426361), wave * DC.ar(0.5522335767746), wave * DC.ar(0.061391472816467), wave * DC.ar(0.73237574100494))]);
varWMRapiAM17465211 = IndexL.ar(Array.fill(2.pow(14), { |i| rrand(-1, 1) }).as(LocalBuf), varWMRapiAM17465212, 0.94522011547616 * varWMRapiAM17465212 * gateEnv, Silent.ar());
varWMRapiAM17465212 = Pan2.ar(varWMRapiAM17465213 * varWMRapiAM17465211, modY * signal, modY);
varWMRapiAM17465213 = AmpCompA.ar(modY, varWMRapiAM17465210 * modY, x, varWMRapiAM1746529);
varWMRapiAM17465214 = RunningSum.ar(varWMRapiAM17465214 * in, varWMRapiAM1746529);
varWMRapiAM1746529 = Trig.ar(0.64684402942657 * varWMRapiAM17465211, signal * varWMRapiAM17465213);
varWMRapiAM17465210 = Line.ar(modX * modZ, gateEnv * in, z, 0.96530186353945 * signal * varWMRapiAM17465210, Silent.ar(), bufnum);
varWMRapiAM17465211 = InGrainB.ar(wave * DC.ar(0.80377852916718), wave * DC.ar(0.61723601818085), wave * DC.ar(0.054355621337891), wave * DC.ar(0.6085706949234), wave * DC.ar(0.91318607330322), wave * DC.ar(0.99226975440979));
varWMRapiAM17465212 = AmplitudeMod.ar(modZ * varWMRapiAM1746529, signal * varWMRapiAM17465211, modZ * varWMRapiAM17465212, EnvDetect.ar(wave * DC.ar(0.67323172092438), wave * DC.ar(0.19961714744568), wave * DC.ar(0.78891360759735)), Silent.ar().slew(wave * DC.ar(0.49773907661438), wave * DC.ar(0.015880227088928)));
varWMRapiAM17465213 = Demand.ar(varWMRapiAM17465212 * varWMRapiAM1746529, gateEnv, in * varWMRapiAM17465214);
varWMRapiAM17465214 = AllpassN.ar(0.9257824420929 * varWMRapiAM17465212 * varWMRapiAM17465210, x, 0.39115071296692 * varWMRapiAM17465210 * wave, modX, gateEnv, Silent.ar());

signal = varWMRapiAM17465214;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");




/////////////////////////////////////////////////////////
// Bin.Auto.CDY174653
/////////////////////////////////////////////////////////

SynthDef.new("Bin.Auto.CDY174653", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varBinAutoCDY1746539, varBinAutoCDY17465310, varBinAutoCDY17465311, varBinAutoCDY17465312, varBinAutoCDY17465313, varBinAutoCDY17465314, varBinAutoCDY17465315;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varBinAutoCDY1746539 = varBinAutoCDY17465310 = varBinAutoCDY17465311 = varBinAutoCDY17465312 = varBinAutoCDY17465313 = varBinAutoCDY17465314 = varBinAutoCDY17465315 = K2A.ar(t_trig).dup;
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
varBinAutoCDY1746539 = YigClifford3DC.ar(wave * modX, gate, 0.4200724363327 * varBinAutoCDY17465310, 0.385413646698 * gateEnv * env.rightShift(FhnTrig.ar(wave * DC.ar(0.25550961494446), wave * DC.ar(0.88261067867279), wave * DC.ar(0.92715454101562), wave * DC.ar(0.31150543689728), wave * DC.ar(0.48259997367859), wave * DC.ar(0.35978090763092), wave * DC.ar(0.75861740112305), wave * DC.ar(0.099653244018555), wave * DC.ar(0.53624701499939), wave * DC.ar(0.14861965179443), wave * DC.ar(0.94857144355774))), modX, modX, island, t_trig, 0.45798996060438 * Latoocarfian2DL.ar(wave * DC.ar(0.75893020629883), wave * DC.ar(0.60114026069641), wave * DC.ar(0.5993914604187), wave * DC.ar(0.73341488838196), wave * DC.ar(0.027987003326416), wave * DC.ar(0.099898338317871), wave * DC.ar(0.10859262943268), wave * DC.ar(0.25406324863434), wave * DC.ar(0.28887236118317), wave * DC.ar(0.96466267108917)), Silent.ar());
varBinAutoCDY17465310 = Latoocarfian2DC.ar(FoaPanB.ar(wave * DC.ar(0.11746335029602), wave * DC.ar(0.56022429466248), wave * DC.ar(0.74203324317932), wave * DC.ar(0.90165567398071), wave * DC.ar(0.68556761741638)).exprange(1, SampleRate.ir), signal * wave, modX, signal, varBinAutoCDY17465314 * varBinAutoCDY17465314, signal * varBinAutoCDY17465314, modX * in, varBinAutoCDY17465310 * varBinAutoCDY1746539, in, Silent.ar());
varBinAutoCDY17465311 = ZeroCrossing.ar(z);
varBinAutoCDY17465312 = StandardTrig.ar(WhiteNoise.ar(wave * DC.ar(0.56695437431335), wave * DC.ar(0.97549045085907)).exprange(1, SampleRate.ir), modX * wave, bufnum, wave * varBinAutoCDY17465310, amp, 0.99988592591988 * varBinAutoCDY17465312 * in, Silent.ar());
varBinAutoCDY17465313 = DelayN.ar(modZ, in * modZ, env * varBinAutoCDY17465312, 0.98747634020468 * modZ * modZ, Silent.ar());
varBinAutoCDY17465314 = Integrator.ar(varBinAutoCDY17465310 * env, 0.017515897750854 * varBinAutoCDY17465314 * varBinAutoCDY17465312, 0.99998815130237 * modX * in, OSFold4.ar(wave * DC.ar(0.51489365100861), wave * DC.ar(0.59547078609467), wave * DC.ar(0.80312097072601)));
varBinAutoCDY17465315 = SoftClipAmp8.ar(GaussTrig.ar(wave * DC.ar(0.36023318767548), wave * DC.ar(0.066468477249146), wave * DC.ar(0.30599117279053), wave * DC.ar(0.71397316455841)), signal, gateEnv, Silent.ar());
varBinAutoCDY1746539 = Line.ar(varBinAutoCDY1746539 * modZ, varBinAutoCDY1746539, in * gateEnv, DegreeToKey.ar(wave * DC.ar(0.55611658096313), wave * DC.ar(0.45572805404663), wave * DC.ar(0.91798579692841), wave * DC.ar(0.19008612632751), wave * DC.ar(0.043915510177612)), Silent.ar(), 0.74695992469788 * varBinAutoCDY17465312 * modZ);
varBinAutoCDY17465310 = AllpassC.ar(wave * DC.ar(0.58211421966553), wave * DC.ar(0.85646283626556), wave * DC.ar(0.79765486717224), wave * DC.ar(0.30287730693817), wave * DC.ar(0.31904518604279), wave * DC.ar(0.80959486961365));
varBinAutoCDY17465311 = HenonC.ar(env * wave, varBinAutoCDY17465313 * modZ, varBinAutoCDY17465313 * varBinAutoCDY17465314, varBinAutoCDY17465311 * varBinAutoCDY17465313, 0.61718618869781 * in * varBinAutoCDY17465311, FBSineN.ar(wave * DC.ar(0.91496193408966), wave * DC.ar(0.96035850048065), wave * DC.ar(0.56257820129395), wave * DC.ar(0.23460876941681), wave * DC.ar(0.03106415271759), wave * DC.ar(0.2220504283905), wave * DC.ar(0.76130664348602), wave * DC.ar(0.11190629005432), wave * DC.ar(0.3723030090332)), Silent.ar());
varBinAutoCDY17465312 = LFNoise0.ar(env * varBinAutoCDY17465315, 0.99878697959922 * in * modY, Silent.ar());
varBinAutoCDY17465313 = PeakEQ4.ar(varBinAutoCDY17465311, varBinAutoCDY17465314 * modX, varBinAutoCDY17465311, FSinOsc.ar(varBinAutoCDY17465310 * varBinAutoCDY17465313, SawDPW.ar(wave * DC.ar(0.18614828586578), wave * DC.ar(0.42234790325165), wave * DC.ar(0.57113075256348), wave * DC.ar(0.47764468193054)), 0.74334568786407 * gateEnv * varBinAutoCDY17465313, Silent.ar()));
varBinAutoCDY17465314 = AtsPartial.ar(wave * DC.ar(0.16582798957825), wave * DC.ar(0.66326820850372), wave * DC.ar(0.22885847091675), wave * DC.ar(0.46292805671692), wave * DC.ar(0.047064900398254), wave * DC.ar(0.086732268333435), wave * DC.ar(0.94775986671448));
varBinAutoCDY17465315 = GaussTrig.ar(wave * DC.ar(0.67157554626465), wave * DC.ar(0.62238574028015), wave * DC.ar(0.91519272327423), wave * DC.ar(0.015097260475159));

signal = varBinAutoCDY17465315;
signal = SanityCheck2.ar(signal);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth/resources/");


)

