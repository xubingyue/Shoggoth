// SynthDef generator for Shoggoth

// Components: Template

// Techniques, generate a base sound, then generate several variations
// Use introspection to fill arguments.
// Make and  use arguments.

// Static class used to start/stop/control synth def generation
ShSynthGen {

	classvar  <>numGenerations, <>numPrototypes, <>numPrototypeVariations, <>generations, <>nilMacro, <>filePath, <>prototypeStrategy, <>variationStrategy, <>template;
	classvar <>synthBeginCode, <>synthEndCode, <>tab;

	*generate { arg argNumPrototypes, argNumPrototypeVariations, argFilePath, argTemplate, argPrototypeStrategy, argVariationStrategy;
		ShSynthGen.setup(argNumPrototypes, argNumPrototypeVariations, argFilePath, argTemplate, argPrototypeStrategy, argVariationStrategy);
		ShSynthGen.generateSynthDefs;
		ShSynthGen.finish;
	}

	*setup { arg argNumPrototypes, argNumPrototypeVariations, argFilePath, argTemplate, argPrototypeStrategy, argVariationStrategy;

		"ShSynthGen.setup".postln;
		ShSynthGen.numPrototypes = argNumPrototypes;
		ShSynthGen.numPrototypeVariations = argNumPrototypeVariations;
		ShSynthGen.filePath = argFilePath ? "";
		ShSynthGen.numGenerations = numPrototypes + (numPrototypes * numPrototypeVariations);
		ShSynthGen.generations = [];
		ShSynthGen.nilMacro = ShSynthMacro.new({ arg inputs, variables, arguments; [nil, nil] });
		ShSynthGen.prototypeStrategy = argPrototypeStrategy;
		ShSynthGen.variationStrategy = argVariationStrategy;
		ShSynthGen.template = argTemplate;
		ShSynthGen.tab = "    ";
		ShSynthGen.synthBeginCode = "SynthDef.new(__NAME__, {\n";
		ShSynthGen.synthEndCode = "})";
	}

	*generateSynthDefs {
		"ShSynthGen.generateSynthDefs".postln;
		ShSynthGen.numPrototypes.do {
			var prototypeName = ShSynthGen.template.generateSynthName;
			var prototype = ShSynthGen.prototypeStrategy.value(prototypeName, ShSynthGen.template);
			prototype.compile;
			ShSynthGen.generations = ShSynthGen.generations.add(prototype);

			ShSynthGen.numPrototypeVariations.do {
				arg i;
				var variation = ShSynthGen.variationStrategy.value(prototypeName ++ (i + 1).asString, prototype);
				variation.compile;
				ShSynthGen.generations = ShSynthGen.generations.add(variation);
			}
		}
	}

	*writeSynth { arg name, code;
		var writeCode = "/////////////////////////////////////////////////////////\n// " ++ name ++ "\n/////////////////////////////////////////////////////////\n\n" ++ code;
		var appendString = "";

		try({ writeCode.interpret; }, { "compile failed.".postln; ^nil });

		if(ShSynthGen.filePath != nil, { appendString = ".store.writeDefFile(\"" ++ filePath ++ "\");\n"; }, { appendString = ";\n" });
		appendString = appendString ++ "\n\n\n\n";
		writeCode = writeCode ++ appendString;
	    // writeCode.interpret;
		^writeCode;
	}

	*finish {
		var compilationName = "GeneratedSynthDefs--" ++ Date.localtime.asString.replace(" ", "-");
		var commentBlock = "//////////////////////////////////////////////////////////////////////////////////////////////////////////\n";
		var synthDefCompilationFileString = commentBlock ++ "// " ++ compilationName ++ "\n" ++ commentBlock ++ "\n\n\n";
		var synthDefCompilationFile = File(ShSynthGen.filePath ++ "/" ++ compilationName ++ ".sc", "w");
		var synthDefNameFile, synthDefNameFileString;
		var successfulSynths = [];

		"ShSynthGen.finish".postln;

		ShSynthGen.generations.do {
			arg item, i;
			var newSynth = ShSynthGen.writeSynth(item.name, item.code);

			if(newSynth != nil, {
				synthDefCompilationFileString = synthDefCompilationFileString ++ newSynth;
				successfulSynths = successfulSynths.add(item.name);
			});
		};

		synthDefCompilationFile.write(synthDefCompilationFileString);
		synthDefCompilationFile.close;

		synthDefNameFile = File(ShSynthGen.filePath ++ "/" ++ compilationName ++ "Names.txt", "w");
		synthDefNameFileString = "";

		successfulSynths.do {
			arg name, i;
			synthDefNameFileString = synthDefNameFileString ++ name ++ "\n";
		};

		synthDefNameFile.write(synthDefNameFileString);
		synthDefNameFile.close;

		"ShSynthGen: done.".postln;
	}

	*randomUGen {
		var ugen = UGen.allSubclasses[UGen.allSubclasses.size.rand];
		var pass = false;

		while({
			ugen.class.findRespondingMethodFor(\ar) == nil;
		}, {
			if(ugen.class.asString.contains("PV_") == false, { pass = true }); // Filter out PV UGens -> These will need special handling.}
			if(ugen.class.findRespondingMethodFor(\ar) == nil, { pass = false; });

			if(pass == false, {
				ugen = UGen.allSubclasses[UGen.allSubclasses.size.rand];
			});
		});

		^ugen
	}

	*audioRateArguments {
		arg class;
		var arguments = class.class.findRespondingMethodFor(\ar).argNames.deepCopy;
		var stringArguments = [];

		if(arguments != nil, {
			arguments = arguments.removeAll(\this);

			arguments.do {
				arg argument, i;
				stringArguments = stringArguments.add(argument.asString);
			};

			^stringArguments;
		}, {
			^[];
		});
	}

	// Special case argument generation
	*generateFreqArgument {
		arg inputs, variables, arguments;
		var code = "";
		var prob = 1.0.rand;

		"Generating new Freq argument".postln;

		case
		{ prob < 0.5 }

		{
			if(variables.indexOf("scale") != nil, {
				code = "Select.kr(Latch.ar(" ++ ShSynthGen.generateUGenCode(inputs, variables, arguments) ++ ", ";
				code = code ++ ShSynthGen.generateTrigArgument(inputs, variables, arguments) ++ ") * scale.size, scale)";
				^code;
			});

			if((variables.indexOf("freq") != nil) || (arguments.indexOf("freq") != nil), { ^"freq"; });

			code = variables.choose ++ " * " ++ variables.choose;
		}

		{ prob >= 0.5 && prob < 0.75 } { code = variables.choose }
		{ prob >= 0.75 } { code = ShSynthGen.generateUGenCode(inputs, variables, arguments) ++ ".exprange(1, SampleRate.ir)" };

		^code;
	}

	*generateBufferArgument {
		arg inputs, variables, arguments;
		// var code = "LocalBuf(2.pow(" ++  ++ "))";
		var code = "Array.fill(2.pow(" ++ rrand(10, 20) ++ "), { |i| rrand(-1, 1) }).as(LocalBuf)";
		"Generating new Buffer argument".postln;
		^code;
	}

	*generateEnveloperArgument {
		arg inputs, variables, arguments;
		var code = "";
		var prob = 1.0.rand;

		"Generating new Env argument".postln;

		case
		{ prob < 0.75 }

		{
			if((variables.indexOf("env") != nil) || (arguments.indexOf("env") != nil), { ^"env" });
			if((variables.indexOf("gateEnv") != nil) || (arguments.indexOf("gateEnv") != nil), { ^"gateEnv" });
			code = variables.choose ++ " * " ++ variables.choose;
		}

		{ prob >= 0.75 && prob < 0.85 } { code = variables.choose; }
		{ prob >= 0.85 } { code = ShSynthGen.generateUGenCode(inputs, variables, arguments) };

		^code;
	}

	*generateTrigArgument {
		arg inputs, variables, arguments;
		var code = "";
		var prob = 1.0.rand;

		"Generating new Trig argument".postln;

		case
		{ prob < 0.75 }

		{
			if((variables.indexOf("t_trig") != nil) || (arguments.indexOf("t_trig") != nil), { ^"t_trig" });
			if((variables.indexOf("trig") != nil) || (arguments.indexOf("trig") != nil), { ^"trig" });
			code = variables.choose ++ " * " ++ variables.choose;
		}

		{ prob >= 0.75 && prob < 0.85 } { code = variables.choose; }
		{ prob >= 0.85 } { code = ShSynthGen.generateUGenCode(inputs, variables, arguments) };

		^code;
	}

	*generateMulArgument {
		arg inputs, variables, arguments;
		var code = "";
		var prob = 1.0.rand;

		"Generating new Mul argument".postln;

		case
		{ prob < 0.5 } { code = (1 - exprand(0.00001, 1)).asString ++ " * " ++ ShSynthGen.generateEnveloperArgument(inputs, variables, arguments) }
		{ prob >= 0.5 && prob < 0.75 } { code = variables.choose; }
		{ prob >= 0.75 } { code = ShSynthGen.generateUGenCode(inputs, variables, arguments); };

		^code;
	}

	*generateArrayArgument {
		arg inputs, variables, arguments;
		var code = "[" ++ ShSynthGen.generateUGenCode(inputs, variables, arguments) ++ ", " ++ ShSynthGen.generateUGenCode(inputs, variables, arguments) ++ "]";
		^code;
	}

	*generateAddArgument {
		arg inputs, variables, arguments;
		var code = "";

		"Generating new Add argument".postln;
		if(1.0.rand < 0.9, { code = "0"; }, { code = ShSynthGen.generateUGenCode(inputs, variables, arguments); });

		^code;
	}

	// Generic UGen code creation
	*generateUGenCode {
		arg inputs, variables, arguments;

		var code = "";
		var ugen = ShSynthGen.randomUGen;
		var ugenArgs = ShSynthGen.audioRateArguments(ugen);

		"Generating new UGen".postln;

		code = code ++ ugen.asString ++ ".ar(";

		ugenArgs.do {
			arg argument, i;
			var furtherParse = true;

			case
			{ argument.contains("buf") } {
				if(argument.contains("sndbuf") || argument.contains("envbuf"), { code = code ++ "bufnum"; }, {
					code = code ++ ShSynthGen.generateBufferArgument(inputs, variables, arguments);
				});

				furtherParse = false;
			}

			{ argument.contains("env") && furtherParse } { code = code ++ ShSynthGen.generateEnveloperArgument(inputs, variables, arguments); furtherParse = false; }
			{ argument.contains("trig") && furtherParse } { code = code ++ ShSynthGen.generateTrigArgument(inputs, variables, arguments); furtherParse = false; }
			{ argument.contains("array") && furtherParse } { code = code ++ ShSynthGen.generateArrayArgument(inputs, variables, arguments); furtherParse = false; }
			{ argument.contains("mul") && furtherParse } { code = code ++ ShSynthGen.generateMulArgument(inputs, variables, arguments); furtherParse = false; }
			{ argument.contains("add") && furtherParse } { code = code ++ ShSynthGen.generateAddArgument(inputs, variables, arguments); furtherParse = false; }
			{ argument.contains("freq") && furtherParse } { code = code ++ ShSynthGen.generateFreqArgument(inputs, variables, arguments); furtherParse = false; }
			{ argument.contains("numChannels") && furtherParse } { code = code ++ "2"; furtherParse = false; }
			{ argument.contains("nChans") && furtherParse } { code = code ++ "2"; furtherParse = false; }
			{ argument.contains("numChans") && furtherParse } { code = code ++ "2"; furtherParse = false; }
			{ argument.contains("Chans") && furtherParse } { code = code ++ "2"; furtherParse = false; }
			{ argument.contains("chans") && furtherParse } { code = code ++ "2"; furtherParse = false; }
			{ argument.contains("channels") && furtherParse } { code = code ++ "2"; furtherParse = false; };

			if(furtherParse, {
				var prob = 1.0.rand;
				var argumentString = "";

				case
				{ prob < 0.1 } // Create another ugen to fill the argument

				{
					code = code ++ ShSynthGen.generateUGenCode(inputs, variables, arguments);
				}

				{ prob >= 0.1 && prob < 0.45 } // Pick an input

				{
					// code = code ++ inputs.choose;
	    			code = code ++ variables.choose ++ " * " ++ variables.choose;
				}

				{ prob >= 0.45 && prob < 0.7 } // Pick a variable

				{
					code = code ++ variables.choose;
				}

				{ prob >= 0.7 && prob < 0.9 } // Pick an argument

				{
					argumentString = arguments.choose;
					if(argumentString.contains("="), { argumentString = argumentString.subStr(0, argumentString.find("=") - 1); });
					code = code ++ argumentString;
				}

				{ prob >= 0.9 } // Just pick a number and multiply by env

				{
					code = code ++ rrand(exprand(1, 666), exprand(1, 6666)).asString ++ " * " ++ ShSynthGen.generateEnveloperArgument(inputs, variables, arguments);
				}
			});

			// if(i < (ugenArgs.size - 1), { code = code ++ ", " });
			code = code ++ ", ";
		};

		while({ code.endsWith(",") || code.endsWith(" ") }, { code = code.subStr(0, code.size - 2) });
		code = code ++ ")";

		^code;
	}
}

