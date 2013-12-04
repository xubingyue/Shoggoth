//////////////////////////////////////////////////////////////////////////////////////////////////////////
// GeneratedSynthDefs--Fri-Nov-22-20:14:10-2013
//////////////////////////////////////////////////////////////////////////////////////////////////////////

(

/////////////////////////////////////////////////////////
// Belirs.3552012421
/////////////////////////////////////////////////////////

SynthDef.new("Belirs.3552012421", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varBelirs3552012429, varBelirs35520124210, varBelirs35520124211, varBelirs35520124212, varBelirs355201242113, varBelirs355201242114;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varBelirs3552012429 = varBelirs35520124210 = varBelirs35520124211 = varBelirs35520124212 = varBelirs355201242113 = varBelirs355201242114 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varBelirs3552012429 = XFade2.ar(varBelirs3552012429 * modZ, gate, varBelirs3552012429 * varBelirs35520124211, 0.096922397613525 * signal * varBelirs355201242114);
varBelirs35520124210 = EnvGen.ar(varBelirs35520124211 * modY, modY * wave, varBelirs35520124211, modZ, 0.98764967918396 * in, varBelirs35520124210 * varBelirs3552012429);
varBelirs35520124211 = AllpassL.ar(varBelirs35520124211 * varBelirs35520124210, modX * varBelirs35520124210, signal * varBelirs355201242113, varBelirs35520124211, modY, Silent.ar());
varBelirs35520124212 = PanX.ar(2, varBelirs35520124211, t_trig, varBelirs355201242114 * varBelirs355201242114, island);
varBelirs3552012429 = Decimator.ar(varBelirs355201242113, wave * gateEnv, wave, 0.98278322046816 * varBelirs35520124212 * varBelirs3552012429, Silent.ar());
varBelirs35520124210 = Impulse.ar(wave * DC.ar(0.40588223934174), wave * DC.ar(0.22859132289886), wave * DC.ar(0.85101699829102), wave * DC.ar(0.26961576938629));
varBelirs35520124211 = DoubleNestedAllpassC.ar(0.12279546260834 * env * env, in * varBelirs355201242114, varBelirs35520124210 * varBelirs35520124211, bufnum, varBelirs355201242113 * in, y, signal * varBelirs355201242114, varBelirs35520124210 * modY, Normalizer.ar(wave * DC.ar(0.28765845298767), wave * DC.ar(0.29215681552887), wave * DC.ar(0.12415742874146)), gate, 0.99995633301836 * varBelirs3552012429 * signal, Silent.ar());
varBelirs35520124212 = LagUD.ar(wave * DC.ar(0.58236122131348), wave * DC.ar(0.27818858623505), wave * DC.ar(0.84383893013), wave * DC.ar(0.19241797924042), wave * DC.ar(0.99725270271301));
varBelirs3552012429 = B2Ster.ar(wave * DC.ar(0.28368902206421), wave * DC.ar(0.83228099346161), wave * DC.ar(0.90214359760284), wave * DC.ar(0.48305463790894), wave * DC.ar(0.44365513324738));
varBelirs35520124210 = Line.ar(wave * DC.ar(0.096155762672424), wave * DC.ar(0.47893834114075), wave * DC.ar(0.7057933807373), wave * DC.ar(0.49665021896362), wave * DC.ar(0.20454370975494), wave * DC.ar(0.34355473518372));
varBelirs35520124211 = Concat2.ar(wave * DC.ar(0.2144296169281), wave * DC.ar(0.73854720592499), wave * DC.ar(0.38758015632629), wave * DC.ar(0.64436435699463), wave * DC.ar(0.31201088428497), wave * DC.ar(0.99301314353943), wave * DC.ar(0.57450067996979), wave * DC.ar(0.31221508979797), wave * DC.ar(0.63611650466919), wave * DC.ar(0.26649332046509), wave * DC.ar(0.8998349905014), wave * DC.ar(0.13463962078094), wave * DC.ar(0.73102784156799), wave * DC.ar(0.45756852626801), wave * DC.ar(0.84922802448273));
varBelirs35520124212 = FSinOsc.ar(wave * DC.ar(0.56391000747681), wave * DC.ar(0.28751707077026), wave * DC.ar(0.19367218017578), wave * DC.ar(0.04652988910675));
// Variation test code
varBelirs355201242113 = RedDPCMencode.ar(varBelirs35520124212, in * modY);
varBelirs355201242114 = VBAP.ar(2, modY.slew(varBelirs3552012429 * DC.ar(0.27955687046051), varBelirs3552012429 * DC.ar(0.87598896026611)), Array.fill(2.pow(15), { |i| rrand(-1, 1) }).as(LocalBuf), modX * varBelirs355201242114, 0.13017392158508 * modZ, varBelirs355201242114);
varBelirs355201242113 = FincoSprottS.ar(LorenzTrig.ar(varBelirs35520124211 * DC.ar(0.46210491657257), varBelirs3552012429 * DC.ar(0.70306038856506), varBelirs3552012429 * DC.ar(0.094021081924438), varBelirs3552012429 * DC.ar(0.19412815570831), varBelirs35520124210 * DC.ar(0.92505395412445), varBelirs35520124212 * DC.ar(0.64566874504089), varBelirs35520124212 * DC.ar(0.73456799983978), varBelirs35520124211 * DC.ar(0.67754113674164), varBelirs35520124211 * DC.ar(0.76777279376984), varBelirs3552012429 * DC.ar(0.86019456386566), varBelirs3552012429 * DC.ar(0.48950183391571)).exprange(1, SampleRate.ir), HenonN.ar(signal, signal, varBelirs3552012429 * varBelirs35520124211, varBelirs35520124210 * varBelirs35520124211, varBelirs355201242113, 0.98263574956994 * varBelirs355201242113, Silent.ar()), 0.24188113212585 * CombC.ar(varBelirs35520124212 * DC.ar(0.061977863311768), varBelirs35520124211 * DC.ar(0.59827375411987), varBelirs3552012429 * DC.ar(0.73776924610138), varBelirs35520124210 * DC.ar(0.65581178665161), varBelirs35520124211 * DC.ar(0.80198562145233), varBelirs3552012429 * DC.ar(0.25044298171997)), modY * varBelirs35520124212, signal, signal, 0.85952067375183 * Duty.ar(varBelirs35520124212 * DC.ar(0.55727195739746), varBelirs3552012429 * DC.ar(0.47688126564026), varBelirs35520124210 * DC.ar(0.071351647377014), varBelirs35520124210 * DC.ar(0.65896761417389)), 0.95680802832851 * in * gateEnv, LorenzL.ar(varBelirs35520124210 * DC.ar(0.72747409343719), varBelirs35520124212 * DC.ar(0.19696712493896), varBelirs35520124212 * DC.ar(0.2433021068573), varBelirs35520124210 * DC.ar(0.067782878875732), varBelirs35520124211 * DC.ar(0.12032532691956), varBelirs35520124210 * DC.ar(0.21868574619293), varBelirs35520124212 * DC.ar(0.37916660308838), varBelirs35520124212 * DC.ar(0.70571827888489), varBelirs35520124211 * DC.ar(0.31420588493347), varBelirs35520124211 * DC.ar(0.82336807250977)));
varBelirs355201242114 = BPF.ar(varBelirs355201242113 * varBelirs35520124212, wave, varBelirs35520124212 * in, 0.99996051497853 * modY * varBelirs355201242114, Silent.ar());
varBelirs355201242113 = FMGrainI.ar(varBelirs35520124210 * varBelirs35520124210, varBelirs35520124211 * varBelirs355201242114, SoftClipAmp8.ar(varBelirs35520124212 * DC.ar(0.54756283760071), varBelirs35520124211 * DC.ar(0.71637368202209), varBelirs35520124211 * DC.ar(0.25311255455017), varBelirs3552012429 * DC.ar(0.058295130729675)).exprange(1, SampleRate.ir), DemandEnvGen.ar(varBelirs3552012429 * DC.ar(0.60336315631866), varBelirs35520124212 * DC.ar(0.90978670120239), varBelirs35520124210 * DC.ar(0.34388148784637), varBelirs3552012429 * DC.ar(0.70429134368896), varBelirs3552012429 * DC.ar(0.23878371715546), varBelirs35520124212 * DC.ar(0.0060468912124634), varBelirs3552012429 * DC.ar(0.29507148265839), varBelirs3552012429 * DC.ar(0.81523203849792), varBelirs35520124210 * DC.ar(0.61261773109436), varBelirs35520124212 * DC.ar(0.65001547336578)).exprange(1, SampleRate.ir), modZ * varBelirs355201242113, bufnum, bufnum, varBelirs35520124212, 0.99943904218017 * varBelirs35520124211 * modX, Gendy4.ar(varBelirs35520124212 * DC.ar(0.24673068523407), varBelirs35520124211 * DC.ar(0.12397408485413), varBelirs35520124210 * DC.ar(0.39806401729584), varBelirs3552012429 * DC.ar(0.98882472515106), varBelirs35520124210 * DC.ar(0.64375531673431), varBelirs35520124210 * DC.ar(0.52784049510956), varBelirs35520124212 * DC.ar(0.11865425109863), varBelirs35520124210 * DC.ar(0.14432871341705), varBelirs35520124210 * DC.ar(0.15625035762787), varBelirs3552012429 * DC.ar(0.98572087287903), varBelirs35520124211 * DC.ar(0.753573179245), varBelirs35520124211 * DC.ar(0.75705778598785)));
varBelirs355201242114 = Poll.ar(varBelirs3552012429 * gateEnv, env, varBelirs355201242113 * in, varBelirs35520124210 * varBelirs35520124212);

signal = varBelirs355201242114;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// WM.ATOM.K201243
/////////////////////////////////////////////////////////

SynthDef.new("WM.ATOM.K201243", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varWMATOMK2012439, varWMATOMK20124310, varWMATOMK20124311;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varWMATOMK2012439 = varWMATOMK20124310 = varWMATOMK20124311 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varWMATOMK2012439 = Changed.ar(amp, in);
varWMATOMK20124310 = Normalizer.ar(varWMATOMK20124311, modX * modX, env * varWMATOMK20124311);
varWMATOMK20124311 = Balance.ar(t_trig, 0.32345819473267 * A2B.ar(wave * DC.ar(0.38409984111786), wave * DC.ar(0.40691161155701), wave * DC.ar(0.74555397033691), wave * DC.ar(0.59665024280548)), 0.46209299564362 * wave.expexp(wave * DC.ar(0.58584201335907), wave * DC.ar(0.44152081012726), wave * DC.ar(0.37151265144348), wave * DC.ar(0.41879522800446), wave * DC.ar(0.23361170291901)), t_trig, 0.88865893064751 * modZ * env, Silent.ar());
varWMATOMK2012439 = AllpassC.ar(bufnum, in * modX, y, 0.63729226589203 * varWMATOMK20124310 * modX, varWMATOMK20124311.unsignedRightShift(BLowPass.ar(wave * DC.ar(0.19215571880341), wave * DC.ar(0.082723617553711), wave * DC.ar(0.46707630157471), wave * DC.ar(0.9760582447052), wave * DC.ar(0.34348511695862))), PulseCount.ar(wave * DC.ar(0.94150996208191), wave * DC.ar(0.70077931880951)));
varWMATOMK20124310 = StandardTrig.ar(wave, modX * modZ, 0.50594389438629 * Wrap.ar(wave * DC.ar(0.40913653373718), wave * DC.ar(0.7334588766098), wave * DC.ar(0.62659645080566)), amp, wave, 0.99024978794498 * varWMATOMK2012439 * varWMATOMK20124310, MoogFF.ar(wave * DC.ar(0.79676854610443), wave * DC.ar(0.67885112762451), wave * DC.ar(0.97749781608582), wave * DC.ar(0.14571285247803), wave * DC.ar(0.86204063892365), wave * DC.ar(0.15708839893341)));
varWMATOMK20124311 = MonoGrainBF.ar(wave * DC.ar(0.029189229011536), wave * DC.ar(0.11656069755554), wave * DC.ar(0.71997141838074), wave * DC.ar(0.6366240978241), wave * DC.ar(0.50154876708984), wave * DC.ar(0.54899060726166), wave * DC.ar(0.8664311170578), wave * DC.ar(0.87216448783875), wave * DC.ar(0.049315690994263), wave * DC.ar(0.83162295818329), wave * DC.ar(0.26931500434875));
varWMATOMK2012439 = HenonC.ar(wave * DC.ar(0.84759771823883), wave * DC.ar(0.71040368080139), wave * DC.ar(0.027814745903015), wave * DC.ar(0.84787929058075), wave * DC.ar(0.45592164993286), wave * DC.ar(0.035752773284912), wave * DC.ar(0.8674088716507));
varWMATOMK20124310 = FMGrainB.ar(wave * DC.ar(0.50895464420319), wave * DC.ar(0.22676301002502), wave * DC.ar(0.97227728366852), wave * DC.ar(0.48266911506653), wave * DC.ar(0.95508658885956), wave * DC.ar(0.85597705841064), wave * DC.ar(0.49556624889374), wave * DC.ar(0.43442952632904));
varWMATOMK20124311 = FoaZoomY.ar(wave * DC.ar(0.7605277299881), wave * DC.ar(0.66359031200409), wave * DC.ar(0.34875094890594), wave * DC.ar(0.5599672794342));

signal = varWMATOMK20124311;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// WM.Ant.D:Tw201246
/////////////////////////////////////////////////////////

SynthDef.new("WM.Ant.D:Tw201246", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varWMAntDTw2012469, varWMAntDTw20124610, varWMAntDTw20124611, varWMAntDTw20124612;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varWMAntDTw2012469 = varWMAntDTw20124610 = varWMAntDTw20124611 = varWMAntDTw20124612 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varWMAntDTw2012469 = Balance2.ar(signal * varWMAntDTw20124611, env * signal, varWMAntDTw2012469 * varWMAntDTw2012469, varWMAntDTw20124611 * varWMAntDTw2012469);
varWMAntDTw20124610 = Dust2.ar(BufGrainB.ar(wave * DC.ar(0.22288846969604), wave * DC.ar(0.82667660713196), wave * DC.ar(0.54307448863983), wave * DC.ar(0.7473064661026), wave * DC.ar(0.10354578495026), wave * DC.ar(0.24733006954193), wave * DC.ar(0.60669052600861), wave * DC.ar(0.5796902179718), wave * DC.ar(0.77990746498108)), YigClifford3DN.ar(wave * DC.ar(0.16170287132263), wave * DC.ar(0.085451364517212), wave * DC.ar(0.55482351779938), wave * DC.ar(0.33645308017731), wave * DC.ar(0.78803610801697), wave * DC.ar(0.87311351299286), wave * DC.ar(0.059588551521301), wave * DC.ar(0.70454370975494), wave * DC.ar(0.88549113273621), wave * DC.ar(0.59774172306061)), Silent.ar());
varWMAntDTw20124611 = TRand.ar(modZ, x, signal);
varWMAntDTw20124612 = Lorenz2DN.ar(env * modZ, varWMAntDTw20124610 * modY, z, modZ * modZ, modY * modY, y, varWMAntDTw2012469 * varWMAntDTw20124611, island, modZ * in, InGrainB.ar(wave * DC.ar(0.83070242404938), wave * DC.ar(0.31788408756256), wave * DC.ar(0.45370531082153), wave * DC.ar(0.92254209518433), wave * DC.ar(0.60089457035065), wave * DC.ar(0.81536674499512)), Silent.ar());
varWMAntDTw2012469 = GbmanN.ar(BLowShelf.ar(wave * DC.ar(0.73536658287048), wave * DC.ar(0.62816751003265), wave * DC.ar(0.099791169166565), wave * DC.ar(0.76459348201752), wave * DC.ar(0.55344092845917), wave * DC.ar(0.7866587638855)).exprange(1, SampleRate.ir), Spring.ar(wave * DC.ar(0.42411136627197), wave * DC.ar(0.77855336666107), wave * DC.ar(0.80595827102661)), in * wave, IEnvGen.ar(wave * DC.ar(0.87632048130035), wave * DC.ar(0.17781293392181), wave * DC.ar(0.6729462146759), wave * DC.ar(0.6782306432724)), Silent.ar());
varWMAntDTw20124610 = Index.ar(wave * DC.ar(0.31594288349152), wave * DC.ar(0.789510846138), wave * DC.ar(0.84587550163269), wave * DC.ar(0.57691168785095));
varWMAntDTw20124611 = PVInfo.ar(Array.fill(2.pow(14), { |i| rrand(-1, 1) }).as(LocalBuf), 0.50358355045319 * in * varWMAntDTw20124612, 0.41108357906342 * wave * in, 0.99496608978466 * modX * in, Silent.ar());
varWMAntDTw20124612 = Balance2.ar(wave * DC.ar(0.074887037277222), wave * DC.ar(0.99047386646271), wave * DC.ar(0.8660477399826), wave * DC.ar(0.075038313865662));
varWMAntDTw2012469 = SinOsc.ar(wave * DC.ar(0.6735907793045), wave * DC.ar(0.93296194076538), wave * DC.ar(0.064016580581665), wave * DC.ar(0.23029673099518));
varWMAntDTw20124610 = Streson.ar(wave * DC.ar(0.10932767391205), wave * DC.ar(0.58438718318939), wave * DC.ar(0.15903306007385), wave * DC.ar(0.22424650192261), wave * DC.ar(0.77572917938232));
varWMAntDTw20124611 = LFGauss.ar(wave * DC.ar(0.11281788349152), wave * DC.ar(0.6483690738678), wave * DC.ar(0.79499495029449), wave * DC.ar(0.55009984970093), wave * DC.ar(0.7608106136322));
varWMAntDTw20124612 = XLine.ar(wave * DC.ar(0.7637095451355), wave * DC.ar(0.2209484577179), wave * DC.ar(0.56404805183411), wave * DC.ar(0.36674857139587), wave * DC.ar(0.8558235168457), wave * DC.ar(0.58031952381134));

signal = varWMAntDTw20124612;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// W32.Misif@mm201246
/////////////////////////////////////////////////////////

SynthDef.new("W32.Misif@mm201246", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varW32Misifmm2012469, varW32Misifmm20124610;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varW32Misifmm2012469 = varW32Misifmm20124610 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varW32Misifmm2012469 = B2A.ar(gateEnv, in * modY, bufnum, modX);
varW32Misifmm20124610 = CombC.ar(Formant.ar(wave * DC.ar(0.17483425140381), wave * DC.ar(0.93197977542877), wave * DC.ar(0.15887832641602), wave * DC.ar(0.11850106716156), wave * DC.ar(0.1388601064682)), 0.32399427890778 * signal * modX, bufnum, in, 0.99978970419394 * varW32Misifmm20124610 * modZ, Silent.ar());
varW32Misifmm2012469 = DoubleNestedAllpassC.ar(varW32Misifmm2012469 * wave, modZ, bufnum, varW32Misifmm20124610 * varW32Misifmm2012469, island, modZ * varW32Misifmm20124610, 0.36181235313416 * wave * in, 0.12280523777008 * Nes2.ar(wave * DC.ar(0.86072599887848), wave * DC.ar(0.094513416290283), wave * DC.ar(0.54740273952484), wave * DC.ar(0.96352887153625), wave * DC.ar(0.85802388191223), wave * DC.ar(0.30377876758575), wave * DC.ar(0.77530443668365), wave * DC.ar(0.092689275741577), wave * DC.ar(0.073380351066589), wave * DC.ar(0.13640356063843), wave * DC.ar(0.87464380264282), wave * DC.ar(0.095179796218872), wave * DC.ar(0.10916495323181), wave * DC.ar(0.22416567802429), wave * DC.ar(0.67436921596527), wave * DC.ar(0.12197148799896), wave * DC.ar(0.65741753578186), wave * DC.ar(0.1498167514801), wave * DC.ar(0.49447643756866), wave * DC.ar(0.47444880008698)), in * modZ, gate, 0.92577553355964 * modY, Silent.ar());
varW32Misifmm20124610 = DoubleNestedAllpassN.ar(wave * DC.ar(0.035228133201599), wave * DC.ar(0.049235463142395), wave * DC.ar(0.027068853378296), wave * DC.ar(0.44886136054993), wave * DC.ar(0.21140146255493), wave * DC.ar(0.97139358520508), wave * DC.ar(0.61973810195923), wave * DC.ar(0.67472684383392), wave * DC.ar(0.23275554180145), wave * DC.ar(0.58811235427856), wave * DC.ar(0.44523870944977), wave * DC.ar(0.75728499889374));
varW32Misifmm2012469 = FoaProximity.ar(wave * DC.ar(0.53309416770935), wave * DC.ar(0.10583925247192), wave * DC.ar(0.57729053497314), wave * DC.ar(0.33238351345062));
varW32Misifmm20124610 = AtsPartial.ar(wave * DC.ar(0.62720847129822), wave * DC.ar(0.43559885025024), wave * DC.ar(0.38273870944977), wave * DC.ar(0.040901780128479), wave * DC.ar(0.62931168079376), wave * DC.ar(0.5213178396225), wave * DC.ar(0.40751981735229));

signal = varW32Misifmm20124610;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// WM.TWNO.U:Tw2012481
/////////////////////////////////////////////////////////

SynthDef.new("WM.TWNO.U:Tw2012481", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varWMTWNOUTw2012489, varWMTWNOUTw20124810, varWMTWNOUTw20124811, varWMTWNOUTw201248112;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varWMTWNOUTw2012489 = varWMTWNOUTw20124810 = varWMTWNOUTw20124811 = varWMTWNOUTw201248112 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varWMTWNOUTw2012489 = TGaussRand.ar(modZ, modX * in, varWMTWNOUTw20124811 * modX, HenonTrig.ar(wave * DC.ar(0.68902242183685), wave * DC.ar(0.64204943180084), wave * DC.ar(0.44699454307556), wave * DC.ar(0.98844337463379), wave * DC.ar(0.61739146709442), wave * DC.ar(0.82784163951874), wave * DC.ar(0.74041402339935), wave * DC.ar(0.06888210773468)), Silent.ar());
varWMTWNOUTw20124810 = Astrocade.ar(t_trig, 0.97526025772095 * modY * wave, in, env, signal * varWMTWNOUTw20124810, gateEnv * varWMTWNOUTw20124810, modY, modZ);
varWMTWNOUTw20124811 = InGrainBBF.ar(varWMTWNOUTw20124811 * varWMTWNOUTw2012489, gateEnv * wave, 0.95245325565338 * CuspN.ar(wave * DC.ar(0.1540435552597), wave * DC.ar(0.36047470569611), wave * DC.ar(0.80691730976105), wave * DC.ar(0.48676562309265), wave * DC.ar(0.072472453117371), wave * DC.ar(0.93173778057098)), bufnum, modY * varWMTWNOUTw20124811, 0.69494998455048 * gateEnv * varWMTWNOUTw2012489, 0.37381589412689 * env * varWMTWNOUTw2012489, in, BPeakEQ.ar(wave * DC.ar(0.0051778554916382), wave * DC.ar(0.42140376567841), wave * DC.ar(0.20891380310059), wave * DC.ar(0.20102751255035), wave * DC.ar(0.63671004772186), wave * DC.ar(0.39374470710754)), LastValue.ar(wave * DC.ar(0.17502593994141), wave * DC.ar(0.24472236633301)));
varWMTWNOUTw2012489 = StkModalBar.ar(wave * DC.ar(0.1699321269989), wave * DC.ar(0.37372875213623), wave * DC.ar(0.92378675937653), wave * DC.ar(0.93182826042175), wave * DC.ar(0.75803124904633), wave * DC.ar(0.89425921440125), wave * DC.ar(0.4167537689209), wave * DC.ar(0.71237516403198), wave * DC.ar(0.68782496452332), wave * DC.ar(0.67540550231934), wave * DC.ar(0.04994523525238));
varWMTWNOUTw20124810 = InsideOut.ar(gateEnv * signal, XOut.ar(wave * DC.ar(0.004944920539856), wave * DC.ar(0.35865521430969), wave * DC.ar(0.91574966907501)), Silent.ar());
varWMTWNOUTw20124811 = Pokey.ar(0.31093549728394 * env * varWMTWNOUTw20124811, modX, z, env * modZ, gate, varWMTWNOUTw20124811 * varWMTWNOUTw20124810, NLFiltN.ar(wave * DC.ar(0.023948550224304), wave * DC.ar(0.38396275043488), wave * DC.ar(0.95097887516022), wave * DC.ar(0.28538405895233), wave * DC.ar(0.033527374267578), wave * DC.ar(0.71033704280853), wave * DC.ar(0.500448346138), wave * DC.ar(0.55555105209351)), island, varWMTWNOUTw201248112 * gateEnv);
varWMTWNOUTw2012489 = PosRatio.ar(wave * DC.ar(0.19650626182556), wave * DC.ar(0.76030898094177), wave * DC.ar(0.19115090370178));
varWMTWNOUTw20124810 = AmpCompA.ar(wave * DC.ar(0.53404200077057), wave * DC.ar(0.76719868183136), wave * DC.ar(0.21344304084778), wave * DC.ar(0.38480055332184));
varWMTWNOUTw20124811 = LatoocarfianL.ar(wave * DC.ar(0.977942943573), wave * DC.ar(0.10581076145172), wave * DC.ar(0.43930530548096), wave * DC.ar(0.31699156761169), wave * DC.ar(0.19577527046204), wave * DC.ar(0.1852114200592), wave * DC.ar(0.73451924324036), wave * DC.ar(0.67068588733673), wave * DC.ar(0.067365646362305));
// Variation test code
varWMTWNOUTw201248112 = PeakEQ4.ar(gateEnv, gateEnv, varWMTWNOUTw20124811 * varWMTWNOUTw20124811, modX);
varWMTWNOUTw201248112 = Impulse.ar(env * modX, wave * in, 0.99996186919415 * signal * gateEnv, VarSaw.ar(varWMTWNOUTw20124810 * DC.ar(0.13585925102234), varWMTWNOUTw20124811 * DC.ar(0.86992621421814), varWMTWNOUTw20124810 * DC.ar(0.59268283843994), varWMTWNOUTw20124810 * DC.ar(0.30577301979065), varWMTWNOUTw2012489 * DC.ar(0.48291504383087)));
varWMTWNOUTw201248112 = BLowPass.ar(gateEnv * gateEnv, varWMTWNOUTw201248112 * varWMTWNOUTw20124811, varWMTWNOUTw20124810, BufGrainBF.ar(varWMTWNOUTw20124810 * DC.ar(0.80111277103424), varWMTWNOUTw2012489 * DC.ar(0.4413994550705), varWMTWNOUTw20124810 * DC.ar(0.18114280700684), varWMTWNOUTw2012489 * DC.ar(0.74290895462036), varWMTWNOUTw20124811 * DC.ar(0.84896194934845), varWMTWNOUTw2012489 * DC.ar(0.73530864715576), varWMTWNOUTw20124810 * DC.ar(0.57975006103516), varWMTWNOUTw20124811 * DC.ar(0.88025689125061), varWMTWNOUTw20124810 * DC.ar(0.47617936134338), varWMTWNOUTw2012489 * DC.ar(0.52430772781372), varWMTWNOUTw20124811 * DC.ar(0.47628903388977), varWMTWNOUTw2012489 * DC.ar(0.78079795837402)), LFDNoise1.ar(varWMTWNOUTw20124811 * DC.ar(0.69459331035614), varWMTWNOUTw20124810 * DC.ar(0.17745971679688), varWMTWNOUTw20124810 * DC.ar(0.95920705795288)));

signal = varWMTWNOUTw201248112;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// BAT.Datty201248
/////////////////////////////////////////////////////////

SynthDef.new("BAT.Datty201248", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varBATDatty2012489, varBATDatty20124810, varBATDatty20124811, varBATDatty20124812;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varBATDatty2012489 = varBATDatty20124810 = varBATDatty20124811 = varBATDatty20124812 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varBATDatty2012489 = Gbman2DL.ar(varBATDatty2012489 * in, signal * modZ, in * modZ, varBATDatty20124812 * in, 0.99993990424069 * varBATDatty2012489, Silent.ar());
varBATDatty20124810 = LPF18.ar(modZ * wave, modX, z, env * modY);
varBATDatty20124811 = StkBowed.ar(signal * signal, island, modY * varBATDatty20124810, OneZero.ar(wave * DC.ar(0.22651922702789), wave * DC.ar(0.10598456859589), wave * DC.ar(0.23417687416077), wave * DC.ar(0.71443033218384)).exprange(1, SampleRate.ir).slew(wave * DC.ar(0.18495333194733), wave * DC.ar(0.97210872173309)), modZ, signal, signal * modY.unipolar(wave * DC.ar(0.26753902435303)), env.excess(SinGrainB.ar(wave * DC.ar(0.98262929916382), wave * DC.ar(0.89476490020752), wave * DC.ar(0.78224849700928), wave * DC.ar(0.45228934288025), wave * DC.ar(0.95988357067108), wave * DC.ar(0.6048572063446))), y, varBATDatty20124810, Silent.ar());
varBATDatty20124812 = GrainBuf.ar(2, varBATDatty2012489 * varBATDatty20124812, env, bufnum, wave, 0.73505973815918 * env, modZ * varBATDatty20124810, modZ, bufnum, StkBeeThree.ar(wave * DC.ar(0.82262790203094), wave * DC.ar(0.5206800699234), wave * DC.ar(0.62674999237061), wave * DC.ar(0.90853023529053), wave * DC.ar(0.24489653110504), wave * DC.ar(0.3114105463028), wave * DC.ar(0.12071526050568), wave * DC.ar(0.56839728355408), wave * DC.ar(0.81922936439514)), modY, Limiter.ar(wave * DC.ar(0.085410475730896), wave * DC.ar(0.58093225955963), wave * DC.ar(0.76187908649445)));
varBATDatty2012489 = Slub.ar(wave * DC.ar(0.72063589096069), wave * DC.ar(0.03276538848877));
varBATDatty20124810 = FBSineC.ar(wave * DC.ar(0.32610309123993), wave * DC.ar(0.54744040966034), wave * DC.ar(0.23330843448639), wave * DC.ar(0.081314444541931), wave * DC.ar(0.75257539749146), wave * DC.ar(0.98265027999878), wave * DC.ar(0.02787709236145), wave * DC.ar(0.45280575752258), wave * DC.ar(0.817751288414));
varBATDatty20124811 = TPV.ar(z, wave.mod(FoaDirectO.ar(wave * DC.ar(0.33980131149292), wave * DC.ar(0.2565336227417), wave * DC.ar(0.1196722984314), wave * DC.ar(0.61073207855225))), FoaFocusY.ar(wave * DC.ar(0.34283304214478), wave * DC.ar(0.99839234352112), wave * DC.ar(0.11747527122498), wave * DC.ar(0.086710810661316)), 0.45655703544617 * signal, modY, 0.9968942917628 * env * varBATDatty20124811, varBATDatty2012489, varBATDatty2012489 * env, HilbertFIR.ar(wave * DC.ar(0.071635246276855), wave * DC.ar(0.48491454124451)), Silent.ar());
varBATDatty20124812 = LastValue.ar(varBATDatty2012489, modZ);
varBATDatty2012489 = ToggleFF.ar(wave * DC.ar(0.99863231182098));
varBATDatty20124810 = FMHEncode0.ar(wave * DC.ar(0.15346074104309), wave * DC.ar(0.64428687095642), wave * DC.ar(0.17538332939148), wave * DC.ar(0.364253282547));
varBATDatty20124811 = StandardN.ar(wave * DC.ar(0.1700611114502), wave * DC.ar(0.21110129356384), wave * DC.ar(0.57066535949707), wave * DC.ar(0.18857848644257), wave * DC.ar(0.28561151027679), wave * DC.ar(0.87367534637451));
varBATDatty20124812 = NTube.ar(wave * DC.ar(0.80051863193512), wave * DC.ar(0.21387982368469), wave * DC.ar(0.077415704727173), wave * DC.ar(0.41428124904633), wave * DC.ar(0.54605853557587), wave * DC.ar(0.56621515750885));

signal = varBATDatty20124812;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// VBS.Zambo.Trojan201249
/////////////////////////////////////////////////////////

SynthDef.new("VBS.Zambo.Trojan201249", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varVBSZamboTrojan2012499, varVBSZamboTrojan20124910, varVBSZamboTrojan20124911, varVBSZamboTrojan20124912, varVBSZamboTrojan20124913, varVBSZamboTrojan20124914;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varVBSZamboTrojan2012499 = varVBSZamboTrojan20124910 = varVBSZamboTrojan20124911 = varVBSZamboTrojan20124912 = varVBSZamboTrojan20124913 = varVBSZamboTrojan20124914 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varVBSZamboTrojan2012499 = DoubleNestedAllpassN.ar(varVBSZamboTrojan20124912 * varVBSZamboTrojan20124914, modZ * varVBSZamboTrojan20124913, gateEnv * gateEnv.linlin(wave * DC.ar(0.85401952266693), wave * DC.ar(0.73432731628418), wave * DC.ar(0.51376354694366), wave * DC.ar(0.60375118255615), wave * DC.ar(0.55863964557648)), 0.30205988883972 * env * gateEnv, varVBSZamboTrojan20124910, amp, 0.9901487827301 * env * varVBSZamboTrojan20124910, t_trig, signal, FBSineC.ar(wave * DC.ar(0.60654103755951), wave * DC.ar(0.5520943403244), wave * DC.ar(0.60812282562256), wave * DC.ar(0.27137362957001), wave * DC.ar(0.50443756580353), wave * DC.ar(0.30604434013367), wave * DC.ar(0.65789902210236), wave * DC.ar(0.70642602443695), wave * DC.ar(0.87920439243317)), 0.99808757904885 * GaussTrig.ar(wave * DC.ar(0.31622135639191), wave * DC.ar(0.63688850402832), wave * DC.ar(0.24345076084137), wave * DC.ar(0.93026196956635)), Silent.ar());
varVBSZamboTrojan20124910 = PulseDivider.ar(modZ * signal, StkBlowHole.ar(wave * DC.ar(0.9266471862793), wave * DC.ar(0.97213196754456), wave * DC.ar(0.14350926876068), wave * DC.ar(0.11709344387054), wave * DC.ar(0.027097463607788), wave * DC.ar(0.50574922561646), wave * DC.ar(0.86252975463867), wave * DC.ar(0.38545715808868)), gateEnv * modZ);
varVBSZamboTrojan20124911 = StandardL.ar(wave * gateEnv, y, bufnum, in * signal.ring2(Fhn2DL.ar(wave * DC.ar(0.12478232383728), wave * DC.ar(0.89808189868927), wave * DC.ar(0.66237473487854), wave * DC.ar(0.74006223678589), wave * DC.ar(0.24378776550293), wave * DC.ar(0.24312150478363), wave * DC.ar(0.2006927728653), wave * DC.ar(0.16498124599457), wave * DC.ar(0.78486621379852), wave * DC.ar(0.35523545742035), wave * DC.ar(0.28268587589264))), 0.99997149091741 * varVBSZamboTrojan20124912 * env, Silent.ar());
varVBSZamboTrojan20124912 = InGrainBBF.ar(varVBSZamboTrojan2012499, varVBSZamboTrojan20124913, z, bufnum, island, signal, varVBSZamboTrojan20124912 * signal, varVBSZamboTrojan20124910 * modY, varVBSZamboTrojan20124913, Silent.ar());
varVBSZamboTrojan20124913 = TermanWang.ar(in, env * varVBSZamboTrojan20124911, signal * wave, env * varVBSZamboTrojan20124911, gate, modZ * signal, varVBSZamboTrojan20124910 * varVBSZamboTrojan20124912, modY * modX, varVBSZamboTrojan2012499 * in, env, Convolution2L.ar(wave * DC.ar(0.54314303398132), wave * DC.ar(0.62411248683929), wave * DC.ar(0.40070617198944), wave * DC.ar(0.60483610630035), wave * DC.ar(0.91146290302277), wave * DC.ar(0.72327315807343), wave * DC.ar(0.5524754524231)));
varVBSZamboTrojan20124914 = FoaNFC.ar(wave, varVBSZamboTrojan20124910, 0.91771054793502 * signal * varVBSZamboTrojan20124911, Silent.ar());
varVBSZamboTrojan2012499 = LatoocarfianC.ar(wave * DC.ar(0.19112622737885), wave * DC.ar(0.56214320659637), wave * DC.ar(0.31182420253754), wave * DC.ar(0.54519283771515), wave * DC.ar(0.34461212158203), wave * DC.ar(0.034251689910889), wave * DC.ar(0.71248936653137), wave * DC.ar(0.11373817920685), wave * DC.ar(0.74799644947052));
varVBSZamboTrojan20124910 = RLPF.ar(wave * DC.ar(0.88243508338928), wave * DC.ar(0.97111141681671), wave * DC.ar(0.38425135612488), wave * DC.ar(0.024226903915405), wave * DC.ar(0.048237919807434));
varVBSZamboTrojan20124911 = BLowShelf.ar(wave * DC.ar(0.32083964347839), wave * DC.ar(0.26954877376556), wave * DC.ar(0.95588147640228), wave * DC.ar(0.66066133975983), wave * DC.ar(0.3234611749649), wave * DC.ar(0.42529881000519));
varVBSZamboTrojan20124912 = SpruceBudworm.ar(gateEnv * modY, island, env, x, varVBSZamboTrojan2012499 * varVBSZamboTrojan20124914, varVBSZamboTrojan2012499 * varVBSZamboTrojan20124913, y, in * varVBSZamboTrojan20124913, varVBSZamboTrojan20124911 * varVBSZamboTrojan20124914, y, Gbman2DN.ar(wave * DC.ar(0.016501426696777), wave * DC.ar(0.75294482707977), wave * DC.ar(0.77659904956818), wave * DC.ar(0.73233151435852), wave * DC.ar(0.467613697052), wave * DC.ar(0.96301567554474)), Silent.ar());
varVBSZamboTrojan20124913 = Blip.ar(wave * DC.ar(0.45868539810181), wave * DC.ar(0.10561001300812), wave * DC.ar(0.30324053764343), wave * DC.ar(0.47528564929962));
varVBSZamboTrojan20124914 = FincoSprottS.ar(modY * env, varVBSZamboTrojan20124911 * modY, modY * in, z, modY * modY, in * varVBSZamboTrojan20124913, y, 0.98001887392597 * env * varVBSZamboTrojan2012499, Silent.ar().minNyquist());
varVBSZamboTrojan2012499 = Phasor.ar(wave * DC.ar(0.68789100646973), wave * DC.ar(0.1501157283783), wave * DC.ar(0.0270836353302), wave * DC.ar(0.30216944217682), wave * DC.ar(0.4268411397934));
varVBSZamboTrojan20124910 = BFEncode1.ar(wave * DC.ar(0.26553499698639), wave * DC.ar(0.21361017227173), wave * DC.ar(0.40212726593018), wave * DC.ar(0.10198128223419), wave * DC.ar(0.30142462253571), wave * DC.ar(0.40428912639618));
varVBSZamboTrojan20124911 = SawDPW.ar(wave * DC.ar(0.30105841159821), wave * DC.ar(0.81796669960022), wave * DC.ar(0.0047976970672607), wave * DC.ar(0.01726245880127));
varVBSZamboTrojan20124912 = SwitchDelay.ar(wave * DC.ar(0.037385582923889), wave * DC.ar(0.12534809112549), wave * DC.ar(0.86422276496887), wave * DC.ar(0.83981251716614), wave * DC.ar(0.0024174451828003), wave * DC.ar(0.69642806053162), wave * DC.ar(0.26364552974701), wave * DC.ar(0.72337782382965));
varVBSZamboTrojan20124913 = FoaFocusY.ar(wave * DC.ar(0.89545726776123), wave * DC.ar(0.77846729755402), wave * DC.ar(0.74699199199677), wave * DC.ar(0.57572615146637));
varVBSZamboTrojan20124914 = StkBeeThree.ar(wave * DC.ar(0.043647050857544), wave * DC.ar(0.955970287323), wave * DC.ar(0.73083114624023), wave * DC.ar(0.74758923053741), wave * DC.ar(0.15072298049927), wave * DC.ar(0.14776885509491), wave * DC.ar(0.017112493515015), wave * DC.ar(0.17912042140961), wave * DC.ar(0.89294636249542));

signal = varVBSZamboTrojan20124914;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// SmartSecurity2012501
/////////////////////////////////////////////////////////

SynthDef.new("SmartSecurity2012501", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varSmartSecurity2012509, varSmartSecurity20125010, varSmartSecurity20125011, varSmartSecurity20125012, varSmartSecurity201250113;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varSmartSecurity2012509 = varSmartSecurity20125010 = varSmartSecurity20125011 = varSmartSecurity20125012 = varSmartSecurity201250113 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varSmartSecurity2012509 = BufGrainBF.ar(B2UHJ.ar(wave * DC.ar(0.74412524700165), wave * DC.ar(0.7059942483902), wave * DC.ar(0.21826899051666)), env * modX, bufnum, varSmartSecurity20125012, modY * modY, varSmartSecurity20125010 * varSmartSecurity201250113, modX * varSmartSecurity201250113, signal * varSmartSecurity20125010, modX, varSmartSecurity20125011 * signal, 0.99972030058037 * signal * in, Silent.ar());
varSmartSecurity20125010 = SkipNeedle.ar(modX * varSmartSecurity201250113, varSmartSecurity20125010 * varSmartSecurity2012509, wave * modX);
varSmartSecurity20125011 = StkVoicForm.ar(modX, wave * modZ, varSmartSecurity20125010 * signal, env * varSmartSecurity20125010, gateEnv, varSmartSecurity20125012 * env, varSmartSecurity20125010 * gateEnv, FSinOsc.ar(wave * DC.ar(0.19523859024048), wave * DC.ar(0.4934253692627), wave * DC.ar(0.68957996368408), wave * DC.ar(0.34696269035339)), Silent.ar());
varSmartSecurity20125012 = NestedAllpassC.ar(wave * varSmartSecurity201250113, in * env, signal, amp, x, amp, modX * modY, FoaTumble.ar(wave * DC.ar(0.39221274852753), wave * DC.ar(0.56793141365051), wave * DC.ar(0.11396753787994), wave * DC.ar(0.58474028110504)), Silent.ar());
varSmartSecurity2012509 = OSTrunc8.ar(0.39189076423645 * GbmanN.ar(wave * DC.ar(0.72625231742859), wave * DC.ar(0.80843877792358), wave * DC.ar(0.79563724994659), wave * DC.ar(0.058337807655334), wave * DC.ar(0.38250088691711)), t_trig);
varSmartSecurity20125010 = Pulse.ar(wave * DC.ar(0.84570741653442), wave * DC.ar(0.99033451080322), wave * DC.ar(0.47383594512939), wave * DC.ar(0.87128007411957));
varSmartSecurity20125011 = Fhn2DL.ar(wave * DC.ar(0.54720139503479), wave * DC.ar(0.80385029315948), wave * DC.ar(0.1548033952713), wave * DC.ar(0.98347401618958), wave * DC.ar(0.03611433506012), wave * DC.ar(0.82952320575714), wave * DC.ar(0.58441245555878), wave * DC.ar(0.72188770771027), wave * DC.ar(0.34712338447571), wave * DC.ar(0.67337286472321), wave * DC.ar(0.96071541309357));
varSmartSecurity20125012 = SwitchDelay.ar(wave * DC.ar(0.45824944972992), wave * DC.ar(0.81027781963348), wave * DC.ar(0.044851779937744), wave * DC.ar(0.021752834320068), wave * DC.ar(0.7537397146225), wave * DC.ar(0.40402221679688), wave * DC.ar(0.14468145370483), wave * DC.ar(0.024474859237671));
varSmartSecurity2012509 = AllpassN.ar(wave * DC.ar(0.70249772071838), wave * DC.ar(0.22625863552094), wave * DC.ar(0.78879868984222), wave * DC.ar(0.22453391551971), wave * DC.ar(0.29378950595856), wave * DC.ar(0.15443933010101));
varSmartSecurity20125010 = PV_JensenAndersen.ar(wave * DC.ar(0.077442288398743), wave * DC.ar(0.10124254226685), wave * DC.ar(0.42580533027649), wave * DC.ar(0.69865012168884), wave * DC.ar(0.90158808231354), wave * DC.ar(0.97059440612793), wave * DC.ar(0.20893907546997));
varSmartSecurity20125011 = CombC.ar(wave * DC.ar(0.085035681724548), wave * DC.ar(0.49675321578979), wave * DC.ar(0.84738171100616), wave * DC.ar(0.45324862003326), wave * DC.ar(0.6738383769989), wave * DC.ar(0.2282497882843));
varSmartSecurity20125012 = FincoSprottM.ar(wave * DC.ar(0.34958136081696), wave * DC.ar(0.89494895935059), wave * DC.ar(0.40845096111298), wave * DC.ar(0.17991101741791), wave * DC.ar(0.18405485153198), wave * DC.ar(0.93017292022705), wave * DC.ar(0.60260963439941), wave * DC.ar(0.096394419670105), wave * DC.ar(0.18842887878418));
// Variation test code
varSmartSecurity201250113 = OSWrap4.ar(wave * modX, varSmartSecurity20125010 * varSmartSecurity20125012, varSmartSecurity201250113 * wave);
varSmartSecurity201250113 = Oregonator.ar(gate, island, wave * varSmartSecurity20125012, signal * varSmartSecurity20125012, amp, env * varSmartSecurity20125010, modZ * wave, modX, 0.58139490363985 * varSmartSecurity20125010 * signal, Silent.ar());
varSmartSecurity201250113 = SinGrainBF.ar(varSmartSecurity201250113 * gateEnv, AverageOutput.ar(z, varSmartSecurity20125010 * varSmartSecurity20125011, 0.95776377041851 * modZ, Silent.ar()), modZ, varSmartSecurity20125010 * varSmartSecurity20125012, bufnum, env * modY, y, CircleRamp.ar(varSmartSecurity20125012 * DC.ar(0.90444040298462), varSmartSecurity20125010 * DC.ar(0.065305352210999), varSmartSecurity20125012 * DC.ar(0.14856958389282), varSmartSecurity20125010 * DC.ar(0.64461195468903), varSmartSecurity20125011 * DC.ar(0.79106569290161), varSmartSecurity20125010 * DC.ar(0.6304669380188)).blend(varSmartSecurity20125011 * DC.ar(0.41277134418488), varSmartSecurity20125011 * DC.ar(0.37583315372467)), Silent.ar());

signal = varSmartSecurity201250113;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// W97M.Panther.Variant201252
/////////////////////////////////////////////////////////

SynthDef.new("W97M.Panther.Variant201252", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varW97MPantherVariant2012529, varW97MPantherVariant20125210, varW97MPantherVariant20125211, varW97MPantherVariant20125212;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varW97MPantherVariant2012529 = varW97MPantherVariant20125210 = varW97MPantherVariant20125211 = varW97MPantherVariant20125212 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varW97MPantherVariant2012529 = DoubleNestedAllpassN.ar(SinGrainIBF.ar(wave * DC.ar(0.64315128326416), wave * DC.ar(0.80490529537201), wave * DC.ar(0.55011475086212), wave * DC.ar(0.97452771663666), wave * DC.ar(0.34600925445557), wave * DC.ar(0.74121654033661), wave * DC.ar(0.29128968715668), wave * DC.ar(0.76032066345215), wave * DC.ar(0.18183624744415), wave * DC.ar(0.88957738876343), wave * DC.ar(0.066574335098267), wave * DC.ar(0.70626354217529)), 0.21075892448425 * varW97MPantherVariant20125211 * varW97MPantherVariant20125210, varW97MPantherVariant20125210 * gateEnv, signal * signal, signal * varW97MPantherVariant2012529, env * varW97MPantherVariant20125212, amp, island, z, varW97MPantherVariant20125212, modZ, Silent.ar());
varW97MPantherVariant20125210 = BHiPass.ar(0.89968371391296 * signal * modY, GaussTrig.ar(wave * DC.ar(0.91912305355072), wave * DC.ar(0.91201651096344), wave * DC.ar(0.48451292514801), wave * DC.ar(0.53540289402008)).exprange(1, SampleRate.ir).blend(wave * DC.ar(0.16290521621704), wave * DC.ar(0.14420175552368)), in * varW97MPantherVariant2012529, 0.99863532297559 * DFM1.ar(wave * DC.ar(0.94592130184174), wave * DC.ar(0.54278028011322), wave * DC.ar(0.20764005184174), wave * DC.ar(0.70061671733856), wave * DC.ar(0.51405715942383), wave * DC.ar(0.41215085983276), wave * DC.ar(0.91972100734711), wave * DC.ar(0.75984406471252)), Silent.ar());
varW97MPantherVariant20125211 = FoaNFC.ar(y, env * varW97MPantherVariant2012529, Compander.ar(wave * DC.ar(0.21756315231323), wave * DC.ar(0.80768632888794), wave * DC.ar(0.66321575641632), wave * DC.ar(0.75472784042358), wave * DC.ar(0.12231051921844), wave * DC.ar(0.91945159435272), wave * DC.ar(0.33773648738861), wave * DC.ar(0.46214842796326), wave * DC.ar(0.149001121521)), Silent.ar());
varW97MPantherVariant20125212 = SortBuf.ar(Array.fill(2.pow(12), { |i| rrand(-1, 1) }).as(LocalBuf), modY * env, amp);
varW97MPantherVariant2012529 = Rotate2.ar(varW97MPantherVariant20125210, varW97MPantherVariant20125212 * varW97MPantherVariant20125210, modY * signal);
varW97MPantherVariant20125210 = Fhn2DL.ar(wave * DC.ar(0.89811420440674), wave * DC.ar(0.44024682044983), wave * DC.ar(0.54973089694977), wave * DC.ar(0.074227094650269), wave * DC.ar(0.63947141170502), wave * DC.ar(0.50977683067322), wave * DC.ar(0.43548452854156), wave * DC.ar(0.060989022254944), wave * DC.ar(0.35506212711334), wave * DC.ar(0.10421562194824), wave * DC.ar(0.61400353908539));
varW97MPantherVariant20125211 = Henon2DN.ar(wave * DC.ar(0.74513185024261), wave * DC.ar(0.9303947687149), wave * DC.ar(0.26300203800201), wave * DC.ar(0.044564723968506), wave * DC.ar(0.53869044780731), wave * DC.ar(0.34545016288757), wave * DC.ar(0.40705716609955), wave * DC.ar(0.5586234331131));
varW97MPantherVariant20125212 = PV_HainsworthFoote.ar(Array.fill(2.pow(11), { |i| rrand(-1, 1) }).as(LocalBuf), env * varW97MPantherVariant20125210, modY * modY, in * modZ, modX * signal);
varW97MPantherVariant2012529 = TwoTube.ar(wave * DC.ar(0.024417400360107), wave * DC.ar(0.88188767433167), wave * DC.ar(0.50398087501526), wave * DC.ar(0.83359384536743), wave * DC.ar(0.8574013710022), wave * DC.ar(0.1436722278595), wave * DC.ar(0.013204336166382));
varW97MPantherVariant20125210 = BrownNoise.ar(wave * DC.ar(0.91418254375458), wave * DC.ar(0.019497871398926));
varW97MPantherVariant20125211 = ToggleFF.ar(wave * DC.ar(0.90631985664368));
varW97MPantherVariant20125212 = MonoGrain.ar(wave * DC.ar(0.75721096992493), wave * DC.ar(0.28803944587708), wave * DC.ar(0.87853133678436), wave * DC.ar(0.045623898506165), wave * DC.ar(0.75422811508179), wave * DC.ar(0.71599745750427));

signal = varW97MPantherVariant20125212;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// W97M.Panther.Variant2012521
/////////////////////////////////////////////////////////

SynthDef.new("W97M.Panther.Variant2012521", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varW97MPantherVariant2012529, varW97MPantherVariant20125210, varW97MPantherVariant20125211, varW97MPantherVariant20125212, varW97MPantherVariant201252113, varW97MPantherVariant201252114, varW97MPantherVariant201252115;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varW97MPantherVariant2012529 = varW97MPantherVariant20125210 = varW97MPantherVariant20125211 = varW97MPantherVariant20125212 = varW97MPantherVariant201252113 = varW97MPantherVariant201252114 = varW97MPantherVariant201252115 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varW97MPantherVariant2012529 = SoftClipper8.ar(island);
varW97MPantherVariant20125210 = FoaZoomX.ar(varW97MPantherVariant20125210 * varW97MPantherVariant2012529, wave * varW97MPantherVariant20125212, 0.98789599322461 * varW97MPantherVariant20125210, Silent.ar());
varW97MPantherVariant20125211 = FoaPushX.ar(signal, 0.47120893001556 * varW97MPantherVariant201252114, modZ, Silent.ar().lag3ud(wave * DC.ar(0.9454528093338), wave * DC.ar(0.58807027339935)));
varW97MPantherVariant20125212 = BPZ2.ar(wave, 0.99729206391791 * modX * wave, Silent.ar());
varW97MPantherVariant2012529 = Standard2DC.ar(wave * DC.ar(0.95129942893982), wave * DC.ar(0.11128318309784), wave * DC.ar(0.1315176486969), wave * DC.ar(0.12436270713806), wave * DC.ar(0.089444518089294), wave * DC.ar(0.44024896621704), wave * DC.ar(0.97026085853577));
varW97MPantherVariant20125210 = SMS.ar(wave * DC.ar(0.67363631725311), wave * DC.ar(0.30215358734131), wave * DC.ar(0.94440352916718), wave * DC.ar(0.81299102306366), wave * DC.ar(0.99876761436462), wave * DC.ar(0.3083074092865), wave * DC.ar(0.11805558204651), wave * DC.ar(0.7162880897522), wave * DC.ar(0.26091194152832), wave * DC.ar(0.20370435714722), wave * DC.ar(0.85409295558929), wave * DC.ar(0.061214447021484), wave * DC.ar(0.90788757801056));
varW97MPantherVariant20125211 = LoopBuf.ar(2, Array.fill(2.pow(16), { |i| rrand(-1, 1) }).as(LocalBuf), varW97MPantherVariant20125212, island, varW97MPantherVariant201252115, varW97MPantherVariant20125211, modY * env, modZ * varW97MPantherVariant20125211);
varW97MPantherVariant20125212 = OSFold4.ar(modX * varW97MPantherVariant20125212, in, modZ * gateEnv);
varW97MPantherVariant2012529 = PVSynth.ar(wave * DC.ar(0.53523099422455), wave * DC.ar(0.55824732780457), wave * DC.ar(0.28316926956177), wave * DC.ar(0.55832517147064), wave * DC.ar(0.63788568973541), wave * DC.ar(0.23369193077087), wave * DC.ar(0.3685816526413), wave * DC.ar(0.016640663146973), wave * DC.ar(0.40930461883545));
varW97MPantherVariant20125210 = DelayN.ar(wave * DC.ar(0.81701183319092), wave * DC.ar(0.61122834682465), wave * DC.ar(0.4855819940567), wave * DC.ar(0.63397431373596), wave * DC.ar(0.93068528175354));
varW97MPantherVariant20125211 = GbmanN.ar(wave * DC.ar(0.97417759895325), wave * DC.ar(0.77920174598694), wave * DC.ar(0.8940167427063), wave * DC.ar(0.9543080329895), wave * DC.ar(0.33865761756897));
varW97MPantherVariant20125212 = Rotate.ar(wave * DC.ar(0.57001030445099), wave * DC.ar(0.30705511569977), wave * DC.ar(0.30844187736511), wave * DC.ar(0.20802664756775), wave * DC.ar(0.66908895969391));
// Variation test code
varW97MPantherVariant201252113 = CombLP.ar(modZ * varW97MPantherVariant201252115, island, 0.31679129600525 * Convolution2L.ar(varW97MPantherVariant20125210 * DC.ar(0.11161041259766), varW97MPantherVariant2012529 * DC.ar(0.077970266342163), varW97MPantherVariant20125211 * DC.ar(0.8307853937149), varW97MPantherVariant20125210 * DC.ar(0.74760687351227), varW97MPantherVariant2012529 * DC.ar(0.24558115005493), varW97MPantherVariant2012529 * DC.ar(0.19982159137726), varW97MPantherVariant2012529 * DC.ar(0.57781684398651)), varW97MPantherVariant201252113 * varW97MPantherVariant20125211, varW97MPantherVariant20125211 * env, varW97MPantherVariant2012529, 0.93727121849371 * varW97MPantherVariant20125210 * varW97MPantherVariant20125211, TwoPole.ar(varW97MPantherVariant20125210 * DC.ar(0.94750452041626), varW97MPantherVariant2012529 * DC.ar(0.97454559803009), varW97MPantherVariant2012529 * DC.ar(0.84148943424225), varW97MPantherVariant20125210 * DC.ar(0.23555564880371), varW97MPantherVariant20125212 * DC.ar(0.23663818836212)));
varW97MPantherVariant201252114 = XOut.ar((80 + (island * 2)), varW97MPantherVariant20125211 * env, [RMAFoodChainL.ar(varW97MPantherVariant2012529 * DC.ar(0.30053067207336), varW97MPantherVariant20125212 * DC.ar(0.55799758434296), varW97MPantherVariant20125211 * DC.ar(0.40018022060394), varW97MPantherVariant2012529 * DC.ar(0.58522844314575), varW97MPantherVariant20125212 * DC.ar(0.073298454284668), varW97MPantherVariant2012529 * DC.ar(0.97389197349548), varW97MPantherVariant20125211 * DC.ar(0.00054478645324707), varW97MPantherVariant20125212 * DC.ar(0.22521781921387), varW97MPantherVariant20125211 * DC.ar(0.1803070306778), varW97MPantherVariant20125210 * DC.ar(0.058894872665405), varW97MPantherVariant20125210 * DC.ar(0.82919526100159), varW97MPantherVariant20125210 * DC.ar(0.34298932552338), varW97MPantherVariant20125211 * DC.ar(0.37496876716614), varW97MPantherVariant20125210 * DC.ar(0.78731536865234), varW97MPantherVariant20125210 * DC.ar(0.70479118824005)), ClipNoise.ar(varW97MPantherVariant20125210 * DC.ar(0.26634621620178), varW97MPantherVariant20125211 * DC.ar(0.61762475967407))]);
varW97MPantherVariant201252115 = FoaFocusZ.ar(varW97MPantherVariant2012529 * signal, modX * signal.div(SinGrain.ar(varW97MPantherVariant2012529 * DC.ar(0.24421405792236), varW97MPantherVariant2012529 * DC.ar(0.58709275722504), varW97MPantherVariant20125210 * DC.ar(0.04147744178772), varW97MPantherVariant2012529 * DC.ar(0.17384171485901), varW97MPantherVariant2012529 * DC.ar(0.40540027618408))), BufGrainBF.ar(varW97MPantherVariant20125211 * DC.ar(0.57090055942535), varW97MPantherVariant20125212 * DC.ar(0.49068665504456), varW97MPantherVariant20125210 * DC.ar(0.079331159591675), varW97MPantherVariant20125211 * DC.ar(0.70617401599884), varW97MPantherVariant20125210 * DC.ar(0.84734332561493), varW97MPantherVariant20125210 * DC.ar(0.14375650882721), varW97MPantherVariant20125210 * DC.ar(0.35830557346344), varW97MPantherVariant2012529 * DC.ar(0.31430220603943), varW97MPantherVariant2012529 * DC.ar(0.36990106105804), varW97MPantherVariant20125211 * DC.ar(0.35816073417664), varW97MPantherVariant20125210 * DC.ar(0.85970723628998), varW97MPantherVariant2012529 * DC.ar(0.36509203910828)), Silent.ar());
varW97MPantherVariant201252113 = Tap.ar(Array.fill(2.pow(15), { |i| rrand(-1, 1) }).as(LocalBuf), 2, modY);
varW97MPantherVariant201252114 = FhnTrig.ar(BMoog.ar(varW97MPantherVariant20125212 * DC.ar(0.18615806102753), varW97MPantherVariant20125211 * DC.ar(0.98608613014221), varW97MPantherVariant20125212 * DC.ar(0.7915176153183), varW97MPantherVariant2012529 * DC.ar(0.36994910240173), varW97MPantherVariant20125210 * DC.ar(0.74333095550537), varW97MPantherVariant2012529 * DC.ar(0.57227635383606), varW97MPantherVariant20125210 * DC.ar(0.027976870536804)).exprange(1, SampleRate.ir), varW97MPantherVariant2012529, y, amp, gate, wave * modX, in * wave, varW97MPantherVariant2012529 * varW97MPantherVariant20125210, y, 0.99984862087514 * gateEnv * modZ, Silent.ar());
varW97MPantherVariant201252115 = TDelay.ar(amp, amp);
varW97MPantherVariant201252113 = MonoGrainBF.ar(in.mod(LeakDC.ar(varW97MPantherVariant2012529 * DC.ar(0.17094016075134), varW97MPantherVariant20125211 * DC.ar(0.21078205108643), varW97MPantherVariant20125212 * DC.ar(0.042817234992981), varW97MPantherVariant20125211 * DC.ar(0.47515332698822))), gate, in * modZ, varW97MPantherVariant20125210, varW97MPantherVariant201252114, varW97MPantherVariant201252115, varW97MPantherVariant20125211 * modZ, x, amp, 0.95919893480566 * wave * signal, Silent.ar());
varW97MPantherVariant201252114 = BufGrainIBF.ar(varW97MPantherVariant201252114 * varW97MPantherVariant2012529, 0.31070268154144 * BufAllpassL.ar(varW97MPantherVariant2012529 * DC.ar(0.21666264533997), varW97MPantherVariant2012529 * DC.ar(0.27305579185486), varW97MPantherVariant20125210 * DC.ar(0.35591471195221), varW97MPantherVariant20125210 * DC.ar(0.71043288707733), varW97MPantherVariant20125210 * DC.ar(0.40047693252563), varW97MPantherVariant20125212 * DC.ar(0.79101085662842)), bufnum, island, signal * gateEnv, bufnum, bufnum, varW97MPantherVariant201252115, y, in * varW97MPantherVariant20125211, varW97MPantherVariant2012529, varW97MPantherVariant2012529, varW97MPantherVariant2012529 * varW97MPantherVariant2012529, FhnTrig.ar(varW97MPantherVariant2012529 * DC.ar(0.89654493331909), varW97MPantherVariant2012529 * DC.ar(0.10098099708557), varW97MPantherVariant2012529 * DC.ar(0.1411896944046), varW97MPantherVariant20125211 * DC.ar(0.87336778640747), varW97MPantherVariant2012529 * DC.ar(0.48782455921173), varW97MPantherVariant2012529 * DC.ar(0.21643388271332), varW97MPantherVariant20125212 * DC.ar(0.48714029788971), varW97MPantherVariant20125210 * DC.ar(0.94954478740692), varW97MPantherVariant20125210 * DC.ar(0.98151051998138), varW97MPantherVariant20125212 * DC.ar(0.54739224910736), varW97MPantherVariant20125211 * DC.ar(0.81780230998993)), Silent.ar());
varW97MPantherVariant201252115 = FoaFocusZ.ar(Pan2.ar(gateEnv, wave, varW97MPantherVariant20125212 * in), env, BHiPass.ar(varW97MPantherVariant20125211 * DC.ar(0.68565428256989), varW97MPantherVariant20125211 * DC.ar(0.79122233390808), varW97MPantherVariant2012529 * DC.ar(0.12676966190338), varW97MPantherVariant20125211 * DC.ar(0.43287491798401), varW97MPantherVariant20125211 * DC.ar(0.97718393802643)), Silent.ar().lag2(varW97MPantherVariant20125210 * DC.ar(0.3358234167099), varW97MPantherVariant20125210 * DC.ar(0.54684174060822)));

signal = varW97MPantherVariant201252115;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// W97M.Fool.Family2012521
/////////////////////////////////////////////////////////

SynthDef.new("W97M.Fool.Family2012521", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varW97MFoolFamily2012529, varW97MFoolFamily20125210, varW97MFoolFamily20125211, varW97MFoolFamily20125212, varW97MFoolFamily201252113, varW97MFoolFamily201252114, varW97MFoolFamily201252115, varW97MFoolFamily201252116;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varW97MFoolFamily2012529 = varW97MFoolFamily20125210 = varW97MFoolFamily20125211 = varW97MFoolFamily20125212 = varW97MFoolFamily201252113 = varW97MFoolFamily201252114 = varW97MFoolFamily201252115 = varW97MFoolFamily201252116 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varW97MFoolFamily2012529 = DriveNoise.ar(varW97MFoolFamily201252113 * varW97MFoolFamily201252113, varW97MFoolFamily201252115 * varW97MFoolFamily201252114.lag2(wave * DC.ar(0.40606069564819), wave * DC.ar(0.37705099582672)), 0.99552763521111 * varW97MFoolFamily201252115 * env.excess(RMShelf2.ar(wave * DC.ar(0.70250082015991), wave * DC.ar(0.29563224315643), wave * DC.ar(0.66099941730499), wave * DC.ar(0.85764670372009), wave * DC.ar(0.66497766971588))));
varW97MFoolFamily20125210 = AY.ar(varW97MFoolFamily20125212, gateEnv * modX, wave, 0.56798207759857 * varW97MFoolFamily20125211 * signal, y, varW97MFoolFamily20125211 * varW97MFoolFamily20125210, signal * modX, varW97MFoolFamily201252114, gateEnv * varW97MFoolFamily201252113, env * varW97MFoolFamily201252114, modX * gateEnv, WalshHadamard.ar(wave * DC.ar(0.92626488208771), wave * DC.ar(0.56665086746216), wave * DC.ar(0.021739959716797), wave * DC.ar(0.84128749370575)), Silent.ar());
varW97MFoolFamily20125211 = LinCongN.ar(modZ * varW97MFoolFamily20125212, gateEnv.excess(Oregonator.ar(wave * DC.ar(0.94354021549225), wave * DC.ar(0.69256067276001), wave * DC.ar(0.95203232765198), wave * DC.ar(0.97905957698822), wave * DC.ar(0.3088526725769), wave * DC.ar(0.73378169536591), wave * DC.ar(0.58616745471954), wave * DC.ar(0.72697103023529), wave * DC.ar(0.89255821704865), wave * DC.ar(0.4791886806488))), varW97MFoolFamily201252116, x, x, 0.9765433686256 * varW97MFoolFamily201252113, Silent.ar());
varW97MFoolFamily20125212 = LFCub.ar(modZ, gateEnv * modZ, 0.99964947773383 * signal * varW97MFoolFamily201252116, Silent.ar());
varW97MFoolFamily2012529 = NLFiltL.ar(modX * modY, in * modZ.sqrsum(LFGauss.ar(wave * DC.ar(0.88702654838562), wave * DC.ar(0.3787978887558), wave * DC.ar(0.0022766590118408), wave * DC.ar(0.91739463806152), wave * DC.ar(0.49700307846069))), LFCub.ar(wave * DC.ar(0.16952657699585), wave * DC.ar(0.1560320854187), wave * DC.ar(0.28612995147705), wave * DC.ar(0.25341510772705)), env * wave, signal * modX, 0.38809859752655 * varW97MFoolFamily20125210 * varW97MFoolFamily2012529, 0.62303720731024 * signal * env, Silent.ar());
varW97MFoolFamily20125210 = FoaFocusZ.ar(wave * DC.ar(0.40250337123871), wave * DC.ar(0.29374158382416), wave * DC.ar(0.018962264060974), wave * DC.ar(0.34711730480194));
varW97MFoolFamily20125211 = K2A.ar(wave * DC.ar(0.39948344230652));
varW97MFoolFamily20125212 = AtsBand.ar(Array.fill(2.pow(15), { |i| rrand(-1, 1) }).as(LocalBuf), 0.65924751758575 * in * varW97MFoolFamily201252113, x, 0.9941774802263 * wave * varW97MFoolFamily20125210, Silent.ar());
varW97MFoolFamily2012529 = RosslerL.ar(wave * DC.ar(0.11329233646393), wave * DC.ar(0.28880059719086), wave * DC.ar(0.17527186870575), wave * DC.ar(0.50295269489288), wave * DC.ar(0.50024020671844), wave * DC.ar(0.037772417068481), wave * DC.ar(0.45965921878815), wave * DC.ar(0.44990491867065), wave * DC.ar(0.77866101264954), wave * DC.ar(0.33937644958496));
varW97MFoolFamily20125210 = AnalyseEvents2.ar(wave * DC.ar(0.58825898170471), wave * DC.ar(0.36373019218445), wave * DC.ar(0.4963082075119), wave * DC.ar(0.4932256937027), wave * DC.ar(0.33003032207489), wave * DC.ar(0.80245244503021));
varW97MFoolFamily20125211 = HenonL.ar(wave * DC.ar(0.20284640789032), wave * DC.ar(0.89011919498444), wave * DC.ar(0.77061975002289), wave * DC.ar(0.29929172992706), wave * DC.ar(0.64877045154572), wave * DC.ar(0.99316120147705), wave * DC.ar(0.79037523269653));
varW97MFoolFamily20125212 = InGrainBBF.ar(wave * DC.ar(0.50834548473358), wave * DC.ar(0.2935745716095), wave * DC.ar(0.97411727905273), wave * DC.ar(0.66158425807953), wave * DC.ar(0.30738711357117), wave * DC.ar(0.65134942531586), wave * DC.ar(0.90003097057343), wave * DC.ar(0.27555561065674), wave * DC.ar(0.077808141708374), wave * DC.ar(0.63141405582428));
// Variation test code
varW97MFoolFamily201252113 = IFFT.ar(Array.fill(2.pow(13), { |i| rrand(-1, 1) }).as(LocalBuf), varW97MFoolFamily20125211, gateEnv * gateEnv);
varW97MFoolFamily201252114 = FMGrainI.ar(modX * modX, amp, varW97MFoolFamily201252113 * varW97MFoolFamily2012529, varW97MFoolFamily201252113 * varW97MFoolFamily201252115, y, bufnum, bufnum, modY, 0.99994791309187 * varW97MFoolFamily201252113, Silent.ar());
varW97MFoolFamily201252115 = OffsetOut.ar((80 + (island * 2)), [RunningMin.ar(varW97MFoolFamily2012529 * DC.ar(0.36461222171783), varW97MFoolFamily2012529 * DC.ar(0.8415412902832)), LorenzL.ar(varW97MFoolFamily20125212 * DC.ar(0.11390233039856), varW97MFoolFamily20125210 * DC.ar(0.59837079048157), varW97MFoolFamily2012529 * DC.ar(0.43468272686005), varW97MFoolFamily20125211 * DC.ar(0.77986252307892), varW97MFoolFamily20125211 * DC.ar(0.39666604995728), varW97MFoolFamily20125211 * DC.ar(0.26489675045013), varW97MFoolFamily20125212 * DC.ar(0.21227264404297), varW97MFoolFamily20125211 * DC.ar(0.22754955291748), varW97MFoolFamily2012529 * DC.ar(0.010572552680969), varW97MFoolFamily20125211 * DC.ar(0.9572731256485))]);
varW97MFoolFamily201252116 = Pokey.ar(varW97MFoolFamily2012529 * varW97MFoolFamily20125210, z, gateEnv * gateEnv, varW97MFoolFamily201252116 * modX, varW97MFoolFamily2012529, varW97MFoolFamily20125212 * varW97MFoolFamily201252114, wave * modZ, amp, gate);
varW97MFoolFamily201252113 = LinCongL.ar(varW97MFoolFamily201252114, in * modY, modY, gateEnv * modY, Pulse.ar(varW97MFoolFamily201252114, varW97MFoolFamily20125212 * varW97MFoolFamily20125212, 0.64995165350516 * varW97MFoolFamily201252115 * varW97MFoolFamily2012529, Silent.ar()), 0.99204622166867 * modY * varW97MFoolFamily201252116, Silent.ar());
varW97MFoolFamily201252114 = Pan4.ar(wave * modY, modY, x, gateEnv);
varW97MFoolFamily201252115 = Tap.ar(Array.fill(2.pow(14), { |i| rrand(-1, 1) }).as(LocalBuf).lagud(varW97MFoolFamily20125211 * DC.ar(0.68675255775452), varW97MFoolFamily20125210 * DC.ar(0.017509698867798)), 2, modX * modY);
varW97MFoolFamily201252116 = EnvDetect.ar(wave * varW97MFoolFamily201252115, gateEnv * wave, modY * varW97MFoolFamily2012529);
varW97MFoolFamily201252113 = FoaFocusX.ar(wave * signal, varW97MFoolFamily20125210, modZ, Silent.ar());
varW97MFoolFamily201252114 = YigClifford3DC.ar(gateEnv * varW97MFoolFamily20125212, varW97MFoolFamily20125212, FoaFocusX.ar(in * varW97MFoolFamily20125211, signal * in, 0.99950879019114 * varW97MFoolFamily201252116 * varW97MFoolFamily20125212, Silent.ar()), varW97MFoolFamily2012529, env * modZ, varW97MFoolFamily201252114 * modY, modZ, x, SoftClipper8.ar(varW97MFoolFamily2012529 * DC.ar(0.91277253627777)), Silent.ar());
varW97MFoolFamily201252115 = Phasor.ar(varW97MFoolFamily20125210 * varW97MFoolFamily2012529, varW97MFoolFamily2012529, varW97MFoolFamily201252113, varW97MFoolFamily201252115 * in, x);
varW97MFoolFamily201252116 = StandardN.ar(varW97MFoolFamily20125211 * varW97MFoolFamily20125212, varW97MFoolFamily20125212, bufnum, wave, varW97MFoolFamily201252115, Silent.ar());

signal = varW97MFoolFamily201252116;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Bin.Auto.CFS2012531
/////////////////////////////////////////////////////////

SynthDef.new("Bin.Auto.CFS2012531", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varBinAutoCFS2012539, varBinAutoCFS201253110, varBinAutoCFS201253111;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varBinAutoCFS2012539 = varBinAutoCFS201253110 = varBinAutoCFS201253111 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varBinAutoCFS2012539 = Pluck.ar(gate, signal, modY, gateEnv * wave, varBinAutoCFS201253111 * signal, signal * modZ, 0.9992638183602 * varBinAutoCFS201253111 * in, Silent.ar());
varBinAutoCFS2012539 = Poll.ar(in * wave, wave * varBinAutoCFS201253111, y, modX * signal);
varBinAutoCFS2012539 = FMGrainBF.ar(wave * DC.ar(0.11040127277374), wave * DC.ar(0.95119631290436), wave * DC.ar(0.25337958335876), wave * DC.ar(0.30092430114746), wave * DC.ar(0.81183385848999), wave * DC.ar(0.25047636032104), wave * DC.ar(0.099681496620178), wave * DC.ar(0.70892906188965), wave * DC.ar(0.021263003349304), wave * DC.ar(0.35941922664642), wave * DC.ar(0.8388968706131));
// Variation test code
varBinAutoCFS201253110 = WeaklyNonlinear.ar(env * varBinAutoCFS2012539, modY * modY, env, z, in * varBinAutoCFS2012539, 0.36311566829681 * signal * modY, signal * varBinAutoCFS201253111, z, env * modZ, DriveNoise.ar(modX * signal, modX * modX, gateEnv), env * modX, 0.99965497024172 * varBinAutoCFS201253111 * modY, Silent.ar());
varBinAutoCFS201253111 = TwoTube.ar(env * modZ, modX * env, 0.93159651756287 * ArrayMax.ar(varBinAutoCFS2012539 * DC.ar(0.22686719894409)), varBinAutoCFS201253111 * modZ, modX * in, 0.98662364914323 * modZ * env, Silent.ar());
varBinAutoCFS201253110 = LPF.ar(0.65533721446991 * modY * modY, signal, wave.lag2ud(varBinAutoCFS2012539 * DC.ar(0.4209771156311), varBinAutoCFS2012539 * DC.ar(0.19125068187714)), Silent.ar());
varBinAutoCFS201253111 = Fold.ar(x, z, modX);
varBinAutoCFS201253110 = BufGrainBF.ar(modZ, LPCError.ar(z, modZ * varBinAutoCFS201253111.lincurve(varBinAutoCFS2012539 * DC.ar(0.96237003803253), varBinAutoCFS2012539 * DC.ar(0.40318989753723), varBinAutoCFS2012539 * DC.ar(0.35193419456482), varBinAutoCFS2012539 * DC.ar(0.85312950611115), varBinAutoCFS2012539 * DC.ar(0.12474226951599), varBinAutoCFS2012539 * DC.ar(0.14695429801941)), 0.99004462801758 * in * varBinAutoCFS201253110, Silent.ar()), bufnum, modZ, x, env * modZ, varBinAutoCFS201253110, varBinAutoCFS201253111 * gateEnv, varBinAutoCFS2012539 * varBinAutoCFS201253110, modX * signal, 0.99936957361234 * gateEnv * varBinAutoCFS201253110.lag3(varBinAutoCFS2012539 * DC.ar(0.56890904903412), varBinAutoCFS2012539 * DC.ar(0.26489162445068)), Silent.ar());
varBinAutoCFS201253111 = Gbman2DN.ar(Latoocarfian2DC.ar(varBinAutoCFS2012539 * DC.ar(0.92197155952454), varBinAutoCFS2012539 * DC.ar(0.64426863193512), varBinAutoCFS2012539 * DC.ar(0.5645250082016), varBinAutoCFS2012539 * DC.ar(0.57900369167328), varBinAutoCFS2012539 * DC.ar(0.5512615442276), varBinAutoCFS2012539 * DC.ar(0.092371463775635), varBinAutoCFS2012539 * DC.ar(0.38400816917419), varBinAutoCFS2012539 * DC.ar(0.42111420631409), varBinAutoCFS2012539 * DC.ar(0.96641528606415), varBinAutoCFS2012539 * DC.ar(0.39976036548615)).exprange(1, SampleRate.ir), varBinAutoCFS201253110 * varBinAutoCFS201253111, modY * gateEnv, 0.86174404621124 * varBinAutoCFS2012539 * varBinAutoCFS2012539, 0.88295822137368 * varBinAutoCFS201253110 * varBinAutoCFS201253110, Silent.ar());

signal = varBinAutoCFS201253111;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// HLLS.4200(2)201255
/////////////////////////////////////////////////////////

SynthDef.new("HLLS.4200(2)201255", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varHLLS420022012559, varHLLS4200220125510, varHLLS4200220125511;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varHLLS420022012559 = varHLLS4200220125510 = varHLLS4200220125511 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varHLLS420022012559 = CrossoverDistortion.ar(varHLLS420022012559, gateEnv, varHLLS4200220125511, signal, Silent.ar().bitAnd(Concat2.ar(wave * DC.ar(0.84648489952087), wave * DC.ar(0.015779376029968), wave * DC.ar(0.19857561588287), wave * DC.ar(0.077735185623169), wave * DC.ar(0.35479342937469), wave * DC.ar(0.87247896194458), wave * DC.ar(0.14783883094788), wave * DC.ar(0.79732012748718), wave * DC.ar(0.14832782745361), wave * DC.ar(0.36343717575073), wave * DC.ar(0.30828928947449), wave * DC.ar(0.39510321617126), wave * DC.ar(0.094842433929443), wave * DC.ar(0.25142443180084), wave * DC.ar(0.38461911678314))));
varHLLS4200220125510 = NestedAllpassC.ar(amp, modZ * in, BufAllpassC.ar(wave * DC.ar(0.53190791606903), wave * DC.ar(0.038510084152222), wave * DC.ar(0.38817203044891), wave * DC.ar(0.28553926944733), wave * DC.ar(0.50018322467804), wave * DC.ar(0.1921569108963)), env * varHLLS4200220125510, gateEnv * modZ, env, amp, Atari2600.ar(wave * DC.ar(0.63166892528534), wave * DC.ar(0.15436315536499), wave * DC.ar(0.59078419208527), wave * DC.ar(0.1650083065033), wave * DC.ar(0.66141152381897), wave * DC.ar(0.68782794475555), wave * DC.ar(0.66619670391083)), Silent.ar());
varHLLS4200220125511 = SinGrainBBF.ar(Perlin3.ar(wave * DC.ar(0.6381094455719), wave * DC.ar(0.31208908557892), wave * DC.ar(0.62578678131104)), wave * modZ, in, bufnum, in * gateEnv, wave, gateEnv * env, varHLLS4200220125511 * modY, DoubleWell.ar(wave * DC.ar(0.33827412128448), wave * DC.ar(0.28466153144836), wave * DC.ar(0.7422981262207), wave * DC.ar(0.31737780570984), wave * DC.ar(0.85479354858398), wave * DC.ar(0.48544108867645), wave * DC.ar(0.10406219959259), wave * DC.ar(0.11431133747101), wave * DC.ar(0.10058224201202), wave * DC.ar(0.70844972133636)), Silent.ar());
varHLLS420022012559 = Pulse.ar(wave * DC.ar(0.21351850032806), wave * DC.ar(0.81696557998657), wave * DC.ar(0.31691324710846), wave * DC.ar(0.17045938968658));
varHLLS4200220125510 = LFDNoise0.ar(gateEnv * gateEnv, 0.99986889674585 * gateEnv * varHLLS4200220125511.range(wave * DC.ar(0.41813635826111), wave * DC.ar(0.10043036937714)), SetResetFF.ar(wave * DC.ar(0.75438213348389), wave * DC.ar(0.78122317790985)));
varHLLS4200220125511 = BufGrainBBF.ar(env, 0.84979689121246 * Lag3UD.ar(wave * DC.ar(0.41965341567993), wave * DC.ar(0.98534619808197), wave * DC.ar(0.20112037658691), wave * DC.ar(0.57249760627747), wave * DC.ar(0.12122321128845)), bufnum, varHLLS4200220125510, 0.929612159729 * modY, bufnum, in * in, island, bufnum, env * gateEnv, gateEnv, varHLLS4200220125510, Silent.ar());
varHLLS420022012559 = Beep.ar(wave * DC.ar(0.18663847446442), wave * DC.ar(0.1140376329422));
varHLLS4200220125510 = YigClifford3DC.ar(wave * DC.ar(0.35932290554047), wave * DC.ar(0.37907063961029), wave * DC.ar(0.70883512496948), wave * DC.ar(0.49995183944702), wave * DC.ar(0.73534178733826), wave * DC.ar(0.96692788600922), wave * DC.ar(0.38566434383392), wave * DC.ar(0.93154585361481), wave * DC.ar(0.024736404418945), wave * DC.ar(0.13633847236633));
varHLLS4200220125511 = Lag3UD.ar(wave * DC.ar(0.46091246604919), wave * DC.ar(0.33912754058838), wave * DC.ar(0.48029363155365), wave * DC.ar(0.81157243251801), wave * DC.ar(0.86465060710907));

signal = varHLLS4200220125511;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// MTE.Engine2012551
/////////////////////////////////////////////////////////

SynthDef.new("MTE.Engine2012551", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varMTEEngine2012559, varMTEEngine20125510, varMTEEngine20125511, varMTEEngine20125512, varMTEEngine201255113;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varMTEEngine2012559 = varMTEEngine20125510 = varMTEEngine20125511 = varMTEEngine20125512 = varMTEEngine201255113 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varMTEEngine2012559 = StkShakers.ar(amp, bufnum, bufnum, wave, varMTEEngine2012559 * in, MarkovSynth.ar(wave * DC.ar(0.35704708099365), wave * DC.ar(0.44871425628662), wave * DC.ar(0.077267050743103), wave * DC.ar(0.33130550384521)), Silent.ar());
varMTEEngine20125510 = LagUD.ar(x, wave * in, varMTEEngine20125512, FoaProximity.ar(wave * DC.ar(0.3369345664978), wave * DC.ar(0.7474592924118), wave * DC.ar(0.80860269069672), wave * DC.ar(0.64888048171997)), Silent.ar());
varMTEEngine20125511 = Lag.ar(varMTEEngine201255113 * modY, varMTEEngine20125510, 0.66814103905558 * gateEnv * env, Silent.ar());
varMTEEngine20125512 = Rotate.ar(amp, 0.063637137413025 * varMTEEngine201255113 * modY, t_trig, in, varMTEEngine20125511);
varMTEEngine2012559 = FBSineC.ar(modZ, varMTEEngine20125511 * varMTEEngine2012559, gate, varMTEEngine2012559 * modX, gate, amp, signal * modX, 0.9995568145574 * varMTEEngine20125511 * varMTEEngine20125510, Silent.ar());
varMTEEngine20125510 = DelayC.ar(wave * DC.ar(0.40372824668884), wave * DC.ar(0.35780775547028), wave * DC.ar(0.99053573608398), wave * DC.ar(0.86774480342865), wave * DC.ar(0.35352206230164));
varMTEEngine20125511 = InGrainB.ar(varMTEEngine20125511 * varMTEEngine20125510, 0.72964417934418 * varMTEEngine20125510 * varMTEEngine201255113, 0.57657551765442 * BufDelayC.ar(wave * DC.ar(0.98292517662048), wave * DC.ar(0.18042433261871), wave * DC.ar(0.96925747394562), wave * DC.ar(0.074219465255737), wave * DC.ar(0.26274752616882)), bufnum, 0.99997413102181 * Median.ar(wave * DC.ar(0.059457898139954), wave * DC.ar(0.63235640525818), wave * DC.ar(0.077537059783936), wave * DC.ar(0.85082733631134)), Silent.ar());
varMTEEngine20125512 = OSFold4.ar(wave * DC.ar(0.045057415962219), wave * DC.ar(0.20427703857422), wave * DC.ar(0.7268580198288));
varMTEEngine2012559 = LFNoise1.ar(wave * DC.ar(0.82063210010529), wave * DC.ar(0.040185570716858), wave * DC.ar(0.81874024868011));
varMTEEngine20125510 = K2A.ar(wave * DC.ar(0.25457489490509));
varMTEEngine20125511 = AtsNoiSynth.ar(wave * DC.ar(0.22709250450134), wave * DC.ar(0.90356814861298), wave * DC.ar(0.39960753917694), wave * DC.ar(0.93354499340057), wave * DC.ar(0.25783336162567), wave * DC.ar(0.20504605770111), wave * DC.ar(0.79555940628052), wave * DC.ar(0.95154190063477), wave * DC.ar(0.85419738292694), wave * DC.ar(0.059766530990601), wave * DC.ar(0.14691483974457), wave * DC.ar(0.12728488445282), wave * DC.ar(0.67510843276978), wave * DC.ar(0.63392448425293));
varMTEEngine20125512 = SinOscFB.ar(wave * DC.ar(0.19887745380402), wave * DC.ar(0.056942105293274), wave * DC.ar(0.97982537746429), wave * DC.ar(0.015368223190308));
// Variation test code
varMTEEngine201255113 = PartConv.ar(x, gateEnv, Array.fill(2.pow(11), { |i| rrand(-1, 1) }).as(LocalBuf), 0.99967838492325 * signal * in, AtsBand.ar(varMTEEngine2012559 * DC.ar(0.12340116500854), varMTEEngine20125511 * DC.ar(0.28107857704163), varMTEEngine2012559 * DC.ar(0.34289240837097), varMTEEngine20125510 * DC.ar(0.72351050376892), varMTEEngine2012559 * DC.ar(0.53487038612366)));
varMTEEngine201255113 = SinOsc.ar(TBrownRand.ar(varMTEEngine2012559 * DC.ar(0.43423175811768), varMTEEngine20125510 * DC.ar(0.75500738620758), varMTEEngine20125511 * DC.ar(0.82038688659668), varMTEEngine2012559 * DC.ar(0.22673368453979), varMTEEngine20125511 * DC.ar(0.17115044593811), varMTEEngine20125511 * DC.ar(0.10014688968658), varMTEEngine20125512 * DC.ar(0.91043019294739)).exprange(1, SampleRate.ir), modY * modY, 0.99963498087845 * gateEnv * gateEnv, Silent.ar());
varMTEEngine201255113 = FoaAsymmetry.ar(modY * modY, modZ * in, varMTEEngine20125510, RLPFD.ar(varMTEEngine20125511 * DC.ar(0.60267961025238), varMTEEngine20125512 * DC.ar(0.48219811916351), varMTEEngine20125511 * DC.ar(0.43591499328613), varMTEEngine2012559 * DC.ar(0.05817985534668), varMTEEngine20125511 * DC.ar(0.57945156097412), varMTEEngine20125511 * DC.ar(0.91948640346527)));

signal = varMTEEngine201255113;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Lucretia201256
/////////////////////////////////////////////////////////

SynthDef.new("Lucretia201256", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varLucretia2012569, varLucretia20125610, varLucretia20125611, varLucretia20125612;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varLucretia2012569 = varLucretia20125610 = varLucretia20125611 = varLucretia20125612 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varLucretia2012569 = AY.ar(varLucretia20125610, modX * signal, modY * env, y, env * gateEnv, varLucretia20125611 * in, wave * signal, modZ * in, env * gateEnv, varLucretia20125612 * varLucretia20125610, in, 0.99923383748532 * BFEncode2.ar(wave * DC.ar(0.28732919692993), wave * DC.ar(0.2038916349411), wave * DC.ar(0.12968230247498), wave * DC.ar(0.51384246349335), wave * DC.ar(0.42064261436462), wave * DC.ar(0.31167936325073)), Silent.ar());
varLucretia20125610 = HyperTerrain.ar(Array.fill(2.pow(10), { |i| rrand(-1, 1) }).as(LocalBuf), t_trig, in * varLucretia2012569, bufnum, env, Silent.ar());
varLucretia20125611 = GravityGrid2.ar(varLucretia2012569, 0.012222290039062 * varLucretia20125610 * modX, wave * in, varLucretia20125610 * varLucretia20125612, Array.fill(2.pow(13), { |i| rrand(-1, 1) }).as(LocalBuf), HilbertFIR.ar(wave * DC.ar(0.71378004550934), wave * DC.ar(0.26471304893494)), Silent.ar());
varLucretia20125612 = StkBlowHole.ar(varLucretia20125611 * varLucretia2012569, 0.20811355113983 * gateEnv * modZ, modZ * gateEnv, 0.77856755256653 * env * signal, z, modY, SendTrig.ar(wave * DC.ar(0.1969929933548), wave * DC.ar(0.28303873538971), wave * DC.ar(0.74266040325165)), Silent.ar());
varLucretia2012569 = LinXFade2.ar(in * signal, bufnum, varLucretia20125611, t_trig);
varLucretia20125610 = XFadeRotate.ar(SVF.ar(wave * DC.ar(0.8342444896698), wave * DC.ar(0.30054497718811), wave * DC.ar(0.69305908679962), wave * DC.ar(0.57462465763092), wave * DC.ar(0.61052656173706), wave * DC.ar(0.042944073677063), wave * DC.ar(0.92925608158112), wave * DC.ar(0.47185981273651), wave * DC.ar(0.39319467544556), wave * DC.ar(0.17445802688599)), varLucretia20125611 * varLucretia20125612);
varLucretia20125611 = Klank.ar(`[[Clipper4.ar(wave * DC.ar(0.62654137611389), wave * DC.ar(0.96057319641113), wave * DC.ar(0.30521821975708)), Blip.ar(wave * DC.ar(0.90505361557007), wave * DC.ar(0.55596029758453), wave * DC.ar(0.81570172309875), wave * DC.ar(0.75528705120087))], [FMGrainBBF.ar(wave * DC.ar(0.36290383338928), wave * DC.ar(0.98885464668274), wave * DC.ar(0.9921727180481), wave * DC.ar(0.065717577934265), wave * DC.ar(0.35960042476654), wave * DC.ar(0.66908490657806), wave * DC.ar(0.80602157115936), wave * DC.ar(0.62496292591095), wave * DC.ar(0.17244458198547), wave * DC.ar(0.57420742511749), wave * DC.ar(0.37317538261414), wave * DC.ar(0.69875884056091)), OnePole.ar(wave * DC.ar(0.16539061069489), wave * DC.ar(0.18062949180603), wave * DC.ar(0.16975581645966), wave * DC.ar(0.065648674964905))], [WaveletDaub.ar(wave * DC.ar(0.49857544898987), wave * DC.ar(0.38111102581024), wave * DC.ar(0.0094397068023682), wave * DC.ar(0.24299585819244), wave * DC.ar(0.5219920873642)), OSWrap8.ar(wave * DC.ar(0.91542589664459), wave * DC.ar(0.27395355701447), wave * DC.ar(0.14696419239044))]], varLucretia20125612 * varLucretia20125610, varLucretia2012569 * varLucretia20125611, varLucretia20125612, varLucretia20125610 * gateEnv);
varLucretia20125612 = Slew.ar(modZ * env, PulseCount.ar(wave * DC.ar(0.40374755859375), wave * DC.ar(0.56164991855621)), modZ * modZ, varLucretia2012569, Silent.ar());
varLucretia2012569 = UHJ2B.ar(wave * DC.ar(0.8204071521759), wave * DC.ar(0.53769910335541));
varLucretia20125610 = LFCub.ar(wave * DC.ar(0.69174659252167), wave * DC.ar(0.96843218803406), wave * DC.ar(0.93881571292877), wave * DC.ar(0.17717409133911));
varLucretia20125611 = TDuty.ar(wave * DC.ar(0.77070307731628), wave * DC.ar(0.8765960931778), wave * DC.ar(0.60729074478149), wave * DC.ar(0.024263739585876), wave * DC.ar(0.26999592781067));
varLucretia20125612 = StandardTrig.ar(wave * DC.ar(0.82920777797699), wave * DC.ar(0.70151245594025), wave * DC.ar(0.57022416591644), wave * DC.ar(0.77307772636414), wave * DC.ar(0.97122967243195), wave * DC.ar(0.57508146762848), wave * DC.ar(0.033514857292175));

signal = varLucretia20125612;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Lucretia2012561
/////////////////////////////////////////////////////////

SynthDef.new("Lucretia2012561", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varLucretia2012569, varLucretia20125610, varLucretia20125611, varLucretia20125612, varLucretia201256113;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varLucretia2012569 = varLucretia20125610 = varLucretia20125611 = varLucretia20125612 = varLucretia201256113 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varLucretia2012569 = FoaPsychoShelf.ar(y, modY * signal, varLucretia20125612 * varLucretia20125612, in, FoaPressX.ar(wave * DC.ar(0.26243662834167), wave * DC.ar(0.76652467250824), wave * DC.ar(0.94166135787964), wave * DC.ar(0.022644877433777)), Silent.ar());
varLucretia20125610 = SinGrainIBF.ar(XFadeRotate.ar(wave * DC.ar(0.58802700042725), wave * DC.ar(0.063606858253479)), modX * varLucretia2012569, modY, bufnum, bufnum, varLucretia20125611 * signal, modX * gateEnv, 0.96609687805176 * modY * signal, env, 0.76446342468262 * wave * modY, 0.99005669560128 * modY * varLucretia201256113, Silent.ar());
varLucretia20125611 = SOS.ar(varLucretia20125612 * varLucretia20125610, modX * varLucretia2012569, MZPokey.ar(wave * DC.ar(0.95191335678101), wave * DC.ar(0.58891499042511), wave * DC.ar(0.99814581871033), wave * DC.ar(0.76431024074554), wave * DC.ar(0.87567043304443), wave * DC.ar(0.35881531238556), wave * DC.ar(0.32396256923676), wave * DC.ar(0.86027407646179), wave * DC.ar(0.21312880516052)), modZ * env, FincoSprottL.ar(wave * DC.ar(0.084846258163452), wave * DC.ar(0.67032098770142), wave * DC.ar(0.59175193309784), wave * DC.ar(0.48923623561859), wave * DC.ar(0.93020069599152), wave * DC.ar(0.71041524410248), wave * DC.ar(0.15569460391998), wave * DC.ar(0.59547805786133)), gate, 0.99998476314174 * modZ * varLucretia20125611, Silent.ar());
varLucretia20125612 = WaveLoss.ar(varLucretia2012569 * signal, Normalizer.ar(wave * DC.ar(0.2917594909668), wave * DC.ar(0.41536438465118), wave * DC.ar(0.55149638652802)), 0.37391316890717 * Allpass1.ar(wave * DC.ar(0.65383160114288), wave * DC.ar(0.7575101852417), wave * DC.ar(0.0058842897415161), wave * DC.ar(0.88855755329132)), bufnum, 0.99984216490228 * FMGrainI.ar(wave * DC.ar(0.97991323471069), wave * DC.ar(0.91676294803619), wave * DC.ar(0.39881479740143), wave * DC.ar(0.19772028923035), wave * DC.ar(0.24561274051666), wave * DC.ar(0.56622016429901), wave * DC.ar(0.48256170749664), wave * DC.ar(0.5593181848526), wave * DC.ar(0.44332432746887), wave * DC.ar(0.87470722198486)), Silent.ar());
varLucretia2012569 = DoubleWell3.ar(env, signal * signal, varLucretia20125611, 0.66698563098907 * modX * modY, 0.3623321056366 * env * wave, varLucretia20125611 * modY, 0.99959395531683 * varLucretia20125612 * modX, Silent.ar());
varLucretia20125610 = OneZero.ar(env * varLucretia20125610, varLucretia2012569 * modX, 0.99984199266622 * in * modZ, Silent.ar());
varLucretia20125611 = Allpass2.ar(wave * DC.ar(0.36133861541748), wave * DC.ar(0.7191458940506), wave * DC.ar(0.94467890262604), wave * DC.ar(0.83307003974915), wave * DC.ar(0.73079013824463));
varLucretia20125612 = GravityGrid2.ar(wave * DC.ar(0.38167810440063), wave * DC.ar(0.65555715560913), wave * DC.ar(0.64959990978241), wave * DC.ar(0.20480871200562), wave * DC.ar(0.65025293827057), wave * DC.ar(0.34979379177094), wave * DC.ar(0.14481496810913));
varLucretia2012569 = XOut.ar(wave * DC.ar(0.27334082126617), wave * DC.ar(0.50454580783844), wave * DC.ar(0.50277709960938));
varLucretia20125610 = MeanTriggered.ar(wave * DC.ar(0.93402588367462), wave * DC.ar(0.96259236335754), wave * DC.ar(0.91052579879761), wave * DC.ar(0.23990654945374), wave * DC.ar(0.01924729347229));
varLucretia20125611 = BufDelayC.ar(wave * DC.ar(0.71457040309906), wave * DC.ar(0.23463237285614), wave * DC.ar(0.35792124271393), wave * DC.ar(0.92699038982391), wave * DC.ar(0.57052612304688));
varLucretia20125612 = FoaPressZ.ar(wave * DC.ar(0.31829059123993), wave * DC.ar(0.74830079078674), wave * DC.ar(0.22061240673065), wave * DC.ar(0.15070676803589));
// Variation test code
varLucretia201256113 = Fhn2DL.ar(wave * varLucretia20125612, modZ * varLucretia201256113, modZ * modX, modY, gateEnv * in, bufnum, varLucretia2012569 * varLucretia2012569, t_trig, gateEnv * in, env.minNyquist(), Silent.ar().sqrsum(Allpass1.ar(varLucretia20125611 * DC.ar(0.27933132648468), varLucretia20125612 * DC.ar(0.12276577949524), varLucretia2012569 * DC.ar(0.91478681564331), varLucretia20125610 * DC.ar(0.12114059925079))));
varLucretia201256113 = AmpCompA.ar(modX * gateEnv, gate, x, amp);
varLucretia201256113 = OSFold8.ar(amp, signal * env, modY * varLucretia20125612);

signal = varLucretia201256113;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// IAMV.7992012561
/////////////////////////////////////////////////////////

SynthDef.new("IAMV.7992012561", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varIAMV7992012569, varIAMV79920125610, varIAMV799201256111, varIAMV799201256112, varIAMV799201256113;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varIAMV7992012569 = varIAMV79920125610 = varIAMV799201256111 = varIAMV799201256112 = varIAMV799201256113 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varIAMV7992012569 = SinGrainIBF.ar(in * varIAMV7992012569, wave * varIAMV7992012569, signal * varIAMV79920125610, bufnum, bufnum, in * modX, y, amp, signal * varIAMV799201256111, island, 0.96656615992432 * env * modX, Silent.ar());
varIAMV79920125610 = Wrap.ar(varIAMV799201256113, 0.44454169273376 * wave, NLFiltN.ar(wave * DC.ar(0.032752275466919), wave * DC.ar(0.51074945926666), wave * DC.ar(0.028839945793152), wave * DC.ar(0.68921196460724), wave * DC.ar(0.57581722736359), wave * DC.ar(0.84144771099091), wave * DC.ar(0.43749046325684), wave * DC.ar(0.18748199939728)));
varIAMV7992012569 = FoaZoomZ.ar(wave * DC.ar(0.93374860286713), wave * DC.ar(0.056452035903931), wave * DC.ar(0.83534097671509), wave * DC.ar(0.15502941608429));
varIAMV79920125610 = TRand.ar(signal * env, signal * wave, FincoSprottM.ar(wave * DC.ar(0.17193388938904), wave * DC.ar(0.27502107620239), wave * DC.ar(0.91562211513519), wave * DC.ar(0.31459832191467), wave * DC.ar(0.83701157569885), wave * DC.ar(0.71027219295502), wave * DC.ar(0.10757160186768), wave * DC.ar(0.66349041461945), wave * DC.ar(0.54540884494781)));
varIAMV7992012569 = SinGrainIBF.ar(wave * DC.ar(0.23092520236969), wave * DC.ar(0.98121047019958), wave * DC.ar(0.36842167377472), wave * DC.ar(0.79578626155853), wave * DC.ar(0.64622688293457), wave * DC.ar(0.3378838300705), wave * DC.ar(0.52698791027069), wave * DC.ar(0.080936074256897), wave * DC.ar(0.26453375816345), wave * DC.ar(0.096049189567566), wave * DC.ar(0.24242544174194), wave * DC.ar(0.026422739028931));
varIAMV79920125610 = BufGrainI.ar(wave * DC.ar(0.55358755588531), wave * DC.ar(0.92409634590149), wave * DC.ar(0.39548051357269), wave * DC.ar(0.74640214443207), wave * DC.ar(0.81139016151428), wave * DC.ar(0.0077276229858398), wave * DC.ar(0.8840639591217), wave * DC.ar(0.025911927223206), wave * DC.ar(0.17803061008453), wave * DC.ar(0.91444611549377), wave * DC.ar(0.99141120910645));
// Variation test code
varIAMV799201256111 = PitchShift.ar(varIAMV799201256111, varIAMV79920125610 * modX, signal, varIAMV79920125610 * varIAMV79920125610, modY * env, varIAMV7992012569, GVerb.ar(varIAMV79920125610 * DC.ar(0.37885916233063), varIAMV7992012569 * DC.ar(0.69477939605713), varIAMV7992012569 * DC.ar(0.55917418003082), varIAMV7992012569 * DC.ar(0.36376821994781), varIAMV79920125610 * DC.ar(0.56694340705872), varIAMV79920125610 * DC.ar(0.42157065868378), varIAMV7992012569 * DC.ar(0.88819575309753), varIAMV79920125610 * DC.ar(0.3869913816452), varIAMV7992012569 * DC.ar(0.42230129241943), varIAMV7992012569 * DC.ar(0.68356561660767), varIAMV79920125610 * DC.ar(0.32802069187164), varIAMV79920125610 * DC.ar(0.70779478549957)));
varIAMV799201256112 = CompanderD.ar(signal, env * varIAMV7992012569, varIAMV7992012569, Resonz.ar(in, SinGrain.ar(varIAMV7992012569 * DC.ar(0.87482821941376), varIAMV7992012569 * DC.ar(0.25780344009399), varIAMV79920125610 * DC.ar(0.0051883459091187), varIAMV79920125610 * DC.ar(0.46511697769165), varIAMV79920125610 * DC.ar(0.5208101272583)).exprange(1, SampleRate.ir), signal.expexp(varIAMV79920125610 * DC.ar(0.63751637935638), varIAMV7992012569 * DC.ar(0.21257722377777), varIAMV79920125610 * DC.ar(0.29300379753113), varIAMV7992012569 * DC.ar(0.068918704986572), varIAMV79920125610 * DC.ar(0.82330858707428)), varIAMV799201256112, Silent.ar()).clip(varIAMV7992012569 * DC.ar(0.88198101520538), varIAMV79920125610 * DC.ar(0.36489748954773)), gateEnv, bufnum.excess(MeanTriggered.ar(varIAMV79920125610 * DC.ar(0.33106112480164), varIAMV79920125610 * DC.ar(0.49569928646088), varIAMV7992012569 * DC.ar(0.58214426040649), varIAMV7992012569 * DC.ar(0.26298379898071), varIAMV7992012569 * DC.ar(0.73025977611542))), wave, Silent.ar());
varIAMV799201256113 = BPZ2.ar(signal * wave, Fold.ar(varIAMV79920125610 * DC.ar(0.4029221534729), varIAMV7992012569 * DC.ar(0.16733884811401), varIAMV79920125610 * DC.ar(0.23079323768616)), Silent.ar());
varIAMV799201256111 = FBSineC.ar(varIAMV799201256112 * varIAMV7992012569, varIAMV799201256111.exprange(varIAMV7992012569 * DC.ar(0.072256684303284), varIAMV79920125610 * DC.ar(0.022464752197266)), signal * varIAMV799201256113, gate, varIAMV799201256113 * varIAMV799201256112, signal * modX, 0.82276320457458 * varIAMV799201256112 * modX, 0.9996554803778 * varIAMV799201256111, Silent.ar());
varIAMV799201256112 = FoaDominateX.ar(varIAMV79920125610, PeakFollower.ar(0.68704521656036 * LPCError.ar(varIAMV7992012569 * DC.ar(0.81927859783173), varIAMV79920125610 * DC.ar(0.81868636608124), varIAMV79920125610 * DC.ar(0.2149555683136), varIAMV7992012569 * DC.ar(0.70604729652405)), in), 0.92822564273007 * modY * varIAMV79920125610, Silent.ar());
varIAMV799201256113 = HPZ1.ar(wave * env, 0.56002120855202 * varIAMV799201256113 * varIAMV799201256113, Silent.ar());
varIAMV799201256111 = SpruceBudworm.ar(0.60376942157745 * env * in, varIAMV799201256112 * in, in * env, varIAMV79920125610 * varIAMV799201256113, modY * varIAMV7992012569, t_trig, TExpRand.ar(modX * varIAMV79920125610, t_trig, varIAMV799201256111 * modZ).bitHammingDistance(B2Ster.ar(varIAMV7992012569 * DC.ar(0.7072252035141), varIAMV79920125610 * DC.ar(0.93628072738647), varIAMV79920125610 * DC.ar(0.85771644115448), varIAMV7992012569 * DC.ar(0.65440690517426), varIAMV7992012569 * DC.ar(0.046786069869995))), modY * varIAMV79920125610, in * modY, 0.76253366470337 * varIAMV79920125610 * modY, 0.97743191375259 * modX * in, Silent.ar());
varIAMV799201256112 = A2B.ar(signal, gateEnv * varIAMV799201256112, 0.49918961524963 * modY * varIAMV799201256113, env);
varIAMV799201256113 = InRect.ar(varIAMV799201256113, gateEnv, Rect.new(0, 0, 0.89734327793121, 0.63122665882111));

signal = varIAMV799201256113;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// WM.Nikita2012571
/////////////////////////////////////////////////////////

SynthDef.new("WM.Nikita2012571", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varWMNikita2012579, varWMNikita20125710, varWMNikita20125711, varWMNikita20125712, varWMNikita20125713, varWMNikita201257114, varWMNikita201257115, varWMNikita201257116;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varWMNikita2012579 = varWMNikita20125710 = varWMNikita20125711 = varWMNikita20125712 = varWMNikita20125713 = varWMNikita201257114 = varWMNikita201257115 = varWMNikita201257116 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varWMNikita2012579 = B2UHJ.ar(signal * env, gateEnv, 0.054584980010986 * varWMNikita201257115 * varWMNikita20125711);
varWMNikita20125710 = YigClifford3DC.ar(RedDPCMencode.ar(wave * DC.ar(0.32599449157715), wave * DC.ar(0.99672341346741)).exprange(1, SampleRate.ir), y, modZ * modY, varWMNikita2012579, modX * varWMNikita20125712, x, NestedAllpassN.ar(wave * DC.ar(0.2947918176651), wave * DC.ar(0.19864356517792), wave * DC.ar(0.63547682762146), wave * DC.ar(0.55640769004822), wave * DC.ar(0.96551561355591), wave * DC.ar(0.45579087734222), wave * DC.ar(0.20104539394379), wave * DC.ar(0.023300766944885), wave * DC.ar(0.58229827880859)), varWMNikita20125712, DoubleNestedAllpassL.ar(wave * DC.ar(0.91025876998901), wave * DC.ar(0.010131120681763), wave * DC.ar(0.39646983146667), wave * DC.ar(0.07037627696991), wave * DC.ar(0.44479072093964), wave * DC.ar(0.23512256145477), wave * DC.ar(0.36080718040466), wave * DC.ar(0.30733346939087), wave * DC.ar(0.3956903219223), wave * DC.ar(0.53278076648712), wave * DC.ar(0.74018931388855), wave * DC.ar(0.068816065788269)), Silent.ar());
varWMNikita20125711 = Poll.ar(varWMNikita20125712, modY, 0.095818638801575 * varWMNikita20125710 * varWMNikita20125712, wave * env);
varWMNikita20125712 = GbmanTrig.ar(varWMNikita201257115 * modZ, gateEnv, varWMNikita201257114 * varWMNikita20125711, y.rightShift(SMS.ar(wave * DC.ar(0.46961486339569), wave * DC.ar(0.82996332645416), wave * DC.ar(0.62526500225067), wave * DC.ar(0.20603668689728), wave * DC.ar(0.37009072303772), wave * DC.ar(0.34384524822235), wave * DC.ar(0.46605587005615), wave * DC.ar(0.87256562709808), wave * DC.ar(0.60957229137421), wave * DC.ar(0.9015429019928), wave * DC.ar(0.71324062347412), wave * DC.ar(0.78185641765594), wave * DC.ar(0.92727649211884))), BinData.ar(wave * DC.ar(0.64779472351074), wave * DC.ar(0.95865261554718), wave * DC.ar(0.31697738170624)), Silent.ar());
varWMNikita20125713 = Latoocarfian2DC.ar(modZ, varWMNikita2012579, bufnum, gate, varWMNikita20125712 * varWMNikita20125713, modX, signal * varWMNikita201257116, 0.090417981147766 * modZ * modY, CircleRamp.ar(wave * DC.ar(0.25082302093506), wave * DC.ar(0.36552834510803), wave * DC.ar(0.10818660259247), wave * DC.ar(0.45280969142914), wave * DC.ar(0.70405697822571), wave * DC.ar(0.088507413864136)), Silent.ar());
varWMNikita2012579 = Dust.ar(varWMNikita201257114 * varWMNikita201257116, in, Silent.ar());
varWMNikita20125710 = HPZ2.ar(gateEnv.expexp(wave * DC.ar(0.049498796463013), wave * DC.ar(0.68233788013458), wave * DC.ar(0.45072972774506), wave * DC.ar(0.050355076789856), wave * DC.ar(0.30784940719604)), 0.93747664221411 * varWMNikita2012579 * modX, Silent.ar());
varWMNikita20125711 = BBlockerBuf.ar(signal * wave.excess(Pan2.ar(wave * DC.ar(0.21905958652496), wave * DC.ar(0.40544271469116), wave * DC.ar(0.29300105571747))), Array.fill(2.pow(13), { |i| rrand(-1, 1) }).as(LocalBuf), varWMNikita20125713);
varWMNikita20125712 = FBSineC.ar(Integrator.ar(wave * DC.ar(0.20741760730743), wave * DC.ar(0.45192563533783), wave * DC.ar(0.80405879020691), wave * DC.ar(0.65493988990784)).exprange(1, SampleRate.ir), modZ, varWMNikita201257116 * gateEnv, varWMNikita201257114 * varWMNikita201257115, varWMNikita201257116 * varWMNikita20125710, varWMNikita201257114, gate, Slope.ar(wave * DC.ar(0.42740190029144), wave * DC.ar(0.92476010322571), wave * DC.ar(0.44921147823334)), Silent.ar());
varWMNikita20125713 = TBrownRand.ar(varWMNikita201257114 * signal, varWMNikita201257116 * signal, varWMNikita201257116 * varWMNikita201257115, env, varWMNikita201257115 * in, Gendy1.ar(wave * DC.ar(0.079914689064026), wave * DC.ar(0.33176743984222), wave * DC.ar(0.1893846988678), wave * DC.ar(0.96550130844116), wave * DC.ar(0.54503798484802), wave * DC.ar(0.69729316234589), wave * DC.ar(0.20028805732727), wave * DC.ar(0.2353743314743), wave * DC.ar(0.41431081295013), wave * DC.ar(0.83364009857178), wave * DC.ar(0.33286666870117), wave * DC.ar(0.68945825099945)), Silent.ar());
varWMNikita2012579 = Streson.ar(wave * DC.ar(0.86893546581268), wave * DC.ar(0.53751742839813), wave * DC.ar(0.69296681880951), wave * DC.ar(0.72251391410828), wave * DC.ar(0.1850026845932));
varWMNikita20125710 = FoaDirectZ.ar(wave * DC.ar(0.44550836086273), wave * DC.ar(0.11800241470337), wave * DC.ar(0.16234183311462), wave * DC.ar(0.65222728252411));
varWMNikita20125711 = FoaDirectY.ar(wave * DC.ar(0.058140635490417), wave * DC.ar(0.25916838645935), wave * DC.ar(0.18338966369629), wave * DC.ar(0.24231553077698));
varWMNikita20125712 = TBetaRand.ar(wave * DC.ar(0.17760968208313), wave * DC.ar(0.21938145160675), wave * DC.ar(0.88541233539581), wave * DC.ar(0.11713492870331), wave * DC.ar(0.25563776493073), wave * DC.ar(0.8853794336319), wave * DC.ar(0.91962707042694));
varWMNikita20125713 = Shaper.ar(wave * DC.ar(0.16701853275299), wave * DC.ar(0.41178393363953), wave * DC.ar(0.39877319335938), wave * DC.ar(0.70075416564941));
// Variation test code
varWMNikita201257114 = HenonC.ar(varWMNikita2012579 * varWMNikita201257114, bufnum, varWMNikita201257116 * env, varWMNikita20125712, y, 0.99887771499913 * varWMNikita201257116 * modY, Silent.ar());
varWMNikita201257115 = IEnvGen.ar(modY * wave, varWMNikita201257114 * modZ, varWMNikita20125712, Silent.ar());
varWMNikita201257116 = Henon2DC.ar(LFNoise1.ar(varWMNikita20125710 * DC.ar(0.8682336807251), varWMNikita20125710 * DC.ar(0.73523795604706), varWMNikita20125713 * DC.ar(0.050636291503906)).exprange(1, SampleRate.ir), varWMNikita20125710, modZ * env, varWMNikita20125712, varWMNikita20125711 * varWMNikita20125711, varWMNikita20125712.lag3(varWMNikita2012579 * DC.ar(0.48573291301727), varWMNikita2012579 * DC.ar(0.085093855857849)), DiskOut.ar(varWMNikita20125710 * DC.ar(0.35569441318512), varWMNikita20125711 * DC.ar(0.49451172351837)), Silent.ar());
varWMNikita201257114 = B2Ster.ar(modY * signal, modX, 0.68413197994232 * varWMNikita201257116 * varWMNikita20125712, BPeakEQ.ar(varWMNikita20125713 * DC.ar(0.058927536010742), varWMNikita2012579 * DC.ar(0.65101432800293), varWMNikita20125712 * DC.ar(0.026455521583557), varWMNikita2012579 * DC.ar(0.037302255630493), varWMNikita20125711 * DC.ar(0.28518748283386), varWMNikita20125711 * DC.ar(0.99558448791504)), Silent.ar());
varWMNikita201257115 = FMGrainBF.ar(PVInfo.ar(varWMNikita20125711 * DC.ar(0.6415182352066), varWMNikita20125711 * DC.ar(0.58146870136261), varWMNikita20125711 * DC.ar(0.98125815391541), varWMNikita20125711 * DC.ar(0.75580275058746), varWMNikita20125711 * DC.ar(0.031283020973206)), varWMNikita20125710 * modY, Slub.ar(varWMNikita20125712 * DC.ar(0.095845103263855), varWMNikita2012579 * DC.ar(0.36157512664795)).exprange(1, SampleRate.ir), varWMNikita20125710 * signal, varWMNikita20125712, z, BiPanB2.ar(wave * signal, x, 0.82018506526947 * modZ * signal, varWMNikita20125710 * modY), Duty.ar(varWMNikita201257115, modX, wave * modZ, in), varWMNikita20125713 * varWMNikita20125710, 0.9999721775179 * varWMNikita201257114 * varWMNikita201257114, Silent.ar());
varWMNikita201257116 = BAllPass.ar(modZ * varWMNikita20125710, FoaAsymmetry.ar(varWMNikita20125713 * DC.ar(0.7722293138504), varWMNikita20125711 * DC.ar(0.92814815044403), varWMNikita20125711 * DC.ar(0.71952152252197), varWMNikita20125711 * DC.ar(0.12391626834869)).exprange(1, SampleRate.ir), z, Duty.ar(varWMNikita20125710 * DC.ar(0.017980456352234), varWMNikita20125712 * DC.ar(0.66689133644104), varWMNikita20125710 * DC.ar(0.20077764987946), varWMNikita20125713 * DC.ar(0.22882580757141)), Silent.ar());
varWMNikita201257114 = DoubleWell.ar(Decay.ar(varWMNikita20125712 * env, in * varWMNikita201257116, Gbman2DL.ar(varWMNikita20125711 * DC.ar(0.58902955055237), varWMNikita20125711 * DC.ar(0.93039357662201), varWMNikita20125712 * DC.ar(0.26455318927765), varWMNikita2012579 * DC.ar(0.31909692287445), varWMNikita20125710 * DC.ar(0.64127862453461), varWMNikita20125712 * DC.ar(0.21486020088196)), Silent.ar()), amp, varWMNikita20125712 * wave, signal, FMHEncode2.ar(varWMNikita2012579, varWMNikita201257114 * modY, varWMNikita20125712 * varWMNikita20125712, varWMNikita20125712, env * modY, gateEnv * env), x, t_trig, bufnum, BufGrain.ar(varWMNikita20125710 * DC.ar(0.38532793521881), varWMNikita2012579 * DC.ar(0.64636135101318), varWMNikita20125711 * DC.ar(0.85558927059174), varWMNikita20125712 * DC.ar(0.7439261674881), varWMNikita20125713 * DC.ar(0.90183043479919), varWMNikita20125710 * DC.ar(0.87491011619568), varWMNikita20125712 * DC.ar(0.71114301681519), varWMNikita20125710 * DC.ar(0.74193394184113)).slew(varWMNikita20125710 * DC.ar(0.30127716064453), varWMNikita20125710 * DC.ar(0.31289875507355)), BiPanB2.ar(varWMNikita20125711 * DC.ar(0.80815970897675), varWMNikita2012579 * DC.ar(0.41314744949341), varWMNikita20125713 * DC.ar(0.70232725143433), varWMNikita20125712 * DC.ar(0.18489933013916)));
varWMNikita201257115 = TWindex.ar(modX * varWMNikita20125713, [YigCliffordN.ar(varWMNikita20125710 * DC.ar(0.55759036540985), varWMNikita20125713 * DC.ar(0.7427636384964), varWMNikita20125712 * DC.ar(0.033926486968994), varWMNikita20125710 * DC.ar(0.27425670623779), varWMNikita20125710 * DC.ar(0.26575529575348), varWMNikita20125711 * DC.ar(0.8989759683609), varWMNikita20125713 * DC.ar(0.045406579971313), varWMNikita2012579 * DC.ar(0.86830258369446), varWMNikita2012579 * DC.ar(0.96216249465942)), Schmidt.ar(varWMNikita2012579 * DC.ar(0.78972518444061), varWMNikita2012579 * DC.ar(0.57178783416748), varWMNikita2012579 * DC.ar(0.41425812244415))], in * modY.wrap(varWMNikita20125712 * DC.ar(0.65249860286713), varWMNikita20125712 * DC.ar(0.74055409431458)));
varWMNikita201257116 = Compander.ar(modY, t_trig, in * modY, varWMNikita20125711, varWMNikita20125711 * varWMNikita20125713, modX * varWMNikita201257116, modX * modY, varWMNikita201257114, Silent.ar());

signal = varWMNikita201257116;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// VBS.LoveLetter.A(1)201258
/////////////////////////////////////////////////////////

SynthDef.new("VBS.LoveLetter.A(1)201258", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varVBSLoveLetterA12012589, varVBSLoveLetterA120125810;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varVBSLoveLetterA12012589 = varVBSLoveLetterA120125810 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varVBSLoveLetterA12012589 = Summer.ar(gateEnv * in, in * varVBSLoveLetterA120125810, signal * varVBSLoveLetterA120125810, modZ * varVBSLoveLetterA120125810);
varVBSLoveLetterA120125810 = Phasor.ar(varVBSLoveLetterA120125810, bufnum, modZ * in, in * signal, in);
varVBSLoveLetterA12012589 = RMAFoodChainL.ar(EnvFollow.ar(wave * DC.ar(0.33884024620056), wave * DC.ar(0.6877361536026), wave * DC.ar(0.71700406074524), wave * DC.ar(0.30578756332397)).exprange(1, SampleRate.ir), amp, wave, LPF1.ar(wave * DC.ar(0.58330297470093), wave * DC.ar(0.90662026405334)), varVBSLoveLetterA120125810 * modZ, env * gateEnv, gateEnv * varVBSLoveLetterA12012589, amp, z, wave, wave * signal.lagud(wave * DC.ar(0.63759505748749), wave * DC.ar(0.24092817306519)), y, modY, 0.92505268593961 * FMGrainBBF.ar(wave * DC.ar(0.77625691890717), wave * DC.ar(0.38290131092072), wave * DC.ar(0.69692254066467), wave * DC.ar(0.027998208999634), wave * DC.ar(0.51435995101929), wave * DC.ar(0.38459646701813), wave * DC.ar(0.97253155708313), wave * DC.ar(0.61789786815643), wave * DC.ar(0.46696150302887), wave * DC.ar(0.60568153858185), wave * DC.ar(0.022040486335754), wave * DC.ar(0.33545160293579)), Silent.ar());
varVBSLoveLetterA120125810 = FoaPushY.ar(modX, wave, varVBSLoveLetterA12012589, Silent.ar());
varVBSLoveLetterA12012589 = SpruceBudworm.ar(wave * DC.ar(0.89094460010529), wave * DC.ar(0.75262475013733), wave * DC.ar(0.30393433570862), wave * DC.ar(0.52977812290192), wave * DC.ar(0.43152666091919), wave * DC.ar(0.45231139659882), wave * DC.ar(0.80144655704498), wave * DC.ar(0.99439013004303), wave * DC.ar(0.56213879585266), wave * DC.ar(0.93479752540588), wave * DC.ar(0.85564386844635), wave * DC.ar(0.31596755981445));
varVBSLoveLetterA120125810 = LeakDC.ar(wave * DC.ar(0.29078507423401), wave * DC.ar(0.76724791526794), wave * DC.ar(0.24145472049713), wave * DC.ar(0.26276683807373));

signal = varVBSLoveLetterA120125810;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// VBS.LoveLetter.A(1)2012581
/////////////////////////////////////////////////////////

SynthDef.new("VBS.LoveLetter.A(1)2012581", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varVBSLoveLetterA12012589, varVBSLoveLetterA120125810, varVBSLoveLetterA1201258111, varVBSLoveLetterA1201258112, varVBSLoveLetterA1201258113;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varVBSLoveLetterA12012589 = varVBSLoveLetterA120125810 = varVBSLoveLetterA1201258111 = varVBSLoveLetterA1201258112 = varVBSLoveLetterA1201258113 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varVBSLoveLetterA12012589 = LFNoise2.ar(SinGrainI.ar(wave * DC.ar(0.19172787666321), wave * DC.ar(0.2738561630249), wave * DC.ar(0.48482871055603), wave * DC.ar(0.70683240890503), wave * DC.ar(0.63567495346069), wave * DC.ar(0.58227133750916), wave * DC.ar(0.1811625957489), wave * DC.ar(0.41084289550781)).exprange(1, SampleRate.ir), 0.6485788886021 * env * env, Silent.ar());
varVBSLoveLetterA120125810 = Fhn2DC.ar(varVBSLoveLetterA1201258112 * varVBSLoveLetterA1201258113, wave * varVBSLoveLetterA12012589, in * wave, varVBSLoveLetterA1201258112 * wave, wave, modZ, gateEnv * signal, varVBSLoveLetterA120125810 * varVBSLoveLetterA12012589, AmpComp.ar(wave * DC.ar(0.024909615516663), wave * DC.ar(0.0074806213378906), wave * DC.ar(0.35950946807861)), 0.40037975797347 * modX * varVBSLoveLetterA1201258113, Silent.ar());
varVBSLoveLetterA12012589 = StkShakers.ar(wave * DC.ar(0.78607821464539), wave * DC.ar(0.095842003822327), wave * DC.ar(0.029793620109558), wave * DC.ar(0.15990149974823), wave * DC.ar(0.67165803909302), wave * DC.ar(0.25474691390991), wave * DC.ar(0.29148685932159));
varVBSLoveLetterA120125810 = FoaFocusY.ar(wave * DC.ar(0.09277069568634), wave * DC.ar(0.61049044132233), wave * DC.ar(0.49009573459625), wave * DC.ar(0.85439038276672));
varVBSLoveLetterA12012589 = Lag3.ar(wave * DC.ar(0.086207985877991), wave * DC.ar(0.64284193515778), wave * DC.ar(0.52742040157318), wave * DC.ar(0.49553859233856));
varVBSLoveLetterA120125810 = PinkNoise.ar(wave * DC.ar(0.46156871318817), wave * DC.ar(0.31674635410309));
// Variation test code
varVBSLoveLetterA1201258111 = BBandPass.ar(env, in * modZ, 0.06768262386322 * varVBSLoveLetterA120125810 * wave, SID6581f.ar(varVBSLoveLetterA120125810 * DC.ar(0.82492792606354), varVBSLoveLetterA12012589 * DC.ar(0.62083530426025), varVBSLoveLetterA120125810 * DC.ar(0.66781139373779), varVBSLoveLetterA12012589 * DC.ar(0.51706409454346), varVBSLoveLetterA120125810 * DC.ar(0.080202341079712), varVBSLoveLetterA12012589 * DC.ar(0.38480722904205), varVBSLoveLetterA12012589 * DC.ar(0.44877874851227), varVBSLoveLetterA120125810 * DC.ar(0.79925119876862), varVBSLoveLetterA120125810 * DC.ar(0.71576082706451), varVBSLoveLetterA120125810 * DC.ar(0.79641222953796), varVBSLoveLetterA12012589 * DC.ar(0.9906564950943), varVBSLoveLetterA120125810 * DC.ar(0.2865024805069), varVBSLoveLetterA120125810 * DC.ar(0.2013521194458), varVBSLoveLetterA120125810 * DC.ar(0.60616874694824), varVBSLoveLetterA120125810 * DC.ar(0.027041673660278), varVBSLoveLetterA120125810 * DC.ar(0.95771300792694), varVBSLoveLetterA120125810 * DC.ar(0.61625933647156), varVBSLoveLetterA12012589 * DC.ar(0.56050086021423), varVBSLoveLetterA120125810 * DC.ar(0.0095027685165405), varVBSLoveLetterA120125810 * DC.ar(0.704669713974), varVBSLoveLetterA120125810 * DC.ar(0.28893780708313), varVBSLoveLetterA120125810 * DC.ar(0.70966565608978), varVBSLoveLetterA120125810 * DC.ar(0.090197086334229), varVBSLoveLetterA120125810 * DC.ar(0.086075067520142), varVBSLoveLetterA120125810 * DC.ar(0.13951897621155), varVBSLoveLetterA120125810 * DC.ar(0.21542763710022)), Silent.ar());
varVBSLoveLetterA1201258112 = BufCombC.ar(Array.fill(2.pow(16), { |i| rrand(-1, 1) }).as(LocalBuf), varVBSLoveLetterA1201258112 * varVBSLoveLetterA12012589, varVBSLoveLetterA120125810, env, 0.99353706377886 * DC.ar(varVBSLoveLetterA120125810 * DC.ar(0.24413919448853)), Silent.ar());
varVBSLoveLetterA1201258113 = LPZ1.ar(varVBSLoveLetterA1201258113 * wave, 0.99993674474803 * LinCongN.ar(varVBSLoveLetterA12012589 * DC.ar(0.73717379570007), varVBSLoveLetterA120125810 * DC.ar(0.03948986530304), varVBSLoveLetterA120125810 * DC.ar(0.09149694442749), varVBSLoveLetterA12012589 * DC.ar(0.1618629693985), varVBSLoveLetterA12012589 * DC.ar(0.85290694236755), varVBSLoveLetterA120125810 * DC.ar(0.29896831512451), varVBSLoveLetterA120125810 * DC.ar(0.48769068717957)), Silent.ar());
varVBSLoveLetterA1201258111 = Spring.ar(in * modX, 0.34913837909698 * varVBSLoveLetterA120125810, wave);
varVBSLoveLetterA1201258112 = Pulse.ar(Demand.ar(varVBSLoveLetterA120125810 * DC.ar(0.74579048156738), varVBSLoveLetterA12012589 * DC.ar(0.35898625850677), varVBSLoveLetterA120125810 * DC.ar(0.58883094787598)).exprange(1, SampleRate.ir), 0.11340045928955 * varVBSLoveLetterA1201258112 * modZ, BPF.ar(varVBSLoveLetterA120125810 * DC.ar(0.53186798095703), varVBSLoveLetterA12012589 * DC.ar(0.24151146411896), varVBSLoveLetterA120125810 * DC.ar(0.69625627994537), varVBSLoveLetterA120125810 * DC.ar(0.52692115306854), varVBSLoveLetterA120125810 * DC.ar(0.685826420784)), Silent.ar());
varVBSLoveLetterA1201258113 = HenonL.ar(gateEnv * varVBSLoveLetterA1201258111, 0.78486132621765 * TGaussRand.ar(varVBSLoveLetterA12012589 * DC.ar(0.32557427883148), varVBSLoveLetterA120125810 * DC.ar(0.091389179229736), varVBSLoveLetterA12012589 * DC.ar(0.64817559719086), varVBSLoveLetterA12012589 * DC.ar(0.5548243522644), varVBSLoveLetterA120125810 * DC.ar(0.16841542720795)), in * signal, modZ * varVBSLoveLetterA1201258111, modY * wave, 0.96644334895947 * varVBSLoveLetterA120125810 * modX, Silent.ar());
varVBSLoveLetterA1201258111 = BufCombL.ar(Array.fill(2.pow(10), { |i| rrand(-1, 1) }).as(LocalBuf), bufnum, varVBSLoveLetterA120125810, env * varVBSLoveLetterA120125810, in, Silent.ar());
varVBSLoveLetterA1201258112 = YigMandelbulbN.ar(InGrainBBF.ar(varVBSLoveLetterA12012589 * DC.ar(0.72018778324127), varVBSLoveLetterA120125810 * DC.ar(0.35681140422821), varVBSLoveLetterA120125810 * DC.ar(0.54308903217316), varVBSLoveLetterA120125810 * DC.ar(0.49206233024597), varVBSLoveLetterA120125810 * DC.ar(0.033193707466125), varVBSLoveLetterA12012589 * DC.ar(0.80661594867706), varVBSLoveLetterA120125810 * DC.ar(0.65045940876007), varVBSLoveLetterA12012589 * DC.ar(0.58166599273682), varVBSLoveLetterA12012589 * DC.ar(0.95584285259247), varVBSLoveLetterA120125810 * DC.ar(0.68618249893188)).exprange(1, SampleRate.ir), varVBSLoveLetterA1201258112.blend(varVBSLoveLetterA120125810 * DC.ar(0.81925654411316), varVBSLoveLetterA12012589 * DC.ar(0.39463496208191)), signal * varVBSLoveLetterA1201258113, amp, varVBSLoveLetterA120125810, 0.99987469409099 * modX.lag(varVBSLoveLetterA12012589 * DC.ar(0.43352293968201), varVBSLoveLetterA120125810 * DC.ar(0.33868217468262)), Silent.ar());
varVBSLoveLetterA1201258113 = BBlockerBuf.ar(wave * varVBSLoveLetterA120125810, Array.fill(2.pow(14), { |i| rrand(-1, 1) }).as(LocalBuf).clip(varVBSLoveLetterA12012589 * DC.ar(0.91134786605835), varVBSLoveLetterA12012589 * DC.ar(0.77007746696472)), BufGrain.ar(wave * modY, env, bufnum, varVBSLoveLetterA1201258112, gate, varVBSLoveLetterA120125810, 0.95878166525968 * varVBSLoveLetterA12012589 * varVBSLoveLetterA1201258111, Silent.ar()));

signal = varVBSLoveLetterA1201258113;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Flue201258
/////////////////////////////////////////////////////////

SynthDef.new("Flue201258", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varFlue2012589, varFlue20125810, varFlue20125811, varFlue20125812, varFlue20125813, varFlue20125814;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varFlue2012589 = varFlue20125810 = varFlue20125811 = varFlue20125812 = varFlue20125813 = varFlue20125814 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varFlue2012589 = StkVoicForm.ar(env, varFlue20125813, gateEnv, varFlue20125811, varFlue20125812, varFlue20125813, varFlue20125812 * varFlue20125814, 0.99994903374619 * modZ * signal, Silent.ar());
varFlue20125810 = Slope.ar(island, 0.87848557224409 * modZ * varFlue20125813, SinGrain.ar(wave * DC.ar(0.6008996963501), wave * DC.ar(0.59674525260925), wave * DC.ar(0.71367204189301), wave * DC.ar(0.075865387916565), wave * DC.ar(0.53641653060913)));
varFlue20125811 = PulseCount.ar(env * gateEnv, varFlue20125812 * modX);
varFlue20125812 = DoubleNestedAllpassN.ar(x, modY * varFlue20125814, t_trig, t_trig, env * modX, in, env * varFlue20125811, varFlue2012589, gateEnv, t_trig, 0.99952355173054 * modZ * varFlue20125810, Silent.ar());
varFlue20125813 = WeaklyNonlinear.ar(varFlue20125811, varFlue20125812 * in, gateEnv, varFlue20125812, signal * wave, signal, varFlue20125813, z, varFlue20125813 * env, varFlue20125812, modY, varFlue20125814, Silent.ar());
varFlue20125814 = FoaTilt.ar(varFlue20125810 * varFlue20125811, 0.85797226428986 * signal * varFlue20125812, varFlue20125813, Decay.ar(wave * DC.ar(0.37356281280518), wave * DC.ar(0.096198678016663), wave * DC.ar(0.644122838974), wave * DC.ar(0.59078562259674)));
varFlue2012589 = FhnTrig.ar(wave * DC.ar(0.36597609519958), wave * DC.ar(0.41238677501678), wave * DC.ar(0.88075256347656), wave * DC.ar(0.89021301269531), wave * DC.ar(0.44065153598785), wave * DC.ar(0.6361266374588), wave * DC.ar(0.93450355529785), wave * DC.ar(0.86346983909607), wave * DC.ar(0.26211941242218), wave * DC.ar(0.93537223339081), wave * DC.ar(0.84401166439056));
varFlue20125810 = FMHEncode0.ar(wave * DC.ar(0.88493096828461), wave * DC.ar(0.88265454769135), wave * DC.ar(0.64838004112244), wave * DC.ar(0.35653614997864));
varFlue20125811 = Duty.ar(wave * DC.ar(0.44393169879913), wave * DC.ar(0.77660882472992), wave * DC.ar(0.75232815742493), wave * DC.ar(0.004432201385498));
varFlue20125812 = StkFlute.ar(wave * DC.ar(0.23552560806274), wave * DC.ar(0.29220545291901), wave * DC.ar(0.41009855270386), wave * DC.ar(0.55993163585663), wave * DC.ar(0.92768728733063), wave * DC.ar(0.10854947566986));
varFlue20125813 = LatoocarfianN.ar(wave * DC.ar(0.760822057724), wave * DC.ar(0.94427084922791), wave * DC.ar(0.0066484212875366), wave * DC.ar(0.99537694454193), wave * DC.ar(0.47540581226349), wave * DC.ar(0.97287595272064), wave * DC.ar(0.51735496520996), wave * DC.ar(0.99845695495605), wave * DC.ar(0.71931529045105));
varFlue20125814 = TGrains.ar(2, modZ * varFlue20125811, Array.fill(2.pow(10), { |i| rrand(-1, 1) }).as(LocalBuf), varFlue2012589, varFlue20125811 * varFlue20125810, varFlue2012589 * env.excess(LeastChange.ar(wave * DC.ar(0.25018084049225), wave * DC.ar(0.41263437271118))), wave * in, NestedAllpassN.ar(wave * DC.ar(0.36876773834229), wave * DC.ar(0.099956274032593), wave * DC.ar(0.62327814102173), wave * DC.ar(0.62685966491699), wave * DC.ar(0.71851289272308), wave * DC.ar(0.63699126243591), wave * DC.ar(0.93143749237061), wave * DC.ar(0.64787197113037), wave * DC.ar(0.1961350440979)), 0.47988283634186 * modX * varFlue20125814);
varFlue2012589 = TwoTube.ar(wave * DC.ar(0.57829284667969), wave * DC.ar(0.67185509204865), wave * DC.ar(0.38395667076111), wave * DC.ar(0.0082848072052002), wave * DC.ar(0.65654599666595), wave * DC.ar(0.8916426897049), wave * DC.ar(0.51327335834503));
varFlue20125810 = WeaklyNonlinear2.ar(wave * DC.ar(0.74831223487854), wave * DC.ar(0.54630696773529), wave * DC.ar(0.1723256111145), wave * DC.ar(0.68966221809387), wave * DC.ar(0.16789484024048), wave * DC.ar(0.25392258167267), wave * DC.ar(0.08020555973053), wave * DC.ar(0.95446956157684), wave * DC.ar(0.88621151447296), wave * DC.ar(0.49554455280304), wave * DC.ar(0.1530727148056), wave * DC.ar(0.6130223274231), wave * DC.ar(0.33850300312042));
varFlue20125811 = FoaPressY.ar(wave * DC.ar(0.4043995141983), wave * DC.ar(0.52541637420654), wave * DC.ar(0.44985330104828), wave * DC.ar(0.45504283905029));
varFlue20125812 = XFadeRotate.ar(wave * DC.ar(0.30429446697235), wave * DC.ar(0.63920927047729));
varFlue20125813 = Pan2.ar(wave * DC.ar(0.91272485256195), wave * DC.ar(0.093399405479431), wave * DC.ar(0.75885343551636));
varFlue20125814 = HPF.ar(wave * DC.ar(0.66375720500946), wave * DC.ar(0.46712791919708), wave * DC.ar(0.13938546180725), wave * DC.ar(0.45568943023682));

signal = varFlue20125814;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Hmon201259
/////////////////////////////////////////////////////////

SynthDef.new("Hmon201259", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varHmon2012599, varHmon20125910, varHmon20125911, varHmon20125912;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varHmon2012599 = varHmon20125910 = varHmon20125911 = varHmon20125912 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varHmon2012599 = Allpass2.ar(InGrainIBF.ar(wave * DC.ar(0.38606286048889), wave * DC.ar(0.039725065231323), wave * DC.ar(0.77054882049561), wave * DC.ar(0.040064692497253), wave * DC.ar(0.63234412670135), wave * DC.ar(0.96160650253296), wave * DC.ar(0.56449961662292), wave * DC.ar(0.22913789749146), wave * DC.ar(0.22291243076324), wave * DC.ar(0.55353665351868), wave * DC.ar(0.40501475334167), wave * DC.ar(0.79828059673309)), varHmon20125911 * env, 0.55939090251923 * signal * modY.slew(wave * DC.ar(0.74704039096832), wave * DC.ar(0.40309131145477)), RunningMax.ar(wave * DC.ar(0.21742510795593), wave * DC.ar(0.87934982776642)), Silent.ar());
varHmon20125910 = StkBandedWG.ar(varHmon20125912 * modY, x, modY * gateEnv, modY, modX * varHmon20125911, in, env * env, 0.99208545684814 * modZ * varHmon20125910, varHmon20125912 * varHmon20125910, 0.78007110734952 * varHmon20125910 * varHmon20125911, Silent.ar());
varHmon20125911 = RMEQ.ar(gate, varHmon20125910 * modZ, z, varHmon2012599 * varHmon20125912, 0.87609590594106 * env * modY, Silent.ar());
varHmon20125912 = K2A.ar(t_trig);
varHmon2012599 = Balance2.ar(modY * varHmon20125912, env, wave * modZ, signal * varHmon20125910);
varHmon20125910 = PanB.ar(bufnum, signal * varHmon20125910, modY * signal, varHmon20125912 * varHmon20125911);
varHmon20125911 = B2Ster.ar(wave * DC.ar(0.0092535018920898), wave * DC.ar(0.40743732452393), wave * DC.ar(0.056083559989929), wave * DC.ar(0.85162913799286), wave * DC.ar(0.31394147872925));
varHmon20125912 = Klang.ar(`[[SoftClipAmp4.ar(wave * DC.ar(0.70929157733917), wave * DC.ar(0.12127721309662), wave * DC.ar(0.61864721775055), wave * DC.ar(0.49008631706238)), ClipNoise.ar(wave * DC.ar(0.22028601169586), wave * DC.ar(0.80014050006866))], [AllpassN.ar(wave * DC.ar(0.36902010440826), wave * DC.ar(0.57834219932556), wave * DC.ar(0.16297841072083), wave * DC.ar(0.63822364807129), wave * DC.ar(0.69719326496124), wave * DC.ar(0.1454963684082)), Ramp.ar(wave * DC.ar(0.32715916633606), wave * DC.ar(0.79693961143494), wave * DC.ar(0.57628607749939), wave * DC.ar(0.86123967170715))], [Blip.ar(wave * DC.ar(0.013992786407471), wave * DC.ar(0.18768715858459), wave * DC.ar(0.3928736448288), wave * DC.ar(0.5604419708252)), Pan2.ar(wave * DC.ar(0.0051630735397339), wave * DC.ar(0.077322125434875), wave * DC.ar(0.97272324562073))]], DoubleWell3.ar(wave * DC.ar(0.021633744239807), wave * DC.ar(0.086545348167419), wave * DC.ar(0.83256888389587), wave * DC.ar(0.22865068912506), wave * DC.ar(0.89185798168182), wave * DC.ar(0.45662927627563), wave * DC.ar(0.94994747638702), wave * DC.ar(0.39636647701263)).exprange(1, SampleRate.ir), varHmon20125912 * varHmon20125910);
varHmon2012599 = BFDecode1.ar(wave * DC.ar(0.095544815063477), wave * DC.ar(0.28161859512329), wave * DC.ar(0.53472936153412), wave * DC.ar(0.95042788982391), wave * DC.ar(0.040490984916687), wave * DC.ar(0.36642754077911), wave * DC.ar(0.20170283317566), wave * DC.ar(0.48357439041138), wave * DC.ar(0.44137692451477));
varHmon20125910 = SinGrain.ar(wave * DC.ar(0.51537621021271), wave * DC.ar(0.014656066894531), wave * DC.ar(0.78063404560089), wave * DC.ar(0.68936026096344), wave * DC.ar(0.96408021450043));
varHmon20125911 = FreeVerb.ar(wave * DC.ar(0.33088064193726), wave * DC.ar(0.99553596973419), wave * DC.ar(0.48184144496918), wave * DC.ar(0.64140224456787), wave * DC.ar(0.33161151409149), wave * DC.ar(0.68212831020355));
varHmon20125912 = FoaZoomY.ar(wave * DC.ar(0.62305510044098), wave * DC.ar(0.92151474952698), wave * DC.ar(0.25066196918488), wave * DC.ar(0.68408048152924));

signal = varHmon20125912;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Trojan.Bat.Erase201259
/////////////////////////////////////////////////////////

SynthDef.new("Trojan.Bat.Erase201259", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varTrojanBatErase2012599;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varTrojanBatErase2012599 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varTrojanBatErase2012599 = Spring.ar(in * varTrojanBatErase2012599, modZ * in, 0.7774406671524 * modZ * env);
varTrojanBatErase2012599 = XOut.ar((80 + (island * 2)), bufnum, [StkMoog.ar(wave * DC.ar(0.27501344680786), wave * DC.ar(0.065518140792847), wave * DC.ar(0.39719581604004), wave * DC.ar(0.44974625110626), wave * DC.ar(0.49076819419861), wave * DC.ar(0.24571120738983), wave * DC.ar(0.5598886013031), wave * DC.ar(0.38359200954437), wave * DC.ar(0.65465605258942)), DiskOut.ar(wave * DC.ar(0.88194632530212), wave * DC.ar(0.055026054382324))]);
varTrojanBatErase2012599 = LFClipNoise.ar(wave * DC.ar(0.55082082748413), wave * DC.ar(0.94145333766937), wave * DC.ar(0.34386765956879));

signal = varTrojanBatErase2012599;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Marin201259
/////////////////////////////////////////////////////////

SynthDef.new("Marin201259", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varMarin2012599;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varMarin2012599 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varMarin2012599 = OnePole.ar(t_trig, 0.30590760707855 * gateEnv * modX.clip(wave * DC.ar(0.22116672992706), wave * DC.ar(0.58027482032776)), Out.ar(wave * DC.ar(0.88104283809662), wave * DC.ar(0.6552129983902)), Silent.ar());
varMarin2012599 = MoogFF.ar(in * modX, varMarin2012599 * signal, gateEnv * varMarin2012599, varMarin2012599 * modY, 0.99901932329992 * varMarin2012599 * env, Silent.ar());
varMarin2012599 = EnvGen.ar(wave * DC.ar(0.20185852050781), wave * DC.ar(0.71576189994812), wave * DC.ar(0.64645516872406), wave * DC.ar(0.099196553230286), wave * DC.ar(0.69642794132233), wave * DC.ar(0.4628050327301));

signal = varMarin2012599;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// ZhenZhou.2370201301
/////////////////////////////////////////////////////////

SynthDef.new("ZhenZhou.2370201301", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varZhenZhou23702013019, varZhenZhou237020130110, varZhenZhou237020130111, varZhenZhou237020130112;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varZhenZhou23702013019 = varZhenZhou237020130110 = varZhenZhou237020130111 = varZhenZhou237020130112 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varZhenZhou23702013019 = WeaklyNonlinear2.ar(gate, modY * signal, 0.05923855304718 * GaussTrig.ar(wave * DC.ar(0.25153267383575), wave * DC.ar(0.79764580726624), wave * DC.ar(0.86495065689087), wave * DC.ar(0.18895590305328)), varZhenZhou237020130112 * varZhenZhou237020130111, in, in * modX, modY.expexp(wave * DC.ar(0.13530778884888), wave * DC.ar(0.42398643493652), wave * DC.ar(0.71524608135223), wave * DC.ar(0.57249224185944), wave * DC.ar(0.13412857055664)), modX, modY, varZhenZhou237020130112 * modY, modY * wave, modY, Silent.ar());
varZhenZhou237020130110 = PeakEQ4.ar(amp, BFEncode1.ar(wave * DC.ar(0.59480881690979), wave * DC.ar(0.95282673835754), wave * DC.ar(0.080047011375427), wave * DC.ar(0.21940112113953), wave * DC.ar(0.91851031780243), wave * DC.ar(0.85792994499207)).exprange(1, SampleRate.ir), varZhenZhou237020130112 * varZhenZhou237020130111, wave * modX);
varZhenZhou237020130111 = InFeedback.ar((80 + (island * 2)), 2);
varZhenZhou237020130112 = OSTrunc8.ar(0.35604846477509 * modZ * varZhenZhou23702013019, modZ * modZ);
varZhenZhou23702013019 = DoubleWell.ar(wave * DC.ar(0.78825628757477), wave * DC.ar(0.10039508342743), wave * DC.ar(0.74678671360016), wave * DC.ar(0.58741247653961), wave * DC.ar(0.85673046112061), wave * DC.ar(0.35347020626068), wave * DC.ar(0.54721701145172), wave * DC.ar(0.15175330638885), wave * DC.ar(0.14179003238678), wave * DC.ar(0.5839741230011));
varZhenZhou237020130110 = BufWr.ar([StkClarinet.ar(wave * DC.ar(0.13804519176483), wave * DC.ar(0.91176462173462), wave * DC.ar(0.6223953962326), wave * DC.ar(0.98880004882812), wave * DC.ar(0.29578042030334), wave * DC.ar(0.092962861061096), wave * DC.ar(0.1345819234848), wave * DC.ar(0.8733389377594), wave * DC.ar(0.46290278434753)), LFDNoise0.ar(wave * DC.ar(0.88014554977417), wave * DC.ar(0.97573041915894), wave * DC.ar(0.32833790779114))], Array.fill(2.pow(14), { |i| rrand(-1, 1) }).as(LocalBuf), varZhenZhou237020130110, in * varZhenZhou237020130111);
varZhenZhou237020130111 = BufAllpassL.ar(wave * DC.ar(0.040923953056335), wave * DC.ar(0.71943438053131), wave * DC.ar(0.27805888652802), wave * DC.ar(0.99299800395966), wave * DC.ar(0.88376224040985), wave * DC.ar(0.78168570995331));
varZhenZhou237020130112 = BufGrain.ar(varZhenZhou23702013019 * varZhenZhou237020130111, varZhenZhou23702013019 * gateEnv, bufnum, signal * varZhenZhou237020130111, z, varZhenZhou237020130112, 0.9983785915441 * env * signal, LPF18.ar(wave * DC.ar(0.81198954582214), wave * DC.ar(0.39150547981262), wave * DC.ar(0.75756227970123), wave * DC.ar(0.88091897964478)));
varZhenZhou23702013019 = GbmanTrig.ar(wave * DC.ar(0.37525236606598), wave * DC.ar(0.52101540565491), wave * DC.ar(0.8983246088028), wave * DC.ar(0.23267090320587), wave * DC.ar(0.84702098369598), wave * DC.ar(0.33680236339569));
varZhenZhou237020130110 = FMGrainBF.ar(wave * DC.ar(0.67055416107178), wave * DC.ar(0.32056415081024), wave * DC.ar(0.69761574268341), wave * DC.ar(0.9131692647934), wave * DC.ar(0.69387173652649), wave * DC.ar(0.83543515205383), wave * DC.ar(0.47888767719269), wave * DC.ar(0.35960066318512), wave * DC.ar(0.82785105705261), wave * DC.ar(0.94395363330841), wave * DC.ar(0.23187053203583));
varZhenZhou237020130111 = HPZ1.ar(wave * DC.ar(0.17910099029541), wave * DC.ar(0.51778888702393), wave * DC.ar(0.9227100610733));
varZhenZhou237020130112 = TermanWang.ar(wave * DC.ar(0.77436292171478), wave * DC.ar(0.29845690727234), wave * DC.ar(0.93654489517212), wave * DC.ar(0.67357850074768), wave * DC.ar(0.055410861968994), wave * DC.ar(0.38488841056824), wave * DC.ar(0.41049110889435), wave * DC.ar(0.36422288417816), wave * DC.ar(0.513028383255), wave * DC.ar(0.38576567173004), wave * DC.ar(0.4400851726532));

signal = varZhenZhou237020130112;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// JS.Trojan.Runner201301
/////////////////////////////////////////////////////////

SynthDef.new("JS.Trojan.Runner201301", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varJSTrojanRunner2013019, varJSTrojanRunner20130110;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varJSTrojanRunner2013019 = varJSTrojanRunner20130110 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varJSTrojanRunner2013019 = InGrainBF.ar(varJSTrojanRunner20130110 * modZ, varJSTrojanRunner2013019, modY, gateEnv, modX * modY, modY * in, varJSTrojanRunner2013019 * modZ, 0.98964839243598 * env * modZ, Silent.ar());
varJSTrojanRunner20130110 = StkShakers.ar(signal * signal, modX * modY, wave * modZ, wave, varJSTrojanRunner20130110 * modZ, varJSTrojanRunner2013019, Silent.ar());
varJSTrojanRunner2013019 = Warp1.ar(2, Array.fill(2.pow(10), { |i| rrand(-1, 1) }).as(LocalBuf), modX * modZ, Balance.ar(wave * DC.ar(0.32428276538849), wave * DC.ar(0.0094230175018311), wave * DC.ar(0.43888711929321), wave * DC.ar(0.08784031867981), wave * DC.ar(0.071083307266235), wave * DC.ar(0.26062726974487)).exprange(1, SampleRate.ir), env * modX, bufnum, amp, TDelay.ar(wave * DC.ar(0.44601321220398), wave * DC.ar(0.70381009578705)), env, 0.83041043261771 * modY * wave, Silent.ar());
varJSTrojanRunner20130110 = Amplitude.ar(varJSTrojanRunner20130110 * env, 0.24205636978149 * varJSTrojanRunner20130110, varJSTrojanRunner2013019, 0.99900213192964 * env * modX, Silent.ar());
varJSTrojanRunner2013019 = MarkovSynth.ar(wave * DC.ar(0.96952939033508), wave * DC.ar(0.69042789936066), wave * DC.ar(0.88696432113647), wave * DC.ar(0.5796149969101));
varJSTrojanRunner20130110 = PeakEQ2.ar(wave * DC.ar(0.34251737594604), wave * DC.ar(0.58921253681183), wave * DC.ar(0.22378635406494), wave * DC.ar(0.66650199890137));

signal = varJSTrojanRunner20130110;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// JS.Trojan.Runner2013011
/////////////////////////////////////////////////////////

SynthDef.new("JS.Trojan.Runner2013011", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varJSTrojanRunner2013019, varJSTrojanRunner20130110, varJSTrojanRunner201301111, varJSTrojanRunner201301112;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varJSTrojanRunner2013019 = varJSTrojanRunner20130110 = varJSTrojanRunner201301111 = varJSTrojanRunner201301112 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varJSTrojanRunner2013019 = PanX2D.ar(2, 2, varJSTrojanRunner201301112, gate, modX * varJSTrojanRunner20130110, 0.81049978733063 * env * varJSTrojanRunner201301112, 0.54024434089661 * modX * modZ.lagud(wave * DC.ar(0.45192861557007), wave * DC.ar(0.44205379486084)), varJSTrojanRunner201301111);
varJSTrojanRunner20130110 = RunningSum.ar(env * varJSTrojanRunner201301111, RegaliaMitraEQ.ar(wave * DC.ar(0.17646467685699), wave * DC.ar(0.1203339099884), wave * DC.ar(0.64072036743164), wave * DC.ar(0.22107994556427), wave * DC.ar(0.42973446846008), wave * DC.ar(0.82816207408905)));
varJSTrojanRunner2013019 = FoaFocusY.ar(wave * DC.ar(0.50632333755493), wave * DC.ar(0.76887667179108), wave * DC.ar(0.36090791225433), wave * DC.ar(0.37763071060181));
varJSTrojanRunner20130110 = GrayNoise.ar(0.99939962805419 * varJSTrojanRunner201301111 * varJSTrojanRunner2013019, CombLP.ar(wave * DC.ar(0.79007685184479), wave * DC.ar(0.68750131130219), wave * DC.ar(0.87208759784698), wave * DC.ar(0.58124136924744), wave * DC.ar(0.012004137039185), wave * DC.ar(0.41267561912537), wave * DC.ar(0.30042588710785), wave * DC.ar(0.55180680751801)));
varJSTrojanRunner2013019 = LPF1.ar(wave * DC.ar(0.0062730312347412), wave * DC.ar(0.7088725566864));
varJSTrojanRunner20130110 = NL2.ar(wave * DC.ar(0.99521458148956), wave * DC.ar(0.9781676530838), wave * DC.ar(0.10903561115265), wave * DC.ar(0.92409801483154), wave * DC.ar(0.68695294857025), wave * DC.ar(0.58430731296539), wave * DC.ar(0.76116192340851), wave * DC.ar(0.6739821434021));
// Variation test code
varJSTrojanRunner201301111 = WeaklyNonlinear.ar(wave, x, island, env * varJSTrojanRunner201301112, in * in, varJSTrojanRunner20130110 * env, modX * signal, in, 0.35411369800568 * Nes2.ar(varJSTrojanRunner2013019 * DC.ar(0.3642874956131), varJSTrojanRunner20130110 * DC.ar(0.27308595180511), varJSTrojanRunner2013019 * DC.ar(0.26040506362915), varJSTrojanRunner2013019 * DC.ar(0.50438523292542), varJSTrojanRunner20130110 * DC.ar(0.4239456653595), varJSTrojanRunner20130110 * DC.ar(0.95569515228271), varJSTrojanRunner20130110 * DC.ar(0.10703885555267), varJSTrojanRunner2013019 * DC.ar(0.26811587810516), varJSTrojanRunner2013019 * DC.ar(0.5901802778244), varJSTrojanRunner2013019 * DC.ar(0.038426160812378), varJSTrojanRunner2013019 * DC.ar(0.55995237827301), varJSTrojanRunner2013019 * DC.ar(0.43666732311249), varJSTrojanRunner2013019 * DC.ar(0.77279603481293), varJSTrojanRunner20130110 * DC.ar(0.4468640089035), varJSTrojanRunner20130110 * DC.ar(0.47671461105347), varJSTrojanRunner2013019 * DC.ar(0.70597195625305), varJSTrojanRunner2013019 * DC.ar(0.33519434928894), varJSTrojanRunner2013019 * DC.ar(0.50578820705414), varJSTrojanRunner2013019 * DC.ar(0.49235618114471), varJSTrojanRunner2013019 * DC.ar(0.56367468833923)), y, modY * varJSTrojanRunner201301111, gateEnv, Silent.ar());
varJSTrojanRunner201301112 = PSinGrain.ar(wave, varJSTrojanRunner20130110, signal * in);
varJSTrojanRunner201301111 = SelectL.ar(x, [Convolution3.ar(varJSTrojanRunner20130110 * DC.ar(0.54599320888519), varJSTrojanRunner2013019 * DC.ar(0.91234505176544), varJSTrojanRunner20130110 * DC.ar(0.77231276035309), varJSTrojanRunner2013019 * DC.ar(0.50353252887726), varJSTrojanRunner2013019 * DC.ar(0.75508677959442), varJSTrojanRunner20130110 * DC.ar(0.61402082443237)), BRZ2.ar(varJSTrojanRunner2013019 * DC.ar(0.258664727211), varJSTrojanRunner20130110 * DC.ar(0.57238006591797), varJSTrojanRunner2013019 * DC.ar(0.1206226348877))]);
varJSTrojanRunner201301112 = BufDelayN.ar(Array.fill(2.pow(14), { |i| rrand(-1, 1) }).as(LocalBuf), bufnum, 0.57777035236359 * wave * wave, modZ, Silent.ar());
varJSTrojanRunner201301111 = Summer.ar(Poll.ar(varJSTrojanRunner2013019 * DC.ar(0.25433194637299), varJSTrojanRunner2013019 * DC.ar(0.31700956821442), varJSTrojanRunner20130110 * DC.ar(0.48181521892548), varJSTrojanRunner2013019 * DC.ar(0.22096788883209)), z, modZ, signal * gateEnv);
varJSTrojanRunner201301112 = FMHEncode0.ar(island, T2A.ar(island, gate), varJSTrojanRunner20130110 * modZ, varJSTrojanRunner20130110);

signal = varJSTrojanRunner201301112;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// WM.Bandung.W201303
/////////////////////////////////////////////////////////

SynthDef.new("WM.Bandung.W201303", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varWMBandungW2013039, varWMBandungW20130310, varWMBandungW20130311, varWMBandungW20130312, varWMBandungW20130313;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varWMBandungW2013039 = varWMBandungW20130310 = varWMBandungW20130311 = varWMBandungW20130312 = varWMBandungW20130313 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varWMBandungW2013039 = StereoConvolution2L.ar(modZ, modZ.explin(wave * DC.ar(0.10469436645508), wave * DC.ar(0.5721333026886), wave * DC.ar(0.63909721374512), wave * DC.ar(0.28006780147552), wave * DC.ar(0.77631640434265)), varWMBandungW20130310 * modY, varWMBandungW2013039 * varWMBandungW20130310, varWMBandungW20130312 * modY, wave, 0.99997368122505 * TExpRand.ar(wave * DC.ar(0.02187979221344), wave * DC.ar(0.50908470153809), wave * DC.ar(0.89806592464447)), Silent.ar());
varWMBandungW20130310 = Lag2UD.ar(varWMBandungW20130310 * varWMBandungW20130310, island, 0.61360228061676 * env * env, wave, Silent.ar());
varWMBandungW20130311 = NLFiltC.ar(Fhn2DC.ar(wave * DC.ar(0.10073912143707), wave * DC.ar(0.54316091537476), wave * DC.ar(0.29034769535065), wave * DC.ar(0.22557866573334), wave * DC.ar(0.97692632675171), wave * DC.ar(0.35067415237427), wave * DC.ar(0.49545252323151), wave * DC.ar(0.70400989055634), wave * DC.ar(0.88392412662506), wave * DC.ar(0.56223559379578), wave * DC.ar(0.40276753902435)), modX * gateEnv, env, varWMBandungW2013039 * varWMBandungW20130312, amp, x, Lorenz2DN.ar(wave * DC.ar(0.22076892852783), wave * DC.ar(0.84621512889862), wave * DC.ar(0.53514063358307), wave * DC.ar(0.016412734985352), wave * DC.ar(0.6372891664505), wave * DC.ar(0.02230441570282), wave * DC.ar(0.41212618350983), wave * DC.ar(0.6217383146286), wave * DC.ar(0.97015237808228), wave * DC.ar(0.52871704101562), wave * DC.ar(0.37148630619049)), Silent.ar());
varWMBandungW20130312 = K2A.ar(0.12057030200958 * varWMBandungW20130311 * modZ);
varWMBandungW20130313 = SinGrainIBF.ar(gateEnv * varWMBandungW20130310, varWMBandungW2013039, env, bufnum, bufnum, varWMBandungW20130310 * env, signal * varWMBandungW20130310, varWMBandungW2013039, modZ * varWMBandungW20130312, in, FoaPushY.ar(wave * DC.ar(0.79353666305542), wave * DC.ar(0.41070711612701), wave * DC.ar(0.37370824813843), wave * DC.ar(0.44603073596954)), Silent.ar());
varWMBandungW2013039 = OscN.ar(wave * DC.ar(0.92708277702332), wave * DC.ar(0.41527593135834), wave * DC.ar(0.96375274658203), wave * DC.ar(0.11739218235016), wave * DC.ar(0.46729922294617));
varWMBandungW20130310 = SVF.ar(modX * env, x, signal * signal, modX * modY, modX, x, 0.29839730262756 * varWMBandungW2013039 * varWMBandungW20130312, 0.077943682670593 * wave * modX, modY, Silent.ar());
varWMBandungW20130311 = FMGrainI.ar(wave * DC.ar(0.14690268039703), wave * DC.ar(0.061660766601562), wave * DC.ar(0.18713629245758), wave * DC.ar(0.91441130638123), wave * DC.ar(0.7491682767868), wave * DC.ar(0.39782524108887), wave * DC.ar(0.56707274913788), wave * DC.ar(0.60277354717255), wave * DC.ar(0.95223045349121), wave * DC.ar(0.5560097694397));
varWMBandungW20130312 = FreeVerb.ar(wave * DC.ar(0.91035652160645), wave * DC.ar(0.6316089630127), wave * DC.ar(0.12028837203979), wave * DC.ar(0.4573632478714), wave * DC.ar(0.19392347335815), wave * DC.ar(0.44208431243896));
varWMBandungW20130313 = PitchShift.ar(amp, modZ * varWMBandungW20130310, varWMBandungW20130312 * modY, wave, gate, varWMBandungW20130311, Silent.ar().bitOr(Sweep.ar(wave * DC.ar(0.18189263343811), wave * DC.ar(0.87446284294128))));
varWMBandungW2013039 = PSinGrain.ar(wave * DC.ar(0.95861113071442), wave * DC.ar(0.19808387756348), wave * DC.ar(0.99454164505005));
varWMBandungW20130310 = Clipper32.ar(wave * DC.ar(0.80377960205078), wave * DC.ar(0.96531701087952), wave * DC.ar(0.93853759765625));
varWMBandungW20130311 = WrapSummer.ar(wave * DC.ar(0.93561255931854), wave * DC.ar(0.46218311786652), wave * DC.ar(0.24780642986298), wave * DC.ar(0.35382890701294), wave * DC.ar(0.29794871807098), wave * DC.ar(0.85372829437256));
varWMBandungW20130312 = YigClifford3DN.ar(wave * DC.ar(0.78493583202362), wave * DC.ar(0.71263217926025), wave * DC.ar(0.98334658145905), wave * DC.ar(0.3950719833374), wave * DC.ar(0.69086492061615), wave * DC.ar(0.13514506816864), wave * DC.ar(0.078379273414612), wave * DC.ar(0.22474014759064), wave * DC.ar(0.94458341598511), wave * DC.ar(0.15817284584045));
varWMBandungW20130313 = Formant.ar(wave * DC.ar(0.42645001411438), wave * DC.ar(0.85568010807037), wave * DC.ar(0.18458151817322), wave * DC.ar(0.34977555274963), wave * DC.ar(0.42552626132965));

signal = varWMBandungW20130313;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Altx.2663201304
/////////////////////////////////////////////////////////

SynthDef.new("Altx.2663201304", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varAltx26632013049;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varAltx26632013049 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varAltx26632013049 = NTube.ar(FoaZoomY.ar(wave * DC.ar(0.11143159866333), wave * DC.ar(0.079575538635254), wave * DC.ar(0.3405510187149), wave * DC.ar(0.044179320335388)), [StkSaxofony.ar(wave * DC.ar(0.88318228721619), wave * DC.ar(0.89542174339294), wave * DC.ar(0.52760112285614), wave * DC.ar(0.49605965614319), wave * DC.ar(0.14902639389038), wave * DC.ar(0.89194345474243), wave * DC.ar(0.42107474803925), wave * DC.ar(0.74321246147156), wave * DC.ar(0.24841701984406), wave * DC.ar(0.86437463760376), wave * DC.ar(0.34876883029938)), UHJ2B.ar(wave * DC.ar(0.66545820236206), wave * DC.ar(0.15299034118652))], [RMShelf.ar(wave * DC.ar(0.7332478761673), wave * DC.ar(0.2638486623764), wave * DC.ar(0.28096222877502), wave * DC.ar(0.66998696327209), wave * DC.ar(0.19441962242126)), DoubleWell2.ar(wave * DC.ar(0.41855442523956), wave * DC.ar(0.21171581745148), wave * DC.ar(0.32484149932861), wave * DC.ar(0.75282120704651), wave * DC.ar(0.43439733982086), wave * DC.ar(0.91728055477142), wave * DC.ar(0.89093852043152), wave * DC.ar(0.56100118160248), wave * DC.ar(0.85806906223297), wave * DC.ar(0.26424980163574))], [Breakcore.ar(wave * DC.ar(0.55097639560699), wave * DC.ar(0.24350929260254), wave * DC.ar(0.42695271968842), wave * DC.ar(0.96770286560059), wave * DC.ar(0.62343192100525)), RunningSum.ar(wave * DC.ar(0.094771146774292), wave * DC.ar(0.61277854442596))], 0.68343725525872 * varAltx26632013049 * varAltx26632013049, MedianTriggered.ar(wave * DC.ar(0.67067182064056), wave * DC.ar(0.19559299945831), wave * DC.ar(0.76226449012756), wave * DC.ar(0.059153079986572), wave * DC.ar(0.36315023899078)));
varAltx26632013049 = DoubleNestedAllpassN.ar(t_trig, varAltx26632013049, signal * in, modY, signal, gateEnv * modY, gate, 0.78498208522797 * signal * in, signal, signal, 0.99998790797236 * in * signal, Silent.ar().lagud(wave * DC.ar(0.687708735466), wave * DC.ar(0.072235107421875)));
varAltx26632013049 = FBSineN.ar(wave * DC.ar(0.61460196971893), wave * DC.ar(0.67046940326691), wave * DC.ar(0.68056964874268), wave * DC.ar(0.54954373836517), wave * DC.ar(0.50529384613037), wave * DC.ar(0.32182252407074), wave * DC.ar(0.93480920791626), wave * DC.ar(0.29822087287903), wave * DC.ar(0.49474740028381));

signal = varAltx26632013049;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Altx.26632013041
/////////////////////////////////////////////////////////

SynthDef.new("Altx.26632013041", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varAltx26632013049, varAltx2663201304110, varAltx2663201304111, varAltx2663201304112, varAltx2663201304113, varAltx2663201304114;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varAltx26632013049 = varAltx2663201304110 = varAltx2663201304111 = varAltx2663201304112 = varAltx2663201304113 = varAltx2663201304114 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varAltx26632013049 = NLFiltN.ar(signal * wave, varAltx2663201304113, modX * varAltx2663201304114, varAltx2663201304112, bufnum, varAltx26632013049 * wave, BFEncode1.ar(wave * DC.ar(0.30358898639679), wave * DC.ar(0.72731554508209), wave * DC.ar(0.89300167560577), wave * DC.ar(0.46607065200806), wave * DC.ar(0.14388144016266), wave * DC.ar(0.78387653827667)), Silent.ar());
varAltx26632013049 = BufCombC.ar(Array.fill(2.pow(16), { |i| rrand(-1, 1) }).as(LocalBuf).wrap(wave * DC.ar(0.31896615028381), wave * DC.ar(0.99388360977173)), env * in, modZ, varAltx2663201304114, 0.99970675993499 * varAltx2663201304114 * varAltx2663201304111, Silent.ar());
varAltx26632013049 = BufDelayL.ar(wave * DC.ar(0.30728423595428), wave * DC.ar(0.96872246265411), wave * DC.ar(0.95944356918335), wave * DC.ar(0.6314412355423), wave * DC.ar(0.8819591999054));
// Variation test code
varAltx2663201304110 = FoaDominateY.ar(gateEnv * modX, 0.96929287910461 * modY * varAltx2663201304111, 0.90447262057115 * modZ * modY, Silent.ar());
varAltx2663201304111 = XFade2.ar(island, t_trig, gateEnv * wave, env);
varAltx2663201304112 = LoopBuf.ar(2, Array.fill(2.pow(11), { |i| rrand(-1, 1) }).as(LocalBuf), varAltx2663201304114, wave * varAltx26632013049, varAltx2663201304113 * varAltx26632013049, varAltx2663201304112, t_trig, modY);
varAltx2663201304113 = LocalIn.ar(2, env);
varAltx2663201304114 = LFBrownNoise0.ar(RunningMin.ar(varAltx26632013049 * DC.ar(0.53787076473236), varAltx26632013049 * DC.ar(0.26791596412659)).exprange(1, SampleRate.ir).bitAnd(Breakcore.ar(varAltx26632013049 * DC.ar(0.18720781803131), varAltx26632013049 * DC.ar(0.55619990825653), varAltx26632013049 * DC.ar(0.50487208366394), varAltx26632013049 * DC.ar(0.13514769077301), varAltx26632013049 * DC.ar(0.54912769794464))), modX, gateEnv, 0.97384534751144 * modZ, Silent.ar());
varAltx2663201304110 = Dust2.ar(varAltx2663201304110 * modZ, 0.99827513713224 * wave * varAltx2663201304111, Silent.ar());
varAltx2663201304111 = Astrocade.ar(varAltx26632013049, gateEnv * modX, env, varAltx2663201304112, y, y.blend(varAltx26632013049 * DC.ar(0.33967447280884), varAltx26632013049 * DC.ar(0.8166971206665)), varAltx2663201304114 * gateEnv, varAltx2663201304114 * varAltx2663201304114);
varAltx2663201304112 = ToggleFF.ar(varAltx2663201304114 * varAltx2663201304114);
varAltx2663201304113 = XFadeRotate.ar(modX, varAltx2663201304114);
varAltx2663201304114 = MidEQ.ar(modY * env, varAltx2663201304112 * modY, bufnum, gate, 0.70911881778714 * signal * varAltx2663201304111, Silent.ar());
varAltx2663201304110 = Streson.ar(signal, DC.ar(gate), env * signal, 0.88787990663869 * varAltx2663201304113 * varAltx2663201304113, Silent.ar());
varAltx2663201304111 = UHJ2B.ar(varAltx2663201304111, varAltx26632013049 * env);
varAltx2663201304112 = LorenzL.ar(modZ * varAltx26632013049, 0.75823307037354 * wave * gateEnv, AtsNoiSynth.ar(Array.fill(2.pow(15), { |i| rrand(-1, 1) }).as(LocalBuf), in * varAltx2663201304114, 0.1382474899292 * wave * in, varAltx2663201304112 * varAltx2663201304114, y, varAltx2663201304113, varAltx26632013049 * gateEnv, DelTapWr.ar(varAltx26632013049 * DC.ar(0.98003470897675), varAltx26632013049 * DC.ar(0.66567444801331)).exprange(1, SampleRate.ir), wave * in, modX, varAltx2663201304111, env, 0.77953844813766 * varAltx2663201304112, LFNoise0.ar(varAltx26632013049 * DC.ar(0.17507195472717), varAltx26632013049 * DC.ar(0.79276275634766), varAltx26632013049 * DC.ar(0.98442578315735))), env * varAltx2663201304111, varAltx26632013049, modY * varAltx2663201304112, wave * varAltx2663201304111, Trig.ar(signal, AnalyseEvents2.ar(varAltx26632013049 * DC.ar(0.23792517185211), varAltx26632013049 * DC.ar(0.85780739784241), varAltx26632013049 * DC.ar(0.42428696155548), varAltx26632013049 * DC.ar(0.030802130699158), varAltx26632013049 * DC.ar(0.081337451934814), varAltx26632013049 * DC.ar(0.43497669696808))), env, Silent.ar());
varAltx2663201304113 = MarkovSynth.ar(bufnum, bufnum, varAltx26632013049, varAltx2663201304110 * varAltx2663201304110);
varAltx2663201304114 = Convolution2L.ar(modY, bufnum, modZ * modX, 0.19746518135071 * modZ * modX, varAltx2663201304114 * varAltx26632013049, BufDelayL.ar(varAltx26632013049 * DC.ar(0.027495741844177), varAltx26632013049 * DC.ar(0.34647679328918), varAltx26632013049 * DC.ar(0.84907364845276), varAltx26632013049 * DC.ar(0.92665886878967), varAltx26632013049 * DC.ar(0.085371851921082)), Silent.ar());

signal = varAltx2663201304114;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Secretary201304
/////////////////////////////////////////////////////////

SynthDef.new("Secretary201304", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varSecretary2013049, varSecretary20130410, varSecretary20130411, varSecretary20130412, varSecretary20130413, varSecretary20130414;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varSecretary2013049 = varSecretary20130410 = varSecretary20130411 = varSecretary20130412 = varSecretary20130413 = varSecretary20130414 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varSecretary2013049 = DecodeB2.ar(2, varSecretary20130411, bufnum, modX, island);
varSecretary20130410 = BLowShelf.ar(amp, PanB2.ar(wave * DC.ar(0.5866904258728), wave * DC.ar(0.16235971450806), wave * DC.ar(0.098600506782532)).exprange(1, SampleRate.ir), varSecretary20130414 * signal, z, varSecretary20130411, Silent.ar());
varSecretary20130411 = Wrap.ar(varSecretary20130413 * varSecretary20130414, t_trig, gateEnv * varSecretary20130413);
varSecretary20130412 = BufCombL.ar(Array.fill(2.pow(15), { |i| rrand(-1, 1) }).as(LocalBuf), varSecretary20130411 * varSecretary2013049, gateEnv, in * modY, 0.99788613082508 * env * gateEnv, Silent.ar());
varSecretary20130413 = CombC.ar(signal * varSecretary20130413, varSecretary20130411 * varSecretary20130413, env * gateEnv, wave.slew(wave * DC.ar(0.75625622272491), wave * DC.ar(0.29420077800751)), env, Silent.ar());
varSecretary20130414 = YigCliffordC.ar(signal, varSecretary20130411 * varSecretary20130413, gate, bufnum, modZ, amp, varSecretary20130412 * varSecretary20130411, InGrainBBF.ar(wave * DC.ar(0.65154528617859), wave * DC.ar(0.93195402622223), wave * DC.ar(0.045054912567139), wave * DC.ar(0.16507732868195), wave * DC.ar(0.43089389801025), wave * DC.ar(0.14648616313934), wave * DC.ar(0.34936153888702), wave * DC.ar(0.86537301540375), wave * DC.ar(0.16008985042572), wave * DC.ar(0.88561689853668)), Silent.ar());
varSecretary2013049 = RedPhasor.ar(varSecretary20130410 * varSecretary2013049, varSecretary20130410 * varSecretary2013049, 0.41472601890564 * PinkNoise.ar(wave * DC.ar(0.84656298160553), wave * DC.ar(0.090415239334106)), in * gateEnv, in * varSecretary20130414, gate, env * varSecretary20130410);
varSecretary20130410 = FhnTrig.ar(in, modZ * modZ.madd(wave * DC.ar(0.80962288379669), wave * DC.ar(0.79364502429962)), signal, gateEnv * varSecretary20130410, varSecretary20130412 * gateEnv, bufnum, x, modZ * modX, modX * modY, LatoocarfianN.ar(wave * DC.ar(0.10533857345581), wave * DC.ar(0.54312598705292), wave * DC.ar(0.096010684967041), wave * DC.ar(0.35755228996277), wave * DC.ar(0.94698131084442), wave * DC.ar(0.65513253211975), wave * DC.ar(0.48880577087402), wave * DC.ar(0.35658991336823), wave * DC.ar(0.98746824264526)), Silent.ar());
varSecretary20130411 = Pluck.ar(wave * DC.ar(0.26751625537872), wave * DC.ar(0.70360839366913), wave * DC.ar(0.96617352962494), wave * DC.ar(0.1994754076004), wave * DC.ar(0.35145008563995), wave * DC.ar(0.12581920623779), wave * DC.ar(0.051690697669983), wave * DC.ar(0.34489452838898));
varSecretary20130412 = SinOscFB.ar(varSecretary20130414 * modX, env * varSecretary20130414, 0.99963499486228 * modY * varSecretary20130410, Silent.ar());
varSecretary20130413 = NestedAllpassC.ar(wave * DC.ar(0.84674751758575), wave * DC.ar(0.26080179214478), wave * DC.ar(0.27553308010101), wave * DC.ar(0.59056341648102), wave * DC.ar(0.80117893218994), wave * DC.ar(0.44077432155609), wave * DC.ar(0.71216142177582), wave * DC.ar(0.029239416122437), wave * DC.ar(0.9607869386673));
varSecretary20130414 = Timer.ar(Logistic.ar(wave * DC.ar(0.4029586315155), wave * DC.ar(0.85488617420197), wave * DC.ar(0.66762566566467), wave * DC.ar(0.92192757129669), wave * DC.ar(0.43327021598816)));
varSecretary2013049 = DoubleNestedAllpassC.ar(wave * DC.ar(0.44279408454895), wave * DC.ar(0.86597800254822), wave * DC.ar(0.0092129707336426), wave * DC.ar(0.26829206943512), wave * DC.ar(0.91880035400391), wave * DC.ar(0.88170421123505), wave * DC.ar(0.92253708839417), wave * DC.ar(0.44887840747833), wave * DC.ar(0.40297043323517), wave * DC.ar(0.023785352706909), wave * DC.ar(0.6473468542099), wave * DC.ar(0.078565001487732));
varSecretary20130410 = CombC.ar(wave * DC.ar(0.145463347435), wave * DC.ar(0.5121945142746), wave * DC.ar(0.064298033714294), wave * DC.ar(0.91179156303406), wave * DC.ar(0.75576078891754), wave * DC.ar(0.36572062969208));
varSecretary20130411 = TBetaRand.ar(wave * DC.ar(0.4541836977005), wave * DC.ar(0.7361798286438), wave * DC.ar(0.73494482040405), wave * DC.ar(0.70646595954895), wave * DC.ar(0.56946611404419), wave * DC.ar(0.50252151489258), wave * DC.ar(0.93124651908875));
varSecretary20130412 = SinGrainIBF.ar(wave * DC.ar(0.27115905284882), wave * DC.ar(0.46367073059082), wave * DC.ar(0.14399468898773), wave * DC.ar(0.78946018218994), wave * DC.ar(0.84531271457672), wave * DC.ar(0.017325162887573), wave * DC.ar(0.49266576766968), wave * DC.ar(0.5263124704361), wave * DC.ar(0.11213386058807), wave * DC.ar(0.35199427604675), wave * DC.ar(0.54834580421448), wave * DC.ar(0.09437894821167));
varSecretary20130413 = Duty.ar(wave * DC.ar(0.053485989570618), wave * DC.ar(0.94096052646637), wave * DC.ar(0.1313898563385), wave * DC.ar(0.20282304286957));
varSecretary20130414 = LinExp.ar(wave * DC.ar(0.37967360019684), wave * DC.ar(0.80020868778229), wave * DC.ar(0.14060819149017), wave * DC.ar(0.76900994777679), wave * DC.ar(0.80243325233459));

signal = varSecretary20130414;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// SillyC.279.b201307
/////////////////////////////////////////////////////////

SynthDef.new("SillyC.279.b201307", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varSillyC279b2013079, varSillyC279b20130710, varSillyC279b20130711, varSillyC279b20130712, varSillyC279b20130713;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varSillyC279b2013079 = varSillyC279b20130710 = varSillyC279b20130711 = varSillyC279b20130712 = varSillyC279b20130713 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varSillyC279b2013079 = StkMandolin.ar(varSillyC279b20130711 * wave, modZ, in, x, gate, gate, gateEnv * modZ, 0.99300864831929 * gateEnv * varSillyC279b2013079, Silent.ar());
varSillyC279b20130710 = RMEQ.ar(varSillyC279b2013079 * varSillyC279b20130712, PVSynth.ar(wave * DC.ar(0.24166989326477), wave * DC.ar(0.42116332054138), wave * DC.ar(0.80567336082458), wave * DC.ar(0.71261763572693), wave * DC.ar(0.87407302856445), wave * DC.ar(0.40730857849121), wave * DC.ar(0.54800260066986), wave * DC.ar(0.15582227706909), wave * DC.ar(0.97591507434845)).exprange(1, SampleRate.ir), modX, varSillyC279b2013079 * varSillyC279b20130711, 0.9802782601135 * gateEnv * modY, Silent.ar());
varSillyC279b20130711 = Lorenz2DL.ar(env, NTube.ar(wave * DC.ar(0.097330212593079), wave * DC.ar(0.14911961555481), wave * DC.ar(0.51382672786713), wave * DC.ar(0.4688286781311), wave * DC.ar(0.27272057533264), wave * DC.ar(0.77216506004333)).exprange(1, SampleRate.ir), gateEnv * varSillyC279b20130712, wave * in, y, modZ, varSillyC279b20130712 * varSillyC279b2013079, varSillyC279b20130712 * varSillyC279b20130710.lincurve(wave * DC.ar(0.090203285217285), wave * DC.ar(0.56897342205048), wave * DC.ar(0.33022749423981), wave * DC.ar(0.3854159116745), wave * DC.ar(0.33906519412994), wave * DC.ar(0.92108380794525)), varSillyC279b2013079 * varSillyC279b20130710, 0.55576454554904 * signal, GrayNoise.ar(wave * DC.ar(0.87147665023804), wave * DC.ar(0.90374481678009)));
varSillyC279b20130712 = LocalIn.ar(2, 0.088056325912476 * FincoSprottM.ar(wave * DC.ar(0.92443549633026), wave * DC.ar(0.43906557559967), wave * DC.ar(0.99273705482483), wave * DC.ar(0.42885458469391), wave * DC.ar(0.40614748001099), wave * DC.ar(0.91790425777435), wave * DC.ar(0.55127394199371), wave * DC.ar(0.76391422748566), wave * DC.ar(0.092962503433228)));
varSillyC279b20130713 = MonoGrain.ar(wave, 0.10555756092072 * wave, signal * varSillyC279b20130713, varSillyC279b2013079 * varSillyC279b2013079, IFFT.ar(wave * DC.ar(0.69830024242401), wave * DC.ar(0.22089016437531), wave * DC.ar(0.38484835624695)), Silent.ar());
varSillyC279b2013079 = DiskOut.ar(wave * DC.ar(0.43880760669708), wave * DC.ar(0.1001273393631));
varSillyC279b20130710 = Impulse.ar(varSillyC279b20130711 * modY, varSillyC279b20130711 * gateEnv, modZ, Silent.ar());
varSillyC279b20130711 = Balance2.ar(0.19646048545837 * in * varSillyC279b2013079, modZ * modX, modY, bufnum);
varSillyC279b20130712 = Lag.ar(in, wave * varSillyC279b20130713, Gendy2.ar(wave * DC.ar(0.67099523544312), wave * DC.ar(0.71694183349609), wave * DC.ar(0.72428178787231), wave * DC.ar(0.23657631874084), wave * DC.ar(0.37754011154175), wave * DC.ar(0.71154391765594), wave * DC.ar(0.14657819271088), wave * DC.ar(0.75124394893646), wave * DC.ar(0.093421936035156), wave * DC.ar(0.70316588878632), wave * DC.ar(0.25821459293365), wave * DC.ar(0.31564593315125), wave * DC.ar(0.65039956569672), wave * DC.ar(0.52245652675629)), Silent.ar());
varSillyC279b20130713 = BHiPass.ar(wave * DC.ar(0.59260439872742), wave * DC.ar(0.32279562950134), wave * DC.ar(0.22050476074219), wave * DC.ar(0.021216511726379), wave * DC.ar(0.87886774539948));
varSillyC279b2013079 = Tumble.ar(wave * DC.ar(0.53109920024872), wave * DC.ar(0.62675261497498), wave * DC.ar(0.040371417999268), wave * DC.ar(0.32256817817688), wave * DC.ar(0.16652393341064));
varSillyC279b20130710 = XOut.ar(wave * DC.ar(0.0463787317276), wave * DC.ar(0.41948544979095), wave * DC.ar(0.88093113899231));
varSillyC279b20130711 = Clipper8.ar(wave * DC.ar(0.18789482116699), wave * DC.ar(0.92486143112183), wave * DC.ar(0.027487397193909));
varSillyC279b20130712 = SinGrainI.ar(wave * DC.ar(0.55092179775238), wave * DC.ar(0.20104229450226), wave * DC.ar(0.22025108337402), wave * DC.ar(0.75376069545746), wave * DC.ar(0.95400428771973), wave * DC.ar(0.033801794052124), wave * DC.ar(0.20991146564484), wave * DC.ar(0.94224298000336));
varSillyC279b20130713 = WaveTerrain.ar(wave * DC.ar(0.3004035949707), wave * DC.ar(0.19271147251129), wave * DC.ar(0.50517249107361), wave * DC.ar(0.67204713821411), wave * DC.ar(0.62294089794159), wave * DC.ar(0.59838712215424), wave * DC.ar(0.97195601463318));

signal = varSillyC279b20130713;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// WM.Concept.BH201308
/////////////////////////////////////////////////////////

SynthDef.new("WM.Concept.BH201308", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varWMConceptBH2013089, varWMConceptBH20130810;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varWMConceptBH2013089 = varWMConceptBH20130810 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varWMConceptBH2013089 = Allpass2.ar(0.73317849636078 * wave, wave, modZ * varWMConceptBH2013089, 0.8756420465469 * in, Silent.ar());
varWMConceptBH20130810 = A2B.ar(t_trig, wave, gate, t_trig);
varWMConceptBH2013089 = TermanWang.ar(in * modX, modX * wave, 0.72441589832306 * varWMConceptBH20130810 * modX.curvelin(wave * DC.ar(0.92778944969177), wave * DC.ar(0.93055427074432), wave * DC.ar(0.98579859733582), wave * DC.ar(0.28343224525452), wave * DC.ar(0.52138102054596), wave * DC.ar(0.081606984138489)), signal, gateEnv, modZ, modX * modY, varWMConceptBH20130810 * gateEnv, signal, StkMandolin.ar(wave * DC.ar(0.98487854003906), wave * DC.ar(0.81632316112518), wave * DC.ar(0.12191438674927), wave * DC.ar(0.25950753688812), wave * DC.ar(0.42285716533661), wave * DC.ar(0.73676800727844), wave * DC.ar(0.78728008270264), wave * DC.ar(0.3176337480545), wave * DC.ar(0.84576416015625)), Silent.ar());
varWMConceptBH20130810 = RMAFoodChainL.ar(Hasher.ar(wave * DC.ar(0.35807597637177), wave * DC.ar(0.20565593242645), wave * DC.ar(0.077307462692261)).exprange(1, SampleRate.ir), in * wave, varWMConceptBH2013089 * signal, gateEnv, 0.37525749206543 * modX * env, 0.13052558898926 * SmoothDecimator.ar(wave * DC.ar(0.81413972377777), wave * DC.ar(0.49108505249023), wave * DC.ar(0.65848648548126), wave * DC.ar(0.4841605424881), wave * DC.ar(0.88651919364929)), modX * modZ, y, wave * in, modY, gate, in, signal * varWMConceptBH2013089, InGrainIBF.ar(wave * DC.ar(0.078806519508362), wave * DC.ar(0.83615612983704), wave * DC.ar(0.8416576385498), wave * DC.ar(0.51162767410278), wave * DC.ar(0.11256182193756), wave * DC.ar(0.12416684627533), wave * DC.ar(0.49108028411865), wave * DC.ar(0.081500291824341), wave * DC.ar(0.10148942470551), wave * DC.ar(0.86774945259094), wave * DC.ar(0.23566555976868), wave * DC.ar(0.76798474788666)), Silent.ar());
varWMConceptBH2013089 = T2A.ar(wave * DC.ar(0.92871880531311), wave * DC.ar(0.42970645427704));
varWMConceptBH20130810 = EnvDetect.ar(wave * DC.ar(0.30766451358795), wave * DC.ar(0.96552467346191), wave * DC.ar(0.94849932193756));

signal = varWMConceptBH20130810;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// XM.Cauli.A201309
/////////////////////////////////////////////////////////

SynthDef.new("XM.Cauli.A201309", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varXMCauliA2013099, varXMCauliA20130910, varXMCauliA20130911, varXMCauliA20130912, varXMCauliA20130913, varXMCauliA20130914, varXMCauliA20130915;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varXMCauliA2013099 = varXMCauliA20130910 = varXMCauliA20130911 = varXMCauliA20130912 = varXMCauliA20130913 = varXMCauliA20130914 = varXMCauliA20130915 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varXMCauliA2013099 = In.ar((80 + (island * 2)), 2);
varXMCauliA20130910 = XFadeRotate.ar(varXMCauliA20130913 * env, modY * varXMCauliA20130913);
varXMCauliA20130911 = Out.ar((80 + (island * 2)), [GbmanN.ar(wave * DC.ar(0.53706169128418), wave * DC.ar(0.88224220275879), wave * DC.ar(0.69403827190399), wave * DC.ar(0.20247483253479), wave * DC.ar(0.63842535018921)), B2UHJ.ar(wave * DC.ar(0.048640131950378), wave * DC.ar(0.95273232460022), wave * DC.ar(0.59042322635651))]);
varXMCauliA20130912 = Allpass1.ar(modZ, varXMCauliA20130913 * varXMCauliA20130910, 0.52488097073321 * modZ * signal, Silent.ar());
varXMCauliA20130913 = T2A.ar(varXMCauliA20130912 * gateEnv, 0.19336998462677 * in * signal);
varXMCauliA20130914 = LinCongC.ar(modZ * varXMCauliA20130915, varXMCauliA20130911 * in, z, varXMCauliA2013099, varXMCauliA20130914 * modX, 0.99626864197203 * QuadC.ar(wave * DC.ar(0.52226305007935), wave * DC.ar(0.0031726360321045), wave * DC.ar(0.83892560005188), wave * DC.ar(0.4365029335022), wave * DC.ar(0.80691504478455), wave * DC.ar(0.11432838439941), wave * DC.ar(0.33923625946045)).lincurve(wave * DC.ar(0.24859058856964), wave * DC.ar(0.68428111076355), wave * DC.ar(0.6851122379303), wave * DC.ar(0.95722663402557), wave * DC.ar(0.24457669258118), wave * DC.ar(0.97250199317932)), Silent.ar().blend(wave * DC.ar(0.97010052204132), wave * DC.ar(0.8734884262085)));
varXMCauliA20130915 = FSinOsc.ar(in * modZ, varXMCauliA20130912, 0.57069664003028 * varXMCauliA20130914 * wave, Silent.ar());
varXMCauliA2013099 = PeakEQ4.ar(varXMCauliA20130914, FreqShift.ar(wave * DC.ar(0.65871727466583), wave * DC.ar(0.2207977771759), wave * DC.ar(0.15828585624695), wave * DC.ar(0.76938438415527), wave * DC.ar(0.0011435747146606)).exprange(1, SampleRate.ir), modY * modY, modY);
varXMCauliA20130910 = Phasor.ar(signal * wave, wave * varXMCauliA20130910, Demand.ar(wave * DC.ar(0.99619710445404), wave * DC.ar(0.28932809829712), wave * DC.ar(0.78787517547607)).sqrdif(FMGrainBBF.ar(wave * DC.ar(0.99310863018036), wave * DC.ar(0.44811582565308), wave * DC.ar(0.73950350284576), wave * DC.ar(0.55532932281494), wave * DC.ar(0.63135480880737), wave * DC.ar(0.86349737644196), wave * DC.ar(0.54116249084473), wave * DC.ar(0.90500247478485), wave * DC.ar(0.47466361522675), wave * DC.ar(0.45508432388306), wave * DC.ar(0.0085271596908569), wave * DC.ar(0.91154110431671))), T2A.ar(wave * DC.ar(0.47273921966553), wave * DC.ar(0.99294757843018)), modX);
varXMCauliA20130911 = Nes2.ar(wave * DC.ar(0.16596662998199), wave * DC.ar(0.5095431804657), wave * DC.ar(0.38001763820648), wave * DC.ar(0.36112463474274), wave * DC.ar(0.17812895774841), wave * DC.ar(0.90697622299194), wave * DC.ar(0.99467122554779), wave * DC.ar(0.16668832302094), wave * DC.ar(0.80041468143463), wave * DC.ar(0.0024182796478271), wave * DC.ar(0.70302760601044), wave * DC.ar(0.59801816940308), wave * DC.ar(0.89368855953217), wave * DC.ar(0.1304018497467), wave * DC.ar(0.042979955673218), wave * DC.ar(0.15713751316071), wave * DC.ar(0.70212042331696), wave * DC.ar(0.71391558647156), wave * DC.ar(0.15249252319336), wave * DC.ar(0.7270530462265));
varXMCauliA20130912 = Gendy1.ar(wave * DC.ar(0.52114796638489), wave * DC.ar(0.70089852809906), wave * DC.ar(0.72150552272797), wave * DC.ar(0.67296350002289), wave * DC.ar(0.36616814136505), wave * DC.ar(0.56890714168549), wave * DC.ar(0.63189935684204), wave * DC.ar(0.81814956665039), wave * DC.ar(0.92706370353699), wave * DC.ar(0.46602523326874), wave * DC.ar(0.95038962364197), wave * DC.ar(0.73803424835205));
varXMCauliA20130913 = FMGrainB.ar(varXMCauliA2013099 * varXMCauliA20130913, Osc.ar(wave * DC.ar(0.98065054416656), wave * DC.ar(0.022741198539734), wave * DC.ar(0.88951063156128), wave * DC.ar(0.83681130409241), wave * DC.ar(0.24849653244019)), FoaZoomX.ar(wave * DC.ar(0.83203196525574), wave * DC.ar(0.51932978630066), wave * DC.ar(0.83645009994507), wave * DC.ar(0.22171258926392)).exprange(1, SampleRate.ir), BLowPass.ar(wave * DC.ar(0.64540708065033), wave * DC.ar(0.12400364875793), wave * DC.ar(0.91623556613922), wave * DC.ar(0.2526228427887), wave * DC.ar(0.92570114135742)).exprange(1, SampleRate.ir), signal * in, bufnum, DoubleWell.ar(wave * DC.ar(0.70062184333801), wave * DC.ar(0.060487508773804), wave * DC.ar(0.70491325855255), wave * DC.ar(0.90549647808075), wave * DC.ar(0.13012397289276), wave * DC.ar(0.40414083003998), wave * DC.ar(0.40317142009735), wave * DC.ar(0.9939923286438), wave * DC.ar(0.18424355983734), wave * DC.ar(0.83781850337982)), Silent.ar());
varXMCauliA20130914 = StkPluck.ar(wave * DC.ar(0.29594647884369), wave * DC.ar(0.55924606323242), wave * DC.ar(0.66285586357117), wave * DC.ar(0.7061595916748));
varXMCauliA20130915 = BeatWarper.ar(2, Array.fill(2.pow(15), { |i| rrand(-1, 1) }).as(LocalBuf), in * signal, wave * varXMCauliA20130911.explin(wave * DC.ar(0.69282877445221), wave * DC.ar(0.0065730810165405), wave * DC.ar(0.37082946300507), wave * DC.ar(0.89822149276733), wave * DC.ar(0.30011188983917)), modY * env, varXMCauliA20130914 * varXMCauliA20130914, varXMCauliA20130914 * varXMCauliA20130915, varXMCauliA20130910 * varXMCauliA20130915, 0.9639661496778 * varXMCauliA20130911 * varXMCauliA20130914, Silent.ar());
varXMCauliA2013099 = LFNoise0.ar(wave * DC.ar(0.093726277351379), wave * DC.ar(0.10509049892426), wave * DC.ar(0.055741906166077));
varXMCauliA20130910 = RedDPCMencode.ar(wave * DC.ar(0.35441434383392), wave * DC.ar(0.80242967605591));
varXMCauliA20130911 = NestedAllpassC.ar(wave * DC.ar(0.0041306018829346), wave * DC.ar(0.34207499027252), wave * DC.ar(0.7507346868515), wave * DC.ar(0.91042387485504), wave * DC.ar(0.47105348110199), wave * DC.ar(0.78195655345917), wave * DC.ar(0.96927177906036), wave * DC.ar(0.30912864208221), wave * DC.ar(0.69855678081512));
varXMCauliA20130912 = CombL.ar(wave * DC.ar(0.88924872875214), wave * DC.ar(0.25659942626953), wave * DC.ar(0.96846270561218), wave * DC.ar(0.49585902690887), wave * DC.ar(0.094276309013367), wave * DC.ar(0.21269714832306));
varXMCauliA20130913 = RedDPCMencode.ar(wave * DC.ar(0.059253215789795), wave * DC.ar(0.04954731464386));
varXMCauliA20130914 = NeedleRect.ar(wave * DC.ar(0.31774258613586), wave * DC.ar(0.96274650096893), wave * DC.ar(0.021196842193604), wave * DC.ar(0.4953784942627), wave * DC.ar(0.51361930370331), wave * DC.ar(0.64127290248871), wave * DC.ar(0.052017211914062));
varXMCauliA20130915 = COsc.ar(wave * DC.ar(0.52751183509827), wave * DC.ar(0.29434072971344), wave * DC.ar(0.22048604488373), wave * DC.ar(0.7026891708374), wave * DC.ar(0.96373879909515));

signal = varXMCauliA20130915;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// WM.Npad.DP2013091
/////////////////////////////////////////////////////////

SynthDef.new("WM.Npad.DP2013091", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varWMNpadDP2013099, varWMNpadDP20130910, varWMNpadDP20130911, varWMNpadDP20130912, varWMNpadDP20130913, varWMNpadDP20130914, varWMNpadDP20130915, varWMNpadDP201309116;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varWMNpadDP2013099 = varWMNpadDP20130910 = varWMNpadDP20130911 = varWMNpadDP20130912 = varWMNpadDP20130913 = varWMNpadDP20130914 = varWMNpadDP20130915 = varWMNpadDP201309116 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varWMNpadDP2013099 = RMEQ.ar(in, YigClifford3DL.ar(wave * DC.ar(0.16673874855042), wave * DC.ar(0.26062047481537), wave * DC.ar(0.21800768375397), wave * DC.ar(0.99688923358917), wave * DC.ar(0.48571455478668), wave * DC.ar(0.017899632453918), wave * DC.ar(0.60115456581116), wave * DC.ar(0.7372260093689), wave * DC.ar(0.91145467758179), wave * DC.ar(0.003564715385437)).exprange(1, SampleRate.ir), wave * env, YigClifford3DL.ar(wave * DC.ar(0.77475726604462), wave * DC.ar(0.84076356887817), wave * DC.ar(0.57278275489807), wave * DC.ar(0.74167418479919), wave * DC.ar(0.086786270141602), wave * DC.ar(0.13089740276337), wave * DC.ar(0.48298132419586), wave * DC.ar(0.13412976264954), wave * DC.ar(0.056593894958496), wave * DC.ar(0.65664124488831)), Disintegrator.ar(wave * DC.ar(0.055760025978088), wave * DC.ar(0.12224400043488), wave * DC.ar(0.37393772602081), wave * DC.ar(0.077763676643372), wave * DC.ar(0.21727275848389)), ClipNoise.ar(wave * DC.ar(0.16106009483337), wave * DC.ar(0.52034199237823)));
varWMNpadDP20130910 = SVF.ar(varWMNpadDP20130910 * varWMNpadDP20130912, modX, 0.84905564785004 * env * in, varWMNpadDP20130911 * varWMNpadDP2013099, varWMNpadDP20130913 * signal, modY * modY, z, varWMNpadDP2013099, gateEnv, Silent.ar());
varWMNpadDP20130911 = Allpass1.ar(varWMNpadDP2013099 * varWMNpadDP201309116, modY, 0.99972998405828 * in * varWMNpadDP20130911, Silent.ar());
varWMNpadDP20130912 = SetResetFF.ar(modX * varWMNpadDP201309116, varWMNpadDP201309116 * modZ);
varWMNpadDP20130913 = FoaTilt.ar(t_trig, varWMNpadDP20130913 * signal, 0.99982380010378 * varWMNpadDP20130913 * wave, Silent.ar());
varWMNpadDP20130914 = LorenzL.ar(modZ * varWMNpadDP20130913, modZ, t_trig, varWMNpadDP20130911, t_trig, gateEnv, modX * varWMNpadDP20130910, varWMNpadDP20130914, FBSineC.ar(wave * DC.ar(0.43915581703186), wave * DC.ar(0.028795003890991), wave * DC.ar(0.12243032455444), wave * DC.ar(0.86252856254578), wave * DC.ar(0.83471667766571), wave * DC.ar(0.73849046230316), wave * DC.ar(0.71652829647064), wave * DC.ar(0.28147900104523), wave * DC.ar(0.4448002576828)), Silent.ar());
varWMNpadDP20130915 = BFEncodeSter.ar(varWMNpadDP20130910, Perlin3.ar(wave * DC.ar(0.1180579662323), wave * DC.ar(0.24140322208405), wave * DC.ar(0.39402866363525)), x, varWMNpadDP20130912, wave * gateEnv, varWMNpadDP20130913 * varWMNpadDP20130910, modX * varWMNpadDP20130914, island);
varWMNpadDP2013099 = Lorenz2DL.ar(varWMNpadDP20130914 * gateEnv, modX * in, modX, amp.max(GrayNoise.ar(wave * DC.ar(0.3235102891922), wave * DC.ar(0.24862456321716))), gate, varWMNpadDP20130915 * varWMNpadDP20130914, modX.lincurve(wave * DC.ar(0.26288866996765), wave * DC.ar(0.52781057357788), wave * DC.ar(0.056977391242981), wave * DC.ar(0.90367484092712), wave * DC.ar(0.079380512237549), wave * DC.ar(0.71271014213562)), wave * signal, env, varWMNpadDP2013099, AmplitudeMod.ar(wave * DC.ar(0.96846032142639), wave * DC.ar(0.36199510097504), wave * DC.ar(0.75515413284302), wave * DC.ar(0.22382354736328), wave * DC.ar(0.87252712249756)));
varWMNpadDP20130910 = IndexInBetween.ar(wave * DC.ar(0.21861720085144), wave * DC.ar(0.63067615032196), wave * DC.ar(0.40863180160522), wave * DC.ar(0.61199367046356));
varWMNpadDP20130911 = Convolution.ar(wave * DC.ar(0.81053137779236), wave * DC.ar(0.6847950220108), wave * DC.ar(0.42635631561279), wave * DC.ar(0.69153797626495), wave * DC.ar(0.91715395450592));
varWMNpadDP20130912 = FBSineC.ar(modY * wave, gateEnv * signal, signal, amp, amp, varWMNpadDP20130911, 0.71440970897675 * gateEnv * varWMNpadDP20130911.expexp(wave * DC.ar(0.15478932857513), wave * DC.ar(0.21953344345093), wave * DC.ar(0.81594884395599), wave * DC.ar(0.90197658538818), wave * DC.ar(0.18103730678558)), XFade2.ar(wave * DC.ar(0.75652468204498), wave * DC.ar(0.83375144004822), wave * DC.ar(0.2940388917923), wave * DC.ar(0.0098028182983398)), Silent.ar());
varWMNpadDP20130913 = WaveLoss.ar(wave * DC.ar(0.53490543365479), wave * DC.ar(0.24322652816772), wave * DC.ar(0.46094822883606), wave * DC.ar(0.93967354297638), wave * DC.ar(0.73814880847931), wave * DC.ar(0.33876526355743));
varWMNpadDP20130914 = FMGrainBF.ar(wave * DC.ar(0.25972318649292), wave * DC.ar(0.90578162670135), wave * DC.ar(0.63073778152466), wave * DC.ar(0.052904605865479), wave * DC.ar(0.18685901165009), wave * DC.ar(0.90984427928925), wave * DC.ar(0.69803142547607), wave * DC.ar(0.45171976089478), wave * DC.ar(0.48174381256104), wave * DC.ar(0.69344139099121), wave * DC.ar(0.32533073425293));
varWMNpadDP20130915 = Astrocade.ar(amp, 0.15855062007904 * signal * varWMNpadDP20130910, y, bufnum, z, island, varWMNpadDP2013099 * varWMNpadDP20130911, varWMNpadDP20130911);
varWMNpadDP2013099 = FoaDominateY.ar(wave * DC.ar(0.21965968608856), wave * DC.ar(0.39954209327698), wave * DC.ar(0.6288560628891), wave * DC.ar(0.090681195259094));
varWMNpadDP20130910 = WaveletDaub.ar(wave * DC.ar(0.4126398563385), wave * DC.ar(0.31460022926331), wave * DC.ar(0.46277296543121), wave * DC.ar(0.55001580715179), wave * DC.ar(0.16239190101624));
varWMNpadDP20130911 = RedDPCMdecode.ar(wave * DC.ar(0.49317610263824));
varWMNpadDP20130912 = NLFiltL.ar(wave * DC.ar(0.9508318901062), wave * DC.ar(0.015801668167114), wave * DC.ar(0.3648567199707), wave * DC.ar(0.32841563224792), wave * DC.ar(0.77005755901337), wave * DC.ar(0.4069447517395), wave * DC.ar(0.051587104797363), wave * DC.ar(0.51294434070587));
varWMNpadDP20130913 = FMGrainBBF.ar(wave * DC.ar(0.15995252132416), wave * DC.ar(0.51162683963776), wave * DC.ar(0.47560167312622), wave * DC.ar(0.64572143554688), wave * DC.ar(0.51523280143738), wave * DC.ar(0.83546686172485), wave * DC.ar(0.35785269737244), wave * DC.ar(0.038719415664673), wave * DC.ar(0.12871551513672), wave * DC.ar(0.86667037010193), wave * DC.ar(0.12242865562439), wave * DC.ar(0.71393966674805));
varWMNpadDP20130914 = DemandEnvGen.ar(wave * DC.ar(0.93469512462616), wave * DC.ar(0.95034050941467), wave * DC.ar(0.59390842914581), wave * DC.ar(0.87382900714874), wave * DC.ar(0.38303411006927), wave * DC.ar(0.94661784172058), wave * DC.ar(0.95816111564636), wave * DC.ar(0.43747997283936), wave * DC.ar(0.10915374755859), wave * DC.ar(0.37943482398987));
varWMNpadDP20130915 = SoftClipper8.ar(wave * DC.ar(0.52437341213226));
// Variation test code
varWMNpadDP201309116 = LinCongC.ar(varWMNpadDP20130910, FoaPushX.ar(varWMNpadDP20130913, x, 0.99969656553732 * wave * wave, Silent.ar()), Decay2.ar(varWMNpadDP201309116 * wave, varWMNpadDP20130913 * env, gate, GlitchHPF.ar(varWMNpadDP20130911 * DC.ar(0.54517459869385), varWMNpadDP2013099 * DC.ar(0.16233468055725), varWMNpadDP20130915 * DC.ar(0.55633151531219), varWMNpadDP2013099 * DC.ar(0.89515602588654)), Silent.ar()), varWMNpadDP2013099 * signal, modZ * signal, varWMNpadDP20130914, Silent.ar());
varWMNpadDP201309116 = BBlockerBuf.ar(gateEnv * varWMNpadDP20130912, Array.fill(2.pow(16), { |i| rrand(-1, 1) }).as(LocalBuf), varWMNpadDP20130911 * varWMNpadDP201309116);
varWMNpadDP201309116 = LADSPA.ar(2, varWMNpadDP20130911 * varWMNpadDP2013099.mod(FBSineL.ar(varWMNpadDP20130914 * DC.ar(0.32758772373199), varWMNpadDP20130914 * DC.ar(0.038115978240967), varWMNpadDP20130910 * DC.ar(0.36562132835388), varWMNpadDP20130914 * DC.ar(0.85740220546722), varWMNpadDP20130915 * DC.ar(0.84766554832458), varWMNpadDP2013099 * DC.ar(0.47894740104675), varWMNpadDP2013099 * DC.ar(0.19493305683136), varWMNpadDP20130913 * DC.ar(0.057056903839111), varWMNpadDP20130912 * DC.ar(0.019445776939392))), modY);

signal = varWMNpadDP201309116;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Int_7F201310
/////////////////////////////////////////////////////////

SynthDef.new("Int_7F201310", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varInt_7F2013109, varInt_7F20131010;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varInt_7F2013109 = varInt_7F20131010 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varInt_7F2013109 = BufGrainBBF.ar(gateEnv * env, signal * modZ, bufnum, env, amp, bufnum, gate, varInt_7F20131010, 0.71496117115021 * modY * modY, env * env, signal * signal, 0.98120226625332 * varInt_7F2013109 * signal, Silent.ar());
varInt_7F20131010 = LFDNoise0.ar(modX * signal, 0.95424142250144 * env * varInt_7F20131010, Silent.ar());
varInt_7F2013109 = SinGrainI.ar(env * modZ, gate, modZ, bufnum, bufnum, gate, FoaFocusZ.ar(wave * DC.ar(0.50798952579498), wave * DC.ar(0.4463347196579), wave * DC.ar(0.10359394550323), wave * DC.ar(0.71881330013275)), Silent.ar());
varInt_7F20131010 = LFDNoise3.ar(wave * DC.ar(0.50434982776642), wave * DC.ar(0.76321244239807), wave * DC.ar(0.80610013008118));
varInt_7F2013109 = WaveletDaub.ar(wave * DC.ar(0.12081599235535), wave * DC.ar(0.017192959785461), wave * DC.ar(0.35842657089233), wave * DC.ar(0.84407925605774), wave * DC.ar(0.83652329444885));
varInt_7F20131010 = EnvGen.ar(wave * DC.ar(0.71744513511658), wave * DC.ar(0.7590503692627), wave * DC.ar(0.053909778594971), wave * DC.ar(0.66651666164398), wave * DC.ar(0.79272425174713), wave * DC.ar(0.0273277759552));

signal = varInt_7F20131010;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Apparition.7035201311
/////////////////////////////////////////////////////////

SynthDef.new("Apparition.7035201311", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varApparition70352013119;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varApparition70352013119 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varApparition70352013119 = XFade2.ar(env * env, island, amp, env);
varApparition70352013119 = FMHEncode0.ar(wave * DC.ar(0.67208468914032), wave * DC.ar(0.12300086021423), wave * DC.ar(0.11696815490723), wave * DC.ar(0.41737449169159));
varApparition70352013119 = Latch.ar(wave * DC.ar(0.46261918544769), wave * DC.ar(0.10140120983124));

signal = varApparition70352013119;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Apparition.70352013111
/////////////////////////////////////////////////////////

SynthDef.new("Apparition.70352013111", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varApparition70352013119, varApparition7035201311110, varApparition7035201311111;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varApparition70352013119 = varApparition7035201311110 = varApparition7035201311111 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varApparition70352013119 = Maxamp.ar(signal * env, signal);
varApparition70352013119 = LinCongN.ar(env * modZ, signal, varApparition70352013119 * varApparition7035201311111, varApparition7035201311110 * wave, RunningMax.ar(wave * DC.ar(0.99261295795441), wave * DC.ar(0.07568085193634)), 0.98115518707656 * NestedAllpassL.ar(wave * DC.ar(0.87531387805939), wave * DC.ar(0.34386205673218), wave * DC.ar(0.54755461215973), wave * DC.ar(0.23407018184662), wave * DC.ar(0.80850827693939), wave * DC.ar(0.59244048595428), wave * DC.ar(0.15423810482025), wave * DC.ar(0.95247197151184), wave * DC.ar(0.45773923397064)), Silent.ar());
varApparition70352013119 = PSinGrain.ar(wave * DC.ar(0.13048148155212), wave * DC.ar(0.49796724319458), wave * DC.ar(0.98886227607727));
// Variation test code
varApparition7035201311110 = SwitchDelay.ar(varApparition7035201311110 * signal, varApparition70352013119 * modY, 0.38972890377045 * wave * env, modX * modZ, amp, varApparition7035201311111, 0.49505332896006 * modX * varApparition7035201311111, Silent.ar());
varApparition7035201311111 = Lag3.ar(modY * modX, z, modZ, Silent.ar());
varApparition7035201311110 = StereoConvolution2L.ar(gateEnv, 0.2006950378418 * varApparition70352013119 * varApparition7035201311110, modY, signal * varApparition7035201311111, varApparition70352013119 * modY, x, 0.94122622829951 * wave, Silent.ar());
varApparition7035201311111 = RedPhasor2.ar(modX * varApparition7035201311110, amp, island, y, env * wave, env, modY);
varApparition7035201311110 = LatoocarfianTrig.ar(gateEnv.unipolar(varApparition70352013119 * DC.ar(0.11708092689514)), env, modZ * varApparition7035201311111, env * in.madd(varApparition70352013119 * DC.ar(0.80433750152588), varApparition70352013119 * DC.ar(0.28004121780396)), modZ * modX, in, modZ, gateEnv * varApparition70352013119, in, Silent.ar());
varApparition7035201311111 = SVF.ar(in * in, signal, 0.39899170398712 * modY * modY, varApparition7035201311110 * modZ, 0.41351318359375 * gateEnv * varApparition7035201311110, 0.85795879364014 * varApparition7035201311111 * modY, modZ, varApparition7035201311111 * varApparition70352013119, 0.99558124548687 * signal * varApparition70352013119, Silent.ar());

signal = varApparition7035201311111;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// WitCode.1728201311
/////////////////////////////////////////////////////////

SynthDef.new("WitCode.1728201311", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varWitCode17282013119;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varWitCode17282013119 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varWitCode17282013119 = PanAz.ar(2, z.lag2(wave * DC.ar(0.80321037769318), wave * DC.ar(0.15103709697723)), modX * env, y.lag3ud(wave * DC.ar(0.77803063392639), wave * DC.ar(0.23054182529449)), modX, 0.046489715576172 * BufCombL.ar(wave * DC.ar(0.24633955955505), wave * DC.ar(0.37320852279663), wave * DC.ar(0.66556000709534), wave * DC.ar(0.31869125366211), wave * DC.ar(0.38693523406982), wave * DC.ar(0.14411282539368)));
varWitCode17282013119 = BufGrainBBF.ar(RandSeed.ar(wave * DC.ar(0.91599941253662), wave * DC.ar(0.900426030159)), env * in, bufnum, in, gateEnv, bufnum, 0.41004705429077 * modY * env, varWitCode17282013119 * signal, wave * gateEnv, signal * modY, modY * env, in, Silent.ar());
varWitCode17282013119 = Normalizer.ar(wave * DC.ar(0.44573402404785), wave * DC.ar(0.17404437065125), wave * DC.ar(0.6049257516861));

signal = varWitCode17282013119;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// WM.MDMA.AZ201314
/////////////////////////////////////////////////////////

SynthDef.new("WM.MDMA.AZ201314", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varWMMDMAAZ2013149, varWMMDMAAZ20131410;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varWMMDMAAZ2013149 = varWMMDMAAZ20131410 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varWMMDMAAZ2013149 = MdaPiano.ar(signal * modX, gate, env * varWMMDMAAZ20131410, signal * modZ, modY * gateEnv, varWMMDMAAZ20131410 * in, signal, modY * varWMMDMAAZ20131410, env * varWMMDMAAZ2013149, modZ, y.range(wave * DC.ar(0.50732707977295), wave * DC.ar(0.2089307308197)), 0.71424889564514 * gateEnv, NestedAllpassN.ar(wave * DC.ar(0.60221970081329), wave * DC.ar(0.14714860916138), wave * DC.ar(0.6781975030899), wave * DC.ar(0.66296076774597), wave * DC.ar(0.15261316299438), wave * DC.ar(0.86884713172913), wave * DC.ar(0.83160054683685), wave * DC.ar(0.033032178878784), wave * DC.ar(0.15179550647736)), Changed.ar(wave * DC.ar(0.44512128829956), wave * DC.ar(0.28269290924072)), 0.068306565284729 * varWMMDMAAZ20131410 * varWMMDMAAZ20131410, 0.55279729657507 * modX * modZ, Silent.ar());
varWMMDMAAZ20131410 = Wrap.ar(varWMMDMAAZ20131410 * in, varWMMDMAAZ2013149, modZ);
varWMMDMAAZ2013149 = StkMoog.ar(modZ * modX, island, modZ * env, gateEnv, modY * gateEnv, 0.53406345844269 * varWMMDMAAZ20131410 * modZ, in * modX, FoaFocusX.ar(wave * DC.ar(0.17871904373169), wave * DC.ar(0.29313457012177), wave * DC.ar(0.70217728614807), wave * DC.ar(0.21618914604187)), Silent.ar());
varWMMDMAAZ20131410 = AtsPartial.ar(wave * DC.ar(0.76727259159088), wave * DC.ar(0.71542489528656), wave * DC.ar(0.43005609512329), wave * DC.ar(0.3822455406189), wave * DC.ar(0.86686396598816), wave * DC.ar(0.46982085704803), wave * DC.ar(0.13917088508606));
varWMMDMAAZ2013149 = A2B.ar(wave * DC.ar(0.11070609092712), wave * DC.ar(0.057000756263733), wave * DC.ar(0.7925853729248), wave * DC.ar(0.26318097114563));
varWMMDMAAZ20131410 = LFPulse.ar(wave * DC.ar(0.2199330329895), wave * DC.ar(0.020345449447632), wave * DC.ar(0.18287003040314), wave * DC.ar(0.23707509040833), wave * DC.ar(0.0096969604492188));

signal = varWMMDMAAZ20131410;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Trivial201315
/////////////////////////////////////////////////////////

SynthDef.new("Trivial201315", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varTrivial2013159, varTrivial20131510;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varTrivial2013159 = varTrivial20131510 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varTrivial2013159 = YigCliffordN.ar(varTrivial2013159 * varTrivial20131510, modX * modZ, signal * in, gateEnv * modX, modY * wave, z, gateEnv * modX, 0.99993155188485 * modZ * wave, Silent.ar());
varTrivial20131510 = TGrains2.ar(2, CombFormlet.ar(wave * DC.ar(0.30937135219574), wave * DC.ar(0.95240294933319), wave * DC.ar(0.042164325714111), wave * DC.ar(0.091450691223145), wave * DC.ar(0.81613838672638), wave * DC.ar(0.54503679275513), wave * DC.ar(0.020294904708862)), Array.fill(2.pow(16), { |i| rrand(-1, 1) }).as(LocalBuf), varTrivial20131510 * wave, modZ, wave * gateEnv, in, t_trig, modX, wave, signal * in);
varTrivial2013159 = Slew.ar(x, z.range(wave * DC.ar(0.2127058506012), wave * DC.ar(0.35497975349426)), bufnum, 0.90295140413705 * gateEnv * varTrivial2013159, Silent.ar());
varTrivial20131510 = DelTapRd.ar(wave * DC.ar(0.97971487045288), wave * DC.ar(0.82539010047913), wave * DC.ar(0.9322361946106), wave * DC.ar(0.20842695236206), wave * DC.ar(0.51429748535156), wave * DC.ar(0.10299742221832));
varTrivial2013159 = Atari2600.ar(wave * DC.ar(0.10446584224701), wave * DC.ar(0.11535179615021), wave * DC.ar(0.022899627685547), wave * DC.ar(0.64903771877289), wave * DC.ar(0.98593962192535), wave * DC.ar(0.73483717441559), wave * DC.ar(0.93235337734222));
varTrivial20131510 = Decimator.ar(wave * DC.ar(0.26831066608429), wave * DC.ar(0.23109698295593), wave * DC.ar(0.87554609775543), wave * DC.ar(0.36134719848633), wave * DC.ar(0.95308971405029));

signal = varTrivial20131510;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// X97M.Barisada.Var2013161
/////////////////////////////////////////////////////////

SynthDef.new("X97M.Barisada.Var2013161", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varX97MBarisadaVar2013169, varX97MBarisadaVar20131610, varX97MBarisadaVar201316111, varX97MBarisadaVar201316112;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varX97MBarisadaVar2013169 = varX97MBarisadaVar20131610 = varX97MBarisadaVar201316111 = varX97MBarisadaVar201316112 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varX97MBarisadaVar2013169 = BufGrain.ar(env * modY, 0.82948315143585 * modZ * gateEnv, bufnum, amp, env, varX97MBarisadaVar201316112 * wave, PeakEQ2.ar(wave * DC.ar(0.51713705062866), wave * DC.ar(0.29209434986115), wave * DC.ar(0.42093873023987), wave * DC.ar(0.83721423149109)), Silent.ar());
varX97MBarisadaVar20131610 = Delay2.ar(z, modX, Silent.ar());
varX97MBarisadaVar2013169 = StereoConvolution2L.ar(0.29818058013916 * varX97MBarisadaVar2013169 * varX97MBarisadaVar20131610, bufnum, island, modY * modZ, y, y, modY, WrapIndex.ar(wave * DC.ar(0.89464044570923), wave * DC.ar(0.38676428794861), wave * DC.ar(0.75420868396759), wave * DC.ar(0.88019418716431)));
varX97MBarisadaVar20131610 = WaveletDaub.ar(wave * DC.ar(0.13504505157471), wave * DC.ar(0.35614395141602), wave * DC.ar(0.039276123046875), wave * DC.ar(0.18404471874237), wave * DC.ar(0.93791270256042));
varX97MBarisadaVar2013169 = QuadC.ar(wave * DC.ar(0.75247550010681), wave * DC.ar(0.0020177364349365), wave * DC.ar(0.01027250289917), wave * DC.ar(0.33531153202057), wave * DC.ar(0.68787908554077), wave * DC.ar(0.53329300880432), wave * DC.ar(0.97739839553833));
varX97MBarisadaVar20131610 = WaveLoss.ar(wave * DC.ar(0.37004292011261), wave * DC.ar(0.51676297187805), wave * DC.ar(0.86737489700317), wave * DC.ar(0.91332542896271), wave * DC.ar(0.20114481449127), wave * DC.ar(0.052893042564392));
// Variation test code
varX97MBarisadaVar201316111 = Clipper8.ar(signal * modY, varX97MBarisadaVar20131610, modX * modX);
varX97MBarisadaVar201316112 = Fhn2DN.ar(PanB.ar(varX97MBarisadaVar20131610 * DC.ar(0.34315454959869), varX97MBarisadaVar20131610 * DC.ar(0.54141223430634), varX97MBarisadaVar20131610 * DC.ar(0.45270848274231), varX97MBarisadaVar2013169 * DC.ar(0.84810626506805)).exprange(1, SampleRate.ir), varX97MBarisadaVar2013169 * modZ, in, 0.53191018104553 * varX97MBarisadaVar20131610 * modZ, y, modX.madd(varX97MBarisadaVar2013169 * DC.ar(0.97197473049164), varX97MBarisadaVar2013169 * DC.ar(0.61839640140533)), modX.curvelin(varX97MBarisadaVar20131610 * DC.ar(0.083456993103027), varX97MBarisadaVar2013169 * DC.ar(0.38627970218658), varX97MBarisadaVar20131610 * DC.ar(0.11811983585358), varX97MBarisadaVar20131610 * DC.ar(0.61925196647644), varX97MBarisadaVar2013169 * DC.ar(0.19990479946136), varX97MBarisadaVar20131610 * DC.ar(0.041869640350342)), amp, modX, 0.98861232226761 * modX * modY, Silent.ar());
varX97MBarisadaVar201316111 = LFTri.ar(varX97MBarisadaVar201316111 * modZ, 0.72358524799347 * gateEnv * wave, FoaRotate.ar(varX97MBarisadaVar20131610 * DC.ar(0.45389020442963), varX97MBarisadaVar2013169 * DC.ar(0.55734992027283), varX97MBarisadaVar2013169 * DC.ar(0.97904765605927), varX97MBarisadaVar20131610 * DC.ar(0.53149569034576)), Silent.ar());
varX97MBarisadaVar201316112 = CombL.ar(varX97MBarisadaVar20131610, wave * varX97MBarisadaVar201316112, amp, modZ * modY, in, Silent.ar());
varX97MBarisadaVar201316111 = LPCVals.ar(Array.fill(2.pow(16), { |i| rrand(-1, 1) }).as(LocalBuf), modY * modY);
varX97MBarisadaVar201316112 = Summer.ar(env * gateEnv, t_trig, island, wave * modY);

signal = varX97MBarisadaVar201316112;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// HLLP.Soul.5410201317
/////////////////////////////////////////////////////////

SynthDef.new("HLLP.Soul.5410201317", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varHLLPSoul54102013179, varHLLPSoul541020131710, varHLLPSoul541020131711;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varHLLPSoul54102013179 = varHLLPSoul541020131710 = varHLLPSoul541020131711 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varHLLPSoul54102013179 = Sieve1.ar(Array.fill(2.pow(13), { |i| rrand(-1, 1) }).as(LocalBuf), 0.099293112754822 * gateEnv * wave, varHLLPSoul54102013179 * varHLLPSoul54102013179, 0.95131128302987 * modZ * varHLLPSoul541020131711, Silent.ar().linlin(wave * DC.ar(0.89317119121552), wave * DC.ar(0.45137524604797), wave * DC.ar(0.46782839298248), wave * DC.ar(0.89867115020752), wave * DC.ar(0.55828464031219)));
varHLLPSoul541020131710 = TPV.ar(env * wave, 0.16200423240662 * signal * signal, varHLLPSoul541020131711 * modZ, YigCliffordC.ar(wave * DC.ar(0.60191512107849), wave * DC.ar(0.74757516384125), wave * DC.ar(0.78552186489105), wave * DC.ar(0.85480999946594), wave * DC.ar(0.66469216346741), wave * DC.ar(0.28918480873108), wave * DC.ar(0.77724206447601), wave * DC.ar(0.54052865505219), wave * DC.ar(0.78487586975098)), gateEnv * modX, 0.99942599146182 * modX * signal, varHLLPSoul541020131711 * varHLLPSoul541020131711, modX * modX, 0.59379890966698 * modY * wave, Silent.ar());
varHLLPSoul541020131711 = LPZ1.ar(signal, modZ, Silent.ar());
varHLLPSoul54102013179 = BufGrainBBF.ar(IFFT.ar(wave * DC.ar(0.59515345096588), wave * DC.ar(0.72160923480988), wave * DC.ar(0.81297194957733)), varHLLPSoul54102013179, bufnum, wave, modZ, bufnum, varHLLPSoul541020131710, varHLLPSoul541020131710, modZ, env * varHLLPSoul54102013179, 0.27172541618347 * varHLLPSoul541020131710 * modX, 0.99936078072884 * modZ * varHLLPSoul541020131711, Silent.ar());
varHLLPSoul541020131710 = NLFiltL.ar(wave * DC.ar(0.23855078220367), wave * DC.ar(0.052959561347961), wave * DC.ar(0.77618587017059), wave * DC.ar(0.1235511302948), wave * DC.ar(0.72962021827698), wave * DC.ar(0.68436503410339), wave * DC.ar(0.20308899879456), wave * DC.ar(0.2822402715683));
varHLLPSoul541020131711 = Metro.ar(wave * DC.ar(0.40473413467407), wave * DC.ar(0.77955400943756), wave * DC.ar(0.13361752033234), wave * DC.ar(0.94232487678528));
varHLLPSoul54102013179 = Rotate2.ar(wave * DC.ar(0.015620112419128), wave * DC.ar(0.067615270614624), wave * DC.ar(0.94000828266144));
varHLLPSoul541020131710 = RMEQ.ar(wave * DC.ar(0.23099589347839), wave * DC.ar(0.55981886386871), wave * DC.ar(0.94345450401306), wave * DC.ar(0.21832585334778), wave * DC.ar(0.71444654464722), wave * DC.ar(0.35810792446136));
varHLLPSoul541020131711 = StandardN.ar(wave * DC.ar(0.10002565383911), wave * DC.ar(0.63966572284698), wave * DC.ar(0.94165301322937), wave * DC.ar(0.70218706130981), wave * DC.ar(0.93408942222595), wave * DC.ar(0.70987129211426));

signal = varHLLPSoul541020131711;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Trivial.Lifl.101201317
/////////////////////////////////////////////////////////

SynthDef.new("Trivial.Lifl.101201317", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varTrivialLifl1012013179;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varTrivialLifl1012013179 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varTrivialLifl1012013179 = XFadeRotate.ar(amp, wave * varTrivialLifl1012013179);
varTrivialLifl1012013179 = Logistic.ar(0.42672717571259 * env, Standard2DL.ar(wave * DC.ar(0.88941955566406), wave * DC.ar(0.26140832901001), wave * DC.ar(0.22542083263397), wave * DC.ar(0.65365982055664), wave * DC.ar(0.6845588684082), wave * DC.ar(0.85646319389343), wave * DC.ar(0.041701912879944)).exprange(1, SampleRate.ir), env * signal, BPZ2.ar(wave * DC.ar(0.25501215457916), wave * DC.ar(0.1346755027771), wave * DC.ar(0.46031665802002)), Silent.ar());
varTrivialLifl1012013179 = FoaDirectO.ar(wave * DC.ar(0.24091720581055), wave * DC.ar(0.95911622047424), wave * DC.ar(0.52933192253113), wave * DC.ar(0.45595359802246));

signal = varTrivialLifl1012013179;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// MacGyver.28032013181
/////////////////////////////////////////////////////////

SynthDef.new("MacGyver.28032013181", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varMacGyver28032013189, varMacGyver280320131810, varMacGyver280320131811, varMacGyver280320131812, varMacGyver280320131813, varMacGyver280320131814, varMacGyver280320131815, varMacGyver2803201318116, varMacGyver2803201318117;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varMacGyver28032013189 = varMacGyver280320131810 = varMacGyver280320131811 = varMacGyver280320131812 = varMacGyver280320131813 = varMacGyver280320131814 = varMacGyver280320131815 = varMacGyver2803201318116 = varMacGyver2803201318117 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varMacGyver28032013189 = Blip.ar(modX * varMacGyver280320131812, TPV.ar(wave * DC.ar(0.533576130867), wave * DC.ar(0.66201674938202), wave * DC.ar(0.6603399515152), wave * DC.ar(0.67946779727936), wave * DC.ar(0.17090260982513), wave * DC.ar(0.22099637985229), wave * DC.ar(0.55491530895233), wave * DC.ar(0.59138715267181), wave * DC.ar(0.43293285369873), wave * DC.ar(0.23264372348785)), 0.99398753229065 * varMacGyver2803201318116 * modX, Silent.ar());
varMacGyver280320131810 = IndexL.ar(Array.fill(2.pow(11), { |i| rrand(-1, 1) }).as(LocalBuf), modY * varMacGyver280320131813, LFNoise0.ar(wave * DC.ar(0.15007984638214), wave * DC.ar(0.26061654090881), wave * DC.ar(0.79665672779083)), Silent.ar());
varMacGyver280320131811 = IEnvGen.ar(varMacGyver28032013189 * varMacGyver2803201318117, modY * modX, ArrayMin.ar(wave * DC.ar(0.62473630905151)), Silent.ar());
varMacGyver280320131812 = SanityCheck.ar(y);
varMacGyver280320131813 = YigCliffordC.ar(varMacGyver28032013189 * varMacGyver280320131815, varMacGyver280320131811 * wave, env * varMacGyver280320131811, InGrain.ar(wave * DC.ar(0.7227680683136), wave * DC.ar(0.32488095760345), wave * DC.ar(0.99817526340485), wave * DC.ar(0.70960748195648), wave * DC.ar(0.51483845710754)), varMacGyver280320131813 * varMacGyver280320131813, 0.10422003269196 * varMacGyver280320131811 * signal, varMacGyver2803201318117 * varMacGyver280320131812, wave, Silent.ar());
varMacGyver280320131814 = LinExp.ar(varMacGyver2803201318116 * varMacGyver280320131811, Gbman2DL.ar(wave * DC.ar(0.79570317268372), wave * DC.ar(0.52936089038849), wave * DC.ar(0.79760837554932), wave * DC.ar(0.89882600307465), wave * DC.ar(0.076730132102966), wave * DC.ar(0.69772934913635)), 0.15782022476196 * varMacGyver280320131810 * gateEnv, varMacGyver2803201318116 * varMacGyver280320131810, varMacGyver280320131811);
varMacGyver280320131815 = LinExp.ar(0.27541828155518 * in * signal, varMacGyver280320131813 * env, varMacGyver280320131813 * env, varMacGyver2803201318117 * modZ, varMacGyver2803201318117 * modZ);
varMacGyver28032013189 = FoaTumble.ar(wave * DC.ar(0.49696278572083), wave * DC.ar(0.75610303878784), wave * DC.ar(0.11991536617279), wave * DC.ar(0.39617681503296));
varMacGyver280320131810 = QuadC.ar(Median.ar(wave * DC.ar(0.25831127166748), wave * DC.ar(0.027462124824524), wave * DC.ar(0.16693305969238), wave * DC.ar(0.65032041072845)).exprange(1, SampleRate.ir), 0.95422172546387 * Maxamp.ar(wave * DC.ar(0.78843569755554), wave * DC.ar(0.48107099533081)), 0.73943948745728 * modZ * varMacGyver280320131815, varMacGyver280320131813 * varMacGyver2803201318116, varMacGyver2803201318116, 0.99982727775468 * varMacGyver2803201318116 * varMacGyver280320131815, Silent.ar());
varMacGyver280320131811 = FMGrainIBF.ar(env * wave, island, gateEnv * varMacGyver2803201318116, varMacGyver280320131812, x, bufnum, bufnum, signal, amp, varMacGyver280320131811 * signal, varMacGyver2803201318117, varMacGyver2803201318117, 0.9998060046936 * varMacGyver2803201318116 * in, Silent.ar());
varMacGyver280320131812 = NestedAllpassL.ar(wave * DC.ar(0.87776231765747), wave * DC.ar(0.16997969150543), wave * DC.ar(0.39298188686371), wave * DC.ar(0.29577684402466), wave * DC.ar(0.36851048469543), wave * DC.ar(0.22275352478027), wave * DC.ar(0.25317192077637), wave * DC.ar(0.77405989170074), wave * DC.ar(0.078689813613892));
varMacGyver280320131813 = GVerb.ar(wave * DC.ar(0.4078357219696), wave * DC.ar(0.45469272136688), wave * DC.ar(0.22750973701477), wave * DC.ar(0.84157955646515), wave * DC.ar(0.39072406291962), wave * DC.ar(0.63802897930145), wave * DC.ar(0.93993067741394), wave * DC.ar(0.56503844261169), wave * DC.ar(0.97111034393311), wave * DC.ar(0.59069561958313), wave * DC.ar(0.25651383399963), wave * DC.ar(0.51397716999054));
varMacGyver280320131814 = BufRd.ar(2, Array.fill(2.pow(13), { |i| rrand(-1, 1) }).as(LocalBuf), wave * signal, t_trig, 0.22292363643646 * modY * env);
varMacGyver280320131815 = Tumble.ar(wave * DC.ar(0.218634724617), wave * DC.ar(0.91616809368134), wave * DC.ar(0.9338093996048), wave * DC.ar(0.48992073535919), wave * DC.ar(0.46035718917847));
varMacGyver28032013189 = B2UHJ.ar(wave * DC.ar(0.62605786323547), wave * DC.ar(0.1591420173645), wave * DC.ar(0.5545426607132));
varMacGyver280320131810 = WaveletDaub.ar(wave * DC.ar(0.673619389534), wave * DC.ar(0.44778096675873), wave * DC.ar(0.89356076717377), wave * DC.ar(0.83014035224915), wave * DC.ar(0.99091553688049));
varMacGyver280320131811 = LFNoise1.ar(wave * DC.ar(0.61584544181824), wave * DC.ar(0.20295464992523), wave * DC.ar(0.50770580768585));
varMacGyver280320131812 = IIRFilter.ar(wave * DC.ar(0.15738880634308), wave * DC.ar(0.60135328769684), wave * DC.ar(0.82988905906677), wave * DC.ar(0.74606275558472), wave * DC.ar(0.35687565803528));
varMacGyver280320131813 = FoaDominateZ.ar(wave * DC.ar(0.92765033245087), wave * DC.ar(0.60225093364716), wave * DC.ar(0.90361666679382), wave * DC.ar(0.72855317592621));
varMacGyver280320131814 = BPZ2.ar(wave * DC.ar(0.4385814666748), wave * DC.ar(0.78073406219482), wave * DC.ar(0.52144205570221));
varMacGyver280320131815 = Lag3UD.ar(wave * DC.ar(0.98229324817657), wave * DC.ar(0.99315881729126), wave * DC.ar(0.95442748069763), wave * DC.ar(0.26154339313507), wave * DC.ar(0.68801748752594));
// Variation test code
varMacGyver2803201318116 = EnvFollow.ar(varMacGyver2803201318116 * varMacGyver28032013189, t_trig, varMacGyver280320131810, Silent.ar());
varMacGyver2803201318117 = TBrownRand.ar(modY * varMacGyver2803201318117, AllpassL.ar(in, varMacGyver280320131813, varMacGyver280320131810 * varMacGyver28032013189, 0.84336185455322 * varMacGyver280320131811 * wave, 0.99991476937144 * varMacGyver280320131814 * varMacGyver280320131814, Silent.ar()), varMacGyver2803201318116, x, signal * varMacGyver280320131813.sqrdif(LorenzTrig.ar(varMacGyver280320131812 * DC.ar(0.71113312244415), varMacGyver280320131812 * DC.ar(0.037562727928162), varMacGyver280320131813 * DC.ar(0.76317071914673), varMacGyver280320131813 * DC.ar(0.91254019737244), varMacGyver280320131814 * DC.ar(0.60838329792023), varMacGyver280320131813 * DC.ar(0.35972094535828), varMacGyver280320131813 * DC.ar(0.96154999732971), varMacGyver280320131810 * DC.ar(0.354172706604), varMacGyver280320131815 * DC.ar(0.81149315834045), varMacGyver280320131810 * DC.ar(0.09716522693634), varMacGyver280320131814 * DC.ar(0.15115237236023))), DoubleWell3.ar(varMacGyver280320131815 * DC.ar(0.69890260696411), varMacGyver280320131813 * DC.ar(0.57389521598816), varMacGyver28032013189 * DC.ar(0.069526314735413), varMacGyver280320131815 * DC.ar(0.84334981441498), varMacGyver280320131811 * DC.ar(0.21142208576202), varMacGyver28032013189 * DC.ar(0.7830126285553), varMacGyver28032013189 * DC.ar(0.19053602218628), varMacGyver280320131810 * DC.ar(0.84000957012177)), Silent.ar());
varMacGyver2803201318116 = Breakcore.ar(Array.fill(2.pow(16), { |i| rrand(-1, 1) }).as(LocalBuf), 0.67411303520203 * modX * varMacGyver2803201318117, Delay1.ar(varMacGyver280320131814 * DC.ar(0.56004798412323), varMacGyver280320131813 * DC.ar(0.89183378219604), varMacGyver28032013189 * DC.ar(0.76829993724823)), z, varMacGyver28032013189 * in);
varMacGyver2803201318117 = HenonL.ar(env * varMacGyver280320131813, gate, modZ * modZ, varMacGyver280320131810 * env, varMacGyver2803201318117 * wave, 0.95860337394845 * modY * env, Silent.ar());
varMacGyver2803201318116 = DoubleWell3.ar(modY, modY * wave, varMacGyver280320131810, varMacGyver2803201318116 * wave, 0.4679206609726 * in * modY, y, FoaZoomZ.ar(varMacGyver280320131811 * DC.ar(0.15896558761597), varMacGyver280320131813 * DC.ar(0.76433777809143), varMacGyver280320131812 * DC.ar(0.8306713104248), varMacGyver280320131812 * DC.ar(0.69851839542389)), Silent.ar().hypot(BLowPass.ar(varMacGyver280320131810 * DC.ar(0.73715806007385), varMacGyver280320131814 * DC.ar(0.00146484375), varMacGyver280320131812 * DC.ar(0.4764438867569), varMacGyver280320131813 * DC.ar(0.76406133174896), varMacGyver280320131812 * DC.ar(0.94439208507538))));
varMacGyver2803201318117 = MidEQ.ar(varMacGyver280320131811 * env, StkBandedWG.ar(varMacGyver280320131814 * DC.ar(0.68877577781677), varMacGyver280320131815 * DC.ar(0.068618893623352), varMacGyver280320131810 * DC.ar(0.95123493671417), varMacGyver280320131815 * DC.ar(0.12835597991943), varMacGyver280320131812 * DC.ar(0.2506115436554), varMacGyver280320131815 * DC.ar(0.7694855928421), varMacGyver280320131810 * DC.ar(0.082622289657593), varMacGyver28032013189 * DC.ar(0.37100112438202), varMacGyver280320131815 * DC.ar(0.222700715065), varMacGyver280320131814 * DC.ar(0.40029156208038), varMacGyver280320131814 * DC.ar(0.66478323936462)).exprange(1, SampleRate.ir), varMacGyver280320131812 * varMacGyver280320131814, AtsPartial.ar(Array.fill(2.pow(10), { |i| rrand(-1, 1) }).as(LocalBuf), varMacGyver280320131815 * varMacGyver280320131811, varMacGyver2803201318116, TwoZero.ar(varMacGyver280320131813 * DC.ar(0.27116715908051), varMacGyver280320131812 * DC.ar(0.4675087928772), varMacGyver280320131813 * DC.ar(0.063264846801758), varMacGyver280320131812 * DC.ar(0.28937566280365), varMacGyver280320131815 * DC.ar(0.86065852642059)).exprange(1, SampleRate.ir), Vibrato.ar(varMacGyver280320131810 * DC.ar(0.67919683456421), varMacGyver280320131814 * DC.ar(0.48777484893799), varMacGyver280320131811 * DC.ar(0.614870429039), varMacGyver280320131810 * DC.ar(0.34099817276001), varMacGyver28032013189 * DC.ar(0.38586068153381), varMacGyver280320131813 * DC.ar(0.71561288833618), varMacGyver280320131811 * DC.ar(0.6796749830246), varMacGyver280320131814 * DC.ar(0.39736485481262)).exprange(1, SampleRate.ir), 0.99840610844601 * RedLbyl.ar(varMacGyver28032013189 * DC.ar(0.62884914875031), varMacGyver280320131812 * DC.ar(0.69120895862579), varMacGyver280320131815 * DC.ar(0.99975621700287)), DetectIndex.ar(varMacGyver280320131814 * DC.ar(0.80391991138458), varMacGyver280320131813 * DC.ar(0.030210018157959), varMacGyver280320131811 * DC.ar(0.82730114459991), varMacGyver280320131815 * DC.ar(0.36569118499756))), Formant.ar(varMacGyver280320131814 * DC.ar(0.087332248687744), varMacGyver28032013189 * DC.ar(0.25886988639832), varMacGyver280320131811 * DC.ar(0.85363328456879), varMacGyver280320131812 * DC.ar(0.17917346954346), varMacGyver280320131814 * DC.ar(0.62074553966522)), Silent.ar());

signal = varMacGyver2803201318117;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Zany.452201318
/////////////////////////////////////////////////////////

SynthDef.new("Zany.452201318", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varZany4522013189, varZany45220131810, varZany45220131811, varZany45220131812, varZany45220131813, varZany45220131814, varZany45220131815;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varZany4522013189 = varZany45220131810 = varZany45220131811 = varZany45220131812 = varZany45220131813 = varZany45220131814 = varZany45220131815 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varZany4522013189 = GbmanN.ar(varZany45220131814 * varZany45220131812, wave, in * signal, TDelay.ar(wave * DC.ar(0.8303188085556), wave * DC.ar(0.91079962253571)), Silent.ar());
varZany45220131810 = FoaPanB.ar(varZany45220131810, signal, island, wave, Silent.ar());
varZany45220131811 = Trig.ar(env * signal, varZany45220131813);
varZany45220131812 = IndexL.ar(Array.fill(2.pow(10), { |i| rrand(-1, 1) }).as(LocalBuf), island, 0.61829329230973 * modX * varZany45220131814, TWindex.ar(wave * DC.ar(0.042466521263123), wave * DC.ar(0.88047933578491), wave * DC.ar(0.75237226486206)));
varZany45220131813 = OneZero.ar(varZany45220131814, varZany45220131812 * in, OSTrunc8.ar(wave * DC.ar(0.0081702470779419), wave * DC.ar(0.31229162216187)), Silent.ar());
varZany45220131814 = AtsAmp.ar(Array.fill(2.pow(13), { |i| rrand(-1, 1) }).as(LocalBuf), modY * varZany45220131815, t_trig, 0.99949466759638 * varZany4522013189 * modX, Silent.ar());
varZany45220131815 = YigCliffordC.ar(modZ * modY, varZany45220131811, wave * modY, x, 0.81643307209015 * modZ * varZany45220131813, in.explin(wave * DC.ar(0.18169832229614), wave * DC.ar(0.37313616275787), wave * DC.ar(0.99992263317108), wave * DC.ar(0.33345341682434), wave * DC.ar(0.77763891220093)), varZany45220131811, 0.99179820907789 * varZany45220131815 * in, Silent.ar());
varZany4522013189 = Henon2DN.ar(modX * env, modZ, signal, varZany45220131812 * modZ, varZany45220131814 * in, varZany45220131810 * varZany45220131812, 0.77554647847944 * varZany45220131815 * wave, Silent.ar());
varZany45220131810 = FhnTrig.ar(wave * varZany45220131815, StkSaxofony.ar(wave * DC.ar(0.42372858524323), wave * DC.ar(0.64865005016327), wave * DC.ar(0.050746202468872), wave * DC.ar(0.91882383823395), wave * DC.ar(0.14950931072235), wave * DC.ar(0.8470584154129), wave * DC.ar(0.42397773265839), wave * DC.ar(0.11994600296021), wave * DC.ar(0.29993855953217), wave * DC.ar(0.43830382823944), wave * DC.ar(0.51081764698029)).exprange(1, SampleRate.ir), varZany45220131814 * signal, x, bufnum, y, signal * gateEnv, t_trig, modX, 0.9804432581731 * QuadC.ar(wave * DC.ar(0.34261405467987), wave * DC.ar(0.58657908439636), wave * DC.ar(0.54522836208344), wave * DC.ar(0.05538284778595), wave * DC.ar(0.958176612854), wave * DC.ar(0.19053030014038), wave * DC.ar(0.63150179386139)), Silent.ar());
varZany45220131811 = Lag2UD.ar(wave * DC.ar(0.18265509605408), wave * DC.ar(0.70343959331512), wave * DC.ar(0.42588269710541), wave * DC.ar(0.75385975837708), wave * DC.ar(0.53376829624176));
varZany45220131812 = OffsetOut.ar(wave * DC.ar(0.8468416929245), wave * DC.ar(0.63223767280579));
varZany45220131813 = Standard2DL.ar(wave * DC.ar(0.16209816932678), wave * DC.ar(0.84151768684387), wave * DC.ar(0.32072055339813), wave * DC.ar(0.4217072725296), wave * DC.ar(0.75100088119507), wave * DC.ar(0.086992144584656), wave * DC.ar(0.51819002628326));
varZany45220131814 = Spreader.ar(wave * DC.ar(0.64906394481659), wave * DC.ar(0.77556324005127), wave * DC.ar(0.094696640968323), wave * DC.ar(0.42140400409698), wave * DC.ar(0.3825695514679));
varZany45220131815 = BufWr.ar(wave * DC.ar(0.63624227046967), wave * DC.ar(0.41904878616333), wave * DC.ar(0.98239147663116), wave * DC.ar(0.82976460456848));
varZany4522013189 = LeakDC.ar(wave * DC.ar(0.62356841564178), wave * DC.ar(0.62568175792694), wave * DC.ar(0.46712100505829), wave * DC.ar(0.53662884235382));
varZany45220131810 = Henon2DC.ar(wave * DC.ar(0.91383183002472), wave * DC.ar(0.21006214618683), wave * DC.ar(0.71696066856384), wave * DC.ar(0.16028010845184), wave * DC.ar(0.86537671089172), wave * DC.ar(0.30106008052826), wave * DC.ar(0.037893891334534), wave * DC.ar(0.68865096569061));
varZany45220131811 = DelayL.ar(wave * DC.ar(0.59174525737762), wave * DC.ar(0.43020081520081), wave * DC.ar(0.55515134334564), wave * DC.ar(0.20808291435242), wave * DC.ar(0.39249241352081));
varZany45220131812 = GVerb.ar(wave * DC.ar(0.33544635772705), wave * DC.ar(0.79318451881409), wave * DC.ar(0.45718932151794), wave * DC.ar(0.44164609909058), wave * DC.ar(0.55426466464996), wave * DC.ar(0.28243446350098), wave * DC.ar(0.45386004447937), wave * DC.ar(0.41470277309418), wave * DC.ar(0.61922681331635), wave * DC.ar(0.51592683792114), wave * DC.ar(0.88818228244781), wave * DC.ar(0.78142619132996));
varZany45220131813 = Demand.ar(wave * DC.ar(0.61108875274658), wave * DC.ar(0.045564770698547), wave * DC.ar(0.58429181575775));
varZany45220131814 = Blip.ar(wave * DC.ar(0.8623868227005), wave * DC.ar(0.96315133571625), wave * DC.ar(0.2532445192337), wave * DC.ar(0.94269275665283));
varZany45220131815 = LFTri.ar(wave * DC.ar(0.66539824008942), wave * DC.ar(0.85333240032196), wave * DC.ar(0.61763119697571), wave * DC.ar(0.82617628574371));

signal = varZany45220131815;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Kit201319
/////////////////////////////////////////////////////////

SynthDef.new("Kit201319", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varKit2013199, varKit20131910;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varKit2013199 = varKit20131910 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varKit2013199 = BufGrainB.ar(modY * modZ, modX * modX, bufnum, in * varKit2013199, varKit20131910 * gateEnv, bufnum, signal * varKit20131910, varKit20131910, Silent.ar());
varKit20131910 = LPZ2.ar(signal * modZ, 0.97873947008783 * gateEnv * gateEnv, Silent.ar());
varKit2013199 = MeanTriggered.ar(gateEnv * gateEnv, varKit2013199 * wave, 0.9689005613327 * modZ * modX, modX, Silent.ar());
varKit20131910 = LPFVS6.ar(wave * DC.ar(0.69557762145996), wave * DC.ar(0.85898518562317), wave * DC.ar(0.26095902919769));
varKit2013199 = FoaPushZ.ar(wave * DC.ar(0.59762990474701), wave * DC.ar(0.8395848274231), wave * DC.ar(0.55855989456177), wave * DC.ar(0.36225318908691));
varKit20131910 = Henon2DL.ar(wave * DC.ar(0.82009291648865), wave * DC.ar(0.25490593910217), wave * DC.ar(0.30974555015564), wave * DC.ar(0.26426088809967), wave * DC.ar(0.93419361114502), wave * DC.ar(0.37750458717346), wave * DC.ar(0.88013029098511), wave * DC.ar(0.58167243003845));

signal = varKit20131910;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Bin.Auto.BFK201321
/////////////////////////////////////////////////////////

SynthDef.new("Bin.Auto.BFK201321", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varBinAutoBFK2013219, varBinAutoBFK20132110, varBinAutoBFK20132111, varBinAutoBFK20132112, varBinAutoBFK20132113, varBinAutoBFK20132114, varBinAutoBFK20132115;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varBinAutoBFK2013219 = varBinAutoBFK20132110 = varBinAutoBFK20132111 = varBinAutoBFK20132112 = varBinAutoBFK20132113 = varBinAutoBFK20132114 = varBinAutoBFK20132115 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varBinAutoBFK2013219 = Poll.ar(varBinAutoBFK20132111 * varBinAutoBFK20132115, varBinAutoBFK2013219 * in, varBinAutoBFK20132111, modX * modY);
varBinAutoBFK20132110 = AtsBand.ar(Array.fill(2.pow(16), { |i| rrand(-1, 1) }).as(LocalBuf), in, varBinAutoBFK20132115.lag2(wave * DC.ar(0.022082567214966), wave * DC.ar(0.28994226455688)), varBinAutoBFK20132113, SOS.ar(wave * DC.ar(0.95138001441956), wave * DC.ar(0.76270437240601), wave * DC.ar(0.35104620456696), wave * DC.ar(0.95243430137634), wave * DC.ar(0.4435316324234), wave * DC.ar(0.10656154155731), wave * DC.ar(0.79854989051819), wave * DC.ar(0.67465484142303)));
varBinAutoBFK20132111 = AmpCompA.ar(env, modY * wave, env * varBinAutoBFK20132111, modY * wave.lag3(wave * DC.ar(0.14934957027435), wave * DC.ar(0.97827708721161)));
varBinAutoBFK20132112 = StkShakers.ar(signal * modZ, varBinAutoBFK20132112 * signal, t_trig, varBinAutoBFK20132113, varBinAutoBFK20132115 * in, 0.7502578364499 * varBinAutoBFK20132110 * modY.lag2ud(wave * DC.ar(0.38015115261078), wave * DC.ar(0.3880854845047)), Silent.ar());
varBinAutoBFK20132113 = TwoTube.ar(wave * modX, gateEnv * modY, island.range(wave * DC.ar(0.044154167175293), wave * DC.ar(0.55821549892426)), DriveNoise.ar(wave * DC.ar(0.21173632144928), wave * DC.ar(0.60809779167175), wave * DC.ar(0.31556260585785)), varBinAutoBFK20132110, InGrainIBF.ar(wave * DC.ar(0.71184861660004), wave * DC.ar(0.11768424510956), wave * DC.ar(0.10233783721924), wave * DC.ar(0.13326227664948), wave * DC.ar(0.068564295768738), wave * DC.ar(0.26686787605286), wave * DC.ar(0.15384709835052), wave * DC.ar(0.90680348873138), wave * DC.ar(0.24513602256775), wave * DC.ar(0.44559478759766), wave * DC.ar(0.83694684505463), wave * DC.ar(0.83472180366516)), Silent.ar());
varBinAutoBFK20132114 = GlitchHPF.ar(modY * gateEnv, CombLP.ar(wave * DC.ar(0.74407398700714), wave * DC.ar(0.69467878341675), wave * DC.ar(0.12125623226166), wave * DC.ar(0.5803679227829), wave * DC.ar(0.56231045722961), wave * DC.ar(0.52964854240417), wave * DC.ar(0.01811945438385), wave * DC.ar(0.96084868907928)).exprange(1, SampleRate.ir), 0.99998267345842 * signal * wave, Silent.ar());
varBinAutoBFK20132115 = LeakDC.ar(varBinAutoBFK2013219, island, PulseCount.ar(wave * DC.ar(0.70701253414154), wave * DC.ar(0.88890981674194)), Silent.ar());
varBinAutoBFK2013219 = TwoPole.ar(varBinAutoBFK2013219, modX * modY, wave * varBinAutoBFK20132113, varBinAutoBFK2013219, Silent.ar());
varBinAutoBFK20132110 = SOS.ar(0.60432839393616 * varBinAutoBFK20132111 * env.lcm(Out.ar(wave * DC.ar(0.34424304962158), wave * DC.ar(0.19783318042755))), gate, modY, gateEnv, modZ * gateEnv, t_trig, LinCongC.ar(wave * DC.ar(0.76791024208069), wave * DC.ar(0.95451211929321), wave * DC.ar(0.94410765171051), wave * DC.ar(0.63855969905853), wave * DC.ar(0.56055414676666), wave * DC.ar(0.081289649009705), wave * DC.ar(0.64204776287079)), Silent.ar());
varBinAutoBFK20132111 = Convolution2.ar(wave * modZ, LagUD.ar(wave * DC.ar(0.42386722564697), wave * DC.ar(0.643679022789), wave * DC.ar(0.22876000404358), wave * DC.ar(0.38126289844513), wave * DC.ar(0.091805219650269)), CompanderD.ar(wave * DC.ar(0.89935779571533), wave * DC.ar(0.1582510471344), wave * DC.ar(0.85655999183655), wave * DC.ar(0.29513847827911), wave * DC.ar(0.56878983974457), wave * DC.ar(0.28293859958649), wave * DC.ar(0.23544669151306), wave * DC.ar(0.68785262107849)), modY * varBinAutoBFK2013219, 0.99043725732152 * env * varBinAutoBFK20132110, Silent.ar());
varBinAutoBFK20132112 = TermanWang.ar(varBinAutoBFK20132115 * varBinAutoBFK20132113, varBinAutoBFK20132111 * modZ, modY * varBinAutoBFK20132114, varBinAutoBFK20132114, 0.036436438560486 * wave * varBinAutoBFK2013219, 0.67152523994446 * in * signal, 0.48027992248535 * modY * varBinAutoBFK2013219, varBinAutoBFK20132113 * gateEnv, varBinAutoBFK20132115, 0.99992014075711 * modX * modX, Silent.ar());
varBinAutoBFK20132113 = TBetaRand.ar(varBinAutoBFK2013219 * env, t_trig, modY * env, varBinAutoBFK2013219 * varBinAutoBFK20132110, modZ * varBinAutoBFK20132114, 0.99998305185437 * modY, Silent.ar());
varBinAutoBFK20132114 = AmplitudeMod.ar(wave * DC.ar(0.95151233673096), wave * DC.ar(2.4914741516113e-05), wave * DC.ar(0.82339787483215), wave * DC.ar(0.91277670860291), wave * DC.ar(0.64836752414703));
varBinAutoBFK20132115 = FMHEncode0.ar(gateEnv, varBinAutoBFK20132111 * modX, amp, 0.76792502403259 * varBinAutoBFK2013219 * varBinAutoBFK20132114);
varBinAutoBFK2013219 = AtsAmp.ar(wave * DC.ar(0.23934924602509), wave * DC.ar(0.34869873523712), wave * DC.ar(0.54942858219147), wave * DC.ar(0.14813137054443), wave * DC.ar(0.76638221740723));
varBinAutoBFK20132110 = DoubleNestedAllpassL.ar(wave * DC.ar(0.44921123981476), wave * DC.ar(0.20348453521729), wave * DC.ar(0.50006115436554), wave * DC.ar(0.67390859127045), wave * DC.ar(0.67681050300598), wave * DC.ar(0.55527460575104), wave * DC.ar(0.46658456325531), wave * DC.ar(0.75136649608612), wave * DC.ar(0.027888059616089), wave * DC.ar(0.57759809494019), wave * DC.ar(0.30031907558441), wave * DC.ar(0.11126744747162));
varBinAutoBFK20132111 = FoaFocusX.ar(wave * DC.ar(0.39923000335693), wave * DC.ar(0.17024493217468), wave * DC.ar(0.18274068832397), wave * DC.ar(0.47548365592957));
varBinAutoBFK20132112 = TTendency.ar(wave * DC.ar(0.52473056316376), wave * DC.ar(0.031276702880859), wave * DC.ar(0.7686824798584), wave * DC.ar(0.95913445949554), wave * DC.ar(0.56291723251343), wave * DC.ar(0.59863758087158));
varBinAutoBFK20132113 = FoaFocusX.ar(wave * DC.ar(0.93612957000732), wave * DC.ar(0.90885710716248), wave * DC.ar(0.82198405265808), wave * DC.ar(0.48934614658356));
varBinAutoBFK20132114 = DoubleWell2.ar(wave * DC.ar(0.99179828166962), wave * DC.ar(0.98812401294708), wave * DC.ar(0.81852042675018), wave * DC.ar(0.60941362380981), wave * DC.ar(0.26589691638947), wave * DC.ar(0.48235964775085), wave * DC.ar(0.85847783088684), wave * DC.ar(0.4081757068634), wave * DC.ar(0.62525451183319), wave * DC.ar(0.21630585193634));
varBinAutoBFK20132115 = FBSineN.ar(wave * DC.ar(0.51747786998749), wave * DC.ar(0.29746353626251), wave * DC.ar(0.54714930057526), wave * DC.ar(0.3941285610199), wave * DC.ar(0.5472617149353), wave * DC.ar(0.73663902282715), wave * DC.ar(0.09471869468689), wave * DC.ar(0.63345897197723), wave * DC.ar(0.56421065330505));

signal = varBinAutoBFK20132115;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// BW.523201321
/////////////////////////////////////////////////////////

SynthDef.new("BW.523201321", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varBW5232013219, varBW52320132110, varBW52320132111, varBW52320132112, varBW52320132113, varBW52320132114;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varBW5232013219 = varBW52320132110 = varBW52320132111 = varBW52320132112 = varBW52320132113 = varBW52320132114 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varBW5232013219 = LocalIn.ar(2, varBW52320132112);
varBW52320132110 = Latoocarfian2DL.ar(SinGrainB.ar(wave * DC.ar(0.3155597448349), wave * DC.ar(0.40956902503967), wave * DC.ar(0.86265587806702), wave * DC.ar(0.0066969394683838), wave * DC.ar(0.52350115776062), wave * DC.ar(0.51438128948212)).exprange(1, SampleRate.ir), modY * modZ, varBW5232013219 * varBW52320132114, x, env, modY, signal * varBW5232013219, modY, 0.99935881249378 * LPCSynth.ar(wave * DC.ar(0.51314735412598), wave * DC.ar(0.59472250938416), wave * DC.ar(0.15761256217957), wave * DC.ar(0.98828911781311), wave * DC.ar(0.083479404449463)), Silent.ar());
varBW52320132111 = SinTone.ar(varBW52320132111, wave, BRF.ar(wave * DC.ar(0.6144894361496), wave * DC.ar(0.053977966308594), wave * DC.ar(0.98687136173248), wave * DC.ar(0.41234874725342), wave * DC.ar(0.66558289527893)), Silent.ar());
varBW52320132112 = SoftClipAmp.ar(0.94198155403137 * varBW5232013219 * modY, wave, varBW52320132111, Silent.ar());
varBW52320132113 = Spring.ar(varBW5232013219, varBW52320132114 * modY, wave * varBW52320132111);
varBW52320132114 = MarkovSynth.ar(OnePole.ar(wave * DC.ar(0.44324421882629), wave * DC.ar(0.53433239459991), wave * DC.ar(0.43180644512177), wave * DC.ar(0.078231930732727)), Tumble.ar(wave * DC.ar(0.38701748847961), wave * DC.ar(0.25816452503204), wave * DC.ar(0.58171904087067), wave * DC.ar(0.7310596704483), wave * DC.ar(0.39994525909424)), modZ, varBW5232013219);
varBW5232013219 = Delay2.ar(wave * DC.ar(0.25974607467651), wave * DC.ar(0.038952112197876), wave * DC.ar(0.6135505437851));
varBW52320132110 = PartConv.ar(wave * DC.ar(0.7356288433075), wave * DC.ar(0.38919651508331), wave * DC.ar(0.82441675662994), wave * DC.ar(0.79652309417725), wave * DC.ar(0.72090649604797));
varBW52320132111 = FoaPsychoShelf.ar(gateEnv * signal, varBW52320132112, in, varBW5232013219 * modX, StandardL.ar(wave * DC.ar(0.40076088905334), wave * DC.ar(0.49246180057526), wave * DC.ar(0.044366955757141), wave * DC.ar(0.088593244552612), wave * DC.ar(0.73661041259766), wave * DC.ar(0.87075114250183)), Silent.ar());
varBW52320132112 = Pokey.ar(wave * DC.ar(0.50438392162323), wave * DC.ar(0.60811686515808), wave * DC.ar(0.11876821517944), wave * DC.ar(0.2047632932663), wave * DC.ar(0.75177347660065), wave * DC.ar(0.16105008125305), wave * DC.ar(0.78567147254944), wave * DC.ar(0.12776696681976), wave * DC.ar(0.80426204204559));
varBW52320132113 = MoogVCF.ar(wave * DC.ar(0.9814715385437), wave * DC.ar(0.11582326889038), wave * DC.ar(0.67722702026367), wave * DC.ar(0.83292818069458), wave * DC.ar(0.21607232093811));
varBW52320132114 = Saw.ar(wave * DC.ar(0.86149728298187), wave * DC.ar(0.26950669288635), wave * DC.ar(0.94724082946777));
varBW5232013219 = PeakFollower.ar(wave * DC.ar(0.20561623573303), wave * DC.ar(0.073379635810852));
varBW52320132110 = AllpassC.ar(wave * DC.ar(0.37509679794312), wave * DC.ar(0.13379120826721), wave * DC.ar(0.87325882911682), wave * DC.ar(0.59115850925446), wave * DC.ar(0.73717772960663), wave * DC.ar(0.93480920791626));
varBW52320132111 = Trig.ar(wave * DC.ar(0.42797315120697), wave * DC.ar(0.35765242576599));
varBW52320132112 = BufGrainBF.ar(wave * DC.ar(0.94804275035858), wave * DC.ar(0.86121165752411), wave * DC.ar(0.071850776672363), wave * DC.ar(0.13695621490479), wave * DC.ar(0.92098212242126), wave * DC.ar(0.84869480133057), wave * DC.ar(0.60989117622375), wave * DC.ar(0.11076271533966), wave * DC.ar(0.61780858039856), wave * DC.ar(0.77526581287384), wave * DC.ar(0.65783751010895), wave * DC.ar(0.25156211853027));
varBW52320132113 = Decimator.ar(wave * DC.ar(0.77138018608093), wave * DC.ar(0.94599568843842), wave * DC.ar(0.028950810432434), wave * DC.ar(0.59558534622192), wave * DC.ar(0.38195502758026));
varBW52320132114 = AmpCompA.ar(wave * DC.ar(0.15819144248962), wave * DC.ar(0.53287839889526), wave * DC.ar(0.92906951904297), wave * DC.ar(0.98377561569214));

signal = varBW52320132114;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// YOUTH.577201322
/////////////////////////////////////////////////////////

SynthDef.new("YOUTH.577201322", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varYOUTH5772013229, varYOUTH57720132210, varYOUTH57720132211, varYOUTH57720132212, varYOUTH57720132213, varYOUTH57720132214;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varYOUTH5772013229 = varYOUTH57720132210 = varYOUTH57720132211 = varYOUTH57720132212 = varYOUTH57720132213 = varYOUTH57720132214 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varYOUTH5772013229 = CrossoverDistortion.ar(gateEnv, varYOUTH57720132211, z, 0.8994029843992 * wave * env, XOut.ar(wave * DC.ar(0.17868828773499), wave * DC.ar(0.48244059085846), wave * DC.ar(0.25424027442932)));
varYOUTH57720132210 = Latoocarfian2DC.ar(Gendy1.ar(wave * DC.ar(0.46598160266876), wave * DC.ar(0.41713750362396), wave * DC.ar(0.6866352558136), wave * DC.ar(0.74022030830383), wave * DC.ar(0.16203546524048), wave * DC.ar(0.57202792167664), wave * DC.ar(0.29982101917267), wave * DC.ar(0.15591394901276), wave * DC.ar(0.170490026474), wave * DC.ar(0.92631840705872), wave * DC.ar(0.70535981655121), wave * DC.ar(0.18904435634613)).exprange(1, SampleRate.ir), modY * varYOUTH57720132210, modZ * varYOUTH57720132213.bipolar(wave * DC.ar(0.98468959331512)), t_trig, varYOUTH5772013229 * varYOUTH57720132210, 0.67222666740417 * varYOUTH57720132210 * varYOUTH57720132214, modY, 0.57458639144897 * modY * modY, WaveletDaub.ar(wave * DC.ar(0.65084564685822), wave * DC.ar(0.82202649116516), wave * DC.ar(0.13990819454193), wave * DC.ar(0.58297455310822), wave * DC.ar(0.79017806053162)), Silent.ar());
varYOUTH57720132211 = StkFlute.ar(wave * modY, env, NeedleRect.ar(wave * DC.ar(0.60943067073822), wave * DC.ar(0.6715989112854), wave * DC.ar(0.44981753826141), wave * DC.ar(0.34692370891571), wave * DC.ar(0.57487154006958), wave * DC.ar(0.23945093154907), wave * DC.ar(0.71598565578461)), modX * modY, 0.12793404782149 * modX * gateEnv, Silent.ar());
varYOUTH57720132212 = DegreeToKey.ar(Array.fill(2.pow(15), { |i| rrand(-1, 1) }).as(LocalBuf), amp, varYOUTH57720132213, LocalOut.ar(wave * DC.ar(0.47413730621338)), Silent.ar());
varYOUTH57720132213 = IFFT.ar(Array.fill(2.pow(13), { |i| rrand(-1, 1) }).as(LocalBuf), varYOUTH57720132212, varYOUTH57720132210 * gateEnv);
varYOUTH57720132214 = FoaPsychoShelf.ar(modY, in * wave, in * in, modZ * gateEnv, 0.99996006573684 * gateEnv * varYOUTH57720132212, Silent.ar());
varYOUTH5772013229 = FMGrainIBF.ar(wave * DC.ar(0.05330753326416), wave * DC.ar(0.80344152450562), wave * DC.ar(0.5905202627182), wave * DC.ar(0.68329775333405), wave * DC.ar(0.025487065315247), wave * DC.ar(0.64559066295624), wave * DC.ar(0.30801630020142), wave * DC.ar(0.034183621406555), wave * DC.ar(0.5817483663559), wave * DC.ar(0.91523206233978), wave * DC.ar(0.28831112384796), wave * DC.ar(0.27583134174347), wave * DC.ar(0.68936550617218), wave * DC.ar(0.13117122650146));
varYOUTH57720132210 = GlitchHPF.ar(y, in * gateEnv, Gendy3.ar(wave * DC.ar(0.59427630901337), wave * DC.ar(0.1772164106369), wave * DC.ar(0.2134016752243), wave * DC.ar(0.2643711566925), wave * DC.ar(0.78400647640228), wave * DC.ar(0.63088846206665), wave * DC.ar(0.34328401088715), wave * DC.ar(0.59450006484985), wave * DC.ar(0.35154867172241), wave * DC.ar(0.38493955135345), wave * DC.ar(0.033520936965942)), InGrainB.ar(wave * DC.ar(0.45922780036926), wave * DC.ar(0.38076233863831), wave * DC.ar(0.020635962486267), wave * DC.ar(0.4606249332428), wave * DC.ar(0.79720842838287), wave * DC.ar(0.72851955890656)));
varYOUTH57720132211 = DecodeB2.ar(2, varYOUTH57720132211, varYOUTH57720132210, varYOUTH5772013229, varYOUTH5772013229 * gateEnv);
varYOUTH57720132212 = WaveTerrain.ar(wave * DC.ar(0.60893046855927), wave * DC.ar(0.69926750659943), wave * DC.ar(0.16744446754456), wave * DC.ar(0.22889447212219), wave * DC.ar(0.78156793117523), wave * DC.ar(0.6549209356308), wave * DC.ar(0.34881222248077));
varYOUTH57720132213 = BLowPass.ar(0.36915910243988 * varYOUTH57720132211 * modZ, varYOUTH5772013229 * gateEnv, modX * in, 0.96109455500091 * in * varYOUTH57720132213, Silent.ar());
varYOUTH57720132214 = XFadeRotate.ar(wave * DC.ar(0.11696588993073), wave * DC.ar(0.49503254890442));
varYOUTH5772013229 = AmpComp.ar(wave * DC.ar(0.79363548755646), wave * DC.ar(0.82729697227478), wave * DC.ar(0.4062432050705));
varYOUTH57720132210 = OSTrunc8.ar(wave * DC.ar(0.61972200870514), wave * DC.ar(0.64627504348755));
varYOUTH57720132211 = AllpassL.ar(wave * DC.ar(0.87563395500183), wave * DC.ar(0.076366543769836), wave * DC.ar(0.30038154125214), wave * DC.ar(0.88673937320709), wave * DC.ar(0.90989565849304), wave * DC.ar(0.31373929977417));
varYOUTH57720132212 = SoftClipper4.ar(wave * DC.ar(0.043622851371765));
varYOUTH57720132213 = DetectSilence.ar(wave * DC.ar(0.27894461154938), wave * DC.ar(0.92581832408905), wave * DC.ar(0.9731251001358), wave * DC.ar(0.89151000976562));
varYOUTH57720132214 = Gbman2DL.ar(wave * DC.ar(0.40292656421661), wave * DC.ar(0.52136337757111), wave * DC.ar(0.084562063217163), wave * DC.ar(0.061737418174744), wave * DC.ar(0.59790503978729), wave * DC.ar(0.93167126178741));

signal = varYOUTH57720132214;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// YOUTH.5772013221
/////////////////////////////////////////////////////////

SynthDef.new("YOUTH.5772013221", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varYOUTH5772013229, varYOUTH57720132210, varYOUTH57720132211, varYOUTH57720132212, varYOUTH57720132213, varYOUTH57720132214, varYOUTH577201322115;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varYOUTH5772013229 = varYOUTH57720132210 = varYOUTH57720132211 = varYOUTH57720132212 = varYOUTH57720132213 = varYOUTH57720132214 = varYOUTH577201322115 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varYOUTH5772013229 = Tap.ar(Array.fill(2.pow(16), { |i| rrand(-1, 1) }).as(LocalBuf), 2, varYOUTH57720132210 * varYOUTH57720132210);
varYOUTH57720132210 = Delay1.ar(varYOUTH57720132213 * env, varYOUTH5772013229, Silent.ar());
varYOUTH57720132211 = NestedAllpassN.ar(gateEnv * varYOUTH57720132210.unipolar(wave * DC.ar(0.098490118980408)), in, t_trig, 0.56130361557007 * varYOUTH5772013229 * wave, env * modX, modX, t_trig, 0.99967134417782 * wave * varYOUTH57720132211, Silent.ar());
varYOUTH57720132212 = InGrainIBF.ar(varYOUTH577201322115 * varYOUTH57720132210.range(wave * DC.ar(0.12899124622345), wave * DC.ar(0.7606840133667)), varYOUTH57720132210 * varYOUTH57720132213, varYOUTH57720132212 * env, bufnum, bufnum, modY * modX, modY * varYOUTH57720132213, gate, t_trig, modX * signal, in, Silent.ar());
varYOUTH57720132213 = NestedAllpassN.ar(varYOUTH5772013229, LinCongN.ar(wave * DC.ar(0.77792978286743), wave * DC.ar(0.99257230758667), wave * DC.ar(0.53242349624634), wave * DC.ar(0.53417456150055), wave * DC.ar(0.7775319814682), wave * DC.ar(0.924760222435), wave * DC.ar(0.54922938346863)), varYOUTH57720132212 * varYOUTH57720132210, 0.48121178150177 * in * varYOUTH57720132212, modY, 0.15351462364197 * modX * modZ, 0.73006391525269 * modY * modZ, 0.99998904362478 * modZ * gateEnv, Silent.ar());
varYOUTH57720132214 = PeakEQ4.ar(y, varYOUTH57720132214, x, modX);
varYOUTH5772013229 = NestedAllpassN.ar(BufGrainBF.ar(wave * DC.ar(0.25377321243286), wave * DC.ar(0.23167634010315), wave * DC.ar(0.3260463476181), wave * DC.ar(0.30938959121704), wave * DC.ar(0.3018091917038), wave * DC.ar(0.75635194778442), wave * DC.ar(0.45470082759857), wave * DC.ar(0.95149540901184), wave * DC.ar(0.75744771957397), wave * DC.ar(0.72777378559113), wave * DC.ar(0.95467436313629), wave * DC.ar(0.27869081497192)), 0.98997271060944 * varYOUTH57720132212 * gateEnv, modY * modX, varYOUTH57720132212 * signal, x, modY * varYOUTH57720132213, bufnum, signal, Silent.ar());
varYOUTH57720132210 = LeakDC.ar(varYOUTH5772013229 * env, gateEnv * modY, 0.99436612015693 * varYOUTH57720132211 * varYOUTH5772013229, Silent.ar());
varYOUTH57720132211 = FoaAsymmetry.ar(island.fold2(BFEncodeSter.ar(wave * DC.ar(0.26800560951233), wave * DC.ar(0.95125663280487), wave * DC.ar(0.2592933177948), wave * DC.ar(0.75731146335602), wave * DC.ar(0.39641392230988), wave * DC.ar(0.27648079395294), wave * DC.ar(0.71572637557983), wave * DC.ar(0.52180802822113))), varYOUTH57720132210 * in, 0.75090263026841 * InGrainIBF.ar(wave * DC.ar(0.89214670658112), wave * DC.ar(0.66604936122894), wave * DC.ar(0.86928498744965), wave * DC.ar(0.63940370082855), wave * DC.ar(0.60537731647491), wave * DC.ar(0.83487939834595), wave * DC.ar(0.49103081226349), wave * DC.ar(0.426837682724), wave * DC.ar(0.21193242073059), wave * DC.ar(0.48565697669983), wave * DC.ar(0.92558658123016), wave * DC.ar(0.46420478820801)), Silent.ar());
varYOUTH57720132212 = LatoocarfianN.ar(wave * DC.ar(0.54957735538483), wave * DC.ar(0.44830965995789), wave * DC.ar(0.8686934709549), wave * DC.ar(0.57870721817017), wave * DC.ar(0.81404876708984), wave * DC.ar(0.046431303024292), wave * DC.ar(0.58347010612488), wave * DC.ar(0.41172909736633), wave * DC.ar(0.40634715557098));
varYOUTH57720132213 = CuspN.ar(wave * DC.ar(0.20979654788971), wave * DC.ar(0.97795104980469), wave * DC.ar(0.71684372425079), wave * DC.ar(0.83570861816406), wave * DC.ar(0.36133337020874), wave * DC.ar(0.040152549743652));
varYOUTH57720132214 = WrapSummer.ar(wave * DC.ar(0.18051886558533), wave * DC.ar(0.52568209171295), wave * DC.ar(0.27184092998505), wave * DC.ar(0.12043571472168), wave * DC.ar(0.81639111042023), wave * DC.ar(0.81424498558044));
varYOUTH5772013229 = YigCliffordC.ar(wave * DC.ar(0.80700898170471), wave * DC.ar(0.67862248420715), wave * DC.ar(0.22738671302795), wave * DC.ar(0.5678688287735), wave * DC.ar(0.37981677055359), wave * DC.ar(0.61650633811951), wave * DC.ar(0.55761694908142), wave * DC.ar(0.94971609115601), wave * DC.ar(0.53870463371277));
varYOUTH57720132210 = COsc.ar(wave * DC.ar(0.42857038974762), wave * DC.ar(0.35542559623718), wave * DC.ar(0.60278582572937), wave * DC.ar(0.61525726318359), wave * DC.ar(0.82558739185333));
varYOUTH57720132211 = FoaPressZ.ar(wave * DC.ar(0.67325758934021), wave * DC.ar(0.59099924564362), wave * DC.ar(0.85555779933929), wave * DC.ar(0.2132568359375));
varYOUTH57720132212 = SN76489.ar(wave * DC.ar(0.70150256156921), wave * DC.ar(0.095877408981323), wave * DC.ar(0.44725096225739), wave * DC.ar(0.82313406467438), wave * DC.ar(0.15767514705658), wave * DC.ar(0.36370277404785), wave * DC.ar(0.23022949695587), wave * DC.ar(0.12598824501038), wave * DC.ar(0.55500149726868));
varYOUTH57720132213 = Henon2DC.ar(wave * DC.ar(0.90251672267914), wave * DC.ar(0.89452922344208), wave * DC.ar(0.74331510066986), wave * DC.ar(0.24694561958313), wave * DC.ar(0.10651051998138), wave * DC.ar(0.60075175762177), wave * DC.ar(0.83110356330872), wave * DC.ar(0.60645961761475));
varYOUTH57720132214 = Lag3UD.ar(wave * DC.ar(0.66381478309631), wave * DC.ar(0.93705105781555), wave * DC.ar(0.28181433677673), wave * DC.ar(0.45285630226135), wave * DC.ar(0.080276608467102));
// Variation test code
varYOUTH577201322115 = LorenzL.ar(varYOUTH57720132210 * wave, env, varYOUTH57720132212 * varYOUTH57720132213, 0.58530867099762 * modX, varYOUTH57720132213 * modX, 0.91736686229706 * signal * signal, GVerb.ar(varYOUTH577201322115 * varYOUTH57720132211, varYOUTH57720132210 * varYOUTH5772013229, modZ * modY, FoaRotate.ar(varYOUTH57720132213 * DC.ar(0.74327433109283), varYOUTH57720132210 * DC.ar(0.61717140674591), varYOUTH57720132213 * DC.ar(0.78256547451019), varYOUTH57720132210 * DC.ar(0.11977422237396)), varYOUTH57720132213, modX, t_trig, varYOUTH57720132211 * varYOUTH57720132210, modY * varYOUTH57720132210, modX, 0.99993983905912 * Amplitude.ar(varYOUTH57720132210 * DC.ar(0.48499083518982), varYOUTH57720132212 * DC.ar(0.39941298961639), varYOUTH57720132211 * DC.ar(0.91051018238068), varYOUTH57720132213 * DC.ar(0.4826751947403), varYOUTH57720132211 * DC.ar(0.46697521209717)), Silent.ar()), modY * varYOUTH57720132213, 0.99983792814909 * gateEnv * modY, Silent.ar());
varYOUTH577201322115 = DelayN.ar(gate, varYOUTH57720132213, wave * modZ, wave, Silent.ar());
varYOUTH577201322115 = WalshHadamard.ar(varYOUTH577201322115, LFPar.ar(varYOUTH577201322115 * varYOUTH57720132213, gate, 0.99971766076311 * varYOUTH57720132212, Silent.ar()), FoaPushZ.ar(varYOUTH57720132214 * DC.ar(0.7709903717041), varYOUTH5772013229 * DC.ar(0.44994676113129), varYOUTH57720132212 * DC.ar(0.011930465698242), varYOUTH57720132212 * DC.ar(0.017993569374084)), Silent.ar());

signal = varYOUTH577201322115;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");


/////////////////////////////////////////////////////////
// Annres.10522013231
/////////////////////////////////////////////////////////

SynthDef.new("Annres.10522013231", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varAnnres10522013239, varAnnres105220132310, varAnnres105220132311, varAnnres1052201323112, varAnnres1052201323113;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varAnnres10522013239 = varAnnres105220132310 = varAnnres105220132311 = varAnnres1052201323112 = varAnnres1052201323113 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varAnnres10522013239 = PSinGrain.ar(modY, modZ, 0.89666378498077 * in * varAnnres105220132311);
varAnnres105220132310 = Brusselator.ar(in * gateEnv, x, env, gateEnv * modX, 0.9457700252533 * env * modY, bufnum, FoaPressY.ar(wave * DC.ar(0.65643262863159), wave * DC.ar(0.83192312717438), wave * DC.ar(0.23363697528839), wave * DC.ar(0.27366387844086)), Silent.ar().explin(wave * DC.ar(0.86130833625793), wave * DC.ar(0.22295439243317), wave * DC.ar(0.40049862861633), wave * DC.ar(0.97559106349945), wave * DC.ar(0.47955501079559)));
varAnnres105220132311 = QuadL.ar(in, env * varAnnres105220132311, varAnnres1052201323113 * varAnnres1052201323113, x, t_trig, 0.99972722005678 * gateEnv * wave, Convolution3.ar(wave * DC.ar(0.045673131942749), wave * DC.ar(0.45223605632782), wave * DC.ar(0.60088646411896), wave * DC.ar(0.36450278759003), wave * DC.ar(0.86622965335846), wave * DC.ar(0.048452019691467)));
varAnnres10522013239 = PlayBuf.ar(2, Array.fill(2.pow(14), { |i| rrand(-1, 1) }).as(LocalBuf), 0.23293197154999 * varAnnres105220132311 * env, varAnnres1052201323113 * gateEnv, t_trig, 0.33155596256256 * in * in, modX * modY);
varAnnres105220132310 = Henon2DN.ar(signal * in, varAnnres105220132311 * modY, modZ * varAnnres105220132311, varAnnres1052201323112 * varAnnres1052201323112, in * varAnnres10522013239, in, 0.62422193401887 * in * env, Silent.ar());
varAnnres105220132311 = NL2.ar(modY, Array.fill(2.pow(11), { |i| rrand(-1, 1) }).as(LocalBuf), island, varAnnres1052201323113 * in, in * varAnnres105220132311, signal, 0.99833746374744 * modY * varAnnres105220132310, Silent.ar());
varAnnres10522013239 = NeedleRect.ar(wave * DC.ar(0.72382521629333), wave * DC.ar(0.95324146747589), wave * DC.ar(0.2333037853241), wave * DC.ar(0.74968147277832), wave * DC.ar(0.55865097045898), wave * DC.ar(0.43353724479675), wave * DC.ar(0.91462922096252));
varAnnres105220132310 = LFBrownNoise0.ar(wave * DC.ar(0.96874856948853), wave * DC.ar(0.73961043357849), wave * DC.ar(0.77238595485687), wave * DC.ar(0.24218082427979), wave * DC.ar(0.86434018611908));
varAnnres105220132311 = SN76489.ar(wave * DC.ar(0.90852022171021), wave * DC.ar(0.83077347278595), wave * DC.ar(0.85656321048737), wave * DC.ar(0.61160802841187), wave * DC.ar(0.96801900863647), wave * DC.ar(0.16569113731384), wave * DC.ar(0.22807478904724), wave * DC.ar(0.93678510189056), wave * DC.ar(0.5479348897934));
// Variation test code
varAnnres1052201323112 = SendTrig.ar(modY * env, varAnnres105220132311, wave * varAnnres1052201323112);
varAnnres1052201323113 = CrossoverDistortion.ar(modY * in, x, varAnnres105220132310, RosslerL.ar(varAnnres105220132311 * DC.ar(0.50249648094177), varAnnres10522013239 * DC.ar(0.54545831680298), varAnnres10522013239 * DC.ar(0.57874894142151), varAnnres105220132310 * DC.ar(0.11811482906342), varAnnres10522013239 * DC.ar(0.71371567249298), varAnnres105220132311 * DC.ar(0.72984910011292), varAnnres105220132311 * DC.ar(0.54428517818451), varAnnres10522013239 * DC.ar(0.21336424350739), varAnnres10522013239 * DC.ar(0.026807546615601), varAnnres105220132311 * DC.ar(0.98018205165863)), RegaliaMitraEQ.ar(varAnnres105220132310 * DC.ar(0.37980544567108), varAnnres10522013239 * DC.ar(0.53332376480103), varAnnres105220132310 * DC.ar(0.32005333900452), varAnnres10522013239 * DC.ar(0.98489391803741), varAnnres10522013239 * DC.ar(0.54594194889069), varAnnres105220132311 * DC.ar(0.11306643486023)));
varAnnres1052201323112 = Convolution2L.ar(0.56809961795807 * signal * gateEnv, in, wave, varAnnres1052201323112, 0.95895302295685 * modX * env, LFPulse.ar(varAnnres105220132310 * DC.ar(0.15329051017761), varAnnres105220132311 * DC.ar(0.42890703678131), varAnnres105220132310 * DC.ar(0.66762328147888), varAnnres105220132310 * DC.ar(0.88151574134827), varAnnres105220132311 * DC.ar(0.27450454235077)), Silent.ar());
varAnnres1052201323113 = SinGrainB.ar(signal * varAnnres105220132310, wave * modZ, RegaliaMitraEQ.ar(varAnnres10522013239 * DC.ar(0.98718976974487), varAnnres105220132311 * DC.ar(0.83600687980652), varAnnres10522013239 * DC.ar(0.30067324638367), varAnnres10522013239 * DC.ar(0.76377260684967), varAnnres10522013239 * DC.ar(0.17139863967896), varAnnres10522013239 * DC.ar(0.54473292827606)).exprange(1, SampleRate.ir), bufnum, 0.9877109897743 * varAnnres10522013239 * varAnnres1052201323113, Silent.ar());
varAnnres1052201323112 = LinCongL.ar(modZ, modX, x, 0.57841098308563 * in * in, env * varAnnres10522013239, varAnnres1052201323112, Silent.ar());
varAnnres1052201323113 = BufAllpassN.ar(Array.fill(2.pow(11), { |i| rrand(-1, 1) }).as(LocalBuf), y, amp, modZ * wave, Latoocarfian2DN.ar(varAnnres105220132310 * DC.ar(0.27869272232056), varAnnres105220132311 * DC.ar(0.64132988452911), varAnnres105220132310 * DC.ar(0.69745397567749), varAnnres10522013239 * DC.ar(0.2260901927948), varAnnres105220132310 * DC.ar(0.9296897649765), varAnnres10522013239 * DC.ar(0.11260592937469), varAnnres10522013239 * DC.ar(0.16208112239838), varAnnres105220132310 * DC.ar(0.62241351604462), varAnnres10522013239 * DC.ar(0.32108020782471), varAnnres10522013239 * DC.ar(0.20961427688599)), Silent.ar());

signal = varAnnres1052201323113;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Bin.Auto.CDO201326
/////////////////////////////////////////////////////////

SynthDef.new("Bin.Auto.CDO201326", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varBinAutoCDO2013269, varBinAutoCDO20132610, varBinAutoCDO20132611, varBinAutoCDO20132612;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varBinAutoCDO2013269 = varBinAutoCDO20132610 = varBinAutoCDO20132611 = varBinAutoCDO20132612 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varBinAutoCDO2013269 = OSWrap8.ar(varBinAutoCDO20132612, AtsSynth.ar(wave * DC.ar(0.91181910037994), wave * DC.ar(0.48345792293549), wave * DC.ar(0.96355211734772), wave * DC.ar(0.70090341567993), wave * DC.ar(0.89495778083801), wave * DC.ar(0.39982378482819), wave * DC.ar(0.21984004974365), wave * DC.ar(0.81095325946808), wave * DC.ar(0.92889225482941)), varBinAutoCDO20132612 * modY);
varBinAutoCDO20132610 = Metro.ar(z, gateEnv * modZ, LPZ1.ar(wave * DC.ar(0.86174821853638), wave * DC.ar(0.43005883693695), wave * DC.ar(0.18228352069855)), Silent.ar());
varBinAutoCDO20132611 = WaveletDaub.ar(gateEnv * varBinAutoCDO20132611, env * gateEnv, 0.61782968044281 * in * gateEnv, 0.99998961415122 * varBinAutoCDO20132610, Silent.ar());
varBinAutoCDO20132612 = DoubleWell2.ar(WrapIndex.ar(wave * DC.ar(0.90061283111572), wave * DC.ar(0.91504561901093), wave * DC.ar(0.8911257982254), wave * DC.ar(0.53015542030334)), 0.22159266471863 * gateEnv * varBinAutoCDO20132611, bufnum, island, wave * varBinAutoCDO2013269, z, signal, gateEnv, 0.9998993939587 * modZ, Silent.ar());
varBinAutoCDO2013269 = DoubleWell.ar(0.75576019287109 * signal * modZ, gateEnv * signal, t_trig, varBinAutoCDO2013269 * signal, x, in * env, env, signal * varBinAutoCDO20132612, varBinAutoCDO20132611, Silent.ar());
varBinAutoCDO20132610 = BFManipulate.ar(0.65354597568512 * varBinAutoCDO2013269 * modY, wave * varBinAutoCDO20132610.minNyquist(), varBinAutoCDO20132610, modZ, in.lag2ud(wave * DC.ar(0.15466165542603), wave * DC.ar(0.9705331325531)), in * env, varBinAutoCDO20132610 * in);
varBinAutoCDO20132611 = TDuty.ar(wave * DC.ar(0.86776733398438), wave * DC.ar(0.99660420417786), wave * DC.ar(0.76210820674896), wave * DC.ar(0.96634542942047), wave * DC.ar(0.69723641872406));
varBinAutoCDO20132612 = RunningSum.ar(z, in);
varBinAutoCDO2013269 = StandardN.ar(wave * DC.ar(0.79741430282593), wave * DC.ar(0.29245269298553), wave * DC.ar(0.96529817581177), wave * DC.ar(0.93905365467072), wave * DC.ar(0.33108568191528), wave * DC.ar(0.030583143234253));
varBinAutoCDO20132610 = CombFormlet.ar(wave * DC.ar(0.28535866737366), wave * DC.ar(0.29453384876251), wave * DC.ar(0.37011694908142), wave * DC.ar(0.81353938579559), wave * DC.ar(0.23654282093048), wave * DC.ar(0.81090128421783), wave * DC.ar(0.12396121025085));
varBinAutoCDO20132611 = B2Ster.ar(wave * DC.ar(0.16226303577423), wave * DC.ar(0.83006811141968), wave * DC.ar(0.75583434104919), wave * DC.ar(0.12656402587891), wave * DC.ar(0.83247327804565));
varBinAutoCDO20132612 = FoaPushX.ar(wave * DC.ar(0.31846690177917), wave * DC.ar(0.12287902832031), wave * DC.ar(0.96832370758057), wave * DC.ar(0.9214471578598));

signal = varBinAutoCDO20132612;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Weed.5850.F2013271
/////////////////////////////////////////////////////////

SynthDef.new("Weed.5850.F2013271", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varWeed5850F2013279, varWeed5850F201327110;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varWeed5850F2013279 = varWeed5850F201327110 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varWeed5850F2013279 = MarkovSynth.ar(modX, gateEnv * in, varWeed5850F2013279, wave);
varWeed5850F2013279 = BBandStop.ar(0.76467561721802 * signal * varWeed5850F2013279, Gendy4.ar(wave * DC.ar(0.4111453294754), wave * DC.ar(0.37166440486908), wave * DC.ar(0.61131346225739), wave * DC.ar(0.86934673786163), wave * DC.ar(0.46199119091034), wave * DC.ar(0.36975133419037), wave * DC.ar(0.213991522789), wave * DC.ar(0.97751700878143), wave * DC.ar(0.13109064102173), wave * DC.ar(0.62322175502777), wave * DC.ar(0.55223846435547), wave * DC.ar(0.30692362785339)).exprange(1, SampleRate.ir), modY * varWeed5850F201327110, env, Silent.ar());
varWeed5850F2013279 = BPF.ar(wave * DC.ar(0.56680738925934), wave * DC.ar(0.93657052516937), wave * DC.ar(0.034489393234253), wave * DC.ar(0.46865653991699), wave * DC.ar(0.23568856716156));
// Variation test code
varWeed5850F201327110 = FMHDecode1.ar(varWeed5850F201327110 * varWeed5850F201327110, wave * varWeed5850F201327110, island, z, signal * modY, varWeed5850F201327110 * varWeed5850F201327110, modY, modX * signal, varWeed5850F201327110 * in, t_trig, varWeed5850F2013279, modX, Silent.ar());
varWeed5850F201327110 = NL.ar(varWeed5850F201327110, Array.fill(2.pow(16), { |i| rrand(-1, 1) }).as(LocalBuf), Array.fill(2.pow(14), { |i| rrand(-1, 1) }).as(LocalBuf), wave * varWeed5850F201327110, modZ * wave, 0.99985684141621 * varWeed5850F2013279 * in, Silent.ar());
varWeed5850F201327110 = OscN.ar(Array.fill(2.pow(10), { |i| rrand(-1, 1) }).as(LocalBuf), wave, varWeed5850F201327110 * env, 0.99987191107497 * gateEnv, Gendy1.ar(varWeed5850F2013279 * DC.ar(0.59838676452637), varWeed5850F2013279 * DC.ar(0.62873709201813), varWeed5850F2013279 * DC.ar(0.55471062660217), varWeed5850F2013279 * DC.ar(0.012073636054993), varWeed5850F2013279 * DC.ar(0.38724946975708), varWeed5850F2013279 * DC.ar(0.99657225608826), varWeed5850F2013279 * DC.ar(0.20440351963043), varWeed5850F2013279 * DC.ar(0.9454288482666), varWeed5850F2013279 * DC.ar(0.048242211341858), varWeed5850F2013279 * DC.ar(0.096088290214539), varWeed5850F2013279 * DC.ar(0.70123040676117), varWeed5850F2013279 * DC.ar(0.23300504684448)));

signal = varWeed5850F201327110;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Mad.2311201328
/////////////////////////////////////////////////////////

SynthDef.new("Mad.2311201328", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varMad23112013289, varMad231120132810, varMad231120132811, varMad231120132812;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varMad23112013289 = varMad231120132810 = varMad231120132811 = varMad231120132812 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varMad23112013289 = DoubleWell3.ar(wave * varMad231120132811, env * varMad231120132811, x, gateEnv * in, env, signal * varMad23112013289, 0.64219887340663 * varMad23112013289 * varMad231120132812, Silent.ar());
varMad231120132810 = DelayL.ar(0.13676404953003 * varMad23112013289 * modX, 0.49647867679596 * modY * modX, modY, YigClifford3DC.ar(wave * DC.ar(0.72062313556671), wave * DC.ar(0.60549879074097), wave * DC.ar(0.83755350112915), wave * DC.ar(0.77273750305176), wave * DC.ar(0.43230950832367), wave * DC.ar(0.62207293510437), wave * DC.ar(0.85862827301025), wave * DC.ar(0.08613920211792), wave * DC.ar(0.89681208133698), wave * DC.ar(0.85268270969391)), Silent.ar());
varMad231120132811 = CombN.ar(0.82265782356262 * modX * gateEnv, 0.92905795574188 * env * wave, signal * varMad231120132811, varMad23112013289 * varMad231120132812, 0.84170180166583 * modX, Silent.ar());
varMad231120132812 = LPCError.ar(y, 0.35043501853943 * varMad23112013289 * varMad23112013289, 0.56188851569669 * varMad231120132811 * modY, Silent.ar());
varMad23112013289 = OSFold8.ar(wave * DC.ar(0.57550621032715), wave * DC.ar(0.057541251182556), wave * DC.ar(0.44318866729736));
varMad231120132810 = Oregonator.ar(wave * DC.ar(0.30916607379913), wave * DC.ar(0.23235464096069), wave * DC.ar(0.72779428958893), wave * DC.ar(0.1433037519455), wave * DC.ar(0.81241619586945), wave * DC.ar(0.94962084293365), wave * DC.ar(0.36404454708099), wave * DC.ar(0.43004989624023), wave * DC.ar(0.27832841873169), wave * DC.ar(0.090187430381775));
varMad231120132811 = RMEQ.ar(wave * DC.ar(0.027237415313721), wave * DC.ar(0.99323165416718), wave * DC.ar(0.91545724868774), wave * DC.ar(0.40627002716064), wave * DC.ar(0.40189671516418), wave * DC.ar(0.34177815914154));
varMad231120132812 = AudioMSG.ar(amp, 0.55732357501984 * varMad23112013289 * modY, 0.99989804279081 * modY * varMad23112013289, Silent.ar());
varMad23112013289 = FoaTilt.ar(wave * DC.ar(0.29356968402863), wave * DC.ar(0.74598932266235), wave * DC.ar(0.95378410816193), wave * DC.ar(0.76943624019623));
varMad231120132810 = WrapSummer.ar(wave * DC.ar(0.49310970306396), wave * DC.ar(0.49321794509888), wave * DC.ar(0.28100156784058), wave * DC.ar(0.12834429740906), wave * DC.ar(0.48811268806458), wave * DC.ar(0.20135962963104));
varMad231120132811 = MeanTriggered.ar(wave * DC.ar(0.68135666847229), wave * DC.ar(0.82249546051025), wave * DC.ar(0.42517340183258), wave * DC.ar(0.64848554134369), wave * DC.ar(0.54256010055542));
varMad231120132812 = MembraneHexagon.ar(wave * DC.ar(0.83680629730225), wave * DC.ar(0.61758267879486), wave * DC.ar(0.91222810745239), wave * DC.ar(0.98073875904083), wave * DC.ar(0.26119256019592));

signal = varMad231120132812;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Bloodhound.Packed.PEC2013291
/////////////////////////////////////////////////////////

SynthDef.new("Bloodhound.Packed.PEC2013291", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varBloodhoundPackedPEC2013299, varBloodhoundPackedPEC20132910, varBloodhoundPackedPEC20132911, varBloodhoundPackedPEC20132912, varBloodhoundPackedPEC20132913, varBloodhoundPackedPEC201329114, varBloodhoundPackedPEC201329115;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varBloodhoundPackedPEC2013299 = varBloodhoundPackedPEC20132910 = varBloodhoundPackedPEC20132911 = varBloodhoundPackedPEC20132912 = varBloodhoundPackedPEC20132913 = varBloodhoundPackedPEC201329114 = varBloodhoundPackedPEC201329115 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varBloodhoundPackedPEC2013299 = SoftClipper4.ar(varBloodhoundPackedPEC20132913);
varBloodhoundPackedPEC20132910 = B2A.ar(0.99850022792816 * modY * signal, modZ * gateEnv, x, signal);
varBloodhoundPackedPEC20132911 = EnvDetect.ar(varBloodhoundPackedPEC20132912 * modY, z, varBloodhoundPackedPEC20132912 * env);
varBloodhoundPackedPEC20132912 = YigClifford3DC.ar(gateEnv * in, island, varBloodhoundPackedPEC20132912 * varBloodhoundPackedPEC2013299, wave * varBloodhoundPackedPEC20132913, modZ * signal, y, 0.36185121536255 * wave * varBloodhoundPackedPEC20132911, bufnum, 0.99985675003799 * AtsAmp.ar(wave * DC.ar(0.6741384267807), wave * DC.ar(0.31142663955688), wave * DC.ar(0.6953661441803), wave * DC.ar(0.1355072259903), wave * DC.ar(0.22680640220642)), Silent.ar().range(wave * DC.ar(0.32106351852417), wave * DC.ar(0.64197969436646)));
varBloodhoundPackedPEC20132913 = Pluck.ar(varBloodhoundPackedPEC201329114, wave * varBloodhoundPackedPEC20132911, TGaussRand.ar(wave * DC.ar(0.87599670886993), wave * DC.ar(0.43813097476959), wave * DC.ar(0.75138235092163), wave * DC.ar(0.84978055953979), wave * DC.ar(0.20007753372192)), varBloodhoundPackedPEC20132913 * gateEnv, 0.59662890434265 * AudioMSG.ar(wave * DC.ar(0.42949604988098), wave * DC.ar(0.33098459243774), wave * DC.ar(0.6604996919632), wave * DC.ar(0.59299552440643)), t_trig, 0.9987966784699 * env * modZ, Silent.ar());
varBloodhoundPackedPEC2013299 = LFClipNoise.ar(signal, varBloodhoundPackedPEC20132912, Silent.ar().minNyquist());
varBloodhoundPackedPEC20132910 = Standard2DC.ar(wave * DC.ar(0.4736955165863), wave * DC.ar(0.67431581020355), wave * DC.ar(0.37631595134735), wave * DC.ar(0.54346120357513), wave * DC.ar(0.45400786399841), wave * DC.ar(0.90708196163177), wave * DC.ar(0.43549621105194));
varBloodhoundPackedPEC20132911 = LFBrownNoise1.ar(modY * varBloodhoundPackedPEC20132911, gateEnv.unipolar(wave * DC.ar(0.24328351020813)), in, 0.99984817319709 * modZ * varBloodhoundPackedPEC201329115, Silent.ar());
varBloodhoundPackedPEC20132912 = Timer.ar(YigCliffordC.ar(wave * DC.ar(0.64247798919678), wave * DC.ar(0.082145929336548), wave * DC.ar(0.33910202980042), wave * DC.ar(0.6917941570282), wave * DC.ar(0.13235425949097), wave * DC.ar(0.68692827224731), wave * DC.ar(0.45536983013153), wave * DC.ar(0.89216899871826), wave * DC.ar(0.06734025478363)));
varBloodhoundPackedPEC20132913 = Slew.ar(0.9744588136673 * varBloodhoundPackedPEC201329114 * signal, gateEnv, env, 0.96277383736979 * varBloodhoundPackedPEC2013299, Silent.ar());
varBloodhoundPackedPEC2013299 = Clip.ar(wave * DC.ar(0.37291967868805), wave * DC.ar(0.26229441165924), wave * DC.ar(0.28529798984528));
varBloodhoundPackedPEC20132910 = SVF.ar(wave * DC.ar(0.33024799823761), wave * DC.ar(0.48569023609161), wave * DC.ar(0.45291316509247), wave * DC.ar(0.6815013885498), wave * DC.ar(0.64835715293884), wave * DC.ar(0.80634307861328), wave * DC.ar(0.25847661495209), wave * DC.ar(0.9999006986618), wave * DC.ar(0.46575009822845), wave * DC.ar(0.4106285572052));
varBloodhoundPackedPEC20132911 = COsc.ar(wave * DC.ar(0.33835625648499), wave * DC.ar(0.79070627689362), wave * DC.ar(0.99584448337555), wave * DC.ar(0.57492053508759), wave * DC.ar(0.89830124378204));
varBloodhoundPackedPEC20132912 = FreqShift.ar(wave * DC.ar(0.34535932540894), wave * DC.ar(0.14502668380737), wave * DC.ar(0.51779532432556), wave * DC.ar(0.67420303821564), wave * DC.ar(0.64328598976135));
varBloodhoundPackedPEC20132913 = TIRand.ar(wave * DC.ar(0.39417231082916), wave * DC.ar(0.34279096126556), wave * DC.ar(0.29893589019775));
// Variation test code
varBloodhoundPackedPEC201329114 = Convolution2.ar(island, varBloodhoundPackedPEC201329115 * in, varBloodhoundPackedPEC20132910 * varBloodhoundPackedPEC20132912, gate, 0.99996300935072 * in * modX, Silent.ar());
varBloodhoundPackedPEC201329115 = Lag3UD.ar(y, varBloodhoundPackedPEC201329114 * varBloodhoundPackedPEC20132912, island, 0.9999865576996 * BBandPass.ar(varBloodhoundPackedPEC2013299 * DC.ar(0.20220983028412), varBloodhoundPackedPEC20132911 * DC.ar(0.60490560531616), varBloodhoundPackedPEC20132912 * DC.ar(0.45032823085785), varBloodhoundPackedPEC20132913 * DC.ar(0.26483833789825), varBloodhoundPackedPEC20132913 * DC.ar(0.35364270210266)), Silent.ar());
varBloodhoundPackedPEC201329114 = StkBeeThree.ar(varBloodhoundPackedPEC20132913 * varBloodhoundPackedPEC201329114, gateEnv * wave, wave * modZ, y, z, env * env, env * varBloodhoundPackedPEC20132910, BufCombL.ar(varBloodhoundPackedPEC20132911 * DC.ar(0.51907801628113), varBloodhoundPackedPEC2013299 * DC.ar(0.52570307254791), varBloodhoundPackedPEC2013299 * DC.ar(0.83379793167114), varBloodhoundPackedPEC20132912 * DC.ar(0.96748197078705), varBloodhoundPackedPEC20132910 * DC.ar(0.32834851741791), varBloodhoundPackedPEC20132910 * DC.ar(0.3362010717392)), Silent.ar());
varBloodhoundPackedPEC201329115 = UHJ2B.ar(0.17618668079376 * varBloodhoundPackedPEC20132910 * modX, varBloodhoundPackedPEC20132913 * in);
varBloodhoundPackedPEC201329114 = TPV.ar(in, varBloodhoundPackedPEC201329114, varBloodhoundPackedPEC2013299 * in, modY * env, varBloodhoundPackedPEC201329114, 0.99984227983339 * env * modX, modX * modX, varBloodhoundPackedPEC201329115 * varBloodhoundPackedPEC201329115, 0.99981933774725 * varBloodhoundPackedPEC201329114, DoubleWell2.ar(varBloodhoundPackedPEC2013299 * DC.ar(0.093661785125732), varBloodhoundPackedPEC20132911 * DC.ar(0.76734304428101), varBloodhoundPackedPEC20132913 * DC.ar(0.97008204460144), varBloodhoundPackedPEC20132912 * DC.ar(0.18390786647797), varBloodhoundPackedPEC20132912 * DC.ar(0.091985821723938), varBloodhoundPackedPEC20132911 * DC.ar(0.74354481697083), varBloodhoundPackedPEC20132910 * DC.ar(0.73689365386963), varBloodhoundPackedPEC20132910 * DC.ar(0.24025297164917), varBloodhoundPackedPEC20132910 * DC.ar(0.045144081115723), varBloodhoundPackedPEC2013299 * DC.ar(0.098325610160828)));
varBloodhoundPackedPEC201329115 = InGrainIBF.ar(LFDNoise3.ar(varBloodhoundPackedPEC2013299 * DC.ar(0.70310211181641), varBloodhoundPackedPEC2013299 * DC.ar(0.77445268630981), varBloodhoundPackedPEC20132913 * DC.ar(0.99740648269653)), FoaDominateX.ar(varBloodhoundPackedPEC20132910, modZ * varBloodhoundPackedPEC201329115, Gendy4.ar(varBloodhoundPackedPEC20132912 * DC.ar(0.75463652610779), varBloodhoundPackedPEC2013299 * DC.ar(0.079095482826233), varBloodhoundPackedPEC20132912 * DC.ar(0.77910590171814), varBloodhoundPackedPEC20132913 * DC.ar(0.82264959812164), varBloodhoundPackedPEC20132913 * DC.ar(0.099083662033081), varBloodhoundPackedPEC20132912 * DC.ar(0.7537328004837), varBloodhoundPackedPEC20132912 * DC.ar(0.94166016578674), varBloodhoundPackedPEC20132911 * DC.ar(0.90548515319824), varBloodhoundPackedPEC20132910 * DC.ar(0.80444943904877), varBloodhoundPackedPEC2013299 * DC.ar(0.17840278148651), varBloodhoundPackedPEC20132913 * DC.ar(0.98335087299347), varBloodhoundPackedPEC20132912 * DC.ar(0.030065655708313)), Silent.ar()), modY * varBloodhoundPackedPEC20132911, bufnum, bufnum, gate, wave * varBloodhoundPackedPEC201329115, modY * signal, gateEnv, modX * in, varBloodhoundPackedPEC20132912, Silent.ar());

signal = varBloodhoundPackedPEC201329115;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// W97M.Leonor.A201329
/////////////////////////////////////////////////////////

SynthDef.new("W97M.Leonor.A201329", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varW97MLeonorA2013299;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varW97MLeonorA2013299 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varW97MLeonorA2013299 = WhiteNoise.ar(0.070659388328691 * Integrator.ar(wave * DC.ar(0.63289201259613), wave * DC.ar(0.26731967926025), wave * DC.ar(0.48548245429993), wave * DC.ar(0.056546211242676)), Silent.ar());
varW97MLeonorA2013299 = GlitchRHPF.ar(wave * DC.ar(0.69279432296753), wave * DC.ar(0.38629949092865), wave * DC.ar(0.21893215179443), wave * DC.ar(0.76038765907288), wave * DC.ar(0.37164652347565));
varW97MLeonorA2013299 = Pulse.ar(wave * DC.ar(0.18084788322449), wave * DC.ar(0.080039620399475), wave * DC.ar(0.68681669235229), wave * DC.ar(0.86162328720093));

signal = varW97MLeonorA2013299;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Australian.990201329
/////////////////////////////////////////////////////////

SynthDef.new("Australian.990201329", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varAustralian9902013299;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varAustralian9902013299 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varAustralian9902013299 = SOS.ar(varAustralian9902013299, 0.66573309898376 * modY * modX, modZ * modZ, in, 0.87510907649994 * Decimator.ar(wave * DC.ar(0.18062233924866), wave * DC.ar(0.12186467647552), wave * DC.ar(0.94545578956604), wave * DC.ar(0.71753180027008), wave * DC.ar(0.11992919445038)), modX, in, Silent.ar());
varAustralian9902013299 = BiPanB2.ar(wave * DC.ar(0.7663654088974), wave * DC.ar(0.51605188846588), wave * DC.ar(0.73532366752625), wave * DC.ar(0.67034482955933));
varAustralian9902013299 = FoaAsymmetry.ar(wave * DC.ar(0.9018052816391), wave * DC.ar(0.4964804649353), wave * DC.ar(0.10769927501678), wave * DC.ar(0.80747640132904));

signal = varAustralian9902013299;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Bad_COM.600201331
/////////////////////////////////////////////////////////

SynthDef.new("Bad_COM.600201331", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varBad_COM6002013319, varBad_COM60020133110, varBad_COM60020133111, varBad_COM60020133112, varBad_COM60020133113;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varBad_COM6002013319 = varBad_COM60020133110 = varBad_COM60020133111 = varBad_COM60020133112 = varBad_COM60020133113 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varBad_COM6002013319 = Lorenz2DN.ar(varBad_COM60020133113, env * modY, modX, varBad_COM6002013319, 0.022521257400513 * varBad_COM60020133111 * wave, 0.55697524547577 * env * varBad_COM6002013319, bufnum, 0.34111106395721 * FoaPushY.ar(wave * DC.ar(0.86020076274872), wave * DC.ar(0.94777858257294), wave * DC.ar(0.37458860874176), wave * DC.ar(0.02065646648407)), signal * env, 0.15489342922179 * in * in, Tilt.ar(wave * DC.ar(0.056383967399597), wave * DC.ar(0.031325697898865), wave * DC.ar(0.10698485374451), wave * DC.ar(0.92141819000244), wave * DC.ar(0.86678326129913)));
varBad_COM60020133110 = RedPhasor.ar(varBad_COM60020133110 * env, z, z, gateEnv * varBad_COM6002013319, gateEnv * in, varBad_COM6002013319 * modY, signal * varBad_COM60020133111);
varBad_COM60020133111 = BHiPass.ar(x, signal, varBad_COM60020133113, 0.99989421153568 * env * env, Silent.ar());
varBad_COM60020133112 = LeastChange.ar(signal * env, modX);
varBad_COM60020133113 = IndexInBetween.ar(Array.fill(2.pow(16), { |i| rrand(-1, 1) }).as(LocalBuf), island, in, Silent.ar());
varBad_COM6002013319 = QuadL.ar(modY * modX, island, signal, x, signal * varBad_COM60020133111, 0.99795887580846 * modZ * in, Silent.ar());
varBad_COM60020133110 = CombFormlet.ar(wave * DC.ar(0.25952243804932), wave * DC.ar(0.55932366847992), wave * DC.ar(0.045435190200806), wave * DC.ar(0.88968539237976), wave * DC.ar(0.25506198406219), wave * DC.ar(0.48847079277039), wave * DC.ar(0.45837843418121));
varBad_COM60020133111 = SinOsc.ar(wave * DC.ar(0.29086077213287), wave * DC.ar(0.60902786254883), wave * DC.ar(0.64528870582581), wave * DC.ar(0.67886304855347));
varBad_COM60020133112 = FBSineC.ar(wave * DC.ar(0.72533655166626), wave * DC.ar(0.48931622505188), wave * DC.ar(0.015824913978577), wave * DC.ar(0.4426908493042), wave * DC.ar(0.93820786476135), wave * DC.ar(0.10104775428772), wave * DC.ar(0.067017912864685), wave * DC.ar(0.0051928758621216), wave * DC.ar(0.43667459487915));
varBad_COM60020133113 = RunningMin.ar(modZ * wave, in * wave);
varBad_COM6002013319 = Tumble.ar(wave * DC.ar(0.93333899974823), wave * DC.ar(0.22661077976227), wave * DC.ar(0.95668470859528), wave * DC.ar(0.29205322265625), wave * DC.ar(0.77223634719849));
varBad_COM60020133110 = Sweep.ar(wave * DC.ar(0.8128114938736), wave * DC.ar(0.9974353313446));
varBad_COM60020133111 = NTube.ar(wave * DC.ar(0.086408495903015), wave * DC.ar(0.36447966098785), wave * DC.ar(0.96454977989197), wave * DC.ar(0.18992221355438), wave * DC.ar(0.7340008020401), wave * DC.ar(0.78618669509888));
varBad_COM60020133112 = PitchShift.ar(wave * DC.ar(0.4840327501297), wave * DC.ar(0.6851794719696), wave * DC.ar(0.76128017902374), wave * DC.ar(0.14676535129547), wave * DC.ar(0.54159379005432), wave * DC.ar(0.48125112056732), wave * DC.ar(0.63212990760803));
varBad_COM60020133113 = Latoocarfian2DN.ar(wave * DC.ar(0.90660202503204), wave * DC.ar(0.29669332504272), wave * DC.ar(0.77279901504517), wave * DC.ar(0.32196664810181), wave * DC.ar(0.94295942783356), wave * DC.ar(0.25395798683167), wave * DC.ar(0.10335314273834), wave * DC.ar(0.66531264781952), wave * DC.ar(0.30214691162109), wave * DC.ar(0.88125157356262));

signal = varBad_COM60020133113;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Emmie.24402013321
/////////////////////////////////////////////////////////

SynthDef.new("Emmie.24402013321", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varEmmie24402013329, varEmmie244020133210, varEmmie2440201332111;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varEmmie24402013329 = varEmmie244020133210 = varEmmie2440201332111 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varEmmie24402013329 = CrossoverDistortion.ar(varEmmie244020133210 * modZ, modZ * modZ, bufnum, LorenzTrig.ar(wave * DC.ar(0.50168192386627), wave * DC.ar(0.31412220001221), wave * DC.ar(0.89220416545868), wave * DC.ar(0.45555245876312), wave * DC.ar(0.29167664051056), wave * DC.ar(0.65347731113434), wave * DC.ar(0.2854608297348), wave * DC.ar(0.32075703144073), wave * DC.ar(0.65548300743103), wave * DC.ar(0.6879917383194), wave * DC.ar(0.65768957138062)), Silent.ar());
varEmmie244020133210 = YigCliffordN.ar(modZ, varEmmie244020133210, wave, 0.52425754070282 * wave * in, 0.60900747776031 * gateEnv * env, t_trig, wave, modX, Silent.ar());
varEmmie24402013329 = Vibrato.ar(wave * DC.ar(0.5100063085556), wave * DC.ar(0.078023672103882), wave * DC.ar(0.65034890174866), wave * DC.ar(0.55405151844025), wave * DC.ar(0.8337094783783), wave * DC.ar(0.21696305274963), wave * DC.ar(0.44643092155457), wave * DC.ar(0.97459602355957));
varEmmie244020133210 = CombN.ar(wave * DC.ar(0.87659561634064), wave * DC.ar(0.28969883918762), wave * DC.ar(0.21399438381195), wave * DC.ar(0.67017412185669), wave * DC.ar(0.67553913593292), wave * DC.ar(0.48293113708496));
varEmmie24402013329 = WrapIndex.ar(wave * DC.ar(0.63356363773346), wave * DC.ar(0.61272132396698), wave * DC.ar(0.23494589328766), wave * DC.ar(0.63246536254883));
varEmmie244020133210 = DriveNoise.ar(wave * DC.ar(0.56906354427338), wave * DC.ar(0.77188384532928), wave * DC.ar(0.96106374263763));
// Variation test code
varEmmie2440201332111 = YigClifford3DN.ar(wave * modX, modY, in, in, 0.6827164888382 * gateEnv * signal, bufnum, varEmmie2440201332111 * modY, in * gateEnv, 0.99982470150725 * varEmmie244020133210 * varEmmie24402013329, Silent.ar());
varEmmie2440201332111 = AtsBand.ar(Array.fill(2.pow(15), { |i| rrand(-1, 1) }).as(LocalBuf), z, amp, 0.99990179348029 * env * varEmmie244020133210, Silent.ar());
varEmmie2440201332111 = TRand.ar(wave.lag3ud(varEmmie244020133210 * DC.ar(0.79078149795532), varEmmie24402013329 * DC.ar(0.53772604465485)), modZ * gateEnv, FincoSprottM.ar(varEmmie244020133210 * DC.ar(0.61857342720032), varEmmie244020133210 * DC.ar(0.25177919864655), varEmmie244020133210 * DC.ar(0.039206981658936), varEmmie24402013329 * DC.ar(0.084214448928833), varEmmie244020133210 * DC.ar(0.52666854858398), varEmmie24402013329 * DC.ar(0.18598020076752), varEmmie244020133210 * DC.ar(0.42037689685822), varEmmie24402013329 * DC.ar(0.39580154418945), varEmmie244020133210 * DC.ar(0.53991055488586)));

signal = varEmmie2440201332111;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Black2013331
/////////////////////////////////////////////////////////

SynthDef.new("Black2013331", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varBlack2013339, varBlack20133310, varBlack20133311, varBlack20133312, varBlack201333113;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varBlack2013339 = varBlack20133310 = varBlack20133311 = varBlack20133312 = varBlack201333113 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varBlack2013339 = Compander.ar(island, t_trig, gateEnv * varBlack20133311, 0.33236122131348 * signal * env, varBlack20133310 * modX, wave, 0.86143004894257 * varBlack201333113 * varBlack20133311, varBlack201333113.excess(DoubleWell2.ar(wave * DC.ar(0.73880636692047), wave * DC.ar(0.27642357349396), wave * DC.ar(0.73733305931091), wave * DC.ar(0.59813463687897), wave * DC.ar(0.50983452796936), wave * DC.ar(0.18324339389801), wave * DC.ar(0.16716039180756), wave * DC.ar(0.88352024555206), wave * DC.ar(0.0084927082061768), wave * DC.ar(0.63607048988342))), Silent.ar());
varBlack20133310 = Lag3UD.ar(varBlack20133312 * modY, varBlack20133310, bufnum, 0.9979501438851 * wave * varBlack20133311, Silent.ar());
varBlack20133311 = LADSPA.ar(2, env, modY);
varBlack20133312 = OSTrunc8.ar(island, amp);
varBlack2013339 = Ball.ar(wave * DC.ar(0.13517153263092), wave * DC.ar(0.87073564529419), wave * DC.ar(0.34603536128998), wave * DC.ar(0.8691713809967));
varBlack20133310 = AmplitudeMod.ar(z, 0.96300292015076 * env * gateEnv, varBlack20133311 * modY, 0.99997363718494 * varBlack201333113 * modY, Silent.ar());
varBlack20133311 = TTendency.ar(Select.ar(wave * DC.ar(0.097805261611938), wave * DC.ar(0.48006653785706)), in * varBlack2013339, signal, z, FoaDirectO.ar(wave * DC.ar(0.65063321590424), wave * DC.ar(0.14031255245209), wave * DC.ar(0.5453085899353), wave * DC.ar(0.4670193195343)), modX);
varBlack20133312 = ReplaceOut.ar((80 + (island * 2)), [LFGauss.ar(wave * DC.ar(0.62231290340424), wave * DC.ar(0.79606688022614), wave * DC.ar(0.7770516872406), wave * DC.ar(0.32066237926483), wave * DC.ar(0.34791707992554)), BBandPass.ar(wave * DC.ar(0.11561751365662), wave * DC.ar(0.85386061668396), wave * DC.ar(0.32157802581787), wave * DC.ar(0.62764739990234), wave * DC.ar(0.3766405582428))]);
varBlack2013339 = FoaPushZ.ar(wave * DC.ar(0.074899315834045), wave * DC.ar(0.98689103126526), wave * DC.ar(0.21099650859833), wave * DC.ar(0.017955780029297));
varBlack20133310 = PeakEQ4.ar(wave * DC.ar(0.86803770065308), wave * DC.ar(0.98185253143311), wave * DC.ar(0.07930052280426), wave * DC.ar(0.51382219791412));
varBlack20133311 = Ramp.ar(wave * DC.ar(0.42439126968384), wave * DC.ar(0.11992871761322), wave * DC.ar(0.25778543949127), wave * DC.ar(0.068739652633667));
varBlack20133312 = QuadL.ar(wave * DC.ar(0.17877745628357), wave * DC.ar(0.90806758403778), wave * DC.ar(0.6617910861969), wave * DC.ar(0.43962025642395), wave * DC.ar(0.024346947669983), wave * DC.ar(0.25161302089691), wave * DC.ar(0.7604398727417));
// Variation test code
varBlack201333113 = LPCError.ar(modZ, env, 0.99990124855034 * in * wave, Silent.ar());
varBlack201333113 = SinGrain.ar(modZ * in, bufnum, varBlack20133310, FoaDirectY.ar(varBlack20133312 * DC.ar(0.9655818939209), varBlack20133311 * DC.ar(0.51268553733826), varBlack20133312 * DC.ar(0.38541436195374), varBlack2013339 * DC.ar(0.25047194957733)), VOSIM.ar(varBlack20133311 * DC.ar(0.24735534191132), varBlack20133312 * DC.ar(0.64247488975525), varBlack20133311 * DC.ar(0.26060962677002), varBlack2013339 * DC.ar(0.10634779930115), varBlack2013339 * DC.ar(0.3353511095047), varBlack2013339 * DC.ar(0.89461839199066)));
varBlack201333113 = FMHEncode1.ar(signal, signal, gateEnv * modX, t_trig, varBlack20133310, varBlack20133310 * in);

signal = varBlack201333113;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// _8842013341
/////////////////////////////////////////////////////////

SynthDef.new("_8842013341", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, var_8842013349, var_88420133410, var_884201334111, var_884201334112, var_884201334113, var_884201334114;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = var_8842013349 = var_88420133410 = var_884201334111 = var_884201334112 = var_884201334113 = var_884201334114 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
var_8842013349 = GrainSin.ar(2, modY * var_884201334111, modY * modX, var_884201334113 * modY, Compander.ar(wave * DC.ar(0.68084228038788), wave * DC.ar(0.28872525691986), wave * DC.ar(0.79822552204132), wave * DC.ar(0.62930309772491), wave * DC.ar(0.37814652919769), wave * DC.ar(0.41206109523773), wave * DC.ar(0.66656112670898), wave * DC.ar(0.54284167289734), wave * DC.ar(0.9056715965271)), bufnum, var_8842013349 * modZ, OnePole.ar(wave * DC.ar(0.87217092514038), wave * DC.ar(0.68804407119751), wave * DC.ar(0.8012843132019), wave * DC.ar(0.81865978240967)), Silent.ar());
var_88420133410 = VBAP.ar(2, env * var_8842013349, Array.fill(2.pow(15), { |i| rrand(-1, 1) }).as(LocalBuf), modY * modZ, var_884201334114 * var_884201334114, var_884201334113);
var_8842013349 = LorenzL.ar(wave * DC.ar(0.70410680770874), wave * DC.ar(0.13943779468536), wave * DC.ar(0.50016522407532), wave * DC.ar(0.60520339012146), wave * DC.ar(0.0022504329681396), wave * DC.ar(0.17611885070801), wave * DC.ar(0.042602896690369), wave * DC.ar(0.86032259464264), wave * DC.ar(0.83497726917267), wave * DC.ar(0.23317968845367));
var_88420133410 = Fhn2DN.ar(wave * DC.ar(0.94924986362457), wave * DC.ar(0.34890508651733), wave * DC.ar(0.48649966716766), wave * DC.ar(0.31726717948914), wave * DC.ar(0.70871520042419), wave * DC.ar(0.84458231925964), wave * DC.ar(0.8921834230423), wave * DC.ar(0.98739194869995), wave * DC.ar(0.94275557994843), wave * DC.ar(0.73812198638916), wave * DC.ar(0.24875962734222));
var_8842013349 = TextVU.ar(wave * DC.ar(0.84770965576172), wave * DC.ar(0.94808495044708), wave * DC.ar(0.65912759304047), wave * DC.ar(0.29819548130035), wave * DC.ar(0.61030888557434), wave * DC.ar(0.71913063526154));
var_88420133410 = PanB.ar(wave * DC.ar(0.12797939777374), wave * DC.ar(0.95660471916199), wave * DC.ar(0.01629912853241), wave * DC.ar(0.85737133026123));
// Variation test code
var_884201334111 = LPZ1.ar(var_88420133410, 0.99876950447296 * var_884201334114 * modZ, Silent.ar());
var_884201334112 = Oregonator.ar(gateEnv * var_884201334113, modX, var_884201334111, signal, DetectIndex.ar(Array.fill(2.pow(16), { |i| rrand(-1, 1) }).as(LocalBuf), modZ * signal, ZeroCrossing.ar(var_8842013349 * DC.ar(0.52333867549896)), Silent.ar()), modY, wave * modY, gateEnv * modZ, 0.99967622021077 * var_8842013349 * var_8842013349, StkMoog.ar(var_8842013349 * DC.ar(0.12308371067047), var_8842013349 * DC.ar(0.98987710475922), var_8842013349 * DC.ar(0.8734358549118), var_8842013349 * DC.ar(0.97852671146393), var_8842013349 * DC.ar(0.23975992202759), var_88420133410 * DC.ar(0.88099503517151), var_8842013349 * DC.ar(0.94549298286438), var_8842013349 * DC.ar(0.01593542098999), var_8842013349 * DC.ar(0.30518174171448)));
var_884201334113 = BBandPass.ar(modY * var_8842013349, wave, var_884201334113 * var_884201334111, env, Silent.ar());
var_884201334114 = Out.ar((80 + (island * 2)), [FMGrainIBF.ar(var_88420133410 * DC.ar(0.45394718647003), var_88420133410 * DC.ar(0.7774955034256), var_8842013349 * DC.ar(0.76705980300903), var_8842013349 * DC.ar(0.23874735832214), var_8842013349 * DC.ar(0.36316621303558), var_88420133410 * DC.ar(0.3478729724884), var_88420133410 * DC.ar(0.53339874744415), var_88420133410 * DC.ar(0.63638758659363), var_8842013349 * DC.ar(0.58598458766937), var_88420133410 * DC.ar(0.05773663520813), var_8842013349 * DC.ar(0.8722962141037), var_88420133410 * DC.ar(0.98712575435638), var_8842013349 * DC.ar(0.013565421104431), var_8842013349 * DC.ar(0.24947905540466)), BLBufRd.ar(var_88420133410 * DC.ar(0.50714027881622), var_8842013349 * DC.ar(0.99559712409973), var_8842013349 * DC.ar(0.15693533420563))]);
var_884201334111 = Impulse.ar(var_88420133410 * var_88420133410, var_884201334113 * in, in, Silent.ar());
var_884201334112 = BufDelayL.ar(Array.fill(2.pow(13), { |i| rrand(-1, 1) }).as(LocalBuf), var_884201334114 * wave, var_884201334114 * modX, env, Silent.ar().sqrdif(Allpass1.ar(var_8842013349 * DC.ar(0.60900318622589), var_88420133410 * DC.ar(0.9041576385498), var_8842013349 * DC.ar(0.84504222869873), var_88420133410 * DC.ar(0.91427671909332))));
var_884201334113 = SetResetFF.ar(wave * var_884201334111, var_884201334114 * signal);
var_884201334114 = StandardL.ar(var_884201334112 * var_884201334113, modZ * var_88420133410, x, in * var_884201334112, signal, Silent.ar());
var_884201334111 = MoogLadder.ar(signal, var_88420133410, var_8842013349 * in, 0.99994819971915 * var_884201334111, Silent.ar());
var_884201334112 = LPCVals.ar(Array.fill(2.pow(16), { |i| rrand(-1, 1) }).as(LocalBuf), modZ * var_88420133410);
var_884201334113 = Sweep.ar(env * var_884201334111, 0.48614585399628 * modZ * wave);
var_884201334114 = AtsNoise.ar(Array.fill(2.pow(14), { |i| rrand(-1, 1) }).as(LocalBuf), z, island, 0.80605147570573 * modX * var_8842013349, Silent.ar());

signal = var_884201334114;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// HLLP.5540201336
/////////////////////////////////////////////////////////

SynthDef.new("HLLP.5540201336", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varHLLP55402013369;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varHLLP55402013369 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varHLLP55402013369 = Gbman2DN.ar(gateEnv * modZ, modX * in, 0.71393942832947 * signal * modY, gateEnv, 0.99948007614714 * modZ * gateEnv, Silent.ar());
varHLLP55402013369 = OSFold8.ar(wave * DC.ar(0.29673290252686), wave * DC.ar(0.55911004543304), wave * DC.ar(0.091176867485046));
varHLLP55402013369 = FincoSprottS.ar(wave * DC.ar(0.64626157283783), wave * DC.ar(0.0042331218719482), wave * DC.ar(0.32993948459625), wave * DC.ar(0.34616136550903), wave * DC.ar(0.29000568389893), wave * DC.ar(0.71415627002716), wave * DC.ar(0.87364315986633), wave * DC.ar(0.012720465660095), wave * DC.ar(0.21072292327881));

signal = varHLLP55402013369;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// W32.HLLP.XINF.18432201339
/////////////////////////////////////////////////////////

SynthDef.new("W32.HLLP.XINF.18432201339", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varW32HLLPXINF184322013399;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varW32HLLPXINF184322013399 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varW32HLLPXINF184322013399 = QuadN.ar(HenonL.ar(wave * DC.ar(0.99516808986664), wave * DC.ar(0.86580348014832), wave * DC.ar(0.60731780529022), wave * DC.ar(0.10612058639526), wave * DC.ar(0.80333042144775), wave * DC.ar(0.4796462059021), wave * DC.ar(0.71947431564331)).exprange(1, SampleRate.ir), gateEnv * modY, env * modZ, wave * varW32HLLPXINF184322013399, gateEnv * in, OnePole.ar(wave * DC.ar(0.29255902767181), wave * DC.ar(0.71908140182495), wave * DC.ar(0.90098297595978), wave * DC.ar(0.23875617980957)), Silent.ar());
varW32HLLPXINF184322013399 = PlayBuf.ar(2, Array.fill(2.pow(16), { |i| rrand(-1, 1) }).as(LocalBuf), modX * varW32HLLPXINF184322013399, Trig.ar(wave * DC.ar(0.95829105377197), wave * DC.ar(0.68944561481476)), signal * gateEnv, t_trig, in);
varW32HLLPXINF184322013399 = SawDPW.ar(wave * DC.ar(0.86256277561188), wave * DC.ar(0.044324040412903), wave * DC.ar(0.37924122810364), wave * DC.ar(0.86633086204529));

signal = varW32HLLPXINF184322013399;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Tiny.134201339
/////////////////////////////////////////////////////////

SynthDef.new("Tiny.134201339", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varTiny1342013399, varTiny13420133910, varTiny13420133911, varTiny13420133912, varTiny13420133913;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varTiny1342013399 = varTiny13420133910 = varTiny13420133911 = varTiny13420133912 = varTiny13420133913 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varTiny1342013399 = Breakcore.ar(Array.fill(2.pow(11), { |i| rrand(-1, 1) }).as(LocalBuf).lag3ud(wave * DC.ar(0.756138920784), wave * DC.ar(0.14262652397156)), in, wave * varTiny13420133913, gateEnv * varTiny13420133913, 0.86693155765533 * varTiny1342013399 * env);
varTiny13420133910 = TGrains2.ar(2, varTiny1342013399 * modY, Array.fill(2.pow(11), { |i| rrand(-1, 1) }).as(LocalBuf), bufnum, gateEnv * modY, varTiny13420133913 * wave, in * modX, signal * modZ, varTiny13420133912 * modX, varTiny13420133910 * env, in * varTiny13420133911);
varTiny13420133911 = XFade2.ar(DegreeToKey.ar(wave * DC.ar(0.04783308506012), wave * DC.ar(0.52595102787018), wave * DC.ar(0.4259614944458), wave * DC.ar(0.3872743844986), wave * DC.ar(0.96695876121521)), wave * varTiny13420133913, 0.98547339439392 * signal * varTiny13420133913, z);
varTiny13420133912 = NTube.ar(gateEnv * modY, [InGrainBF.ar(wave * DC.ar(0.4375536441803), wave * DC.ar(0.17058026790619), wave * DC.ar(0.20749521255493), wave * DC.ar(0.51130151748657), wave * DC.ar(0.23645770549774), wave * DC.ar(0.90816760063171), wave * DC.ar(0.80579876899719), wave * DC.ar(0.84077775478363), wave * DC.ar(0.85399496555328)), DetectIndex.ar(wave * DC.ar(0.50580906867981), wave * DC.ar(0.95457184314728), wave * DC.ar(0.064366340637207), wave * DC.ar(0.51316237449646))], [Latoocarfian2DN.ar(wave * DC.ar(0.30090272426605), wave * DC.ar(0.73409330844879), wave * DC.ar(0.0012156963348389), wave * DC.ar(0.23793518543243), wave * DC.ar(0.47475552558899), wave * DC.ar(0.41542029380798), wave * DC.ar(0.51049876213074), wave * DC.ar(0.058376789093018), wave * DC.ar(0.43072891235352), wave * DC.ar(0.75165736675262)), BufAllpassC.ar(wave * DC.ar(0.29436802864075), wave * DC.ar(0.26502585411072), wave * DC.ar(0.5132749080658), wave * DC.ar(0.43356645107269), wave * DC.ar(0.874880194664), wave * DC.ar(0.65218484401703))], [Wrap.ar(wave * DC.ar(0.16186261177063), wave * DC.ar(0.25062680244446), wave * DC.ar(0.43175888061523)), Fold.ar(wave * DC.ar(0.68515467643738), wave * DC.ar(0.42817866802216), wave * DC.ar(0.2989501953125))], 0.67509059014839 * FoaTumble.ar(wave * DC.ar(0.54537832736969), wave * DC.ar(0.64302313327789), wave * DC.ar(0.77267098426819), wave * DC.ar(0.38592779636383)), Silent.ar());
varTiny13420133913 = Klang.ar(`[[FMGrainI.ar(wave * DC.ar(0.70558726787567), wave * DC.ar(0.97517096996307), wave * DC.ar(0.29993891716003), wave * DC.ar(0.40665185451508), wave * DC.ar(0.0053110122680664), wave * DC.ar(0.16912007331848), wave * DC.ar(0.66919958591461), wave * DC.ar(0.44502127170563), wave * DC.ar(0.34801876544952), wave * DC.ar(0.47052073478699)), Perlin3.ar(wave * DC.ar(0.27088940143585), wave * DC.ar(0.55461776256561), wave * DC.ar(0.014865636825562))], [RMShelf.ar(wave * DC.ar(0.72750198841095), wave * DC.ar(0.24799501895905), wave * DC.ar(0.80416369438171), wave * DC.ar(0.71862924098969), wave * DC.ar(0.8899347782135)), FoaAsymmetry.ar(wave * DC.ar(0.57124590873718), wave * DC.ar(0.8222348690033), wave * DC.ar(0.079315900802612), wave * DC.ar(0.34363305568695))], [PSinGrain.ar(wave * DC.ar(0.90033602714539), wave * DC.ar(0.05691385269165), wave * DC.ar(0.43571984767914)), Vibrato.ar(wave * DC.ar(0.81173825263977), wave * DC.ar(0.71281671524048), wave * DC.ar(0.096186637878418), wave * DC.ar(0.12259674072266), wave * DC.ar(0.34552729129791), wave * DC.ar(0.50290262699127), wave * DC.ar(0.036689043045044), wave * DC.ar(0.24933421611786))]], modX, signal);
varTiny1342013399 = AY.ar(wave * DC.ar(0.35088956356049), wave * DC.ar(0.12702322006226), wave * DC.ar(0.52122128009796), wave * DC.ar(0.31235730648041), wave * DC.ar(0.69244122505188), wave * DC.ar(0.18853402137756), wave * DC.ar(0.99061715602875), wave * DC.ar(0.89813709259033), wave * DC.ar(0.43037748336792), wave * DC.ar(0.66856229305267), wave * DC.ar(0.34388625621796), wave * DC.ar(0.75638329982758), wave * DC.ar(0.80738985538483));
varTiny13420133910 = SinGrainBF.ar(signal * varTiny13420133913, varTiny13420133911, varTiny13420133913 * signal, t_trig, gateEnv, 0.043903112411499 * modZ * wave, env, BufGrainBBF.ar(wave * DC.ar(0.30375945568085), wave * DC.ar(0.90723836421967), wave * DC.ar(0.71807980537415), wave * DC.ar(0.29508769512177), wave * DC.ar(0.24568212032318), wave * DC.ar(0.51775908470154), wave * DC.ar(0.85640728473663), wave * DC.ar(0.027060627937317), wave * DC.ar(0.40318191051483), wave * DC.ar(0.20077848434448), wave * DC.ar(0.15186619758606), wave * DC.ar(0.035823822021484), wave * DC.ar(0.62664699554443)), Silent.ar());
varTiny13420133911 = LinCongN.ar(wave * DC.ar(0.52736341953278), wave * DC.ar(0.15597581863403), wave * DC.ar(0.062145829200745), wave * DC.ar(0.60522019863129), wave * DC.ar(0.55583143234253), wave * DC.ar(0.15064358711243), wave * DC.ar(0.79628026485443));
varTiny13420133912 = Median.ar(modZ * varTiny1342013399, 0.49768841266632 * gateEnv * varTiny13420133912, varTiny13420133912, Silent.ar());
varTiny13420133913 = RegaliaMitraEQ.ar(gate, signal * modX, island.linexp(wave * DC.ar(0.057462453842163), wave * DC.ar(0.42107689380646), wave * DC.ar(0.15360713005066), wave * DC.ar(0.52018451690674), wave * DC.ar(0.066510915756226)), t_trig, varTiny13420133911, Silent.ar());
varTiny1342013399 = RMEQ.ar(wave * DC.ar(0.64910197257996), wave * DC.ar(0.27637088298798), wave * DC.ar(0.33483636379242), wave * DC.ar(0.79100728034973), wave * DC.ar(0.97172939777374), wave * DC.ar(0.78727054595947));
varTiny13420133910 = FMHEncode0.ar(wave * DC.ar(0.44276428222656), wave * DC.ar(0.51989543437958), wave * DC.ar(0.69025444984436), wave * DC.ar(0.10716283321381));
varTiny13420133911 = Lorenz2DL.ar(wave * DC.ar(0.64511263370514), wave * DC.ar(0.59636545181274), wave * DC.ar(0.82683455944061), wave * DC.ar(0.065658688545227), wave * DC.ar(0.15035057067871), wave * DC.ar(0.40290534496307), wave * DC.ar(0.62850284576416), wave * DC.ar(0.13906049728394), wave * DC.ar(0.75351071357727), wave * DC.ar(0.46040141582489), wave * DC.ar(0.81215882301331));
varTiny13420133912 = TDuty.ar(wave * DC.ar(0.22059535980225), wave * DC.ar(0.44004011154175), wave * DC.ar(0.97335290908813), wave * DC.ar(0.00086724758148193), wave * DC.ar(0.16850638389587));
varTiny13420133913 = Fhn2DC.ar(wave * DC.ar(0.79737460613251), wave * DC.ar(0.13066744804382), wave * DC.ar(0.89273774623871), wave * DC.ar(0.82180190086365), wave * DC.ar(0.9757194519043), wave * DC.ar(0.4764187335968), wave * DC.ar(0.86334836483002), wave * DC.ar(0.39656507968903), wave * DC.ar(0.64023661613464), wave * DC.ar(0.83986043930054), wave * DC.ar(0.8603184223175));

signal = varTiny13420133913;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Bin.Auto.BMU2013391
/////////////////////////////////////////////////////////

SynthDef.new("Bin.Auto.BMU2013391", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varBinAutoBMU2013399, varBinAutoBMU20133910, varBinAutoBMU201339111, varBinAutoBMU201339112;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varBinAutoBMU2013399 = varBinAutoBMU20133910 = varBinAutoBMU201339111 = varBinAutoBMU201339112 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varBinAutoBMU2013399 = MZPokey.ar(gateEnv * modX, varBinAutoBMU201339111, modY, BFEncode1.ar(wave * DC.ar(0.49643278121948), wave * DC.ar(0.88621282577515), wave * DC.ar(0.77666592597961), wave * DC.ar(0.4505580663681), wave * DC.ar(0.19159162044525), wave * DC.ar(0.5815292596817)), gate, 0.16081762313843 * varBinAutoBMU201339111 * signal, modY, signal * varBinAutoBMU20133910, HenonTrig.ar(wave * DC.ar(0.98327028751373), wave * DC.ar(0.8339056968689), wave * DC.ar(0.85583519935608), wave * DC.ar(0.056962132453918), wave * DC.ar(0.91390573978424), wave * DC.ar(0.60666275024414), wave * DC.ar(0.090651273727417), wave * DC.ar(0.20607697963715)));
varBinAutoBMU20133910 = Formant.ar(varBinAutoBMU201339112, Crackle.ar(wave * DC.ar(0.43163108825684), wave * DC.ar(0.24855971336365), wave * DC.ar(0.57534515857697)).exprange(1, SampleRate.ir), varBinAutoBMU201339112 * signal, 0.99998663160477 * modZ * gateEnv, Silent.ar());
varBinAutoBMU2013399 = Instruction.ar(Array.fill(2.pow(16), { |i| rrand(-1, 1) }).as(LocalBuf), varBinAutoBMU201339112, Silent.ar());
varBinAutoBMU20133910 = ReplaceOut.ar(wave * DC.ar(0.95791113376617), wave * DC.ar(0.16513991355896));
varBinAutoBMU2013399 = TPV.ar(wave * DC.ar(0.52292191982269), wave * DC.ar(0.074921607971191), wave * DC.ar(0.78996157646179), wave * DC.ar(0.95994091033936), wave * DC.ar(0.68985199928284), wave * DC.ar(0.63174402713776), wave * DC.ar(0.71287894248962), wave * DC.ar(0.81444585323334), wave * DC.ar(0.46509540081024), wave * DC.ar(0.048398852348328));
varBinAutoBMU20133910 = CombC.ar(wave * DC.ar(0.67569231987), wave * DC.ar(0.27804827690125), wave * DC.ar(0.082417845726013), wave * DC.ar(0.73872995376587), wave * DC.ar(0.75573921203613), wave * DC.ar(0.3200261592865));
// Variation test code
varBinAutoBMU201339111 = StkPluck.ar(varBinAutoBMU2013399 * varBinAutoBMU201339111, env * modZ, 0.97203698536393 * modX * varBinAutoBMU20133910, Silent.ar());
varBinAutoBMU201339112 = Wrap.ar(0.43363988399506 * gateEnv * wave, varBinAutoBMU20133910 * modZ, varBinAutoBMU2013399);
varBinAutoBMU201339111 = NestedAllpassC.ar(signal * modX, wave * gateEnv, modZ * varBinAutoBMU2013399, modY * varBinAutoBMU201339112, wave, modZ, signal * modX, 0.41318966812319 * varBinAutoBMU201339111 * modY, Silent.ar());
varBinAutoBMU201339112 = SelectL.ar(modX * varBinAutoBMU2013399, [RosslerResL.ar(varBinAutoBMU2013399 * DC.ar(0.11087965965271), varBinAutoBMU2013399 * DC.ar(0.30582690238953), varBinAutoBMU20133910 * DC.ar(0.79119694232941), varBinAutoBMU20133910 * DC.ar(0.76889407634735), varBinAutoBMU20133910 * DC.ar(0.1249121427536), varBinAutoBMU2013399 * DC.ar(0.51668703556061), varBinAutoBMU2013399 * DC.ar(0.26397621631622), varBinAutoBMU20133910 * DC.ar(0.24593901634216), varBinAutoBMU2013399 * DC.ar(0.30151093006134), varBinAutoBMU2013399 * DC.ar(0.92519426345825), varBinAutoBMU2013399 * DC.ar(0.60222458839417), varBinAutoBMU20133910 * DC.ar(0.95978486537933)), EnvDetect.ar(varBinAutoBMU20133910 * DC.ar(0.02187180519104), varBinAutoBMU2013399 * DC.ar(0.60827815532684), varBinAutoBMU20133910 * DC.ar(0.39944171905518))]);
varBinAutoBMU201339111 = SanityCheck2.ar(amp);
varBinAutoBMU201339112 = Fold.ar(0.58402693271637 * SelectL.ar(varBinAutoBMU2013399 * DC.ar(0.4280469417572), varBinAutoBMU20133910 * DC.ar(0.5306601524353)), varBinAutoBMU201339111, RedPhasor2.ar(signal * modZ, bufnum, modX * varBinAutoBMU201339111, varBinAutoBMU201339111 * signal, varBinAutoBMU2013399 * signal.wrap(varBinAutoBMU2013399 * DC.ar(0.63887500762939), varBinAutoBMU2013399 * DC.ar(0.6173722743988)), varBinAutoBMU201339111 * signal, z));

signal = varBinAutoBMU201339112;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// IVP.354201340
/////////////////////////////////////////////////////////

SynthDef.new("IVP.354201340", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varIVP3542013409, varIVP35420134010, varIVP35420134011, varIVP35420134012, varIVP35420134013;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varIVP3542013409 = varIVP35420134010 = varIVP35420134011 = varIVP35420134012 = varIVP35420134013 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varIVP3542013409 = MidEQ.ar(varIVP3542013409, env, RunningMin.ar(wave * DC.ar(0.50732922554016), wave * DC.ar(0.44229209423065)), modZ * gateEnv.fold(wave * DC.ar(0.65676367282867), wave * DC.ar(0.95214295387268)), 0.9974357578793 * varIVP35420134010 * varIVP35420134012, Silent.ar());
varIVP35420134010 = BRF.ar(modZ, LorenzL.ar(wave * DC.ar(0.35172879695892), wave * DC.ar(0.53344714641571), wave * DC.ar(0.93551909923553), wave * DC.ar(0.91726052761078), wave * DC.ar(0.16551387310028), wave * DC.ar(0.86749041080475), wave * DC.ar(0.76070761680603), wave * DC.ar(0.13102173805237), wave * DC.ar(0.12511765956879), wave * DC.ar(0.13389456272125)).exprange(1, SampleRate.ir), gateEnv * varIVP35420134012, 0.99973002623628 * modY * modY, Silent.ar());
varIVP35420134011 = FoaDominateZ.ar(modX * modZ, gateEnv, varIVP35420134011, Silent.ar());
varIVP35420134012 = Tilt.ar(varIVP35420134010 * varIVP35420134010, InGrainBBF.ar(wave * DC.ar(0.95498085021973), wave * DC.ar(0.82009935379028), wave * DC.ar(0.14372003078461), wave * DC.ar(0.39696037769318), wave * DC.ar(0.7128918170929), wave * DC.ar(0.17852091789246), wave * DC.ar(0.55539989471436), wave * DC.ar(0.8655172586441), wave * DC.ar(0.31304860115051), wave * DC.ar(0.89267814159393)), 0.73327624797821 * env * env, amp.slew(wave * DC.ar(0.76804745197296), wave * DC.ar(0.77262306213379)), varIVP35420134013);
varIVP35420134013 = NestedAllpassL.ar(z, 0.071071267127991 * AtsNoise.ar(wave * DC.ar(0.12565803527832), wave * DC.ar(0.399986743927), wave * DC.ar(0.066482424736023), wave * DC.ar(0.9132467508316), wave * DC.ar(0.58732581138611)), varIVP3542013409 * varIVP35420134010, bufnum, env * modZ, gate, varIVP3542013409, 0.99964534025302 * varIVP35420134010 * varIVP35420134011, Silent.ar());
varIVP3542013409 = BufCombL.ar(Array.fill(2.pow(14), { |i| rrand(-1, 1) }).as(LocalBuf), varIVP35420134012 * varIVP35420134010, 0.71176254749298 * varIVP35420134012 * varIVP35420134013, x, 0.999186559033 * varIVP3542013409 * modY, Silent.ar().curvelin(wave * DC.ar(0.69422447681427), wave * DC.ar(0.64698147773743), wave * DC.ar(0.12483072280884), wave * DC.ar(0.72647333145142), wave * DC.ar(0.50192952156067), wave * DC.ar(0.22193312644958)));
varIVP35420134010 = DetectIndex.ar(wave * DC.ar(0.20160841941833), wave * DC.ar(0.83851563930511), wave * DC.ar(0.84197604656219), wave * DC.ar(0.94353663921356));
varIVP35420134011 = HenonL.ar(varIVP35420134013, in.lag3ud(wave * DC.ar(0.79852986335754), wave * DC.ar(0.03248393535614)), varIVP3542013409 * env, gate, signal, RunningSum.ar(wave * DC.ar(0.43947887420654), wave * DC.ar(0.0021618604660034)), Silent.ar().slew(wave * DC.ar(0.23738992214203), wave * DC.ar(0.84025859832764)));
varIVP35420134012 = AtsAmp.ar(Array.fill(2.pow(13), { |i| rrand(-1, 1) }).as(LocalBuf), bufnum, y, varIVP35420134012, Silent.ar());
varIVP35420134013 = EnvGen.ar(wave * DC.ar(0.77087581157684), wave * DC.ar(0.099226832389832), wave * DC.ar(0.96066844463348), wave * DC.ar(0.9516167640686), wave * DC.ar(0.22307419776917), wave * DC.ar(0.80183589458466));
varIVP3542013409 = VMScan2D.ar(wave * DC.ar(0.26593112945557), wave * DC.ar(0.83151340484619), wave * DC.ar(0.13688158988953));
varIVP35420134010 = BufGrainB.ar(wave * DC.ar(0.93523824214935), wave * DC.ar(0.66337418556213), wave * DC.ar(0.65256404876709), wave * DC.ar(0.51042854785919), wave * DC.ar(0.30156993865967), wave * DC.ar(0.40269207954407), wave * DC.ar(0.1468608379364), wave * DC.ar(0.10593903064728), wave * DC.ar(0.066540598869324));
varIVP35420134011 = LorenzL.ar(wave * DC.ar(0.069687128067017), wave * DC.ar(0.36061155796051), wave * DC.ar(0.070512533187866), wave * DC.ar(0.086255192756653), wave * DC.ar(0.93401443958282), wave * DC.ar(0.69044709205627), wave * DC.ar(0.24452006816864), wave * DC.ar(0.26909685134888), wave * DC.ar(0.8885223865509), wave * DC.ar(0.66957032680511));
varIVP35420134012 = BBandPass.ar(wave * DC.ar(0.68120324611664), wave * DC.ar(0.047230243682861), wave * DC.ar(0.14151048660278), wave * DC.ar(0.30783212184906), wave * DC.ar(0.80456304550171));
varIVP35420134013 = InGrainI.ar(wave * DC.ar(0.25507116317749), wave * DC.ar(0.68543291091919), wave * DC.ar(0.21985197067261), wave * DC.ar(0.95491743087769), wave * DC.ar(0.37375617027283), wave * DC.ar(0.13879835605621), wave * DC.ar(0.090610265731812), wave * DC.ar(0.45032382011414));

signal = varIVP35420134013;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// XM.Laroux.AE201341
/////////////////////////////////////////////////////////

SynthDef.new("XM.Laroux.AE201341", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varXMLarouxAE2013419, varXMLarouxAE20134110, varXMLarouxAE20134111;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varXMLarouxAE2013419 = varXMLarouxAE20134110 = varXMLarouxAE20134111 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varXMLarouxAE2013419 = Duty.ar(varXMLarouxAE2013419 * modZ, y, varXMLarouxAE20134111 * gateEnv, env);
varXMLarouxAE20134110 = LatoocarfianN.ar(QuadL.ar(wave * DC.ar(0.17188882827759), wave * DC.ar(0.28780233860016), wave * DC.ar(0.14840960502625), wave * DC.ar(0.5230005979538), wave * DC.ar(0.41997253894806), wave * DC.ar(0.31133770942688), wave * DC.ar(0.51073575019836)).exprange(1, SampleRate.ir), varXMLarouxAE20134110, amp, env * modY, modZ * wave, bufnum, varXMLarouxAE20134111 * varXMLarouxAE20134110, 0.59934308528144 * signal * signal, Silent.ar());
varXMLarouxAE20134111 = BRZ2.ar(in * modZ, varXMLarouxAE2013419, Silent.ar());
varXMLarouxAE2013419 = DoubleWell.ar(modY * in, wave * signal, modZ, signal, varXMLarouxAE2013419, island, signal * modX, varXMLarouxAE20134111, PV_HainsworthFoote.ar(wave * DC.ar(0.71028125286102), wave * DC.ar(0.21244359016418), wave * DC.ar(0.52566480636597), wave * DC.ar(0.64625799655914), wave * DC.ar(0.90932011604309)), Silent.ar());
varXMLarouxAE20134110 = TwoTube.ar(modX * modY, 0.093942642211914 * env * modY, gateEnv * signal, gateEnv * varXMLarouxAE20134110, signal, 0.48849402943121 * BufGrainI.ar(wave * DC.ar(0.21498537063599), wave * DC.ar(0.13790416717529), wave * DC.ar(0.17998242378235), wave * DC.ar(0.028122544288635), wave * DC.ar(0.82976078987122), wave * DC.ar(0.39883196353912), wave * DC.ar(0.70472240447998), wave * DC.ar(0.49348151683807), wave * DC.ar(0.4734206199646), wave * DC.ar(0.72002136707306), wave * DC.ar(0.47103095054626)), Silent.ar());
varXMLarouxAE20134111 = LPFVS6.ar(wave * DC.ar(0.054880261421204), wave * DC.ar(0.54827880859375), wave * DC.ar(0.2091281414032));
varXMLarouxAE2013419 = LFSaw.ar(wave * DC.ar(0.92633843421936), wave * DC.ar(0.36788165569305), wave * DC.ar(0.88825654983521), wave * DC.ar(0.68947494029999));
varXMLarouxAE20134110 = StandardL.ar(wave * DC.ar(0.22511565685272), wave * DC.ar(0.10631883144379), wave * DC.ar(0.48601806163788), wave * DC.ar(0.11090564727783), wave * DC.ar(0.43333375453949), wave * DC.ar(0.49406659603119));
varXMLarouxAE20134111 = EnvDetect.ar(wave * DC.ar(0.35343503952026), wave * DC.ar(0.51692700386047), wave * DC.ar(0.22890114784241));

signal = varXMLarouxAE20134111;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// XM.Extras.E201341
/////////////////////////////////////////////////////////

SynthDef.new("XM.Extras.E201341", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varXMExtrasE2013419, varXMExtrasE20134110;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varXMExtrasE2013419 = varXMExtrasE20134110 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varXMExtrasE2013419 = DiskOut.ar(Array.fill(2.pow(15), { |i| rrand(-1, 1) }).as(LocalBuf), [YigMandelbulbN.ar(wave * DC.ar(0.64801609516144), wave * DC.ar(0.47344589233398), wave * DC.ar(0.96621155738831), wave * DC.ar(0.25176918506622), wave * DC.ar(0.0078201293945312), wave * DC.ar(0.89650094509125), wave * DC.ar(0.55455911159515)), IFFT.ar(wave * DC.ar(0.82048690319061), wave * DC.ar(0.837681889534), wave * DC.ar(0.6366935968399))]);
varXMExtrasE20134110 = BBandPass.ar(gate, gateEnv * gateEnv, y, 0.99958538745497 * modX * varXMExtrasE20134110, Silent.ar());
varXMExtrasE2013419 = FreeVerb2.ar(wave * DC.ar(0.19164752960205), wave * DC.ar(0.68198657035828), wave * DC.ar(0.57061731815338), wave * DC.ar(0.8400422334671), wave * DC.ar(0.063819646835327), wave * DC.ar(0.80148553848267), wave * DC.ar(0.59513854980469));
varXMExtrasE20134110 = OnePole.ar(modZ * varXMExtrasE2013419, in * in, modZ, Silent.ar());
varXMExtrasE2013419 = LFDClipNoise.ar(wave * DC.ar(0.24247980117798), wave * DC.ar(0.1852091550827), wave * DC.ar(0.58934903144836));
varXMExtrasE20134110 = StkClarinet.ar(wave * DC.ar(0.87514495849609), wave * DC.ar(0.53944575786591), wave * DC.ar(0.94620001316071), wave * DC.ar(0.46921145915985), wave * DC.ar(0.69167304039001), wave * DC.ar(0.020476102828979), wave * DC.ar(0.70256733894348), wave * DC.ar(0.5769248008728), wave * DC.ar(0.89441478252411));

signal = varXMExtrasE20134110;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Bin.Auto.CLZ201341
/////////////////////////////////////////////////////////

SynthDef.new("Bin.Auto.CLZ201341", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varBinAutoCLZ2013419;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varBinAutoCLZ2013419 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varBinAutoCLZ2013419 = FMGrainBBF.ar(modX * modX, 0.79867494106293 * modX * modX, modY, signal, in, bufnum, 0.80756330490112 * modY * env, modY * modX, wave * gateEnv, modX * env, 0.99941080723379 * signal * modY, Silent.ar());
varBinAutoCLZ2013419 = FoaPushZ.ar(modY * in, gateEnv, modY, Silent.ar());
varBinAutoCLZ2013419 = MoogFF.ar(wave * DC.ar(0.033042550086975), wave * DC.ar(0.94639122486115), wave * DC.ar(0.71236836910248), wave * DC.ar(0.99119603633881), wave * DC.ar(0.6695601940155), wave * DC.ar(0.25271594524384));

signal = varBinAutoCLZ2013419;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// PS-MPC.426.b2013421
/////////////////////////////////////////////////////////

SynthDef.new("PS-MPC.426.b2013421", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varPSMPC426b2013429, varPSMPC426b201342110;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varPSMPC426b2013429 = varPSMPC426b201342110 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varPSMPC426b2013429 = AtsParInfo.ar(Array.fill(2.pow(12), { |i| rrand(-1, 1) }).as(LocalBuf), varPSMPC426b201342110 * env, varPSMPC426b201342110 * gateEnv, 0.98215654159075 * env, YigCliffordC.ar(wave * DC.ar(0.52828168869019), wave * DC.ar(0.055851578712463), wave * DC.ar(0.40359711647034), wave * DC.ar(0.36467111110687), wave * DC.ar(0.75415349006653), wave * DC.ar(0.16282522678375), wave * DC.ar(0.33889448642731), wave * DC.ar(0.30006241798401), wave * DC.ar(0.23255848884583)).unipolar(wave * DC.ar(0.84788978099823)));
varPSMPC426b2013429 = OSWrap4.ar(wave * DC.ar(0.9812992811203), wave * DC.ar(0.77639746665955), wave * DC.ar(0.56887650489807));
varPSMPC426b2013429 = WeaklyNonlinear.ar(wave * DC.ar(0.30922889709473), wave * DC.ar(0.35316622257233), wave * DC.ar(0.66310667991638), wave * DC.ar(0.93080520629883), wave * DC.ar(0.52895379066467), wave * DC.ar(0.03101909160614), wave * DC.ar(0.032307863235474), wave * DC.ar(0.30185544490814), wave * DC.ar(0.66592347621918), wave * DC.ar(0.56114757061005), wave * DC.ar(0.31303524971008), wave * DC.ar(0.57548105716705), wave * DC.ar(0.63489580154419));
// Variation test code
varPSMPC426b201342110 = CoinGate.ar(modZ * varPSMPC426b201342110, varPSMPC426b201342110 * gateEnv);
varPSMPC426b201342110 = Latch.ar(gateEnv * signal, modY * in);
varPSMPC426b201342110 = LFDNoise0.ar(modZ * modZ, 0.99314239761889 * varPSMPC426b2013429 * in, Silent.ar());

signal = varPSMPC426b201342110;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Bin.Auto.BFA201343
/////////////////////////////////////////////////////////

SynthDef.new("Bin.Auto.BFA201343", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varBinAutoBFA2013439, varBinAutoBFA20134310, varBinAutoBFA20134311;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varBinAutoBFA2013439 = varBinAutoBFA20134310 = varBinAutoBFA20134311 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varBinAutoBFA2013439 = Gendy4.ar(gate, gate, amp, varBinAutoBFA2013439 * modX, StkMandolin.ar(wave * DC.ar(0.73780655860901), wave * DC.ar(0.15976405143738), wave * DC.ar(0.095652222633362), wave * DC.ar(0.27984285354614), wave * DC.ar(0.11336600780487), wave * DC.ar(0.2649222612381), wave * DC.ar(0.428830742836), wave * DC.ar(0.19116795063019), wave * DC.ar(0.67848777770996)).exprange(1, SampleRate.ir), gateEnv, wave, island, wave * wave.scaleneg(DiskOut.ar(wave * DC.ar(0.30625009536743), wave * DC.ar(0.092739462852478))), gateEnv * in, 0.97417227598215 * signal * signal, Silent.ar());
varBinAutoBFA20134310 = HPZ2.ar(UHJ2B.ar(wave * DC.ar(0.95656681060791), wave * DC.ar(0.60720789432526)), gateEnv, Silent.ar());
varBinAutoBFA20134311 = StkVoicForm.ar(varBinAutoBFA2013439 * in, t_trig, varBinAutoBFA20134311 * in, varBinAutoBFA20134311 * varBinAutoBFA2013439, varBinAutoBFA20134311 * in, z, in * varBinAutoBFA20134311, 0.40041682000015 * varBinAutoBFA20134310 * in, Silent.ar());
varBinAutoBFA2013439 = ArrayMin.ar(wave * DC.ar(0.53217887878418));
varBinAutoBFA20134310 = DetectIndex.ar(Array.fill(2.pow(16), { |i| rrand(-1, 1) }).as(LocalBuf), FBSineL.ar(wave * DC.ar(0.59157288074493), wave * DC.ar(0.050958633422852), wave * DC.ar(0.23613584041595), wave * DC.ar(0.73458313941956), wave * DC.ar(0.0081288814544678), wave * DC.ar(0.013903498649597), wave * DC.ar(0.33617866039276), wave * DC.ar(0.18470525741577), wave * DC.ar(0.32979297637939)), FMHEncode2.ar(wave * DC.ar(0.15340602397919), wave * DC.ar(0.22095847129822), wave * DC.ar(0.46265435218811), wave * DC.ar(0.21337342262268), wave * DC.ar(0.60330832004547), wave * DC.ar(0.17915952205658)), Silent.ar());
varBinAutoBFA20134311 = LFPar.ar(wave * DC.ar(0.36333787441254), wave * DC.ar(0.90712642669678), wave * DC.ar(0.55179190635681), wave * DC.ar(0.54204630851746));
varBinAutoBFA2013439 = DiskOut.ar(wave * DC.ar(0.4260870218277), wave * DC.ar(0.52369105815887));
varBinAutoBFA20134310 = TBrownRand.ar(wave * DC.ar(0.72306835651398), wave * DC.ar(0.20510935783386), wave * DC.ar(0.86872017383575), wave * DC.ar(0.41137838363647), wave * DC.ar(0.79755997657776), wave * DC.ar(0.55005812644958), wave * DC.ar(0.98095369338989));
varBinAutoBFA20134311 = InGrainB.ar(wave * DC.ar(0.60556888580322), wave * DC.ar(0.55394327640533), wave * DC.ar(0.32768797874451), wave * DC.ar(0.045954465866089), wave * DC.ar(0.09014892578125), wave * DC.ar(0.87265300750732));

signal = varBinAutoBFA20134311;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Bin.Auto.BYL201345
/////////////////////////////////////////////////////////

SynthDef.new("Bin.Auto.BYL201345", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varBinAutoBYL2013459, varBinAutoBYL20134510, varBinAutoBYL20134511, varBinAutoBYL20134512;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varBinAutoBYL2013459 = varBinAutoBYL20134510 = varBinAutoBYL20134511 = varBinAutoBYL20134512 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varBinAutoBYL2013459 = PVInfo.ar(Array.fill(2.pow(16), { |i| rrand(-1, 1) }).as(LocalBuf), 0.75545036792755 * env * wave, 0.74754416942596 * FoaNFC.ar(wave * DC.ar(0.31547510623932), wave * DC.ar(0.51523888111115), wave * DC.ar(0.49886858463287), wave * DC.ar(0.49265444278717)), ZeroCrossing.ar(wave * DC.ar(0.3276538848877)), Silent.ar());
varBinAutoBYL20134510 = NestedAllpassL.ar(wave * varBinAutoBYL2013459, gateEnv, SelectL.ar(wave * DC.ar(0.091612577438354), wave * DC.ar(0.82885670661926)), 0.88838720321655 * varBinAutoBYL20134511 * modZ, env, varBinAutoBYL20134510, 0.74529755115509 * varBinAutoBYL2013459 * varBinAutoBYL20134510, 0.95610738173735 * varBinAutoBYL2013459 * in, Silent.ar());
varBinAutoBYL20134511 = Fold.ar(signal * signal, gateEnv * modX, IIRFilter.ar(wave * DC.ar(0.34963393211365), wave * DC.ar(0.77868103981018), wave * DC.ar(0.6330840587616), wave * DC.ar(0.042901158332825), wave * DC.ar(0.52358305454254)));
varBinAutoBYL20134512 = VOsc3.ar(Array.fill(2.pow(11), { |i| rrand(-1, 1) }).as(LocalBuf), signal, modX * varBinAutoBYL20134511.unipolar(wave * DC.ar(0.0090451240539551)), modY * varBinAutoBYL20134510, 0.99817592902239 * modY * modZ, Silent.ar());
varBinAutoBYL2013459 = TwoZero.ar(wave * signal, FoaNFC.ar(wave * DC.ar(0.84638559818268), wave * DC.ar(0.73962438106537), wave * DC.ar(0.41555500030518), wave * DC.ar(0.31510412693024)).exprange(1, SampleRate.ir), varBinAutoBYL20134511 * gateEnv, 0.96381167995985 * modY * signal, Silent.ar());
varBinAutoBYL20134510 = DelTapWr.ar(wave * DC.ar(0.24980485439301), wave * DC.ar(0.86624383926392));
varBinAutoBYL20134511 = OSTrunc4.ar(varBinAutoBYL2013459 * modY, gateEnv * varBinAutoBYL20134512);
varBinAutoBYL20134512 = PitchShift.ar(wave, signal * signal, varBinAutoBYL20134510 * modZ, varBinAutoBYL20134512 * modX, env * varBinAutoBYL20134510, wave, Silent.ar());
varBinAutoBYL2013459 = InGrain.ar(wave * DC.ar(0.86977469921112), wave * DC.ar(0.15089988708496), wave * DC.ar(0.72994709014893), wave * DC.ar(0.15350425243378), wave * DC.ar(0.81314539909363));
varBinAutoBYL20134510 = BPF.ar(wave * DC.ar(0.36943531036377), wave * DC.ar(0.35826110839844), wave * DC.ar(0.4224705696106), wave * DC.ar(0.3138530254364), wave * DC.ar(0.51420938968658));
varBinAutoBYL20134511 = Metro.ar(wave * DC.ar(0.7151802778244), wave * DC.ar(0.54509687423706), wave * DC.ar(0.85102581977844), wave * DC.ar(0.80470299720764));
varBinAutoBYL20134512 = LFBrownNoise1.ar(wave * DC.ar(0.16185545921326), wave * DC.ar(0.19120717048645), wave * DC.ar(0.30534279346466), wave * DC.ar(0.012616038322449), wave * DC.ar(0.57261526584625));

signal = varBinAutoBYL20134512;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// VBS.Kidarcade.B201348
/////////////////////////////////////////////////////////

SynthDef.new("VBS.Kidarcade.B201348", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varVBSKidarcadeB2013489;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varVBSKidarcadeB2013489 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varVBSKidarcadeB2013489 = Gendy3.ar(gateEnv * wave, modZ * wave, bufnum, signal * in, signal * wave, varVBSKidarcadeB2013489 * modY, modZ * modX, in * modY, 0.90188753604889 * env * in, 0.89458110181204 * varVBSKidarcadeB2013489 * gateEnv, Silent.ar());
varVBSKidarcadeB2013489 = BufGrainIBF.ar(wave * DC.ar(0.12726199626923), wave * DC.ar(0.94610130786896), wave * DC.ar(0.80517876148224), wave * DC.ar(0.85917747020721), wave * DC.ar(0.89197540283203), wave * DC.ar(0.038987755775452), wave * DC.ar(0.98407328128815), wave * DC.ar(0.5531941652298), wave * DC.ar(0.12407827377319), wave * DC.ar(0.46175158023834), wave * DC.ar(0.3993581533432), wave * DC.ar(0.88336980342865), wave * DC.ar(0.41371762752533), wave * DC.ar(0.65280938148499), wave * DC.ar(0.98158669471741));
varVBSKidarcadeB2013489 = Rotate2.ar(wave * DC.ar(0.9402722120285), wave * DC.ar(0.22451317310333), wave * DC.ar(0.74730563163757));

signal = varVBSKidarcadeB2013489;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Redpine.467201348
/////////////////////////////////////////////////////////

SynthDef.new("Redpine.467201348", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varRedpine4672013489, varRedpine46720134810, varRedpine46720134811, varRedpine46720134812, varRedpine46720134813, varRedpine46720134814;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varRedpine4672013489 = varRedpine46720134810 = varRedpine46720134811 = varRedpine46720134812 = varRedpine46720134813 = varRedpine46720134814 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varRedpine4672013489 = PV_HainsworthFoote.ar(Array.fill(2.pow(14), { |i| rrand(-1, 1) }).as(LocalBuf), island, varRedpine46720134813 * modX, in * varRedpine4672013489, varRedpine46720134811);
varRedpine46720134810 = FBSineL.ar(modY, island, varRedpine4672013489 * varRedpine46720134813, modY, varRedpine46720134810 * gateEnv, modX * wave, z, varRedpine4672013489, Silent.ar());
varRedpine46720134811 = Slub.ar(modY * varRedpine46720134810, modX * modX);
varRedpine46720134812 = FoaFocusY.ar(modY, varRedpine46720134814, FMGrainB.ar(wave * DC.ar(0.14610910415649), wave * DC.ar(0.76529824733734), wave * DC.ar(0.23705244064331), wave * DC.ar(0.25335264205933), wave * DC.ar(0.068327665328979), wave * DC.ar(0.012913227081299), wave * DC.ar(0.62204158306122), wave * DC.ar(0.96839046478271)), Silent.ar());
varRedpine46720134813 = SoftClipper4.ar(varRedpine46720134810);
varRedpine46720134814 = Summer.ar(varRedpine46720134813 * varRedpine46720134813, Concat.ar(wave * DC.ar(0.86195552349091), wave * DC.ar(0.18221139907837), wave * DC.ar(0.98468744754791), wave * DC.ar(0.58406460285187), wave * DC.ar(0.26610481739044), wave * DC.ar(0.09133768081665), wave * DC.ar(0.36830449104309), wave * DC.ar(0.99985194206238), wave * DC.ar(0.029261589050293), wave * DC.ar(0.60270035266876), wave * DC.ar(0.0059612989425659), wave * DC.ar(0.61608874797821), wave * DC.ar(0.42126953601837), wave * DC.ar(0.75168538093567)), modX * in, modZ * signal);
varRedpine4672013489 = DoubleWell2.ar(wave * DC.ar(0.070670247077942), wave * DC.ar(0.85231375694275), wave * DC.ar(0.14011979103088), wave * DC.ar(0.59567022323608), wave * DC.ar(0.26522970199585), wave * DC.ar(0.87708914279938), wave * DC.ar(0.35582590103149), wave * DC.ar(0.14232778549194), wave * DC.ar(0.5287926197052), wave * DC.ar(0.49823546409607));
varRedpine46720134810 = Shaper.ar(wave * DC.ar(0.8484411239624), wave * DC.ar(0.47807896137238), wave * DC.ar(0.83176875114441), wave * DC.ar(0.55891048908234));
varRedpine46720134811 = GbmanL.ar(wave * DC.ar(0.11988055706024), wave * DC.ar(0.077876925468445), wave * DC.ar(0.91988599300385), wave * DC.ar(0.82108235359192), wave * DC.ar(0.93413853645325));
varRedpine46720134812 = SMS.ar(gateEnv, AllpassL.ar(wave * DC.ar(0.85366272926331), wave * DC.ar(0.77257061004639), wave * DC.ar(0.6454371213913), wave * DC.ar(0.7491283416748), wave * DC.ar(0.73089230060577), wave * DC.ar(0.39307689666748)), varRedpine4672013489 * wave, varRedpine46720134811 * modY, island, 0.9929469052156 * Delay2.ar(wave * DC.ar(0.064695715904236), wave * DC.ar(0.67578184604645), wave * DC.ar(0.81854093074799)), Silent.ar(), varRedpine46720134810 * varRedpine46720134812, varRedpine4672013489 * wave, 0.99998809278918 * modX * signal, Array.fill(2.pow(10), { |i| rrand(-1, 1) }).as(LocalBuf), 0.99139160420453 * varRedpine46720134814 * modX.max(HilbertFIR.ar(wave * DC.ar(0.59990227222443), wave * DC.ar(0.045449614524841))), Silent.ar());
varRedpine46720134813 = AY.ar(wave * DC.ar(0.27109241485596), wave * DC.ar(0.70298004150391), wave * DC.ar(0.3647962808609), wave * DC.ar(0.14603018760681), wave * DC.ar(0.12047576904297), wave * DC.ar(0.4103696346283), wave * DC.ar(0.48293697834015), wave * DC.ar(0.94542360305786), wave * DC.ar(0.97993957996368), wave * DC.ar(0.5211592912674), wave * DC.ar(0.3734849691391), wave * DC.ar(0.43836867809296), wave * DC.ar(0.83030521869659));
varRedpine46720134814 = BufGrain.ar(wave * DC.ar(0.20908725261688), wave * DC.ar(0.079219937324524), wave * DC.ar(0.66210412979126), wave * DC.ar(0.4630491733551), wave * DC.ar(0.83525991439819), wave * DC.ar(0.49348986148834), wave * DC.ar(0.31260919570923), wave * DC.ar(0.94699048995972));
varRedpine4672013489 = NestedAllpassN.ar(wave * DC.ar(0.92498755455017), wave * DC.ar(0.61869978904724), wave * DC.ar(0.58495056629181), wave * DC.ar(0.61618804931641), wave * DC.ar(0.67396426200867), wave * DC.ar(0.35840594768524), wave * DC.ar(0.44251537322998), wave * DC.ar(0.31793296337128), wave * DC.ar(0.58942210674286));
varRedpine46720134810 = Perlin3.ar(wave * DC.ar(0.63625407218933), wave * DC.ar(0.68654763698578), wave * DC.ar(0.053782343864441));
varRedpine46720134811 = FoaZoomY.ar(wave * DC.ar(0.72952508926392), wave * DC.ar(0.098849892616272), wave * DC.ar(0.72405314445496), wave * DC.ar(0.37082123756409));
varRedpine46720134812 = LFSaw.ar(wave * DC.ar(0.9573712348938), wave * DC.ar(0.77015435695648), wave * DC.ar(0.37371408939362), wave * DC.ar(0.52114546298981));
varRedpine46720134813 = Balance.ar(wave * DC.ar(0.60841822624207), wave * DC.ar(0.61187028884888), wave * DC.ar(0.65641665458679), wave * DC.ar(0.68596923351288), wave * DC.ar(0.53992342948914), wave * DC.ar(0.48889744281769));
varRedpine46720134814 = Lag2UD.ar(wave * DC.ar(0.26627480983734), wave * DC.ar(0.93030154705048), wave * DC.ar(0.61782670021057), wave * DC.ar(0.78322196006775), wave * DC.ar(0.30098652839661));

signal = varRedpine46720134814;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Youth.512201348
/////////////////////////////////////////////////////////

SynthDef.new("Youth.512201348", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varYouth5122013489, varYouth51220134810, varYouth51220134811, varYouth51220134812, varYouth51220134813;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varYouth5122013489 = varYouth51220134810 = varYouth51220134811 = varYouth51220134812 = varYouth51220134813 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varYouth5122013489 = FreeVerb2.ar(signal * modY, signal, in * varYouth51220134811, 0.58052718639374 * varYouth51220134812 * modX, modZ * modY, 0.99548191112011 * varYouth51220134811 * in, Silent.ar());
varYouth51220134810 = StkBowed.ar(varYouth51220134812 * varYouth5122013489, bufnum, varYouth51220134813 * varYouth51220134811, YigCliffordC.ar(wave * DC.ar(0.8692239522934), wave * DC.ar(0.49073207378387), wave * DC.ar(0.16138863563538), wave * DC.ar(0.35758674144745), wave * DC.ar(0.94973409175873), wave * DC.ar(0.038325667381287), wave * DC.ar(0.74959409236908), wave * DC.ar(0.0083298683166504), wave * DC.ar(0.36989426612854)).exprange(1, SampleRate.ir), varYouth51220134811 * varYouth51220134813, signal, 0.98017156124115 * varYouth51220134812 * varYouth51220134813, env * varYouth51220134811, env * wave, 0.99982715689772 * signal * varYouth51220134813, Silent.ar());
varYouth51220134811 = SoftClipper4.ar(0.14748573303223 * modX * varYouth51220134810);
varYouth51220134812 = SMS.ar(amp, modZ * modY, t_trig, modY, varYouth5122013489, 0.8801853366766 * modY * wave, Silent.ar(), x, signal * env, 0.96343507282456 * varYouth51220134813, Array.fill(2.pow(14), { |i| rrand(-1, 1) }).as(LocalBuf), 0.99988993690419 * modZ * env, Silent.ar());
varYouth51220134813 = PanB.ar(modY, 0.0099464654922485 * signal * modY, PeakFollower.ar(wave * DC.ar(0.5120507478714), wave * DC.ar(0.021653532981873)), amp);
varYouth5122013489 = Summer.ar(wave * DC.ar(0.88252067565918), wave * DC.ar(0.17867279052734), wave * DC.ar(0.68439447879791), wave * DC.ar(0.93074059486389));
varYouth51220134810 = Lorenz2DL.ar(varYouth51220134812, varYouth51220134812 * env, amp, varYouth5122013489, varYouth5122013489 * varYouth51220134813, x, wave, island, gate, varYouth51220134811, Silent.ar());
varYouth51220134811 = BFEncode2.ar(modZ, varYouth51220134810 * varYouth51220134813, z, bufnum, varYouth51220134812, amp);
varYouth51220134812 = FreqShift.ar(varYouth51220134811 * signal, varYouth51220134811 * varYouth51220134812, env.lag2(wave * DC.ar(0.45628297328949), wave * DC.ar(0.15200757980347)), varYouth5122013489, DoubleWell2.ar(wave * DC.ar(0.2101743221283), wave * DC.ar(0.42707049846649), wave * DC.ar(0.79400539398193), wave * DC.ar(0.57402348518372), wave * DC.ar(0.90044784545898), wave * DC.ar(0.51593172550201), wave * DC.ar(0.29486107826233), wave * DC.ar(0.64106678962708), wave * DC.ar(0.22959971427917), wave * DC.ar(0.4803364276886)).bitXor(Standard2DC.ar(wave * DC.ar(0.52565693855286), wave * DC.ar(0.15116608142853), wave * DC.ar(0.22243976593018), wave * DC.ar(0.69493103027344), wave * DC.ar(0.34692394733429), wave * DC.ar(0.57931232452393), wave * DC.ar(0.68938267230988))));
varYouth51220134813 = B2A.ar(wave * DC.ar(0.6966757774353), wave * DC.ar(0.59666609764099), wave * DC.ar(0.53034901618958), wave * DC.ar(0.23721444606781));
varYouth5122013489 = LPCSynth.ar(wave * DC.ar(0.33278906345367), wave * DC.ar(0.2658177614212), wave * DC.ar(0.72120082378387), wave * DC.ar(0.1264876127243), wave * DC.ar(0.77082705497742));
varYouth51220134810 = SinGrainIBF.ar(wave * DC.ar(0.42150449752808), wave * DC.ar(0.45472931861877), wave * DC.ar(0.081280708312988), wave * DC.ar(0.49061942100525), wave * DC.ar(0.14984571933746), wave * DC.ar(0.10850703716278), wave * DC.ar(0.26709079742432), wave * DC.ar(0.68433964252472), wave * DC.ar(0.52611780166626), wave * DC.ar(0.88819193840027), wave * DC.ar(0.73331308364868), wave * DC.ar(0.943230509758));
varYouth51220134811 = AY8910.ar(wave * DC.ar(0.30602860450745), wave * DC.ar(0.67416906356812), wave * DC.ar(0.51450967788696), wave * DC.ar(0.96193051338196), wave * DC.ar(0.75187981128693), wave * DC.ar(0.40971708297729), wave * DC.ar(0.078823685646057), wave * DC.ar(0.78153395652771), wave * DC.ar(0.30511617660522), wave * DC.ar(0.31668281555176), wave * DC.ar(0.83158302307129), wave * DC.ar(0.27958655357361), wave * DC.ar(0.8381894826889), wave * DC.ar(0.74667608737946), wave * DC.ar(0.11313116550446));
varYouth51220134812 = FoaZoomZ.ar(wave * DC.ar(0.44477236270905), wave * DC.ar(0.74556148052216), wave * DC.ar(0.025841236114502), wave * DC.ar(0.034777283668518));
varYouth51220134813 = FBSineL.ar(wave * DC.ar(0.44142007827759), wave * DC.ar(0.075429916381836), wave * DC.ar(0.92480719089508), wave * DC.ar(0.82311427593231), wave * DC.ar(0.2327184677124), wave * DC.ar(0.19882440567017), wave * DC.ar(0.3812175989151), wave * DC.ar(0.95806527137756), wave * DC.ar(0.92662620544434));

signal = varYouth51220134813;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// X97M.Fusion.B201349
/////////////////////////////////////////////////////////

SynthDef.new("X97M.Fusion.B201349", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varX97MFusionB2013499, varX97MFusionB20134910, varX97MFusionB20134911, varX97MFusionB20134912, varX97MFusionB20134913, varX97MFusionB20134914;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varX97MFusionB2013499 = varX97MFusionB20134910 = varX97MFusionB20134911 = varX97MFusionB20134912 = varX97MFusionB20134913 = varX97MFusionB20134914 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varX97MFusionB2013499 = BRZ2.ar(0.14207291603088 * varX97MFusionB20134913 * varX97MFusionB20134912, Formlet.ar(wave * DC.ar(0.97502136230469), wave * DC.ar(0.32010018825531), wave * DC.ar(0.58870613574982), wave * DC.ar(0.87665045261383), wave * DC.ar(0.17524480819702), wave * DC.ar(0.21137011051178)), Silent.ar());
varX97MFusionB20134910 = Normalizer.ar(AtsParInfo.ar(wave * DC.ar(0.42807364463806), wave * DC.ar(0.80237340927124), wave * DC.ar(0.49812889099121), wave * DC.ar(0.91018617153168), wave * DC.ar(0.046112060546875)), varX97MFusionB20134911, RHPF.ar(wave * DC.ar(0.62582004070282), wave * DC.ar(0.31217861175537), wave * DC.ar(0.38541722297668), wave * DC.ar(0.37796306610107), wave * DC.ar(0.61195409297943)));
varX97MFusionB20134911 = QuadC.ar(env * modY, signal, varX97MFusionB20134913 * modX, modZ, varX97MFusionB20134913, 0.99956672570525 * varX97MFusionB20134914 * signal, Silent.ar());
varX97MFusionB20134912 = Maxamp.ar(varX97MFusionB20134911, 0.25644993782043 * modX * varX97MFusionB20134911);
varX97MFusionB20134913 = InGrainIBF.ar(modY * wave, varX97MFusionB20134911, signal * modX, bufnum, bufnum, wave * gateEnv, varX97MFusionB20134914 * varX97MFusionB20134913, 0.14552140235901 * varX97MFusionB20134913, wave * varX97MFusionB20134914, varX97MFusionB2013499, LFNoise2.ar(wave * DC.ar(0.44052088260651), wave * DC.ar(0.036068439483643), wave * DC.ar(0.49155449867249)), VOsc3.ar(wave * DC.ar(0.9764860868454), wave * DC.ar(0.87524676322937), wave * DC.ar(0.27089583873749), wave * DC.ar(0.18399882316589), wave * DC.ar(0.45104324817657), wave * DC.ar(0.96955800056458)));
varX97MFusionB20134914 = BinData.ar(Array.fill(2.pow(12), { |i| rrand(-1, 1) }).as(LocalBuf), modX * varX97MFusionB20134913, varX97MFusionB20134911 * varX97MFusionB20134913);
varX97MFusionB2013499 = GravityGrid2.ar(0.59728145599365 * varX97MFusionB20134912 * varX97MFusionB20134914, modZ * gateEnv, varX97MFusionB20134913 * varX97MFusionB20134911, modX, Array.fill(2.pow(13), { |i| rrand(-1, 1) }).as(LocalBuf), signal, Silent.ar());
varX97MFusionB20134910 = MeanTriggered.ar(z, modY * modZ, modY * modZ, 0.95854246132295 * varX97MFusionB20134914 * in, Silent.ar());
varX97MFusionB20134911 = TDuty.ar(y, varX97MFusionB20134910 * wave, 0.24303138256073 * varX97MFusionB20134913 * varX97MFusionB20134913, wave * wave, varX97MFusionB2013499 * varX97MFusionB20134910);
varX97MFusionB20134912 = MembraneCircle.ar(wave * DC.ar(0.54154014587402), wave * DC.ar(0.30524265766144), wave * DC.ar(0.72629749774933), wave * DC.ar(0.74215292930603), wave * DC.ar(0.48564481735229));
varX97MFusionB20134913 = Fold.ar(varX97MFusionB20134912 * modX, modY * varX97MFusionB20134914, modX * modX);
varX97MFusionB20134914 = BufDelayL.ar(wave * DC.ar(0.99371230602264), wave * DC.ar(0.81530833244324), wave * DC.ar(0.56114101409912), wave * DC.ar(0.36496782302856), wave * DC.ar(0.93504905700684));
varX97MFusionB2013499 = A2B.ar(wave * DC.ar(0.52790689468384), wave * DC.ar(0.56646263599396), wave * DC.ar(0.88124716281891), wave * DC.ar(0.34918081760406));
varX97MFusionB20134910 = Fold.ar(wave * DC.ar(0.49764513969421), wave * DC.ar(0.4497184753418), wave * DC.ar(0.15421259403229));
varX97MFusionB20134911 = IFFT.ar(wave * DC.ar(0.66252946853638), wave * DC.ar(0.48568081855774), wave * DC.ar(0.24421858787537));
varX97MFusionB20134912 = RHPF.ar(wave * DC.ar(0.95315945148468), wave * DC.ar(0.68357145786285), wave * DC.ar(0.86049938201904), wave * DC.ar(0.21589088439941), wave * DC.ar(0.98114335536957));
varX97MFusionB20134913 = IFFT.ar(wave * DC.ar(0.72715020179749), wave * DC.ar(0.21423828601837), wave * DC.ar(0.076396346092224));
varX97MFusionB20134914 = DC.ar(wave * DC.ar(0.29481887817383));

signal = varX97MFusionB20134914;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Filler.209201351
/////////////////////////////////////////////////////////

SynthDef.new("Filler.209201351", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varFiller2092013519, varFiller20920135110;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varFiller2092013519 = varFiller20920135110 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varFiller2092013519 = StkVoicForm.ar(modX, RHPF.ar(wave * DC.ar(0.56563031673431), wave * DC.ar(0.65544927120209), wave * DC.ar(0.7554087638855), wave * DC.ar(0.35643899440765), wave * DC.ar(0.18679964542389)), varFiller20920135110, modX * gateEnv, Rotate.ar(wave * DC.ar(0.52587759494781), wave * DC.ar(0.10978925228119), wave * DC.ar(0.74942815303802), wave * DC.ar(0.83506083488464), wave * DC.ar(0.90145480632782)), wave * env, modX * gateEnv, 0.99977686979644 * SinGrainIBF.ar(wave * DC.ar(0.007137656211853), wave * DC.ar(0.20394551753998), wave * DC.ar(0.62389302253723), wave * DC.ar(0.14637887477875), wave * DC.ar(0.23335075378418), wave * DC.ar(0.15327179431915), wave * DC.ar(0.41824460029602), wave * DC.ar(0.7555490732193), wave * DC.ar(0.4481828212738), wave * DC.ar(0.38225710391998), wave * DC.ar(0.13263714313507), wave * DC.ar(0.10278010368347)), Silent.ar());
varFiller20920135110 = BufAllpassN.ar(Array.fill(2.pow(13), { |i| rrand(-1, 1) }).as(LocalBuf), modY, modY * modX, x, 0.81332535684049 * gateEnv, Silent.ar());
varFiller2092013519 = LFNoise0.ar(wave * DC.ar(0.95703399181366), wave * DC.ar(0.66659796237946), wave * DC.ar(0.98795485496521));
varFiller20920135110 = Fhn2DL.ar(env * gateEnv, wave * modY, OSTrunc8.ar(wave * DC.ar(0.24324142932892), wave * DC.ar(0.88571178913116)), gateEnv * modX, in * env, modY, 0.56525337696075 * modY * signal, in, signal, 0.99106600072437 * modY * signal, Silent.ar());
varFiller2092013519 = StkBowed.ar(wave * DC.ar(0.25653076171875), wave * DC.ar(0.38736248016357), wave * DC.ar(0.74459362030029), wave * DC.ar(0.12744748592377), wave * DC.ar(0.093251466751099), wave * DC.ar(0.055314898490906), wave * DC.ar(0.87660980224609), wave * DC.ar(0.54168570041656), wave * DC.ar(0.14125657081604), wave * DC.ar(0.24137032032013), wave * DC.ar(0.73404264450073));
varFiller20920135110 = Balance.ar(wave * DC.ar(0.97537052631378), wave * DC.ar(0.36392188072205), wave * DC.ar(0.060249090194702), wave * DC.ar(0.43688726425171), wave * DC.ar(0.27673184871674), wave * DC.ar(0.57036697864532));

signal = varFiller20920135110;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// WM.Bandung.F201352
/////////////////////////////////////////////////////////

SynthDef.new("WM.Bandung.F201352", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varWMBandungF2013529, varWMBandungF20135210;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varWMBandungF2013529 = varWMBandungF20135210 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varWMBandungF2013529 = LPF1.ar(gateEnv * modZ, env * gateEnv);
varWMBandungF20135210 = Trig.ar(varWMBandungF2013529, z);
varWMBandungF2013529 = SyncSaw.ar(wave * DC.ar(0.51857113838196), wave * DC.ar(0.58028948307037), wave * DC.ar(0.35586071014404), wave * DC.ar(0.88997399806976));
varWMBandungF20135210 = BRZ2.ar(wave * DC.ar(0.5061172246933), wave * DC.ar(0.11412703990936), wave * DC.ar(0.2895188331604));
varWMBandungF2013529 = SelectL.ar(wave * DC.ar(0.7857072353363), wave * DC.ar(0.34427726268768));
varWMBandungF20135210 = BufDelayN.ar(wave * DC.ar(0.22372913360596), wave * DC.ar(0.79989004135132), wave * DC.ar(0.65410053730011), wave * DC.ar(0.47532844543457), wave * DC.ar(0.21241903305054));

signal = varWMBandungF20135210;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// WM.Bandung.F2013521
/////////////////////////////////////////////////////////

SynthDef.new("WM.Bandung.F2013521", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varWMBandungF2013529, varWMBandungF20135210, varWMBandungF201352111, varWMBandungF201352112;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varWMBandungF2013529 = varWMBandungF20135210 = varWMBandungF201352111 = varWMBandungF201352112 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varWMBandungF2013529 = MoogLadder.ar(0.03825044631958 * varWMBandungF201352111, varWMBandungF20135210.lagud(wave * DC.ar(0.25391793251038), wave * DC.ar(0.33268368244171)), wave * env, PartConv.ar(wave * DC.ar(0.030387759208679), wave * DC.ar(0.36635661125183), wave * DC.ar(0.25400292873383), wave * DC.ar(0.78949272632599), wave * DC.ar(0.51432347297668)), Silent.ar());
varWMBandungF20135210 = IEnvGen.ar(WhiteNoise.ar(wave * DC.ar(0.16295325756073), wave * DC.ar(0.44078981876373)), 0.18108582496643 * wave * modX, 0.99789029249278 * varWMBandungF201352112 * env, Silent.ar());
varWMBandungF2013529 = SinGrainBF.ar(wave * wave, env.mod(BBandStop.ar(wave * DC.ar(0.79432547092438), wave * DC.ar(0.51577997207642), wave * DC.ar(0.1972119808197), wave * DC.ar(0.95956933498383), wave * DC.ar(0.68042874336243))), varWMBandungF201352111 * varWMBandungF201352112, varWMBandungF20135210 * in, varWMBandungF201352111 * varWMBandungF20135210.lag3(wave * DC.ar(0.038838028907776), wave * DC.ar(0.4271981716156)), GlitchHPF.ar(wave * DC.ar(0.47054529190063), wave * DC.ar(0.50874435901642), wave * DC.ar(0.16021335124969), wave * DC.ar(0.38248062133789)), gateEnv, 0.99964949170535 * varWMBandungF201352111 * modZ, Silent.ar());
varWMBandungF20135210 = FoaPressX.ar(varWMBandungF201352111 * varWMBandungF201352112.exprange(wave * DC.ar(0.98169827461243), wave * DC.ar(0.86421382427216)), varWMBandungF201352112 * modZ, 0.99994560328899 * in, Silent.ar());
varWMBandungF2013529 = VOsc3.ar(wave * DC.ar(0.44595384597778), wave * DC.ar(0.55302715301514), wave * DC.ar(0.1120707988739), wave * DC.ar(0.99962842464447), wave * DC.ar(0.7150821685791), wave * DC.ar(0.63943326473236));
varWMBandungF20135210 = WrapSummer.ar(wave * DC.ar(0.19437313079834), wave * DC.ar(0.21158730983734), wave * DC.ar(0.613356590271), wave * DC.ar(0.54059851169586), wave * DC.ar(0.48666667938232), wave * DC.ar(0.59430587291718));
// Variation test code
varWMBandungF201352111 = AverageOutput.ar(varWMBandungF201352112, wave * varWMBandungF201352111, Slope.ar(varWMBandungF20135210 * DC.ar(0.14141607284546), varWMBandungF20135210 * DC.ar(0.035622477531433), varWMBandungF20135210 * DC.ar(0.062275528907776)), Silent.ar());
varWMBandungF201352112 = XFadeRotate.ar(varWMBandungF201352112 * modZ, modX);
varWMBandungF201352111 = Atari2600.ar(y, gateEnv * signal, modY * modX, varWMBandungF201352111 * varWMBandungF201352112, varWMBandungF201352112, amp, varWMBandungF20135210 * varWMBandungF2013529);
varWMBandungF201352112 = Limiter.ar(modY * varWMBandungF20135210, modZ, varWMBandungF20135210);
varWMBandungF201352111 = FSinOsc.ar(wave, modX * wave, 0.7782566641552 * CombC.ar(varWMBandungF2013529 * DC.ar(0.036749005317688), varWMBandungF2013529 * DC.ar(0.38662695884705), varWMBandungF2013529 * DC.ar(0.62777388095856), varWMBandungF20135210 * DC.ar(0.56699240207672), varWMBandungF20135210 * DC.ar(0.60804212093353), varWMBandungF2013529 * DC.ar(0.070403695106506)).exprange(varWMBandungF20135210 * DC.ar(0.55480802059174), varWMBandungF20135210 * DC.ar(0.40514945983887)), Silent.ar());
varWMBandungF201352112 = Gendy1.ar(modX, 0.65484285354614 * modY * in, wave, signal * signal, varWMBandungF2013529, Lag2UD.ar(varWMBandungF20135210 * DC.ar(0.21053087711334), varWMBandungF20135210 * DC.ar(0.7856240272522), varWMBandungF2013529 * DC.ar(0.14416408538818), varWMBandungF2013529 * DC.ar(0.60579204559326), varWMBandungF20135210 * DC.ar(0.72392499446869)).exprange(1, SampleRate.ir), modY * varWMBandungF201352111, signal * gateEnv, modX, y, in, Silent.ar());

signal = varWMBandungF201352112;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Poful.5392201352
/////////////////////////////////////////////////////////

SynthDef.new("Poful.5392201352", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varPoful53922013529, varPoful539220135210, varPoful539220135211;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varPoful53922013529 = varPoful539220135210 = varPoful539220135211 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varPoful53922013529 = LFDClipNoise.ar(BufCombN.ar(wave * DC.ar(0.62276697158813), wave * DC.ar(0.95227229595184), wave * DC.ar(0.73896288871765), wave * DC.ar(0.86099624633789), wave * DC.ar(0.38615739345551), wave * DC.ar(0.76091229915619)).exprange(1, SampleRate.ir), varPoful53922013529, Silent.ar());
varPoful539220135210 = Phasor.ar(modZ * env, in * env, gateEnv * varPoful539220135211, amp, in);
varPoful539220135211 = SendTrig.ar(x, amp, modZ * env);
varPoful53922013529 = HilbertFIR.ar(z, Array.fill(2.pow(10), { |i| rrand(-1, 1) }).as(LocalBuf));
varPoful539220135210 = GlitchRHPF.ar(wave * DC.ar(0.765061378479), wave * DC.ar(0.92822539806366), wave * DC.ar(0.83290660381317), wave * DC.ar(0.47628116607666), wave * DC.ar(0.57641839981079));
varPoful539220135211 = Clipper32.ar(amp, 0.26183271408081 * wave * modX, wave);
varPoful53922013529 = NLFiltN.ar(wave * DC.ar(0.27063000202179), wave * DC.ar(0.50655019283295), wave * DC.ar(0.78837823867798), wave * DC.ar(0.71334099769592), wave * DC.ar(0.22692632675171), wave * DC.ar(0.76892387866974), wave * DC.ar(0.9827846288681), wave * DC.ar(0.44910371303558));
varPoful539220135210 = RunningSum.ar(wave * DC.ar(0.039044380187988), wave * DC.ar(0.83239638805389));
varPoful539220135211 = PosRatio.ar(wave * DC.ar(0.58205699920654), wave * DC.ar(0.40531075000763), wave * DC.ar(0.082919836044312));

signal = varPoful539220135211;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Eumel.383.D(2)201352
/////////////////////////////////////////////////////////

SynthDef.new("Eumel.383.D(2)201352", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varEumel383D22013529, varEumel383D220135210, varEumel383D220135211, varEumel383D220135212, varEumel383D220135213, varEumel383D220135214, varEumel383D220135215;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varEumel383D22013529 = varEumel383D220135210 = varEumel383D220135211 = varEumel383D220135212 = varEumel383D220135213 = varEumel383D220135214 = varEumel383D220135215 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varEumel383D22013529 = Lorenz2DL.ar(varEumel383D220135213 * gateEnv, env, island, x, modY * varEumel383D22013529, y, gate, varEumel383D220135212 * env, varEumel383D220135215 * env, 0.85146354456265 * gateEnv * varEumel383D220135212, Silent.ar());
varEumel383D220135210 = LocalOut.ar([Latoocarfian2DN.ar(wave * DC.ar(0.55296576023102), wave * DC.ar(0.52484858036041), wave * DC.ar(0.29193019866943), wave * DC.ar(0.55175995826721), wave * DC.ar(0.68910598754883), wave * DC.ar(0.4149489402771), wave * DC.ar(0.53774285316467), wave * DC.ar(0.0027812719345093), wave * DC.ar(0.53043389320374), wave * DC.ar(0.78488790988922)), GbmanL.ar(wave * DC.ar(0.088045716285706), wave * DC.ar(0.93269383907318), wave * DC.ar(0.36825144290924), wave * DC.ar(0.50556194782257), wave * DC.ar(0.88731932640076))]);
varEumel383D220135211 = SinTone.ar(varEumel383D220135213 * varEumel383D220135211, varEumel383D220135215, AverageOutput.ar(wave * DC.ar(0.52840411663055), wave * DC.ar(0.4573380947113), wave * DC.ar(0.20669651031494), wave * DC.ar(0.40092873573303)), Silent.ar());
varEumel383D220135212 = Standard2DL.ar(varEumel383D220135210 * varEumel383D220135212, varEumel383D220135213 * varEumel383D220135210, z, in, modZ, BMoog.ar(wave * DC.ar(0.31263267993927), wave * DC.ar(0.047581791877747), wave * DC.ar(0.40627181529999), wave * DC.ar(0.53624391555786), wave * DC.ar(0.13841104507446), wave * DC.ar(0.1063951253891), wave * DC.ar(0.29588603973389)), LPCError.ar(wave * DC.ar(0.02243173122406), wave * DC.ar(0.94777595996857), wave * DC.ar(0.76645112037659), wave * DC.ar(0.21443939208984)));
varEumel383D220135213 = Fold.ar(modY, modX, varEumel383D220135210 * in);
varEumel383D220135214 = ScopeOut.ar([FMHEncode0.ar(wave * DC.ar(0.14001023769379), wave * DC.ar(0.5254909992218), wave * DC.ar(0.29461491107941), wave * DC.ar(0.00063717365264893)), AnalyseEvents2.ar(wave * DC.ar(0.62069749832153), wave * DC.ar(0.19959425926208), wave * DC.ar(0.75085306167603), wave * DC.ar(0.053996443748474), wave * DC.ar(0.39483332633972), wave * DC.ar(0.12473821640015))], Array.fill(2.pow(14), { |i| rrand(-1, 1) }).as(LocalBuf));
varEumel383D220135215 = WalshHadamard.ar(modY, signal.sqrsum(Delay1.ar(wave * DC.ar(0.4621354341507), wave * DC.ar(0.19717586040497), wave * DC.ar(0.14193248748779))), in, Silent.ar());
varEumel383D22013529 = FoaPsychoShelf.ar(wave * DC.ar(0.541375041008), wave * DC.ar(0.071880340576172), wave * DC.ar(0.43009221553802), wave * DC.ar(0.55032813549042), wave * DC.ar(0.94580602645874), wave * DC.ar(0.66318869590759));
varEumel383D220135210 = CuspN.ar(varEumel383D22013529, 0.90500330924988 * modY, wave * wave, varEumel383D220135213 * modY, 0.99515453424239 * signal * wave, Silent.ar());
varEumel383D220135211 = PVSynth.ar(Array.fill(2.pow(14), { |i| rrand(-1, 1) }).as(LocalBuf), varEumel383D220135214 * modX, 0.4946049451828 * BufAllpassC.ar(wave * DC.ar(0.33955669403076), wave * DC.ar(0.64937961101532), wave * DC.ar(0.29069554805756), wave * DC.ar(0.8716778755188), wave * DC.ar(0.79134726524353), wave * DC.ar(0.64594209194183)), varEumel383D220135215 * modX, modX * varEumel383D220135211, env * modZ, varEumel383D220135210, COsc.ar(wave * DC.ar(0.87334668636322), wave * DC.ar(0.953005194664), wave * DC.ar(0.37198841571808), wave * DC.ar(0.82438063621521), wave * DC.ar(0.42874848842621)), Silent.ar());
varEumel383D220135212 = TTendency.ar(FOS.ar(wave * DC.ar(0.98091220855713), wave * DC.ar(0.073622584342957), wave * DC.ar(0.80301260948181), wave * DC.ar(0.99993574619293), wave * DC.ar(0.14622581005096), wave * DC.ar(0.44371092319489)), env * wave, in, x, island, varEumel383D22013529 * modZ);
varEumel383D220135213 = PVSynth.ar(wave * DC.ar(0.88142037391663), wave * DC.ar(0.001191258430481), wave * DC.ar(0.24208056926727), wave * DC.ar(0.23199999332428), wave * DC.ar(0.24960458278656), wave * DC.ar(0.50564765930176), wave * DC.ar(0.055986404418945), wave * DC.ar(0.058560371398926), wave * DC.ar(0.11792421340942));
varEumel383D220135214 = Lag2UD.ar(varEumel383D220135210 * in.expexp(wave * DC.ar(0.79593288898468), wave * DC.ar(0.30615937709808), wave * DC.ar(0.57172584533691), wave * DC.ar(0.10116350650787), wave * DC.ar(0.49853539466858)), NLFiltL.ar(wave * DC.ar(0.55739867687225), wave * DC.ar(0.48603916168213), wave * DC.ar(0.97375667095184), wave * DC.ar(0.42024338245392), wave * DC.ar(0.54919600486755), wave * DC.ar(0.36212384700775), wave * DC.ar(0.53178238868713), wave * DC.ar(0.50232028961182)), signal * wave, 0.99997377681299 * MidEQ.ar(wave * DC.ar(0.36588144302368), wave * DC.ar(0.49320900440216), wave * DC.ar(0.15104818344116), wave * DC.ar(0.35662078857422), wave * DC.ar(0.31290674209595), wave * DC.ar(0.86751580238342)), Silent.ar());
varEumel383D220135215 = Lorenz2DN.ar(wave * DC.ar(0.85983085632324), wave * DC.ar(0.59271609783173), wave * DC.ar(0.46992981433868), wave * DC.ar(0.24997687339783), wave * DC.ar(0.29618501663208), wave * DC.ar(0.38291692733765), wave * DC.ar(0.0038410425186157), wave * DC.ar(0.8741569519043), wave * DC.ar(0.37197041511536), wave * DC.ar(0.65735495090485), wave * DC.ar(0.30345499515533));
varEumel383D22013529 = SanityCheck2.ar(wave * DC.ar(0.98498558998108));
varEumel383D220135210 = LTI.ar(wave * DC.ar(0.056003212928772), wave * DC.ar(0.84913432598114), wave * DC.ar(0.33739805221558), wave * DC.ar(0.61651217937469), wave * DC.ar(0.99564468860626));
varEumel383D220135211 = Crackle.ar(wave * DC.ar(0.38964033126831), wave * DC.ar(0.14813768863678), wave * DC.ar(0.38663244247437));
varEumel383D220135212 = GbmanL.ar(wave * DC.ar(0.91730690002441), wave * DC.ar(0.56949615478516), wave * DC.ar(0.2060090303421), wave * DC.ar(0.3720531463623), wave * DC.ar(0.56618356704712));
varEumel383D220135213 = Gbman2DC.ar(wave * DC.ar(0.012174367904663), wave * DC.ar(0.73182928562164), wave * DC.ar(0.9524290561676), wave * DC.ar(0.085734248161316), wave * DC.ar(0.7389327287674), wave * DC.ar(0.60022938251495));
varEumel383D220135214 = TExpRand.ar(wave * DC.ar(0.93454802036285), wave * DC.ar(0.24305903911591), wave * DC.ar(0.46298325061798));
varEumel383D220135215 = CompanderD.ar(wave * DC.ar(0.35419535636902), wave * DC.ar(0.97220075130463), wave * DC.ar(0.28695154190063), wave * DC.ar(0.64025592803955), wave * DC.ar(0.30551958084106), wave * DC.ar(0.61227631568909), wave * DC.ar(0.84287858009338), wave * DC.ar(0.10227715969086));

signal = varEumel383D220135215;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Trojan.Repsamo201356
/////////////////////////////////////////////////////////

SynthDef.new("Trojan.Repsamo201356", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varTrojanRepsamo2013569, varTrojanRepsamo20135610, varTrojanRepsamo20135611, varTrojanRepsamo20135612, varTrojanRepsamo20135613, varTrojanRepsamo20135614;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varTrojanRepsamo2013569 = varTrojanRepsamo20135610 = varTrojanRepsamo20135611 = varTrojanRepsamo20135612 = varTrojanRepsamo20135613 = varTrojanRepsamo20135614 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varTrojanRepsamo2013569 = OSFold8.ar(varTrojanRepsamo20135611, y, in * varTrojanRepsamo20135611);
varTrojanRepsamo20135610 = Pokey.ar(varTrojanRepsamo20135612 * modZ, varTrojanRepsamo2013569, varTrojanRepsamo20135612 * modX, modX * gateEnv, env, env * env, 0.3303234577179 * signal.bipolar(wave * DC.ar(0.8202497959137)), varTrojanRepsamo20135613, wave * signal);
varTrojanRepsamo20135611 = TExpRand.ar(env, modY * modZ, wave * gateEnv);
varTrojanRepsamo20135612 = Clip.ar(varTrojanRepsamo20135611 * varTrojanRepsamo20135611, t_trig, modZ * in.fold(wave * DC.ar(0.065936803817749), wave * DC.ar(0.88969457149506)));
varTrojanRepsamo20135613 = TExpRand.ar(z, wave * varTrojanRepsamo20135614, LPF.ar(wave * DC.ar(0.6203955411911), wave * DC.ar(0.46385502815247), wave * DC.ar(0.22879433631897), wave * DC.ar(0.67823362350464)));
varTrojanRepsamo20135614 = Pulse.ar(signal * varTrojanRepsamo20135614, varTrojanRepsamo20135614 * varTrojanRepsamo20135613, FoaPressX.ar(wave * DC.ar(0.60000026226044), wave * DC.ar(0.088595509529114), wave * DC.ar(0.78520226478577), wave * DC.ar(0.25809252262115)), Silent.ar());
varTrojanRepsamo2013569 = Stepper.ar(wave * DC.ar(0.98690032958984), wave * DC.ar(0.55809211730957), wave * DC.ar(0.63667070865631), wave * DC.ar(0.6452169418335), wave * DC.ar(0.10860204696655), wave * DC.ar(0.73588228225708));
varTrojanRepsamo20135610 = Formlet.ar(wave * DC.ar(0.15510535240173), wave * DC.ar(0.98198044300079), wave * DC.ar(0.25963866710663), wave * DC.ar(0.43392109870911), wave * DC.ar(0.92563271522522), wave * DC.ar(0.37840127944946));
varTrojanRepsamo20135611 = LFDNoise0.ar(Shaper.ar(wave * DC.ar(0.18940019607544), wave * DC.ar(0.57814681529999), wave * DC.ar(0.57391047477722), wave * DC.ar(0.14640963077545)).exprange(1, SampleRate.ir), 0.99593942041275 * wave * gateEnv, Silent.ar());
varTrojanRepsamo20135612 = RedPhasor2.ar(modX * varTrojanRepsamo20135612, wave, y, modX * varTrojanRepsamo20135611, modY * varTrojanRepsamo20135611, varTrojanRepsamo20135613, varTrojanRepsamo20135614 * gateEnv);
varTrojanRepsamo20135613 = Nes2.ar(wave * DC.ar(0.57517766952515), wave * DC.ar(0.64243733882904), wave * DC.ar(0.042762398719788), wave * DC.ar(0.10044384002686), wave * DC.ar(0.35889053344727), wave * DC.ar(0.6022766828537), wave * DC.ar(0.10024738311768), wave * DC.ar(0.19718837738037), wave * DC.ar(0.57114481925964), wave * DC.ar(0.19753611087799), wave * DC.ar(0.84573900699615), wave * DC.ar(0.55160248279572), wave * DC.ar(0.51177310943604), wave * DC.ar(0.019468426704407), wave * DC.ar(0.74408304691315), wave * DC.ar(0.32619893550873), wave * DC.ar(0.21944725513458), wave * DC.ar(0.32373201847076), wave * DC.ar(0.085039615631104), wave * DC.ar(0.23194682598114));
varTrojanRepsamo20135614 = AtsBand.ar(Array.fill(2.pow(12), { |i| rrand(-1, 1) }).as(LocalBuf), modY, varTrojanRepsamo20135611 * in, LFPar.ar(wave * DC.ar(0.80473637580872), wave * DC.ar(0.32549941539764), wave * DC.ar(0.90414941310883), wave * DC.ar(0.95468628406525)), Silent.ar());
varTrojanRepsamo2013569 = Breakcore.ar(wave * DC.ar(0.88383889198303), wave * DC.ar(0.54405248165131), wave * DC.ar(0.34855902194977), wave * DC.ar(0.86720061302185), wave * DC.ar(0.47310996055603));
varTrojanRepsamo20135610 = Fhn2DN.ar(wave * DC.ar(0.25704109668732), wave * DC.ar(0.89037108421326), wave * DC.ar(0.91390979290009), wave * DC.ar(0.70917820930481), wave * DC.ar(0.076910257339478), wave * DC.ar(0.13465678691864), wave * DC.ar(0.38258695602417), wave * DC.ar(0.099567532539368), wave * DC.ar(0.20753407478333), wave * DC.ar(0.31014370918274), wave * DC.ar(0.043832421302795));
varTrojanRepsamo20135611 = TBetaRand.ar(wave * DC.ar(0.90772104263306), wave * DC.ar(0.19869303703308), wave * DC.ar(0.88297128677368), wave * DC.ar(0.57316851615906), wave * DC.ar(0.084023594856262), wave * DC.ar(0.52495467662811), wave * DC.ar(0.24322021007538));
varTrojanRepsamo20135612 = Balance2.ar(wave * DC.ar(0.45155239105225), wave * DC.ar(0.75123512744904), wave * DC.ar(0.11305475234985), wave * DC.ar(0.58176553249359));
varTrojanRepsamo20135613 = B2UHJ.ar(wave * DC.ar(0.12334966659546), wave * DC.ar(0.60889339447021), wave * DC.ar(0.3718866109848));
varTrojanRepsamo20135614 = Concat2.ar(wave * DC.ar(0.081667065620422), wave * DC.ar(0.28687584400177), wave * DC.ar(0.27155578136444), wave * DC.ar(0.36616790294647), wave * DC.ar(0.79285907745361), wave * DC.ar(0.96949946880341), wave * DC.ar(0.69588112831116), wave * DC.ar(0.52341222763062), wave * DC.ar(0.57374560832977), wave * DC.ar(0.83219528198242), wave * DC.ar(0.32648873329163), wave * DC.ar(0.66487050056458), wave * DC.ar(0.69618535041809), wave * DC.ar(0.56221663951874), wave * DC.ar(0.6767863035202));

signal = varTrojanRepsamo20135614;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Cruel.1024201356
/////////////////////////////////////////////////////////

SynthDef.new("Cruel.1024201356", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varCruel10242013569, varCruel102420135610, varCruel102420135611;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varCruel10242013569 = varCruel102420135610 = varCruel102420135611 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varCruel10242013569 = OSTrunc8.ar(island, modZ);
varCruel102420135610 = LFBrownNoise1.ar(modY * varCruel102420135611, 0.013424277305603 * varCruel102420135611 * modZ, t_trig, 0.98309491651211 * wave * varCruel102420135610, Silent.ar());
varCruel102420135611 = InRange.ar(amp, varCruel102420135611 * varCruel102420135611, modX.blend(wave * DC.ar(0.403604388237), wave * DC.ar(0.6950261592865)));
varCruel10242013569 = PulseCount.ar(wave, gateEnv * env);
varCruel102420135610 = LFClipNoise.ar(modY * gateEnv, 0.99996764505991 * varCruel102420135611, Rotate.ar(wave * DC.ar(0.087682723999023), wave * DC.ar(0.25704288482666), wave * DC.ar(0.27219939231873), wave * DC.ar(0.59163403511047), wave * DC.ar(0.78561961650848)));
varCruel102420135611 = InGrainBF.ar(modY * varCruel102420135611, bufnum, env * in, modZ * modX, varCruel10242013569, VOsc3.ar(wave * DC.ar(0.32776629924774), wave * DC.ar(0.61730539798737), wave * DC.ar(0.77349829673767), wave * DC.ar(0.68793749809265), wave * DC.ar(0.5339457988739), wave * DC.ar(0.59388875961304)), signal, InGrainBF.ar(wave * DC.ar(0.41542661190033), wave * DC.ar(0.62600708007812), wave * DC.ar(0.4555572271347), wave * DC.ar(0.85903096199036), wave * DC.ar(0.88270127773285), wave * DC.ar(0.63440954685211), wave * DC.ar(0.82371401786804), wave * DC.ar(0.049353837966919), wave * DC.ar(0.3849333524704)), Silent.ar());
varCruel10242013569 = K2A.ar(wave * DC.ar(0.056416630744934));
varCruel102420135610 = DegreeToKey.ar(wave * DC.ar(0.92750775814056), wave * DC.ar(0.22906064987183), wave * DC.ar(0.7831175327301), wave * DC.ar(0.81219875812531), wave * DC.ar(0.90052175521851));
varCruel102420135611 = LinPan2.ar(wave * DC.ar(0.20950675010681), wave * DC.ar(0.74249362945557), wave * DC.ar(0.17608261108398));

signal = varCruel102420135611;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// WM.Dietzel.A201358
/////////////////////////////////////////////////////////

SynthDef.new("WM.Dietzel.A201358", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varWMDietzelA2013589, varWMDietzelA20135810, varWMDietzelA20135811;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varWMDietzelA2013589 = varWMDietzelA20135810 = varWMDietzelA20135811 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varWMDietzelA2013589 = BufDelayN.ar(Array.fill(2.pow(14), { |i| rrand(-1, 1) }).as(LocalBuf), varWMDietzelA2013589, y, 0.99995730982562 * DoubleNestedAllpassC.ar(wave * DC.ar(0.56670832633972), wave * DC.ar(0.52678287029266), wave * DC.ar(0.99794387817383), wave * DC.ar(0.67005515098572), wave * DC.ar(0.9119747877121), wave * DC.ar(0.99135434627533), wave * DC.ar(0.16181147098541), wave * DC.ar(0.92856049537659), wave * DC.ar(0.3987250328064), wave * DC.ar(0.764728307724), wave * DC.ar(0.4731650352478), wave * DC.ar(0.6781507730484)), Silent.ar());
varWMDietzelA20135810 = InRange.ar(0.57778203487396 * modY * in, gateEnv, wave);
varWMDietzelA20135811 = ChuaL.ar(Fold.ar(wave * DC.ar(0.92693698406219), wave * DC.ar(0.39119899272919), wave * DC.ar(0.61115288734436)).exprange(1, SampleRate.ir), 0.21218919754028 * TRand.ar(wave * DC.ar(0.57534122467041), wave * DC.ar(0.67040503025055), wave * DC.ar(0.40381562709808)), modZ * varWMDietzelA20135811, gateEnv * varWMDietzelA20135811, varWMDietzelA20135810 * gateEnv, varWMDietzelA20135810 * modX, varWMDietzelA20135811 * modZ, wave, modY * wave, modY, 0.76693952566965 * FMGrainB.ar(wave * DC.ar(0.073371410369873), wave * DC.ar(0.52027058601379), wave * DC.ar(0.94329273700714), wave * DC.ar(0.99566423892975), wave * DC.ar(0.059963583946228), wave * DC.ar(0.81499326229095), wave * DC.ar(0.67044425010681), wave * DC.ar(0.64183259010315)), Silent.ar());
varWMDietzelA2013589 = DetectIndex.ar(wave * DC.ar(0.068746209144592), wave * DC.ar(0.52485036849976), wave * DC.ar(0.301997423172), wave * DC.ar(0.95718193054199));
varWMDietzelA20135810 = SVF.ar(wave * DC.ar(0.55326557159424), wave * DC.ar(0.97872567176819), wave * DC.ar(0.62948489189148), wave * DC.ar(0.60901403427124), wave * DC.ar(0.33975124359131), wave * DC.ar(0.30864262580872), wave * DC.ar(0.74347686767578), wave * DC.ar(0.44803297519684), wave * DC.ar(0.94999802112579), wave * DC.ar(0.73108434677124));
varWMDietzelA20135811 = PeakEQ4.ar(wave * DC.ar(0.61024165153503), wave * DC.ar(0.23683261871338), wave * DC.ar(0.31693065166473), wave * DC.ar(0.6117901802063));
varWMDietzelA2013589 = Brusselator.ar(wave * DC.ar(0.72983705997467), wave * DC.ar(0.79018068313599), wave * DC.ar(0.50292384624481), wave * DC.ar(0.38368022441864), wave * DC.ar(0.66585981845856), wave * DC.ar(0.13088309764862), wave * DC.ar(0.22802484035492), wave * DC.ar(0.78775203227997));
varWMDietzelA20135810 = MoogLadder.ar(wave * DC.ar(0.7419536113739), wave * DC.ar(0.63703906536102), wave * DC.ar(0.76829469203949), wave * DC.ar(0.50704789161682), wave * DC.ar(0.8206775188446));
varWMDietzelA20135811 = Slub.ar(wave * DC.ar(0.53518497943878), wave * DC.ar(0.92939972877502));

signal = varWMDietzelA20135811;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// HundredPC.684201359
/////////////////////////////////////////////////////////

SynthDef.new("HundredPC.684201359", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varHundredPC6842013599, varHundredPC68420135910, varHundredPC68420135911;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varHundredPC6842013599 = varHundredPC68420135910 = varHundredPC68420135911 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varHundredPC6842013599 = In.ar((80 + (island * 2)), 2);
varHundredPC68420135910 = MeanTriggered.ar(in * modX, Amplitude.ar(wave * DC.ar(0.97976982593536), wave * DC.ar(0.38583636283875), wave * DC.ar(0.53544366359711), wave * DC.ar(0.66202330589294), wave * DC.ar(0.50651967525482)), varHundredPC6842013599 * modY.bipolar(wave * DC.ar(0.54224228858948)), 0.99994833085447 * signal, Silent.ar());
varHundredPC68420135911 = MZPokey.ar(DetectIndex.ar(wave * DC.ar(0.99002707004547), wave * DC.ar(0.37285244464874), wave * DC.ar(0.10783839225769), wave * DC.ar(0.94076097011566)), varHundredPC6842013599 * env, env * modX, 0.71199905872345 * modY * varHundredPC68420135910, modY * modZ, bufnum, in, z, wave);
varHundredPC6842013599 = Slub.ar(wave * DC.ar(0.084230661392212), wave * DC.ar(0.9084769487381));
varHundredPC68420135910 = Decay.ar(0.28715837001801 * modZ * modZ, varHundredPC68420135911 * signal, 0.77950509060343 * varHundredPC68420135910, Silent.ar());
varHundredPC68420135911 = RunningMin.ar(varHundredPC6842013599 * gateEnv, modY * env);
varHundredPC6842013599 = BufDelayL.ar(wave * DC.ar(0.38732254505157), wave * DC.ar(0.7497626543045), wave * DC.ar(0.65495693683624), wave * DC.ar(0.85946023464203), wave * DC.ar(0.51080346107483));
varHundredPC68420135910 = Decimator.ar(wave * DC.ar(0.57701766490936), wave * DC.ar(0.13369357585907), wave * DC.ar(0.78455185890198), wave * DC.ar(0.71093571186066), wave * DC.ar(0.068416595458984));
varHundredPC68420135911 = MonoGrainBF.ar(wave * DC.ar(0.97411453723907), wave * DC.ar(0.84907639026642), wave * DC.ar(0.11347985267639), wave * DC.ar(0.48915922641754), wave * DC.ar(0.24929094314575), wave * DC.ar(0.59926736354828), wave * DC.ar(0.46636915206909), wave * DC.ar(0.25808501243591), wave * DC.ar(0.08215057849884), wave * DC.ar(0.70584630966187), wave * DC.ar(0.73353838920593));

signal = varHundredPC68420135911;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// HundredPC.6842013591
/////////////////////////////////////////////////////////

SynthDef.new("HundredPC.6842013591", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varHundredPC6842013599, varHundredPC68420135910, varHundredPC68420135911, varHundredPC684201359112;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varHundredPC6842013599 = varHundredPC68420135910 = varHundredPC68420135911 = varHundredPC684201359112 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varHundredPC6842013599 = DoubleWell3.ar(modZ, bufnum, in, x, varHundredPC68420135911 * in, 0.93940532207489 * OSWrap8.ar(wave * DC.ar(0.2139858007431), wave * DC.ar(0.44707143306732), wave * DC.ar(0.078085899353027)), 0.99812890550016 * modZ * varHundredPC684201359112, Silent.ar());
varHundredPC68420135910 = RLPF.ar(modZ * varHundredPC68420135911, env * in, modX, 0.89492077153325 * in * varHundredPC684201359112, Silent.ar());
varHundredPC68420135911 = OSWrap4.ar(varHundredPC684201359112, varHundredPC68420135911, gateEnv);
varHundredPC6842013599 = LPCError.ar(varHundredPC6842013599, gateEnv * modX, NLFiltN.ar(wave * DC.ar(0.22994565963745), wave * DC.ar(0.96000516414642), wave * DC.ar(0.95521426200867), wave * DC.ar(0.21002590656281), wave * DC.ar(0.6096373796463), wave * DC.ar(0.88439190387726), wave * DC.ar(0.70956015586853), wave * DC.ar(0.11135792732239)), Silent.ar().blend(wave * DC.ar(0.88644742965698), wave * DC.ar(0.13220453262329)));
varHundredPC68420135910 = WrapIndex.ar(wave * DC.ar(0.72917437553406), wave * DC.ar(0.8929967880249), wave * DC.ar(0.68289148807526), wave * DC.ar(0.62345445156097));
varHundredPC68420135911 = PanX2D.ar(2, 2, varHundredPC68420135910, SyncSaw.ar(wave * DC.ar(0.83374440670013), wave * DC.ar(0.86991131305695), wave * DC.ar(0.66726934909821), wave * DC.ar(0.81268382072449)), amp, modZ, modY, gateEnv * varHundredPC6842013599);
varHundredPC6842013599 = Concat.ar(wave * DC.ar(0.68040442466736), wave * DC.ar(0.090783596038818), wave * DC.ar(0.58711075782776), wave * DC.ar(0.98014616966248), wave * DC.ar(0.84969711303711), wave * DC.ar(0.40532600879669), wave * DC.ar(0.22690987586975), wave * DC.ar(0.23639106750488), wave * DC.ar(0.12190723419189), wave * DC.ar(0.057471036911011), wave * DC.ar(0.50070822238922), wave * DC.ar(0.84315466880798), wave * DC.ar(0.86128211021423), wave * DC.ar(0.89166915416718));
varHundredPC68420135910 = FoaDominateZ.ar(wave * DC.ar(0.53883564472198), wave * DC.ar(0.43387532234192), wave * DC.ar(0.87040042877197), wave * DC.ar(0.44551849365234));
varHundredPC68420135911 = Convolution3.ar(wave * DC.ar(0.95739805698395), wave * DC.ar(0.64153051376343), wave * DC.ar(0.45660841464996), wave * DC.ar(0.043218970298767), wave * DC.ar(0.4656800031662), wave * DC.ar(0.80270171165466));
// Variation test code
varHundredPC684201359112 = SanityCheck2.ar(varHundredPC68420135911 * gateEnv);
varHundredPC684201359112 = Fhn2DC.ar(XFadeRotate.ar(varHundredPC68420135910 * DC.ar(0.70841383934021), varHundredPC68420135910 * DC.ar(0.94002139568329)).exprange(1, SampleRate.ir), env * env.clip2(FoaPushY.ar(varHundredPC6842013599 * DC.ar(0.23789811134338), varHundredPC68420135911 * DC.ar(0.49782943725586), varHundredPC68420135911 * DC.ar(0.69930422306061), varHundredPC68420135911 * DC.ar(0.56912779808044))), modY * modY, Clipper8.ar(env, in, signal * in), signal * modY, varHundredPC68420135911, env, modZ * env, 0.096700072288513 * env * varHundredPC68420135910, StkMandolin.ar(varHundredPC68420135911 * DC.ar(0.87665283679962), varHundredPC68420135910 * DC.ar(0.66050839424133), varHundredPC68420135911 * DC.ar(0.52385914325714), varHundredPC68420135910 * DC.ar(0.45922672748566), varHundredPC68420135910 * DC.ar(0.49304902553558), varHundredPC6842013599 * DC.ar(0.72484457492828), varHundredPC6842013599 * DC.ar(0.2769763469696), varHundredPC68420135911 * DC.ar(0.35209918022156), varHundredPC68420135910 * DC.ar(0.42830801010132)), Silent.ar());
varHundredPC684201359112 = SinTone.ar(FoaDominateZ.ar(varHundredPC68420135910 * DC.ar(0.41192317008972), varHundredPC68420135910 * DC.ar(0.47395372390747), varHundredPC68420135910 * DC.ar(0.55126738548279), varHundredPC68420135911 * DC.ar(0.64061558246613)).exprange(1, SampleRate.ir), in, in, Silent.ar());

signal = varHundredPC684201359112;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// WM.Irish.F2014001
/////////////////////////////////////////////////////////

SynthDef.new("WM.Irish.F2014001", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varWMIrishF2014009, varWMIrishF20140010, varWMIrishF20140011, varWMIrishF201400112, varWMIrishF201400113;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varWMIrishF2014009 = varWMIrishF20140010 = varWMIrishF20140011 = varWMIrishF201400112 = varWMIrishF201400113 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varWMIrishF2014009 = Amplitude.ar(signal, gateEnv, modY * varWMIrishF20140010, modX, Silent.ar());
varWMIrishF20140010 = Lorenz2DN.ar(TIRand.ar(wave * DC.ar(0.32062983512878), wave * DC.ar(0.55322289466858), wave * DC.ar(0.24398994445801)).exprange(1, SampleRate.ir), varWMIrishF20140011 * modZ, varWMIrishF20140010 * modY, in, signal * modX, modY * gateEnv, FreeVerb.ar(wave * DC.ar(0.39560794830322), wave * DC.ar(0.99537968635559), wave * DC.ar(0.0499507188797), wave * DC.ar(0.68134152889252), wave * DC.ar(0.5021904706955), wave * DC.ar(0.65990376472473)), env * varWMIrishF20140010.linlin(wave * DC.ar(0.49480509757996), wave * DC.ar(0.29844355583191), wave * DC.ar(0.71102166175842), wave * DC.ar(0.34519517421722), wave * DC.ar(0.96320974826813)), modX * env, 0.99828995881554 * in * varWMIrishF20140011, Silent.ar());
varWMIrishF20140011 = InRange.ar(env, varWMIrishF2014009, 0.93126213550568 * varWMIrishF20140010 * env);
varWMIrishF2014009 = MostChange.ar(wave * DC.ar(0.68326938152313), wave * DC.ar(0.59120404720306));
varWMIrishF20140010 = Wrap.ar(varWMIrishF201400112 * varWMIrishF20140011, varWMIrishF201400112, gate);
varWMIrishF20140011 = SinOscFB.ar(varWMIrishF2014009, 0.034203410148621 * signal * wave, varWMIrishF201400113, Silent.ar());
varWMIrishF2014009 = BiPanB2.ar(wave * DC.ar(0.81652629375458), wave * DC.ar(0.24535846710205), wave * DC.ar(0.16680717468262), wave * DC.ar(0.031497478485107));
varWMIrishF20140010 = Standard2DL.ar(wave * DC.ar(0.77402698993683), wave * DC.ar(0.047722458839417), wave * DC.ar(0.33882927894592), wave * DC.ar(0.064088225364685), wave * DC.ar(0.74385833740234), wave * DC.ar(0.9793541431427), wave * DC.ar(0.13894820213318));
varWMIrishF20140011 = Gendy5.ar(wave * DC.ar(0.91278910636902), wave * DC.ar(0.62903904914856), wave * DC.ar(0.26939511299133), wave * DC.ar(0.40502142906189), wave * DC.ar(0.3502254486084), wave * DC.ar(0.72948086261749), wave * DC.ar(0.49756050109863), wave * DC.ar(0.63996493816376), wave * DC.ar(0.5481173992157), wave * DC.ar(0.52948021888733), wave * DC.ar(0.91573715209961), wave * DC.ar(0.2663311958313));
// Variation test code
varWMIrishF201400112 = SoftClipper4.ar(gate);
varWMIrishF201400113 = Atari2600.ar(varWMIrishF20140011, modX * gateEnv, modY * varWMIrishF20140011, env * modZ, t_trig, modX * in.linlin(varWMIrishF2014009 * DC.ar(0.84802234172821), varWMIrishF20140010 * DC.ar(0.33789157867432), varWMIrishF20140011 * DC.ar(0.29865515232086), varWMIrishF20140010 * DC.ar(0.50325489044189), varWMIrishF20140010 * DC.ar(0.28686094284058)), gateEnv * modY);
varWMIrishF201400112 = LinPan2.ar(0.34612214565277 * varWMIrishF2014009, env * modX, in);
varWMIrishF201400113 = YigMandelbulbN.ar(varWMIrishF20140010 * gateEnv, varWMIrishF201400113 * in, in * gateEnv, gateEnv, x, modX, Silent.ar());
varWMIrishF201400112 = MedianTriggered.ar(amp, env, gateEnv * wave, B2UHJ.ar(varWMIrishF2014009 * DC.ar(0.7245477437973), varWMIrishF2014009 * DC.ar(0.015296101570129), varWMIrishF20140010 * DC.ar(0.066036581993103)), Silent.ar());
varWMIrishF201400113 = RosslerL.ar(varWMIrishF20140010 * signal, modZ * wave.unsignedRightShift(NestedAllpassC.ar(varWMIrishF2014009 * DC.ar(0.10531508922577), varWMIrishF2014009 * DC.ar(0.54629421234131), varWMIrishF20140011 * DC.ar(0.85295903682709), varWMIrishF20140011 * DC.ar(0.26995694637299), varWMIrishF2014009 * DC.ar(0.48635399341583), varWMIrishF20140010 * DC.ar(0.93934512138367), varWMIrishF20140010 * DC.ar(0.13939607143402), varWMIrishF20140011 * DC.ar(0.42331051826477), varWMIrishF20140010 * DC.ar(0.23406803607941))), varWMIrishF201400112, modX * signal, signal * signal, amp, gateEnv * varWMIrishF2014009, varWMIrishF20140010 * modX, 0.96626442796797 * wave * varWMIrishF201400112, Silent.ar());

signal = varWMIrishF201400113;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// BAT.Corea.293201400
/////////////////////////////////////////////////////////

SynthDef.new("BAT.Corea.293201400", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varBATCorea2932014009, varBATCorea29320140010, varBATCorea29320140011;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varBATCorea2932014009 = varBATCorea29320140010 = varBATCorea29320140011 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varBATCorea2932014009 = CheckBadValues.ar(0.73826444149017 * signal * env, y, in);
varBATCorea29320140010 = LFDNoise3.ar(wave * gateEnv, in, Silent.ar());
varBATCorea29320140011 = Slope.ar(in * gateEnv, LFDNoise3.ar(wave * DC.ar(0.55913960933685), wave * DC.ar(0.33829843997955), wave * DC.ar(0.32834208011627)), Silent.ar());
varBATCorea2932014009 = ReplaceOut.ar(wave * DC.ar(0.83168852329254), wave * DC.ar(0.84542262554169));
varBATCorea29320140010 = Convolution.ar(0.90206730365753 * PeakEQ4.ar(wave * DC.ar(0.83936500549316), wave * DC.ar(0.5163642168045), wave * DC.ar(0.26277482509613), wave * DC.ar(0.53336918354034)), signal * modX, wave, DoubleNestedAllpassL.ar(wave * DC.ar(0.14670276641846), wave * DC.ar(0.0072993040084839), wave * DC.ar(0.56250059604645), wave * DC.ar(0.10078608989716), wave * DC.ar(0.032068967819214), wave * DC.ar(0.87884080410004), wave * DC.ar(0.03451144695282), wave * DC.ar(0.16377592086792), wave * DC.ar(0.90313959121704), wave * DC.ar(0.9591760635376), wave * DC.ar(0.073953151702881), wave * DC.ar(0.64322650432587)), Silent.ar());
varBATCorea29320140011 = FMGrainI.ar(wave * DC.ar(0.58832228183746), wave * DC.ar(0.80671894550323), wave * DC.ar(0.25778150558472), wave * DC.ar(0.43957436084747), wave * DC.ar(0.78114151954651), wave * DC.ar(0.20838212966919), wave * DC.ar(0.95492148399353), wave * DC.ar(0.12331783771515), wave * DC.ar(0.85525584220886), wave * DC.ar(0.53948378562927));
varBATCorea2932014009 = TBall.ar(wave * DC.ar(0.54311954975128), wave * DC.ar(0.27815425395966), wave * DC.ar(0.32917535305023), wave * DC.ar(0.35268819332123));
varBATCorea29320140010 = GbmanL.ar(wave * DC.ar(0.11572074890137), wave * DC.ar(0.44320142269135), wave * DC.ar(0.7522999048233), wave * DC.ar(0.77220904827118), wave * DC.ar(0.56379783153534));
varBATCorea29320140011 = BLowPass.ar(wave * DC.ar(0.25709164142609), wave * DC.ar(0.98751032352448), wave * DC.ar(0.058891177177429), wave * DC.ar(0.44803392887115), wave * DC.ar(0.60249602794647));

signal = varBATCorea29320140011;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// HLLO.6561201400
/////////////////////////////////////////////////////////

SynthDef.new("HLLO.6561201400", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varHLLO65612014009, varHLLO656120140010, varHLLO656120140011;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varHLLO65612014009 = varHLLO656120140010 = varHLLO656120140011 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varHLLO65612014009 = LorenzL.ar(modY * wave, varHLLO65612014009 * in, env * wave, gate, gateEnv * gateEnv, varHLLO656120140011 * modY, gate, varHLLO656120140011, LFDClipNoise.ar(wave * DC.ar(0.28491914272308), wave * DC.ar(0.39681005477905), wave * DC.ar(0.39841222763062)), Silent.ar());
varHLLO656120140010 = Gbman2DC.ar(StkModalBar.ar(wave * DC.ar(0.90385925769806), wave * DC.ar(0.34802198410034), wave * DC.ar(0.77919018268585), wave * DC.ar(0.25740957260132), wave * DC.ar(0.69574248790741), wave * DC.ar(0.81334292888641), wave * DC.ar(0.43409860134125), wave * DC.ar(0.89943397045135), wave * DC.ar(0.047193765640259), wave * DC.ar(0.19884610176086), wave * DC.ar(0.18337512016296)).exprange(1, SampleRate.ir), GrayNoise.ar(wave * DC.ar(0.28509056568146), wave * DC.ar(0.74364769458771)).exprange(1, SampleRate.ir), modZ * varHLLO656120140011, x, signal, Silent.ar());
varHLLO656120140011 = BFDecode1.ar(varHLLO656120140011 * in.lagud(wave * DC.ar(0.5144180059433), wave * DC.ar(0.56513249874115)), env, modZ, varHLLO656120140010 * varHLLO656120140010, z, varHLLO65612014009 * modX, modY * signal, 0.99995016881599 * varHLLO65612014009 * wave, Silent.ar());
varHLLO65612014009 = CrossoverDistortion.ar(wave * DC.ar(0.72523510456085), wave * DC.ar(0.0032310485839844), wave * DC.ar(0.29342663288116), wave * DC.ar(0.3542286157608), wave * DC.ar(0.50854849815369));
varHLLO656120140010 = FoaPushZ.ar(island, env * in, varHLLO656120140010, Silent.ar());
varHLLO656120140011 = RosslerResL.ar(wave * DC.ar(0.29306542873383), wave * DC.ar(0.88381445407867), wave * DC.ar(0.045056223869324), wave * DC.ar(0.89473032951355), wave * DC.ar(0.7938928604126), wave * DC.ar(0.8143390417099), wave * DC.ar(0.77149212360382), wave * DC.ar(0.66541874408722), wave * DC.ar(0.0097353458404541), wave * DC.ar(0.6412513256073), wave * DC.ar(0.24058759212494), wave * DC.ar(0.16567385196686));
varHLLO65612014009 = Maxamp.ar(wave * DC.ar(0.59885346889496), wave * DC.ar(0.91762542724609));
varHLLO656120140010 = CombN.ar(wave * DC.ar(0.43857133388519), wave * DC.ar(0.16376936435699), wave * DC.ar(0.25726699829102), wave * DC.ar(0.97625207901001), wave * DC.ar(0.01200008392334), wave * DC.ar(0.45183730125427));
varHLLO656120140011 = FoaDirectY.ar(wave * DC.ar(0.14693534374237), wave * DC.ar(0.42874765396118), wave * DC.ar(0.65016901493073), wave * DC.ar(0.99770665168762));

signal = varHLLO656120140011;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// W97M.Tamago.E201401
/////////////////////////////////////////////////////////

SynthDef.new("W97M.Tamago.E201401", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varW97MTamagoE2014019, varW97MTamagoE20140110, varW97MTamagoE20140111;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varW97MTamagoE2014019 = varW97MTamagoE20140110 = varW97MTamagoE20140111 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varW97MTamagoE2014019 = Convolution.ar(env * gateEnv, varW97MTamagoE20140110, modY, 0.99993345041874 * varW97MTamagoE20140110 * varW97MTamagoE2014019, Silent.ar());
varW97MTamagoE20140110 = Slub.ar(modX * in, modZ * varW97MTamagoE20140110.lag2ud(wave * DC.ar(0.55305993556976), wave * DC.ar(0.2011843919754)));
varW97MTamagoE20140111 = Astrocade.ar(0.68228912353516 * modX * modX, modX * env, z, t_trig, varW97MTamagoE20140111 * varW97MTamagoE20140110, modY, varW97MTamagoE2014019 * signal, modX * modX);
varW97MTamagoE2014019 = MantissaMask.ar(wave * DC.ar(0.87620437145233), wave * DC.ar(0.047870993614197), wave * DC.ar(0.49853563308716), wave * DC.ar(0.34758710861206));
varW97MTamagoE20140110 = Poll.ar(wave * DC.ar(0.36694550514221), wave * DC.ar(0.40583658218384), wave * DC.ar(0.69744420051575), wave * DC.ar(0.39396798610687));
varW97MTamagoE20140111 = GrainBuf.ar(2, wave * varW97MTamagoE20140110, 0.27393937110901 * varW97MTamagoE2014019 * modX, bufnum, z, amp, modY * modX, varW97MTamagoE2014019, bufnum, QuadN.ar(wave * DC.ar(0.98883163928986), wave * DC.ar(0.11960566043854), wave * DC.ar(0.11317205429077), wave * DC.ar(0.12584125995636), wave * DC.ar(0.68887865543365), wave * DC.ar(0.7391744852066), wave * DC.ar(0.1305605173111)), BiPanB2.ar(wave * DC.ar(0.79860377311707), wave * DC.ar(0.27117574214935), wave * DC.ar(0.84273731708527), wave * DC.ar(0.43413996696472)), Peak.ar(wave * DC.ar(0.82818329334259), wave * DC.ar(0.47472238540649)));
varW97MTamagoE2014019 = Pluck.ar(wave * DC.ar(0.80333566665649), wave * DC.ar(0.1095358133316), wave * DC.ar(0.077099561691284), wave * DC.ar(0.36727702617645), wave * DC.ar(0.53616297245026), wave * DC.ar(0.96386384963989), wave * DC.ar(0.20018637180328), wave * DC.ar(0.13052272796631));
varW97MTamagoE20140110 = FMHDecode1.ar(wave * DC.ar(0.48941075801849), wave * DC.ar(0.1828635931015), wave * DC.ar(0.96310794353485), wave * DC.ar(0.33159983158112), wave * DC.ar(0.57265210151672), wave * DC.ar(0.87001085281372), wave * DC.ar(0.95646178722382), wave * DC.ar(0.056172966957092), wave * DC.ar(0.14521086215973), wave * DC.ar(0.082594752311707), wave * DC.ar(0.94903659820557), wave * DC.ar(0.10494422912598), wave * DC.ar(0.42578899860382));
varW97MTamagoE20140111 = Gendy3.ar(wave * DC.ar(0.75097787380219), wave * DC.ar(0.35951113700867), wave * DC.ar(0.72926580905914), wave * DC.ar(0.51764464378357), wave * DC.ar(0.94025576114655), wave * DC.ar(0.89202320575714), wave * DC.ar(0.38988828659058), wave * DC.ar(0.14563632011414), wave * DC.ar(0.67980432510376), wave * DC.ar(0.15014374256134), wave * DC.ar(0.12931549549103));

signal = varW97MTamagoE20140111;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// W32.HLLP.Tweder201403
/////////////////////////////////////////////////////////

SynthDef.new("W32.HLLP.Tweder201403", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varW32HLLPTweder2014039, varW32HLLPTweder20140310, varW32HLLPTweder20140311, varW32HLLPTweder20140312, varW32HLLPTweder20140313, varW32HLLPTweder20140314, varW32HLLPTweder20140315;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varW32HLLPTweder2014039 = varW32HLLPTweder20140310 = varW32HLLPTweder20140311 = varW32HLLPTweder20140312 = varW32HLLPTweder20140313 = varW32HLLPTweder20140314 = varW32HLLPTweder20140315 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varW32HLLPTweder2014039 = Timer.ar(varW32HLLPTweder20140315 * gateEnv);
varW32HLLPTweder20140310 = LFTri.ar(modZ * gateEnv, bufnum, modX, Silent.ar());
varW32HLLPTweder20140311 = PanX.ar(2, 0.81977725028992 * Pan2.ar(wave * DC.ar(0.57429111003876), wave * DC.ar(0.29814517498016), wave * DC.ar(0.46114075183868)), varW32HLLPTweder2014039 * varW32HLLPTweder20140312.roundUp(NestedAllpassL.ar(wave * DC.ar(0.40161788463593), wave * DC.ar(0.93208301067352), wave * DC.ar(0.22155618667603), wave * DC.ar(0.79323875904083), wave * DC.ar(0.64321660995483), wave * DC.ar(0.41777682304382), wave * DC.ar(0.23957920074463), wave * DC.ar(0.87420606613159), wave * DC.ar(0.96190106868744))), in * modX, modX * modX);
varW32HLLPTweder20140312 = LFBrownNoise1.ar(varW32HLLPTweder20140315 * modX, varW32HLLPTweder20140310 * wave, modX * varW32HLLPTweder20140312, DriveNoise.ar(wave * DC.ar(0.01505172252655), wave * DC.ar(0.14925849437714), wave * DC.ar(0.70222163200378)), Silent.ar());
varW32HLLPTweder20140313 = FMHDecode1.ar(varW32HLLPTweder20140310 * varW32HLLPTweder20140311, signal * varW32HLLPTweder20140310, varW32HLLPTweder20140311 * env, Lag3UD.ar(wave * DC.ar(0.9403167963028), wave * DC.ar(0.77793657779694), wave * DC.ar(0.25384998321533), wave * DC.ar(0.56636834144592), wave * DC.ar(0.41364419460297)), varW32HLLPTweder20140314, signal * varW32HLLPTweder20140310, gateEnv, modZ * env, island, 0.32043242454529 * in * varW32HLLPTweder20140310, varW32HLLPTweder20140311, 0.9999349266389 * varW32HLLPTweder2014039 * varW32HLLPTweder20140310, Silent.ar());
varW32HLLPTweder20140314 = Wrap.ar(gateEnv * modZ, wave, varW32HLLPTweder2014039 * varW32HLLPTweder20140313);
varW32HLLPTweder20140315 = Blip.ar(env * wave, modZ * varW32HLLPTweder20140311, RunningMin.ar(wave * DC.ar(0.81555962562561), wave * DC.ar(0.79891753196716)), Silent.ar());
varW32HLLPTweder2014039 = GrainIn.ar(2, varW32HLLPTweder2014039 * wave, gateEnv * signal, signal * varW32HLLPTweder20140310, x, bufnum, amp, varW32HLLPTweder20140315, Silent.ar());
varW32HLLPTweder20140310 = RegaliaMitraEQ.ar(wave * DC.ar(0.27645111083984), wave * DC.ar(0.00058937072753906), wave * DC.ar(0.90607929229736), wave * DC.ar(0.54040968418121), wave * DC.ar(0.31617736816406), wave * DC.ar(0.66161870956421));
varW32HLLPTweder20140311 = RunningSum.ar(wave * DC.ar(0.18368458747864), wave * DC.ar(0.5257316827774));
varW32HLLPTweder20140312 = BRZ2.ar(wave * DC.ar(0.203697681427), wave * DC.ar(0.27383184432983), wave * DC.ar(0.69334208965302));
varW32HLLPTweder20140313 = FoaTumble.ar(wave * DC.ar(0.24651622772217), wave * DC.ar(0.81384420394897), wave * DC.ar(0.77752375602722), wave * DC.ar(0.90762329101562));
varW32HLLPTweder20140314 = Convolution.ar(env * wave, signal, varW32HLLPTweder20140311, 0.13132592750156 * modY * signal, Silent.ar());
varW32HLLPTweder20140315 = DegreeToKey.ar(wave * DC.ar(0.81442749500275), wave * DC.ar(0.29848444461823), wave * DC.ar(0.85807526111603), wave * DC.ar(0.73111486434937), wave * DC.ar(0.90795207023621));
varW32HLLPTweder2014039 = Rotate2.ar(wave * DC.ar(0.054944157600403), wave * DC.ar(0.15848433971405), wave * DC.ar(0.27699995040894));
varW32HLLPTweder20140310 = SinGrainIBF.ar(wave * DC.ar(0.89772439002991), wave * DC.ar(0.26615345478058), wave * DC.ar(0.31655657291412), wave * DC.ar(0.56652283668518), wave * DC.ar(0.58329248428345), wave * DC.ar(0.6174236536026), wave * DC.ar(0.22119224071503), wave * DC.ar(0.013502836227417), wave * DC.ar(0.87605106830597), wave * DC.ar(0.68029570579529), wave * DC.ar(0.8944216966629), wave * DC.ar(0.0048537254333496));
varW32HLLPTweder20140311 = AtsNoiSynth.ar(wave * DC.ar(0.3717702627182), wave * DC.ar(0.075934767723083), wave * DC.ar(0.65309572219849), wave * DC.ar(0.79415905475616), wave * DC.ar(0.23853206634521), wave * DC.ar(0.39931392669678), wave * DC.ar(0.069763898849487), wave * DC.ar(0.08159601688385), wave * DC.ar(0.66344523429871), wave * DC.ar(0.43812072277069), wave * DC.ar(0.10837125778198), wave * DC.ar(0.77394032478333), wave * DC.ar(0.78779315948486), wave * DC.ar(0.87733292579651));
varW32HLLPTweder20140312 = PVSynth.ar(wave * DC.ar(0.38347315788269), wave * DC.ar(0.067633748054504), wave * DC.ar(0.85259974002838), wave * DC.ar(0.70273232460022), wave * DC.ar(0.41736936569214), wave * DC.ar(0.89144694805145), wave * DC.ar(0.74143266677856), wave * DC.ar(0.47129237651825), wave * DC.ar(0.82038068771362));
varW32HLLPTweder20140313 = CircleRamp.ar(wave * DC.ar(0.80925667285919), wave * DC.ar(0.035590410232544), wave * DC.ar(0.29247748851776), wave * DC.ar(0.22551047801971), wave * DC.ar(0.7407374382019), wave * DC.ar(0.81836497783661));
varW32HLLPTweder20140314 = TPV.ar(wave * DC.ar(0.94474792480469), wave * DC.ar(0.17274522781372), wave * DC.ar(0.28477954864502), wave * DC.ar(0.34392070770264), wave * DC.ar(0.86487126350403), wave * DC.ar(0.56093347072601), wave * DC.ar(0.2857084274292), wave * DC.ar(0.28091716766357), wave * DC.ar(0.72914886474609), wave * DC.ar(0.89184439182281));
varW32HLLPTweder20140315 = DetectSilence.ar(wave * DC.ar(0.31954443454742), wave * DC.ar(0.44759774208069), wave * DC.ar(0.0046039819717407), wave * DC.ar(0.3996570110321));

signal = varW32HLLPTweder20140315;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// HLLP.Xmas.6888201405
/////////////////////////////////////////////////////////

SynthDef.new("HLLP.Xmas.6888201405", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varHLLPXmas68882014059, varHLLPXmas688820140510;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varHLLPXmas68882014059 = varHLLPXmas688820140510 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varHLLPXmas68882014059 = SoftClipper8.ar(modY);
varHLLPXmas688820140510 = BufGrainBBF.ar(StkModalBar.ar(wave * DC.ar(0.72054040431976), wave * DC.ar(0.95134341716766), wave * DC.ar(0.44084870815277), wave * DC.ar(0.5368458032608), wave * DC.ar(0.8879953622818), wave * DC.ar(0.54208517074585), wave * DC.ar(0.4840247631073), wave * DC.ar(0.62930476665497), wave * DC.ar(0.46293473243713), wave * DC.ar(0.63238823413849), wave * DC.ar(0.082153677940369)), modY * gateEnv, bufnum.hypotApx(Decay.ar(wave * DC.ar(0.85929918289185), wave * DC.ar(0.74462163448334), wave * DC.ar(0.74815082550049), wave * DC.ar(0.77566277980804))), wave * wave, gateEnv * env, bufnum, y, modZ * modZ, in, island, EnvDetect.ar(wave * DC.ar(0.84457278251648), wave * DC.ar(0.11236178874969), wave * DC.ar(0.072121739387512)), 0.99998180896408 * Latch.ar(wave * DC.ar(0.71363890171051), wave * DC.ar(0.73087012767792)), Silent.ar());
varHLLPXmas68882014059 = FoaFocusY.ar(in * env, env, signal, Silent.ar());
varHLLPXmas688820140510 = SinGrainIBF.ar(varHLLPXmas68882014059 * wave, 0.11717736721039 * CheckBadValues.ar(wave * DC.ar(0.7202240228653), wave * DC.ar(0.076993346214294), wave * DC.ar(0.88035535812378)), varHLLPXmas688820140510 * signal, bufnum, bufnum, DoubleNestedAllpassC.ar(wave * DC.ar(0.75567591190338), wave * DC.ar(0.94082057476044), wave * DC.ar(0.28133392333984), wave * DC.ar(0.7344354391098), wave * DC.ar(0.28456842899323), wave * DC.ar(0.15849018096924), wave * DC.ar(0.90235006809235), wave * DC.ar(0.91154968738556), wave * DC.ar(0.79913890361786), wave * DC.ar(0.64255487918854), wave * DC.ar(0.2469916343689), wave * DC.ar(0.61196780204773)), varHLLPXmas68882014059 * modZ.bipolar(wave * DC.ar(0.19232487678528)), wave, wave, Pluck.ar(wave * DC.ar(0.55484104156494), wave * DC.ar(0.19471108913422), wave * DC.ar(0.86773121356964), wave * DC.ar(0.047656893730164), wave * DC.ar(0.36945676803589), wave * DC.ar(0.90916454792023), wave * DC.ar(0.91976773738861), wave * DC.ar(0.53311538696289)), 0.74795871796727 * wave * varHLLPXmas688820140510, Silent.ar());
varHLLPXmas68882014059 = PeakEQ2.ar(wave * DC.ar(0.59097874164581), wave * DC.ar(0.47355437278748), wave * DC.ar(0.074919581413269), wave * DC.ar(0.93603909015656));
varHLLPXmas688820140510 = StkShakers.ar(wave * DC.ar(0.19343817234039), wave * DC.ar(0.085620284080505), wave * DC.ar(0.39784240722656), wave * DC.ar(0.67411255836487), wave * DC.ar(0.038050889968872), wave * DC.ar(0.21647250652313), wave * DC.ar(0.22789621353149));

signal = varHLLPXmas688820140510;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// HLLP.Xmas.68882014051
/////////////////////////////////////////////////////////

SynthDef.new("HLLP.Xmas.68882014051", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varHLLPXmas68882014059, varHLLPXmas688820140510, varHLLPXmas6888201405111, varHLLPXmas6888201405112;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varHLLPXmas68882014059 = varHLLPXmas688820140510 = varHLLPXmas6888201405111 = varHLLPXmas6888201405112 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varHLLPXmas68882014059 = CombL.ar(modX * env, varHLLPXmas6888201405112 * modX, 0.95625603199005 * signal * varHLLPXmas688820140510, wave * modZ, 0.99996460083173 * Convolution.ar(wave * DC.ar(0.80045890808105), wave * DC.ar(0.9956237077713), wave * DC.ar(0.99910569190979), wave * DC.ar(0.61877512931824), wave * DC.ar(0.05191969871521)), Silent.ar());
varHLLPXmas688820140510 = RedNoise.ar(gateEnv * env, 0.28419887555795 * varHLLPXmas6888201405111 * wave, Silent.ar());
varHLLPXmas68882014059 = LPZ1.ar(modY * signal, 0.99983134193581 * modY * modX, Silent.ar());
varHLLPXmas688820140510 = BFEncode1.ar(wave * DC.ar(0.093824863433838), wave * DC.ar(0.17033898830414), wave * DC.ar(0.49686884880066), wave * DC.ar(0.72503733634949), wave * DC.ar(0.26515662670135), wave * DC.ar(0.95852959156036));
varHLLPXmas68882014059 = FoaFocusZ.ar(wave * DC.ar(0.21454107761383), wave * DC.ar(0.20619976520538), wave * DC.ar(0.22019982337952), wave * DC.ar(0.9596631526947));
varHLLPXmas688820140510 = Slope.ar(wave * DC.ar(0.45751023292542), wave * DC.ar(0.68852710723877), wave * DC.ar(0.098231434822083));
// Variation test code
varHLLPXmas6888201405111 = PV_HainsworthFoote.ar(Array.fill(2.pow(14), { |i| rrand(-1, 1) }).as(LocalBuf), in, modY * wave, varHLLPXmas688820140510 * varHLLPXmas68882014059, modX * varHLLPXmas688820140510);
varHLLPXmas6888201405112 = Hasher.ar(varHLLPXmas688820140510 * modX, 0.64708946102547 * modY * modY, Silent.ar());
varHLLPXmas6888201405111 = TExpRand.ar(gateEnv * modX, modZ * varHLLPXmas688820140510, varHLLPXmas68882014059 * modX);
varHLLPXmas6888201405112 = FoaTilt.ar(x, in * varHLLPXmas6888201405112, DoubleNestedAllpassN.ar(varHLLPXmas68882014059 * DC.ar(0.62093758583069), varHLLPXmas688820140510 * DC.ar(0.033228278160095), varHLLPXmas688820140510 * DC.ar(0.6758074760437), varHLLPXmas68882014059 * DC.ar(0.76606261730194), varHLLPXmas688820140510 * DC.ar(0.20043933391571), varHLLPXmas68882014059 * DC.ar(0.10571026802063), varHLLPXmas68882014059 * DC.ar(0.27977812290192), varHLLPXmas68882014059 * DC.ar(0.65970087051392), varHLLPXmas688820140510 * DC.ar(0.55379176139832), varHLLPXmas68882014059 * DC.ar(0.82698833942413), varHLLPXmas68882014059 * DC.ar(0.18196904659271), varHLLPXmas688820140510 * DC.ar(0.068145155906677)), Silent.ar());
varHLLPXmas6888201405111 = StkMandolin.ar(in * modY, varHLLPXmas688820140510, signal * varHLLPXmas6888201405111, signal, varHLLPXmas6888201405112, varHLLPXmas688820140510.fold(varHLLPXmas688820140510 * DC.ar(0.49808466434479), varHLLPXmas68882014059 * DC.ar(0.3355188369751)), varHLLPXmas688820140510 * env, 0.67565560037004 * varHLLPXmas6888201405111 * modX, Silent.ar());
varHLLPXmas6888201405112 = Dust.ar(y, Balance2.ar(varHLLPXmas688820140510 * DC.ar(0.038869738578796), varHLLPXmas688820140510 * DC.ar(0.61927330493927), varHLLPXmas688820140510 * DC.ar(0.34544336795807), varHLLPXmas68882014059 * DC.ar(0.84247708320618)), Silent.ar());

signal = varHLLPXmas6888201405112;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// VBS.BinHex.Trojan201405
/////////////////////////////////////////////////////////

SynthDef.new("VBS.BinHex.Trojan201405", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varVBSBinHexTrojan2014059, varVBSBinHexTrojan20140510, varVBSBinHexTrojan20140511, varVBSBinHexTrojan20140512;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varVBSBinHexTrojan2014059 = varVBSBinHexTrojan20140510 = varVBSBinHexTrojan20140511 = varVBSBinHexTrojan20140512 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varVBSBinHexTrojan2014059 = Crackle.ar(varVBSBinHexTrojan20140511 * modY, AtsParInfo.ar(wave * DC.ar(0.49249494075775), wave * DC.ar(0.32816433906555), wave * DC.ar(0.57756757736206), wave * DC.ar(0.46460819244385), wave * DC.ar(0.22845339775085)), Silent.ar());
varVBSBinHexTrojan20140510 = DynKlang.ar(`[[LFGauss.ar(wave * DC.ar(0.64930522441864), wave * DC.ar(0.13036894798279), wave * DC.ar(0.36103248596191), wave * DC.ar(0.80152070522308), wave * DC.ar(0.37073802947998)), BHiShelf.ar(wave * DC.ar(0.21353089809418), wave * DC.ar(0.92812871932983), wave * DC.ar(0.18704545497894), wave * DC.ar(0.77730071544647), wave * DC.ar(0.55624067783356), wave * DC.ar(0.85593974590302))], [SVF.ar(wave * DC.ar(0.58341920375824), wave * DC.ar(0.19138193130493), wave * DC.ar(0.66077816486359), wave * DC.ar(0.40281462669373), wave * DC.ar(0.33514523506165), wave * DC.ar(0.61225688457489), wave * DC.ar(0.82030212879181), wave * DC.ar(0.685267329216), wave * DC.ar(0.73222219944), wave * DC.ar(0.85567688941956)), FoaProximity.ar(wave * DC.ar(0.80894076824188), wave * DC.ar(0.18883621692657), wave * DC.ar(0.23610854148865), wave * DC.ar(0.58174800872803))], [LFTri.ar(wave * DC.ar(0.061876654624939), wave * DC.ar(0.97475469112396), wave * DC.ar(0.71455430984497), wave * DC.ar(0.03591513633728)), Henon2DC.ar(wave * DC.ar(0.010243535041809), wave * DC.ar(0.88655292987823), wave * DC.ar(0.85607039928436), wave * DC.ar(0.36415803432465), wave * DC.ar(0.43605077266693), wave * DC.ar(0.14700746536255), wave * DC.ar(0.22688102722168), wave * DC.ar(0.5206743478775))]], modX * gateEnv, GrayNoise.ar(wave * DC.ar(0.21713423728943), wave * DC.ar(0.21617722511292)).exprange(1, SampleRate.ir));
varVBSBinHexTrojan20140511 = HilbertFIR.ar(varVBSBinHexTrojan20140511 * modZ, Array.fill(2.pow(11), { |i| rrand(-1, 1) }).as(LocalBuf));
varVBSBinHexTrojan20140512 = Summer.ar(modY * gateEnv, wave, modZ * modY, varVBSBinHexTrojan2014059);
varVBSBinHexTrojan2014059 = SoftClipAmp.ar(gate, FoaPushX.ar(wave * DC.ar(0.82381761074066), wave * DC.ar(0.21656823158264), wave * DC.ar(0.43100619316101), wave * DC.ar(0.27768206596375)), LinExp.ar(wave * DC.ar(0.2453488111496), wave * DC.ar(0.44117724895477), wave * DC.ar(0.15174698829651), wave * DC.ar(0.039277791976929), wave * DC.ar(0.59437108039856)), Silent.ar());
varVBSBinHexTrojan20140510 = LFDNoise0.ar(AtsFreq.ar(wave * DC.ar(0.077443957328796), wave * DC.ar(0.76887011528015), wave * DC.ar(0.9003723859787), wave * DC.ar(0.87058138847351), wave * DC.ar(0.61604356765747)).exprange(1, SampleRate.ir), QuadC.ar(wave * DC.ar(0.39014542102814), wave * DC.ar(0.22463667392731), wave * DC.ar(0.20349073410034), wave * DC.ar(0.38056123256683), wave * DC.ar(0.033426403999329), wave * DC.ar(0.52501404285431), wave * DC.ar(0.47387635707855)), Silent.ar());
varVBSBinHexTrojan20140511 = Trig.ar(wave * DC.ar(0.68843340873718), wave * DC.ar(0.65991485118866));
varVBSBinHexTrojan20140512 = FhnTrig.ar(varVBSBinHexTrojan2014059 * env, InGrain.ar(wave * DC.ar(0.36186754703522), wave * DC.ar(0.45723974704742), wave * DC.ar(0.10396003723145), wave * DC.ar(0.58511936664581), wave * DC.ar(0.65682768821716)).exprange(1, SampleRate.ir), varVBSBinHexTrojan2014059 * varVBSBinHexTrojan20140510.ring3(Decay2.ar(wave * DC.ar(0.033283591270447), wave * DC.ar(0.034850716590881), wave * DC.ar(0.17167711257935), wave * DC.ar(0.56064522266388), wave * DC.ar(0.11888527870178))), gateEnv * wave, DoubleNestedAllpassL.ar(wave * DC.ar(0.90901505947113), wave * DC.ar(0.1845874786377), wave * DC.ar(0.77937495708466), wave * DC.ar(0.65267622470856), wave * DC.ar(0.81842184066772), wave * DC.ar(0.1709281206131), wave * DC.ar(0.54552710056305), wave * DC.ar(0.64559543132782), wave * DC.ar(0.68523931503296), wave * DC.ar(0.049832940101624), wave * DC.ar(0.84375977516174), wave * DC.ar(0.24185013771057)), varVBSBinHexTrojan2014059 * env, wave * varVBSBinHexTrojan20140511, in, env * in.linlin(wave * DC.ar(0.56962180137634), wave * DC.ar(0.60498809814453), wave * DC.ar(0.91746711730957), wave * DC.ar(0.32377672195435), wave * DC.ar(0.5664005279541)), 0.99998358179106 * wave * varVBSBinHexTrojan20140512, Silent.ar());
varVBSBinHexTrojan2014059 = InGrain.ar(wave * DC.ar(0.89288449287415), wave * DC.ar(0.61824071407318), wave * DC.ar(0.12351977825165), wave * DC.ar(0.12786936759949), wave * DC.ar(0.61894845962524));
varVBSBinHexTrojan20140510 = RedPhasor.ar(wave * DC.ar(0.54191362857819), wave * DC.ar(0.82707178592682), wave * DC.ar(0.66800677776337), wave * DC.ar(0.59038758277893), wave * DC.ar(0.41415178775787), wave * DC.ar(0.42779111862183), wave * DC.ar(0.39957427978516));
varVBSBinHexTrojan20140511 = QuadC.ar(wave * DC.ar(0.57890903949738), wave * DC.ar(0.14552342891693), wave * DC.ar(0.96056735515594), wave * DC.ar(0.22596192359924), wave * DC.ar(0.39466381072998), wave * DC.ar(0.151691198349), wave * DC.ar(0.76547360420227));
varVBSBinHexTrojan20140512 = RunningMin.ar(wave * DC.ar(0.96154475212097), wave * DC.ar(0.47596454620361));

signal = varVBSBinHexTrojan20140512;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Ire.16384201405
/////////////////////////////////////////////////////////

SynthDef.new("Ire.16384201405", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varIre163842014059, varIre1638420140510, varIre1638420140511, varIre1638420140512, varIre1638420140513;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varIre163842014059 = varIre1638420140510 = varIre1638420140511 = varIre1638420140512 = varIre1638420140513 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varIre163842014059 = Trig.ar(gateEnv, z);
varIre1638420140510 = Clipper32.ar(modX, 0.32366120815277 * wave * env, wave * gateEnv);
varIre1638420140511 = LPCError.ar(modZ * varIre1638420140511, 0.80480897426605 * wave * modZ, modZ, GlitchRHPF.ar(wave * DC.ar(0.42135584354401), wave * DC.ar(0.94218993186951), wave * DC.ar(0.34279203414917), wave * DC.ar(0.6603467464447), wave * DC.ar(0.74014222621918)));
varIre1638420140512 = Clipper32.ar(0.47934007644653 * modY, modX, amp);
varIre1638420140513 = TextVU.ar(signal * wave, varIre1638420140510, y, 0.85379183292389 * modX * env, varIre1638420140511 * signal, wave * gateEnv);
varIre163842014059 = QuadC.ar(wave * DC.ar(0.54001665115356), wave * DC.ar(0.72772419452667), wave * DC.ar(0.66997110843658), wave * DC.ar(0.60935389995575), wave * DC.ar(0.97091281414032), wave * DC.ar(0.30535566806793), wave * DC.ar(0.20219254493713));
varIre1638420140510 = Changed.ar(varIre163842014059 * modZ, y);
varIre1638420140511 = FoaPushY.ar(wave * modY, gateEnv, 0.9906252015767 * modY * in, Silent.ar());
varIre1638420140512 = Maxamp.ar(wave * DC.ar(0.70444941520691), wave * DC.ar(0.12502980232239));
varIre1638420140513 = Allpass2.ar(modY * gateEnv, varIre163842014059, in, modZ, Silent.ar());
varIre163842014059 = Convolution.ar(wave * DC.ar(0.87394285202026), wave * DC.ar(0.29158914089203), wave * DC.ar(0.57757616043091), wave * DC.ar(0.24803507328033), wave * DC.ar(0.24128675460815));
varIre1638420140510 = FoaPsychoShelf.ar(wave * DC.ar(0.35488140583038), wave * DC.ar(0.61245143413544), wave * DC.ar(0.44841623306274), wave * DC.ar(0.38980150222778), wave * DC.ar(0.18827772140503), wave * DC.ar(0.98201382160187));
varIre1638420140511 = Perlin3.ar(wave * DC.ar(0.55792737007141), wave * DC.ar(0.69615519046783), wave * DC.ar(0.3663604259491));
varIre1638420140512 = Pan4.ar(wave * DC.ar(0.6678694486618), wave * DC.ar(0.91877245903015), wave * DC.ar(0.20112228393555), wave * DC.ar(0.13663017749786));
varIre1638420140513 = LPCError.ar(wave * DC.ar(0.1617830991745), wave * DC.ar(0.38941884040833), wave * DC.ar(0.094782829284668), wave * DC.ar(0.30838823318481));

signal = varIre1638420140513;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Dead.945201406
/////////////////////////////////////////////////////////

SynthDef.new("Dead.945201406", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varDead9452014069, varDead94520140610, varDead94520140611, varDead94520140612, varDead94520140613, varDead94520140614;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varDead9452014069 = varDead94520140610 = varDead94520140611 = varDead94520140612 = varDead94520140613 = varDead94520140614 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varDead9452014069 = ScopeOut.ar([StkBowed.ar(wave * DC.ar(0.52485466003418), wave * DC.ar(0.52126407623291), wave * DC.ar(0.51811611652374), wave * DC.ar(0.38356912136078), wave * DC.ar(0.69738388061523), wave * DC.ar(0.44876551628113), wave * DC.ar(0.21938157081604), wave * DC.ar(0.22478425502777), wave * DC.ar(0.7645308971405), wave * DC.ar(0.5126770734787), wave * DC.ar(0.21448314189911)), Hilbert.ar(wave * DC.ar(0.085016846656799), wave * DC.ar(0.41602146625519), wave * DC.ar(0.154914021492))], Array.fill(2.pow(16), { |i| rrand(-1, 1) }).as(LocalBuf));
varDead94520140610 = BufRd.ar(2, Array.fill(2.pow(13), { |i| rrand(-1, 1) }).as(LocalBuf), modY, in * modX, modZ * varDead94520140613);
varDead94520140611 = LFDNoise3.ar(varDead9452014069 * in, 0.99954105541569 * signal * wave.curvelin(wave * DC.ar(0.17603075504303), wave * DC.ar(0.36586499214172), wave * DC.ar(0.17716872692108), wave * DC.ar(0.68348228931427), wave * DC.ar(0.12603580951691), wave * DC.ar(0.40374410152435)), Silent.ar());
varDead94520140612 = TGrains2.ar(2, gateEnv, Array.fill(2.pow(16), { |i| rrand(-1, 1) }).as(LocalBuf), gate, signal.wrap(wave * DC.ar(0.0015163421630859), wave * DC.ar(0.99738478660583)), in * env, 0.51531100273132 * modZ * modY, varDead94520140612 * varDead9452014069, bufnum, 0.35438859462738 * modX, modX);
varDead94520140613 = Concat.ar(0.15343332290649 * env * signal, t_trig, modY.linexp(wave * DC.ar(0.014738202095032), wave * DC.ar(0.51636362075806), wave * DC.ar(0.26271784305573), wave * DC.ar(0.041057467460632), wave * DC.ar(0.76979219913483)), z, varDead94520140611 * varDead9452014069, in * varDead94520140611, WrapSummer.ar(wave * DC.ar(0.58888745307922), wave * DC.ar(0.898646235466), wave * DC.ar(0.44561004638672), wave * DC.ar(0.50185334682465), wave * DC.ar(0.81233716011047), wave * DC.ar(0.87256813049316)), t_trig, island, modZ * modX, varDead94520140614 * signal, 0.34323561191559 * env, modX, Silent.ar());
varDead94520140614 = Changed.ar(signal, 0.37593984603882 * varDead9452014069 * signal);
varDead9452014069 = AY.ar(wave * wave, modY * modY, modX, modX, z, varDead94520140610 * gateEnv, t_trig, 0.71423864364624 * modY * varDead94520140610.wrap(wave * DC.ar(0.96580922603607), wave * DC.ar(0.042257189750671)), modY * varDead94520140611, LFBrownNoise1.ar(wave * DC.ar(0.320152759552), wave * DC.ar(0.63378250598907), wave * DC.ar(0.089892029762268), wave * DC.ar(0.20980393886566), wave * DC.ar(0.87090301513672)), varDead94520140611 * varDead94520140612, BFEncode2.ar(wave * DC.ar(0.8276447057724), wave * DC.ar(0.85823464393616), wave * DC.ar(0.76728141307831), wave * DC.ar(0.036967754364014), wave * DC.ar(0.13668966293335), wave * DC.ar(0.35913407802582)), Silent.ar());
varDead94520140610 = AnalyseEvents2.ar(modX.lag3ud(wave * DC.ar(0.23591101169586), wave * DC.ar(0.71632587909698)), Array.fill(2.pow(12), { |i| rrand(-1, 1) }).as(LocalBuf), z, varDead94520140610 * varDead94520140612, modZ * in, 0.43087482452393 * varDead9452014069 * wave);
varDead94520140611 = Balance.ar(wave * DC.ar(0.89381337165833), wave * DC.ar(0.43291747570038), wave * DC.ar(0.2849338054657), wave * DC.ar(0.35572302341461), wave * DC.ar(0.91842985153198), wave * DC.ar(0.7011467218399));
varDead94520140612 = Saw.ar(wave * DC.ar(0.85077559947968), wave * DC.ar(0.54195737838745), wave * DC.ar(0.2874870300293));
varDead94520140613 = Pluck.ar(wave * DC.ar(0.18300485610962), wave * DC.ar(0.030579805374146), wave * DC.ar(0.44571626186371), wave * DC.ar(0.62958812713623), wave * DC.ar(0.95012414455414), wave * DC.ar(0.80743420124054), wave * DC.ar(0.84044861793518), wave * DC.ar(0.49140858650208));
varDead94520140614 = Oregonator.ar(wave * DC.ar(0.90878546237946), wave * DC.ar(0.47857999801636), wave * DC.ar(0.87287139892578), wave * DC.ar(0.46444022655487), wave * DC.ar(0.54502618312836), wave * DC.ar(0.26761138439178), wave * DC.ar(0.96145713329315), wave * DC.ar(0.39651238918304), wave * DC.ar(0.60474824905396), wave * DC.ar(0.52538406848907));
varDead9452014069 = FoaProximity.ar(wave * DC.ar(0.90978133678436), wave * DC.ar(0.85922598838806), wave * DC.ar(0.52321314811707), wave * DC.ar(0.20384252071381));
varDead94520140610 = MedianTriggered.ar(wave * DC.ar(0.19648396968842), wave * DC.ar(0.31551694869995), wave * DC.ar(0.58455395698547), wave * DC.ar(0.73902010917664), wave * DC.ar(0.41865849494934));
varDead94520140611 = Lag.ar(wave * DC.ar(0.59269797801971), wave * DC.ar(0.72826266288757), wave * DC.ar(0.42507040500641), wave * DC.ar(0.19744563102722));
varDead94520140612 = Duty.ar(wave * DC.ar(0.17550933361053), wave * DC.ar(0.030579566955566), wave * DC.ar(0.2096186876297), wave * DC.ar(0.10384333133698));
varDead94520140613 = InGrainI.ar(wave * DC.ar(0.81909561157227), wave * DC.ar(0.90682935714722), wave * DC.ar(0.95833611488342), wave * DC.ar(0.22362792491913), wave * DC.ar(0.22489297389984), wave * DC.ar(0.080499887466431), wave * DC.ar(0.58692240715027), wave * DC.ar(0.98529422283173));
varDead94520140614 = TwoPole.ar(wave * DC.ar(0.34643197059631), wave * DC.ar(0.086240768432617), wave * DC.ar(0.67594301700592), wave * DC.ar(0.65057170391083), wave * DC.ar(0.36434602737427));

signal = varDead94520140614;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// W32.3Dstars.Worm201406
/////////////////////////////////////////////////////////

SynthDef.new("W32.3Dstars.Worm201406", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varW323DstarsWorm2014069, varW323DstarsWorm20140610, varW323DstarsWorm20140611, varW323DstarsWorm20140612;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varW323DstarsWorm2014069 = varW323DstarsWorm20140610 = varW323DstarsWorm20140611 = varW323DstarsWorm20140612 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varW323DstarsWorm2014069 = TextVU.ar(varW323DstarsWorm20140611 * env.clip2(AllpassC.ar(wave * DC.ar(0.8309600353241), wave * DC.ar(0.62964391708374), wave * DC.ar(0.73825109004974), wave * DC.ar(0.75886738300323), wave * DC.ar(0.13346552848816), wave * DC.ar(0.76177966594696))), env * modY, varW323DstarsWorm20140611, z, varW323DstarsWorm2014069 * varW323DstarsWorm2014069, wave);
varW323DstarsWorm20140610 = RedDPCMencode.ar(env * modZ, x);
varW323DstarsWorm20140611 = LorenzTrig.ar(GbmanN.ar(wave * DC.ar(0.89184045791626), wave * DC.ar(0.046230673789978), wave * DC.ar(0.89418482780457), wave * DC.ar(0.71723020076752), wave * DC.ar(0.20564198493958)).exprange(1, SampleRate.ir), OSTrunc8.ar(wave * DC.ar(0.55524468421936), wave * DC.ar(0.98440289497375)).exprange(1, SampleRate.ir), modY * modX, modX, 0.58968389034271 * gateEnv * varW323DstarsWorm20140611, signal * env, modZ, modX, modY * varW323DstarsWorm20140610.wrap(wave * DC.ar(0.29284107685089), wave * DC.ar(0.26856696605682)), 0.99707993670682 * FMGrain.ar(wave * DC.ar(0.81506991386414), wave * DC.ar(0.71716594696045), wave * DC.ar(0.755446434021), wave * DC.ar(0.80844938755035), wave * DC.ar(0.69059550762177), wave * DC.ar(0.90652990341187), wave * DC.ar(0.61153745651245)), Silent.ar());
varW323DstarsWorm20140612 = AllpassL.ar(modZ, varW323DstarsWorm20140612 * varW323DstarsWorm2014069, bufnum, varW323DstarsWorm20140611, 0.81308506124648 * wave * varW323DstarsWorm20140610, RunningMin.ar(wave * DC.ar(0.47575294971466), wave * DC.ar(0.20153427124023)));
varW323DstarsWorm2014069 = T2A.ar(wave * DC.ar(0.67722046375275), wave * DC.ar(0.20963072776794));
varW323DstarsWorm20140610 = Line.ar(wave * DC.ar(0.35523951053619), wave * DC.ar(0.37074661254883), wave * DC.ar(0.83962631225586), wave * DC.ar(0.72044432163239), wave * DC.ar(0.75699973106384), wave * DC.ar(0.84227287769318));
varW323DstarsWorm20140611 = InRect.ar(modY * modX, 0.37341141700745 * modX * varW323DstarsWorm20140611, Rect.new(0, 0, 0.60803127288818, 0.59269630908966));
varW323DstarsWorm20140612 = BufGrainIBF.ar(signal * in, 0.13453996181488 * modY * varW323DstarsWorm20140611, bufnum, InGrain.ar(wave * DC.ar(0.59742510318756), wave * DC.ar(0.31805288791656), wave * DC.ar(0.044263601303101), wave * DC.ar(0.7800817489624), wave * DC.ar(0.92217671871185)), island, bufnum, bufnum, varW323DstarsWorm20140611, t_trig, modX * modX, env * varW323DstarsWorm20140611, wave, x, OnePole.ar(wave * DC.ar(0.60411584377289), wave * DC.ar(0.95400440692902), wave * DC.ar(0.6849319934845), wave * DC.ar(0.055016756057739)), Silent.ar());
varW323DstarsWorm2014069 = Beep.ar(wave * DC.ar(0.15391480922699), wave * DC.ar(0.32725167274475));
varW323DstarsWorm20140610 = DriveNoise.ar(wave * DC.ar(0.58579134941101), wave * DC.ar(0.95300579071045), wave * DC.ar(0.6950021982193));
varW323DstarsWorm20140611 = PSinGrain.ar(wave * DC.ar(0.16841721534729), wave * DC.ar(0.41712367534637), wave * DC.ar(0.77151441574097));
varW323DstarsWorm20140612 = IEnvGen.ar(wave * DC.ar(0.063508749008179), wave * DC.ar(0.10883164405823), wave * DC.ar(0.85071694850922), wave * DC.ar(0.51789975166321));

signal = varW323DstarsWorm20140612;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// Soldier.799201407
/////////////////////////////////////////////////////////

SynthDef.new("Soldier.799201407", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varSoldier7992014079;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varSoldier7992014079 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varSoldier7992014079 = BufCombN.ar(Array.fill(2.pow(15), { |i| rrand(-1, 1) }).as(LocalBuf), modZ * wave, env * in, modX * signal, LinCongL.ar(wave * DC.ar(0.4935827255249), wave * DC.ar(0.2196341753006), wave * DC.ar(0.69645738601685), wave * DC.ar(0.64382016658783), wave * DC.ar(0.47361254692078), wave * DC.ar(0.19163656234741), wave * DC.ar(0.089837312698364)), Silent.ar());
varSoldier7992014079 = CombLP.ar(env * modX, modY * modY, modX * modY, HPZ2.ar(wave * DC.ar(0.23542428016663), wave * DC.ar(0.73577761650085), wave * DC.ar(0.86935722827911)), Ringz.ar(wave * DC.ar(0.89063692092896), wave * DC.ar(0.65396428108215), wave * DC.ar(0.7995365858078), wave * DC.ar(0.34897565841675), wave * DC.ar(0.34511566162109)), modZ, FreeVerb.ar(wave * DC.ar(0.88742160797119), wave * DC.ar(0.26797246932983), wave * DC.ar(0.72232902050018), wave * DC.ar(0.215447306633), wave * DC.ar(0.24438643455505), wave * DC.ar(0.7659330368042)), Silent.ar());
varSoldier7992014079 = AtsNoiSynth.ar(wave * DC.ar(0.46554791927338), wave * DC.ar(0.80909669399261), wave * DC.ar(0.86514759063721), wave * DC.ar(0.02182924747467), wave * DC.ar(0.096323728561401), wave * DC.ar(0.98492538928986), wave * DC.ar(0.16410171985626), wave * DC.ar(0.056632399559021), wave * DC.ar(0.56542062759399), wave * DC.ar(0.80664730072021), wave * DC.ar(0.97976529598236), wave * DC.ar(0.08370304107666), wave * DC.ar(0.82142174243927), wave * DC.ar(0.49230468273163));

signal = varSoldier7992014079;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// HLLC.10000201407
/////////////////////////////////////////////////////////

SynthDef.new("HLLC.10000201407", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varHLLC100002014079, varHLLC1000020140710, varHLLC1000020140711, varHLLC1000020140712;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varHLLC100002014079 = varHLLC1000020140710 = varHLLC1000020140711 = varHLLC1000020140712 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varHLLC100002014079 = Balance2.ar(gateEnv, island, 0.96477746963501 * varHLLC1000020140711 * varHLLC1000020140710, varHLLC1000020140711 * in);
varHLLC1000020140710 = InGrainBF.ar(modZ, amp, gate, PosRatio.ar(wave * DC.ar(0.93048417568207), wave * DC.ar(0.81858789920807), wave * DC.ar(0.28685104846954)), env * signal, modY, wave * gateEnv, varHLLC1000020140711, Silent.ar());
varHLLC1000020140711 = LorenzL.ar(gateEnv, varHLLC1000020140710, varHLLC100002014079 * varHLLC1000020140711, in * env, modZ, 0.60873913764954 * in, varHLLC1000020140710 * varHLLC1000020140712, wave * modZ, signal, Silent.ar());
varHLLC1000020140712 = DC.ar(t_trig);
varHLLC100002014079 = VOsc.ar(Array.fill(2.pow(13), { |i| rrand(-1, 1) }).as(LocalBuf), BufCombC.ar(wave * DC.ar(0.46693503856659), wave * DC.ar(0.56789684295654), wave * DC.ar(0.61207854747772), wave * DC.ar(0.083959698677063), wave * DC.ar(0.65941762924194), wave * DC.ar(0.19091498851776)).exprange(1, SampleRate.ir), env * signal, varHLLC100002014079, Silent.ar());
varHLLC1000020140710 = Lorenz2DL.ar(wave * gateEnv, in, wave, gateEnv * signal, varHLLC100002014079, varHLLC1000020140710, amp, z, modY * wave, in, Silent.ar());
varHLLC1000020140711 = Convolution2.ar(wave * DC.ar(0.67508363723755), wave * DC.ar(0.34987258911133), wave * DC.ar(0.48867571353912), wave * DC.ar(0.14177680015564), wave * DC.ar(0.91093039512634), wave * DC.ar(0.73327374458313));
varHLLC1000020140712 = EnvFollow.ar(wave * DC.ar(0.88083934783936), wave * DC.ar(0.32249426841736), wave * DC.ar(0.15891242027283), wave * DC.ar(0.17175626754761));
varHLLC100002014079 = StkFlute.ar(wave * DC.ar(0.16702020168304), wave * DC.ar(0.11761701107025), wave * DC.ar(0.64495158195496), wave * DC.ar(0.76972055435181), wave * DC.ar(0.15428996086121), wave * DC.ar(0.70182621479034));
varHLLC1000020140710 = DelayL.ar(wave * DC.ar(0.55592727661133), wave * DC.ar(0.3911828994751), wave * DC.ar(0.51632952690125), wave * DC.ar(0.8542708158493), wave * DC.ar(0.33002161979675));
varHLLC1000020140711 = SN76489.ar(wave * DC.ar(0.68277812004089), wave * DC.ar(0.047538161277771), wave * DC.ar(0.14711463451385), wave * DC.ar(0.15421164035797), wave * DC.ar(0.13012707233429), wave * DC.ar(0.60513293743134), wave * DC.ar(0.81198763847351), wave * DC.ar(0.835409283638), wave * DC.ar(0.78903830051422));
varHLLC1000020140712 = APF.ar(wave * DC.ar(0.34766757488251), wave * DC.ar(0.95327293872833), wave * DC.ar(0.29817581176758), wave * DC.ar(0.081268668174744), wave * DC.ar(0.4403235912323));

signal = varHLLC1000020140712;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// ByRen.1006201408
/////////////////////////////////////////////////////////

SynthDef.new("ByRen.1006201408", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varByRen10062014089, varByRen100620140810, varByRen100620140811;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varByRen10062014089 = varByRen100620140810 = varByRen100620140811 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varByRen10062014089 = Amplitude.ar(modZ, z, modX * varByRen10062014089, RMShelf.ar(wave * DC.ar(0.060689091682434), wave * DC.ar(0.18139183521271), wave * DC.ar(0.13972234725952), wave * DC.ar(0.97021102905273), wave * DC.ar(0.58018887042999)), Silent.ar());
varByRen100620140810 = FMHEncode2.ar(wave, 0.67260897159576 * gateEnv * modX, 0.82006788253784 * modX * varByRen10062014089, 0.079218983650208 * gateEnv, modZ * gateEnv, modX);
varByRen100620140811 = LFClipNoise.ar(varByRen100620140811, 0.99645625705754 * SN76489.ar(wave * DC.ar(0.19299554824829), wave * DC.ar(0.28623127937317), wave * DC.ar(0.46697509288788), wave * DC.ar(0.59197664260864), wave * DC.ar(0.90800940990448), wave * DC.ar(0.71497368812561), wave * DC.ar(0.51682233810425), wave * DC.ar(0.31595730781555), wave * DC.ar(0.33318293094635)), Silent.ar());
varByRen10062014089 = OSWrap8.ar(wave * DC.ar(0.33961939811707), wave * DC.ar(0.62352824211121), wave * DC.ar(0.38391542434692));
varByRen100620140810 = GaussTrig.ar(BFDecode1.ar(wave * DC.ar(0.94109785556793), wave * DC.ar(0.52760481834412), wave * DC.ar(0.59156811237335), wave * DC.ar(0.3750581741333), wave * DC.ar(0.93921387195587), wave * DC.ar(0.85306107997894), wave * DC.ar(0.74259519577026), wave * DC.ar(0.722691655159), wave * DC.ar(0.74875724315643)).exprange(1, SampleRate.ir), varByRen10062014089 * varByRen10062014089, SOS.ar(wave * DC.ar(0.57227540016174), wave * DC.ar(0.085373759269714), wave * DC.ar(0.37665379047394), wave * DC.ar(0.73134326934814), wave * DC.ar(0.75468587875366), wave * DC.ar(0.38792216777802), wave * DC.ar(0.55207514762878), wave * DC.ar(0.84823358058929)), Silent.ar());
varByRen100620140811 = Fhn2DN.ar(wave * DC.ar(0.56843292713165), wave * DC.ar(0.48823881149292), wave * DC.ar(0.1398252248764), wave * DC.ar(0.972616314888), wave * DC.ar(0.61413180828094), wave * DC.ar(0.081931233406067), wave * DC.ar(0.37953746318817), wave * DC.ar(0.48902225494385), wave * DC.ar(0.42206788063049), wave * DC.ar(0.37807595729828), wave * DC.ar(0.2052755355835));
varByRen10062014089 = YigClifford3DC.ar(wave * DC.ar(0.41810584068298), wave * DC.ar(0.81464695930481), wave * DC.ar(0.96588099002838), wave * DC.ar(0.85079205036163), wave * DC.ar(0.46132874488831), wave * DC.ar(0.13558745384216), wave * DC.ar(0.17290544509888), wave * DC.ar(0.2916876077652), wave * DC.ar(0.9944087266922), wave * DC.ar(0.78721070289612));
varByRen100620140810 = LPCSynth.ar(wave * DC.ar(0.22340703010559), wave * DC.ar(0.52119719982147), wave * DC.ar(0.44155168533325), wave * DC.ar(0.65355837345123), wave * DC.ar(0.016883492469788));
varByRen100620140811 = WhiteNoise.ar(wave * DC.ar(0.77020764350891), wave * DC.ar(0.63838529586792));

signal = varByRen100620140811;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// VCL.7428201409
/////////////////////////////////////////////////////////

SynthDef.new("VCL.7428201409", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varVCL74282014099, varVCL742820140910, varVCL742820140911, varVCL742820140912, varVCL742820140913;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varVCL74282014099 = varVCL742820140910 = varVCL742820140911 = varVCL742820140912 = varVCL742820140913 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varVCL74282014099 = FoaDirectX.ar(modY, signal * env, 0.88516473430738 * modX * modZ, XFadeRotate.ar(wave * DC.ar(0.74213361740112), wave * DC.ar(0.12565553188324)));
varVCL742820140910 = AudioMSG.ar(modY * modX, varVCL742820140910 * modY, 0.8794675942163 * modY * varVCL742820140912.hypotApx(SID6581f.ar(wave * DC.ar(0.024687170982361), wave * DC.ar(0.24043548107147), wave * DC.ar(0.80023586750031), wave * DC.ar(0.46601355075836), wave * DC.ar(0.22279500961304), wave * DC.ar(0.087246775627136), wave * DC.ar(0.20847988128662), wave * DC.ar(0.099268913269043), wave * DC.ar(0.055359482765198), wave * DC.ar(0.63854885101318), wave * DC.ar(0.44706773757935), wave * DC.ar(0.27509760856628), wave * DC.ar(0.28128445148468), wave * DC.ar(0.2181224822998), wave * DC.ar(0.30269420146942), wave * DC.ar(0.7767322063446), wave * DC.ar(0.47871649265289), wave * DC.ar(0.97490239143372), wave * DC.ar(0.066336870193481), wave * DC.ar(0.59119713306427), wave * DC.ar(0.93936836719513), wave * DC.ar(0.45102298259735), wave * DC.ar(0.13946282863617), wave * DC.ar(0.6873117685318), wave * DC.ar(0.41612827777863), wave * DC.ar(0.95998167991638))), Silent.ar());
varVCL742820140911 = BRZ2.ar(env, 0.98479002353323 * signal * env, Silent.ar());
varVCL742820140912 = TBall.ar(bufnum, varVCL742820140911 * signal, varVCL74282014099 * gateEnv, XFade2.ar(wave * DC.ar(0.89190208911896), wave * DC.ar(0.81153833866119), wave * DC.ar(0.4860337972641), wave * DC.ar(0.49511539936066)));
varVCL742820140913 = Hilbert.ar(y, 0.9999659441157 * modZ * varVCL742820140910.expexp(wave * DC.ar(0.5826450586319), wave * DC.ar(0.75782561302185), wave * DC.ar(0.86286008358002), wave * DC.ar(0.92350506782532), wave * DC.ar(0.67457222938538)), Silent.ar());
varVCL74282014099 = XOut.ar(wave * DC.ar(0.86884880065918), wave * DC.ar(0.30183827877045), wave * DC.ar(0.864985704422));
varVCL742820140910 = BufAllpassC.ar(Array.fill(2.pow(13), { |i| rrand(-1, 1) }).as(LocalBuf), varVCL742820140913 * varVCL742820140912, varVCL742820140910 * wave, x, 0.24295634954541 * varVCL742820140911 * varVCL742820140910, Silent.ar());
varVCL742820140911 = DoubleNestedAllpassL.ar(wave * DC.ar(0.62340807914734), wave * DC.ar(0.57406520843506), wave * DC.ar(0.21574461460114), wave * DC.ar(0.51885962486267), wave * DC.ar(0.073651552200317), wave * DC.ar(0.36354458332062), wave * DC.ar(0.036525964736938), wave * DC.ar(0.55359208583832), wave * DC.ar(0.76830458641052), wave * DC.ar(0.81928730010986), wave * DC.ar(0.10438299179077), wave * DC.ar(0.31019556522369));
varVCL742820140912 = BLowShelf.ar(wave * DC.ar(0.80348145961761), wave * DC.ar(0.41633641719818), wave * DC.ar(0.72622728347778), wave * DC.ar(0.26894807815552), wave * DC.ar(0.45429456233978), wave * DC.ar(0.17609131336212));
varVCL742820140913 = SinGrainBBF.ar(wave * DC.ar(0.85526812076569), wave * DC.ar(0.94181311130524), wave * DC.ar(0.019949197769165), wave * DC.ar(0.48252558708191), wave * DC.ar(0.58428823947906), wave * DC.ar(0.73107039928436), wave * DC.ar(0.59336686134338), wave * DC.ar(0.18318581581116), wave * DC.ar(0.10688591003418), wave * DC.ar(0.62188160419464));
varVCL74282014099 = OffsetOut.ar(wave * DC.ar(0.00029504299163818), wave * DC.ar(0.013236045837402));
varVCL742820140910 = Latoocarfian2DC.ar(wave * DC.ar(0.041782140731812), wave * DC.ar(0.13234031200409), wave * DC.ar(0.69544780254364), wave * DC.ar(0.042144775390625), wave * DC.ar(0.85213446617126), wave * DC.ar(0.21436750888824), wave * DC.ar(0.039110541343689), wave * DC.ar(0.23492383956909), wave * DC.ar(0.95416331291199), wave * DC.ar(0.68106782436371));
varVCL742820140911 = LatoocarfianN.ar(wave * DC.ar(0.033180236816406), wave * DC.ar(0.6126983165741), wave * DC.ar(0.20155775547028), wave * DC.ar(0.066348195075989), wave * DC.ar(0.8886501789093), wave * DC.ar(0.15525805950165), wave * DC.ar(0.61425566673279), wave * DC.ar(0.062221765518188), wave * DC.ar(0.5948897600174));
varVCL742820140912 = TBrownRand.ar(wave * DC.ar(0.37094163894653), wave * DC.ar(0.17162275314331), wave * DC.ar(0.60110175609589), wave * DC.ar(0.74443113803864), wave * DC.ar(0.59862411022186), wave * DC.ar(0.023410439491272), wave * DC.ar(0.91046464443207));
varVCL742820140913 = MostChange.ar(wave * DC.ar(0.51898801326752), wave * DC.ar(0.21356356143951));

signal = varVCL742820140913;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");




/////////////////////////////////////////////////////////
// FEC(b)201410
/////////////////////////////////////////////////////////

SynthDef.new("FEC(b)201410", {
arg amp=0.25, x=0, y=0, z=0, island=0, gate=1, t_trig=0, bufnum=0;
var env, signal, modX, modY, modZ, gateEnv, wave, in, varFECb2014109;

amp= K2A.ar(amp);
x= K2A.ar(x);
y= K2A.ar(y);
z= K2A.ar(z);
island= K2A.ar(island);
gate= K2A.ar(gate);
t_trig= K2A.ar(t_trig);
bufnum= K2A.ar(bufnum);
env = signal = modX = modY = modZ = gateEnv = wave = in = varFECb2014109 = K2A.ar(t_trig).dup;
gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[ExpRand(0.00001, 0.1), modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
		Phasor.ar(t_trig, Pitch.kr(in[0], 1, 1)[0] / 2, modX * 72, modY * 72, 0),
                         Phasor.ar(t_trig, Pitch.kr(in[1], 1, 1)[0] / 2, modZ * 72, modY * 72, 0),
                         72,
                         72
                        );

                        wave = wave * env thresh: in;


// Generated prototype body code
varFECb2014109 = Slub.ar(signal * modZ, gateEnv * modZ);
varFECb2014109 = WaveTerrain.ar(Array.fill(2.pow(10), { |i| rrand(-1, 1) }).as(LocalBuf), modY, modY * gateEnv, gateEnv * modZ, signal * gateEnv, 0.99990585233016 * signal * signal, Silent.ar());
varFECb2014109 = LPZ1.ar(wave * DC.ar(0.68212938308716), wave * DC.ar(0.28451824188232), wave * DC.ar(0.47341084480286));

signal = varFECb2014109;
signal = SanityCheck2.ar(signal * env);
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * Rand(0.1, 1));

}).store.writeDefFile("/home/octopian/Documents/source/QtDev/Shoggoth-build-desktop/synthdefs/");

)