// Class used to create as the skeleton for randomly generated SynthDefs. A template should begin with arguments, like: "arg arg1, arg2, arg3;" and doesn't include store code
ShSynthTemplate {

	var <nameGenFunc, <generatedNames, <skeleton, <arguments, <variables;

	*new { arg argNameGenFunc;
		^super.new.init(argNameGenFunc);
	}

	init { arg argNameGenFunc;
		nameGenFunc = argNameGenFunc;
		generatedNames = Set[""];
		skeleton = []; // The skeleton is an array of macros and nil values. The nil values will be filled later by code generation.
		arguments = [];
		variables = [];
	}

	addArguments {
		arg newArguments;
		arguments = arguments ++ newArguments;
		("add arguments: " ++ newArguments).postln;
	}

	addVariables {
		arg newVariables;
		variables = variables ++ newVariables;
		("add variables: " ++ newVariables).postln;
	}

	// Push a value (macro or nil) on to the back of the skeleton
	push { arg value;
		if(value != nil, { value.editable = false });
		skeleton = skeleton.add(value);
		("ShSynthTemplate.skeleton.size: " ++ skeleton.size).postln;
	}

	generateSynthName {
		var nameString = "";

		while({ generatedNames.includes(nameString) }, {
			nameString = nameGenFunc.value;
		});

		("Creating Synth: " ++ nameString).postln;
		generatedNames = generatedNames.add(nameString);
		^nameString;
	}
}

// An instance of a SynthDef generation. The code is compartmentalized for easier manipulation and variation.
ShSynthGeneration {

	var <>arguments, <>variables, <name, <template, <variationNumber, <>macros, <code;

	*new { arg argName, argTemplate, argVariationNumber;
		^super.new.init(argName, argTemplate, argVariationNumber);
	}

	init { arg argName, argTemplate, argVariationNumber;
		name = argName;
		template = argTemplate;
		variationNumber = argVariationNumber;
		macros = [];
		code = "";
		arguments = template.arguments;
		variables = template.variables;

		template.skeleton.do {
			arg macro, i;
			"ShSynthGeneration.macros.add".postln;
			macros = macros.add(macro.deepCopy);
			i.postln;
		}
	}

	addArguments {
		arg newArguments;
		arguments = arguments ++ newArguments;
		("add arguments: " ++ newArguments).postln;
	}

	addVariables {
		arg newVariables;
		variables = variables ++ newVariables;
		("add variables: " ++ newVariables).postln;
	}

	insertMacro {
		arg index, macro;
		macros.insert(index, macro);
	}

	pushMacro {
		arg macro;
		macros = macros.insert(macros.size - 1, macro);
	}

	setMacro {
		arg index, macro;
		("ShSynthGeneration.setMacro: " ++ index).postln;
		macros[index] = macro;
	}

	generateVariables {
		arg numberOfVariables;

		var newVariables = Array.fill(numberOfVariables, {
			arg i;
			"var" ++ name.replace(".", "").replace(" ", "").replace("-", "_").replace("[", "").replace("]", "").replace("!", "").replace("(", "").replace(")", "") ++ (i + variables.size + 1).asString;
		});

		this.addVariables(newVariables);

		^newVariables;
	}

	compile {
		var lastOutputs = nil;

		// Begin
		code = ShSynthGen.synthBeginCode.replace("__NAME__", "\"" ++ name ++ "\"");

		// Arguments
		code = code ++ "arg ";

		arguments.do {
			arg argument, i;
			code = code ++ argument ++ ", ";
		};

		code = code.subStr(0, code.size - 3) ++ ";\n";

		// Variables
		code = code ++ "var ";

		variables.do {
			arg variable, i;
			code = code ++ variable ++ ", ";
		};

		code = code.subStr(0, code.size - 3) ++ ";\n\n";

		// Initialize arguments to audio rate versions to prevent errors:
		arguments.do {
			arg argument, i;
			var argumentString = argument;

			if(argumentString.contains("="), { argumentString = argumentString.subStr(0, argumentString.find("=") - 1); });

			code = code ++ argumentString ++ "= K2A.ar(" ++ argumentString ++ ");\n";
		};

		// Initialize variables, preventing compile time errors
		variables.do {
			arg variable, i;
			code = code ++ variable ++ " = ";
		};

		if(variables.size > 0, { code = code ++ "K2A.ar(t_trig).dup;\n"; });

		// Body
		macros.do {
			arg item, i;

			if(item != nil, {
				var compiled = item.compile(lastOutputs, variables, arguments);
				lastOutputs = compiled[1];
				"ShSynthGeneration.item.compiled: ".post;
				compiled.postln;

				code = code ++ compiled[0];
			});
		};

		// End
		code = code ++ ShSynthGen.synthEndCode;
		^code;
	}
}

// Abstracted code chuck generation. Can be fixed or generative.
ShSynthMacro {

	classvar argumentType = \argument;
	classvar variableType = \variable;
	classvar bodyType = \body;
	classvar endType = \end;

	// codeGenFunc should accept an array of inputs and return an array of it's code and outputs like this [ "codeString", outputs ]
	var <outputs, codeGenFunc, code, <>editable, <>type;

	*new { arg argCodeGenFunc, argType;
		^super.new.init(argCodeGenFunc, argType);
	}

	init { arg argCodeGenFunc, argType;
		codeGenFunc = argCodeGenFunc;
		editable = true;
		type = argType ? \body;
	}

	compile { arg inputs, variables, arguments;
		var compiledArray = codeGenFunc.value(inputs, variables, arguments);
		code = compiledArray[0]; // Explicit to guarantee that you're returning the information in the correct format.
		outputs = compiledArray[1]; // Explicit to guarantee that you're returning the information in the correct format.
		^[code, outputs];
	}
}

Shoggoth {

	classvar <>nameSet;

	*generateSynths {
		arg workingDirectory, nameSetFile;

		var prototypeStrategy = {
			arg name, template;
			var generatedSynth = ShSynthGeneration.new(name, template);
			var ugen, ugenArgs, variablesCode, newVariables;

			newVariables = generatedSynth.generateVariables(rrand(1, 7)); // Create some new variables to work with

			// Add new body code
			generatedSynth.pushMacro(
				ShSynthMacro.new({
					arg inputs, variables, arguments;
					var code, outputs;
					code = "// Generated prototype body code\n";

					newVariables.do {
						arg variable, i;
						code = code ++ variable ++ " = " ++ ShSynthGen.generateUGenCode(inputs, variables, arguments) ++ ";\n";
					};

					newVariables.do {
						arg variable, i;
						code = code ++ variable ++ " = " ++ ShSynthGen.generateUGenCode(inputs, variables, arguments) ++ ";\n";
					};

					outputs = newVariables;

					[code, outputs];
				}, \body)
			);

			"prototypeStrategy: body macro created".postln;
			generatedSynth;
		};

		var variationStrategy = {
			arg name, prototype;
			var generatedSynth = ShSynthGeneration.new(name, prototype.template);
			var newVariables;
			generatedSynth.macros = prototype.macros.deepCopy;
			generatedSynth.arguments = prototype.arguments.deepCopy;
			generatedSynth.variables = prototype.variables.deepCopy;

			"variationStrategy: generatedSynth created.".postln;

			newVariables = generatedSynth.generateVariables(rrand(1, 5)); // Create some new variables to work with

			// Variation code here
			generatedSynth.insertMacro(
				generatedSynth.macros.size - 1,
				ShSynthMacro.new({
					arg inputs, variables, arguments;
					var code, outputs;
					code = "// Variation test code\n";

					newVariables.do {
						arg variable, i;
						code = code ++ variable ++ " = " ++ ShSynthGen.generateUGenCode(inputs, variables, arguments) ++ ";\n";
					};

					outputs = newVariables;
					[code, outputs];
				}, \body)
			);

			"variationStrategy: variation macro created.".postln;

			generatedSynth;
		};

		var nameGenFunc, template, beginMacro, middleMacro, endMacro;

		Shoggoth.nameSet = FileReader.read(workingDirectory ++ nameSetFile);

		nameGenFunc = {
			var name = Shoggoth.nameSet[Shoggoth.nameSet.size.rand][0].asString;
			name.postln;
			name;
		};

		// NOTE: Macros added to templates are not editable by variations.
		template = ShSynthTemplate.new(nameGenFunc);

		template.addArguments(["amp=0.25", "x=0", "y=0", "z=0", "island=0", "gate=1", "t_trig=0", "bufnum=0"]);
		template.addVariables(["env", "signal", "modX", "modY", "modZ", "gateEnv", "wave"]);

		middleMacro = ShSynthMacro.new({
			arg inputs, variables, arguments;
			var code, outputs;

			code = "gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
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
			) * env;\n";

			outputs = ["wave"];

			[code, outputs];
		}, \body);

		endMacro = ShSynthMacro.new({
			arg inputs, variables, arguments;
			var code, outputs;

			code = "\n";

			if(inputs.size > 0, {
				code = code ++ "signal = " ++ inputs[inputs.size - 1] ++ ";";
			});

			code = code ++ "\nsignal = SanityCheck2.ar(signal);
			Out.ar(50, Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001));\n";

			outputs = "signal";

			[code, outputs];
		}, \end);

		template.push(beginMacro);
		template.push(middleMacro);
		template.push(nil); // Generated code will be inserted here. Use this for the body of the synth def.
		template.push(endMacro);

		"Done setting up Shoggoth.generateSynths. Generating now...".postln;

		5.do {
			ShSynthGen.generate(5, 1, workingDirectory, template, prototypeStrategy, variationStrategy);
		}
	}
}

/*
Shoggoth.generateSynths("/home/octopian/Documents/source/QtDev/Shoggoth/resources/", "NameSet.txt");
*/