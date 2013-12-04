// SynthDef generator for Shoggoth

// Components: Template

// Techniques, generate a base sound, then generate several variations
// Use introspection to fill arguments.
// Make and use arguments.

// Static class used to start/stop/control synth def generation
ShSynthGen {

        classvar <>numGenerations, <>numPrototypes, <>numPrototypeVariations, <>generations, <>nilMacro, <>filePath, <>prototypeStrategy, <>variationStrategy, <>template;
        classvar <>synthBeginCode, <>synthEndCode, <>tab, <nonCompileableVariableCharacters, <>validUGenMethods, <binaryOpUGens;

        *initClass {

                nonCompileableVariableCharacters = [
                        ".", " ", "-", "[", "]", "!", "£", "$", "%", "^", "&", "*", "(", ")", "@", "#", "'", "?", ",", ";", ":"
                ];

                validUGenMethods = Set[
                        "madd",
                        "range",
                        "exprange",
                        "unipolar",
                        "bipolar",
                        "clip",
                        "fold",
                        "wrap",
                        "blend",
                        "minNyquist",
                        "lag",
                        "lag2",
                        "lag3",
                        "lagud",
                        "lag2ud",
                        "lag3ud",
                        "slew",
                        "linlin",
                        "linexp",
                        "explin",
                        "expexp",
                        "lincurve",
                        "curvelin"
                ];

                binaryOpUGens = [
                        "min",
                        "max",
                        "round",
                        "trunc",
                        "hypot",
                        "hypotApx",
                        "atan2",
                        "ring1",
                        "ring2",
                        "ring3",
                        "ring4",
                        "sumsqr",
                        "difsqr",
                        "sqrsum",
                        "sqrdif",
                        "absdif",
                        "thresh",
                        "amclip",
                        "scaleneg",
                        "clip2",
                        "wrap2",
                        "fold2",
                        "excess",
                        "biexp",
                        "excess",
                        "bilin",
                        "excess",
                        "wrap2",
                        "fold2",
                        "clip2",
                        "rightShift",
                        "unsignedRightShift",
                        "leftShift",
                        "gcd",
                        "lcm",
                        "round",
                        "roundUp",
                        "bitHammingDistance",
                        "bitXor",
                        "bitOr",
                        "bitAnd",
                        "max",
                        "min",
                        "pow",
                        "mod",
                        "div",
                        "dist",
                        "rotate",
                        "theta",
                        "rho"
                ];
        }

        // Removes characters from a string so it can be compiled as a variable or argument name
        *removeNonCompileableCharacters {
                arg string;
                var newString = string.deepCopy;

                nonCompileableVariableCharacters.do {
                        arg item, i;
                        newString = newString.replace(item, "");
                }

                ^newString;
        }

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
                ShSynthGen.tab = " ";
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

                if(ShSynthGen.filePath != nil, { appendString = ".store.writeDefFile(\"" ++ filePath ++ "\");\n"; }, { appendString = ";\n" });
                appendString = appendString ++ "\n\n\n\n";
                writeCode = writeCode ++ appendString;

                try({ writeCode.interpret; }, { arg error; error.postln; "SynthDef compile failed.".postln; ^nil });
                "SynthDef compile successful".postln;
                ^writeCode;
        }

        *finish {
                var compilationName = "GeneratedSynthDefs--" ++ Date.localtime.asString.replace(" ", "-");
                var commentBlock = "//////////////////////////////////////////////////////////////////////////////////////////////////////////\n";
                var synthDefCompilationFileString = commentBlock ++ "// " ++ compilationName ++ "\n" ++ commentBlock ++ "\n\n\n";
                var synthDefCompilationFileName = ShSynthGen.filePath ++ "/" ++ compilationName ++ ".scd";
                var synthDefCompilationNameFileString = ShSynthGen.filePath ++ "/" ++ compilationName ++ "Names.txt";
                var totalSynths, successfulSynths;

                successfulSynths = 0;
                totalSynths = ShSynthGen.generations.size;

                "ShSynthGen.finish beginning".postln;
                File(synthDefCompilationFileName, "a").write(synthDefCompilationFileString).close;

                ShSynthGen.generations.do {
                        arg item, i;
                        var newSynth = ShSynthGen.writeSynth(item.name, item.code);

                        if(newSynth != nil, {
                                File(synthDefCompilationFileName, "a").write(newSynth).close;
                                File(synthDefCompilationNameFileString,"a").write(item.name ++ "\n").close;
                                successfulSynths = successfulSynths + 1;
                        });
                };

                "\n\n///////////////////////////////////////".postln;
                "// ShSynthGen: DONE GENERATING SYNTHS.".postln;
                "///////////////////////////////////////\n".postln;

                (totalSynths.asString ++ " SynthDefs generated.").postln;
                (successfulSynths.asString ++ " SynthDefs successfully compiled.").postln;
                ((totalSynths - successfulSynths).asString ++ " Synthdefs failed to compile.").postln;
                ((successfulSynths / totalSynths * 100).asString ++ "% success rate.").postln;
        }

        *randomUGen {
                var ugen = UGen.allSubclasses.choose;
                var pass = false;

                while({
                        ugen.class.findRespondingMethodFor(\ar) == nil;
                }, {
                        if(ugen.class.asString.contains("PV_").not
                                        && ugen.class.asString.contains("FFT")
                                        && ugen.class.asString.contains("SOMRd").not
                                        && ugen.class.asString.contains("BFEncode").not
                                        && ugen.class.asString.contains("BFDecode").not
                                        && ugen.class.asString.contains("out").not
                                        && ugen.class.asString.contains("Out").not
                                        && ugen.class.asString.contains("VarLag").not,
                                        { pass = true }
                        ); // Filter out certains UGens -> These will need special handling.}

                        if(ugen.class.findRespondingMethodFor(\ar) == nil, { pass = false; });

                        if(pass == false, {
                                ugen = UGen.allSubclasses.choose;
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
                arg inputs, variables, arguments, depth;
                var code = "";
                var prob = 1.0.rand;

                // "Generating new Freq argument".postln;

                case
                { prob < 0.5 }

                {
                        if(variables.indexOf("scale") != nil, {
                                code = "Select.kr(Latch.ar(" ++ ShSynthGen.generateUGenCode(inputs, variables, arguments, depth - 1) ++ ", ";
                                code = code ++ ShSynthGen.generateTrigArgument(inputs, variables, arguments, depth - 1) ++ ") * scale.size, scale)";
                                ^code;
                        });

                        if((variables.indexOf("freq") != nil) || (arguments.indexOf("freq") != nil), { ^"freq"; });

                        code = variables.choose ++ " * " ++ variables.choose;
                }

                { prob >= 0.5 && prob < 0.75 } { code = variables.choose }
                { prob >= 0.75 } { code = ShSynthGen.generateUGenCode(inputs, variables, arguments, depth - 1) ++ ".exprange(1, SampleRate.ir)" };

                ^code;
        }

        *generateBufferArgument {
                arg inputs, variables, arguments;
                // var code = "LocalBuf(2.pow(" ++ ++ "))";
                var code = "Array.fill(2.pow(" ++ rrand(10, 16) ++ "), { |i| rrand(-1, 1) }).as(LocalBuf)";
                // "Generating new Buffer argument".postln;
                ^code;
        }

        *generateEnveloperArgument {
                arg inputs, variables, arguments, depth;
                var code = "";
                var prob = 1.0.rand;

                // "Generating new Env argument".postln;

                case
                { prob < 0.75 }

                {
                        if((variables.indexOf("env") != nil) || (arguments.indexOf("env") != nil), { ^"env" });
                        if((variables.indexOf("gateEnv") != nil) || (arguments.indexOf("gateEnv") != nil), { ^"gateEnv" });
                        code = variables.choose ++ " * " ++ variables.choose;
                }

                { prob >= 0.75 && prob < 0.85 } { code = variables.choose; }
                { prob >= 0.85 } { code = ShSynthGen.generateUGenCode(inputs, variables, arguments, depth - 1) };

                ^code;
        }

        *generateTrigArgument {
                arg inputs, variables, arguments, depth;
                var code = "";
                var prob = 1.0.rand;

                // "Generating new Trig argument".postln;

                case
                { prob < 0.75 }

                {
                        if((variables.indexOf("t_trig") != nil) || (arguments.indexOf("t_trig") != nil), { ^"t_trig" });
                        if((variables.indexOf("trig") != nil) || (arguments.indexOf("trig") != nil), { ^"trig" });
                        code = variables.choose ++ " * " ++ variables.choose;
                }

                { prob >= 0.75 && prob < 0.85 } { code = variables.choose; }
                { prob >= 0.85 } { code = ShSynthGen.generateUGenCode(inputs, variables, arguments, depth - 1) };

                ^code;
        }

        *generateMulArgument {
                arg inputs, variables, arguments, depth;
                var code = "";
                var prob = 1.0.rand;

                // "Generating new Mul argument".postln;

                case
                { prob < 0.5 } { code = (1 - exprand(0.00001, 1)).asString ++ " * " ++ ShSynthGen.generateEnveloperArgument(inputs, variables, arguments, depth - 1) }
                { prob >= 0.5 && prob < 0.75 } { code = variables.choose; }
                { prob >= 0.75 } { code = ShSynthGen.generateUGenCode(inputs, variables, arguments, depth - 1); };

                ^code;
        }

        *generateArrayArgument {
                arg inputs, variables, arguments, depth;
                var code = "[" ++ ShSynthGen.generateUGenCode(inputs, variables, arguments, depth - 1);
                code = code ++ ", " ++ ShSynthGen.generateUGenCode(inputs, variables, arguments, depth - 1) ++ "]";
                ^code;
        }

        *generateAddArgument {
                arg inputs, variables, arguments, depth;
                var code = "";

                // "Generating new Add argument".postln;
                if(1.0.rand < 0.9, { code = "Silent.ar()"; }, { code = ShSynthGen.generateUGenCode(inputs, variables, arguments, depth - 1); });

                ^code;
        }

        *generateBinaryOpUGen {
                arg inputs, variables, arguments, depth;
                var method = ShSynthGen.binaryOpUGens.choose;
                var code = "." ++ method ++ "(" ++ ShSynthGen.generateUGenCode(inputs, variables, arguments, depth - 1) ++ ")";
                //("Generating BinaryOpUGen: " ++ method).postln;
                ^code;
        }

        *generateUGenMethodArguments {
                arg method;
                var arguments = method.argNames.deepCopy;
                var stringArguments = [];

                // "Generating UGen method arguments names.".postln;

                if(arguments != nil, {

                        if(arguments.size > 0, { arguments = arguments.removeAll(\this); });

                        arguments.do {
                                arg argument, i;
                                stringArguments = stringArguments.add(argument.asString);
                        };

                        ^stringArguments;
                }, {
                        ^[];
                });
        }

        *generateUGenMethod {
                arg inputs, variables, arguments, depth;
                var code = ".";
                var pass = false;
                var method, methodName, methodArgs;

                // "Generating UGen method".postln;
                // "Generating UGen methodName".postln;

                while({ pass == false }, {
                        method = UGen.methods.choose;
                        methodName = method.name.asString;

                        if(ShSynthGen.validUGenMethods.includes(methodName), { pass = true });
                });

                code = code ++ methodName ++ "(";
                methodArgs = ShSynthGen.generateUGenMethodArguments(method);

                // "Generating UGen method arguments".postln;

                methodArgs.do {
                        arg argument, i;

                        code = code ++ ShSynthGen.generateArgument(argument, inputs, variables, arguments, depth - 1);

                        // if(i < (ugenArgs.size - 1), { code = code ++ ", " });
                        code = code ++ ", ";
                };

                // "Finishing UGen method".postln;

                while({ code.endsWith(",") || code.endsWith(" ") }, { code = code.subStr(0, code.size - 2) });
                code = code ++ ")";

                ^code;
        }

        *generateArgument {
                arg argument, inputs, variables, arguments, depth;
                var code = "";
                var furtherParse = true;

                case
                { depth <= 0 } { code = code ++ inputs.choose ++ " * DC.ar(" ++ 1.0.rand ++ ")"; furtherParse = false }
                { argument.contains("buf") } {
                        if(argument.contains("sndbuf") || argument.contains("envbuf"), { code = code ++ "bufnum"; }, {
                                code = code ++ ShSynthGen.generateBufferArgument(inputs, variables, arguments, depth - 1);
                        });

                        furtherParse = false;
                }

                { argument.contains("specificationsArray") && furtherParse } {
                        var arrayString = "`[";
                        var numFreqs = 20.rand;

                        arrayString = arrayString ++ ShSynthGen.generateArrayArgument(inputs, variables, arguments, depth - 1);
                        arrayString = arrayString ++ ", " ++ ShSynthGen.generateArrayArgument(inputs, variables, arguments, depth - 1);
                        arrayString = arrayString ++ ", " ++ ShSynthGen.generateArrayArgument(inputs, variables, arguments, depth - 1);
                        /*
                        numFreqs.do { // Freqs
                                arg i;
                                arrayString = arrayString ++ ShSynthGen.generateFreqArgument(inputs, variables, arguments);
                                if(i < (numFreqs - 2), { arrayString = arrayString ++ ", "; }, { arrayString = arrayString ++ "], ["; })
                        };

                        numFreqs.do { // Amplitudes
                                arg i;
                                arrayString = arrayString ++ 1.0.rand;
                                if(i < (numFreqs - 2), { arrayString = arrayString ++ ", "; }, { arrayString = arrayString ++ "], ["; })
                        };

                        numFreqs.do { // Phases
                                arg i;
                                arrayString = arrayString ++ 2pi.rand;
                                if(i < (numFreqs - 2), { arrayString = arrayString ++ ", "; }, { arrayString = arrayString ++ "]"; })
                        };*/

                        arrayString = arrayString ++ "]";

                        code = code ++ arrayString;
                        furtherParse = false;
                }

                { argument.contains("bus") && furtherParse } { code = code ++ "(80 + (island * 2))"; furtherParse = false }
                { argument.contains("env") && furtherParse } { code = code ++ ShSynthGen.generateEnveloperArgument(inputs, variables, arguments, depth - 1); furtherParse = false; }
                { argument.contains("trig") && furtherParse } { code = code ++ ShSynthGen.generateTrigArgument(inputs, variables, arguments, depth - 1); furtherParse = false; }
                { argument.contains("array") && furtherParse } { code = code ++ ShSynthGen.generateArrayArgument(inputs, variables, arguments, depth - 1); furtherParse = false; }
                { argument.contains("Array") && furtherParse } { code = code ++ ShSynthGen.generateArrayArgument(inputs, variables, arguments, depth - 1); furtherParse = false; }
                { argument.contains("channelsArray") && furtherParse } {
                        code = code ++ ShSynthGen.generateArrayArgument(inputs, variables, arguments, depth - 1); furtherParse = false;
                }
                { argument.contains("mul") && furtherParse } { code = code ++ ShSynthGen.generateMulArgument(inputs, variables, arguments, depth - 1); furtherParse = false; }
                { argument.contains("add") && furtherParse } { code = code ++ ShSynthGen.generateAddArgument(inputs, variables, arguments, depth - 1); furtherParse = false; }
                { argument.contains("freq") && furtherParse } { code = code ++ ShSynthGen.generateFreqArgument(inputs, variables, arguments, depth - 1); furtherParse = false; }
                { argument.contains("numChannels") && furtherParse } { code = code ++ "2"; furtherParse = false; }
                { argument.contains("nChans") && furtherParse } { code = code ++ "2"; furtherParse = false; }
                { argument.contains("numChans") && furtherParse } { code = code ++ "2"; furtherParse = false; }
                { argument.contains("Chans") && furtherParse } { code = code ++ "2"; furtherParse = false; }
                { argument.contains("chans") && furtherParse } { code = code ++ "2"; furtherParse = false; }
                { (argument.contains("channels") && argument.contains("Array").not) && furtherParse } { code = code ++ "2"; furtherParse = false; }
                { argument.contains("rect") && furtherParse } { code = code ++ "Rect.new(0, 0, " ++ 1.0.rand ++ ", " ++ 1.0.rand ++ ")"; furtherParse = false; }
                { argument.contains("clip") } { code = code ++ "\\minmax"; furtherParse = false; };

                if(furtherParse, {
                        var prob = 1.0.rand;
                        var argumentString = "";

                        case
                        { prob < 0.05 } // Create another ugen to fill the argument

                        {
                                code = code ++ ShSynthGen.generateUGenCode(inputs, variables, arguments, depth - 1);
                        }

                        { prob >= 0.025 && prob < 0.45 } // Pick an input

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
                                code = code ++ 1.0.rand.asString ++ " * " ++ ShSynthGen.generateEnveloperArgument(inputs, variables, arguments, depth - 1);
                        }
                });

                if(depth > 0, {
                        if(1.0.rand < 0.025, { code = code ++ ShSynthGen.generateUGenMethod(inputs, variables, arguments, depth - 1); });
                        if(1.0.rand < 0.0125, { code = code ++ ShSynthGen.generateBinaryOpUGen(inputs, variables, arguments, depth - 1); });
                });

                ^code;
        }

        // Generic UGen code creation
        *generateUGenCode {
                arg inputs, variables, arguments, depth;

                var code = "";
                var ugen = ShSynthGen.randomUGen;
                var ugenArgs = ShSynthGen.audioRateArguments(ugen);

                // "Generating new UGen".postln;

                code = code ++ ugen.asString ++ ".ar(";

                ugenArgs.do {
                        arg argument, i;

                        code = code ++ ShSynthGen.generateArgument(argument, inputs, variables, arguments, depth);

                        // if(i < (ugenArgs.size - 1), { code = code ++ ", " });
                        code = code ++ ", ";
                };

                while({ code.endsWith(",") || code.endsWith(" ") || code.endsWith(".") }, { code = code.subStr(0, code.size - 2) });
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
                        "var" ++ ShSynthGen.removeNonCompileableCharacters(name) ++ (i + variables.size + 1).asString;
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
                                                code = code ++ variable ++ " = " ++ ShSynthGen.generateUGenCode(inputs, variables, arguments, 2.rand + 1) ++ ";\n";
                                        };

                                        newVariables.do {
                                                arg variable, i;
                                                code = code ++ variable ++ " = " ++ ShSynthGen.generateUGenCode(inputs, variables, arguments, 3.rand) ++ ";\n";
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
                        // This variation just adds new variables. You can iterated through the current macros stored in generatedSynth.macros and test for if it is .editable
                        // If is editable than you can parse over it and make any changes you'd like.
                        generatedSynth.insertMacro(
                                generatedSynth.macros.size - 1,
                                ShSynthMacro.new({
                                        arg inputs, variables, arguments;
                                        var code, outputs;
                                        code = "// Variation test code\n";

                                        newVariables.do {
                                                arg variable, i;
                                                code = code ++ variable ++ " = " ++ ShSynthGen.generateUGenCode(inputs, variables, arguments, 2) ++ ";\n";
                                        };

                                        newVariables.do {
                                                arg variable, i;
                                                code = code ++ variable ++ " = " ++ ShSynthGen.generateUGenCode(inputs, variables, arguments, 2) ++ ";\n";
                                        };

                                        newVariables.do {
                                                arg variable, i;
                                                code = code ++ variable ++ " = " ++ ShSynthGen.generateUGenCode(inputs, variables, arguments, 2) ++ ";\n";
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
                        var name = Shoggoth.nameSet.choose[0].asString;
                        name = name ++ Date.getDate.secStamp;
                        name.postln;
                        name;
                };

                // NOTE: Macros added to templates are not editable by variations.
                template = ShSynthTemplate.new(nameGenFunc);

                template.addArguments(["amp=0.25", "x=0", "y=0", "z=0", "island=0", "gate=1", "t_trig=0", "bufnum=0"]);
                template.addVariables(["env", "signal", "modX", "modY", "modZ", "gateEnv", "wave", "in"]);

                middleMacro = ShSynthMacro.new({
                        arg inputs, variables, arguments;
                        var code, outputs;

                        code = "gateEnv = EnvGen.ar(Env.asr(0, 1, 0.001, -4), gate:gate, doneAction:2);
                        modX = K2A.ar(x / 430);
                        modY = K2A.ar(y.linlin(-200, 200, 0, 0.999));
                        modZ = K2A.ar(z / 430);
                        env = EnvGen.ar(Env.new([0, 1, 0],[0.0001, modY.linexp(0, 1, 0.001, 0.25)], -4), gate:t_trig, doneAction:0);

                        in = InFeedback.ar(80 + (island * 2), 2);
                        wave = WaveTerrain.ar(
                         bufnum,
                         env * modX * 72,
                         env * modZ * 72,
                         72,
                         72
                        );

			wave = (in * 0.25) + wave;

                        \n";

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

                        code = code ++ "\nsignal = SanityCheck2.ar(signal) * env;
                        signal = Limiter.ar(LeakDC.ar(signal) * amp * gateEnv, 1, 0.001);
                        Out.ar(50, signal);
                        Out.ar(80 + (island * 2), signal * 0.5);
                        \n";

                        outputs = "signal";

                        [code, outputs];
                }, \end);

                template.push(beginMacro);
                template.push(middleMacro);
                template.push(nil); // Generated code will be inserted here. Use this for the body of the synth def.
                template.push(endMacro);

                "Done setting up Shoggoth.generateSynths. Generating now...".postln;

                ShSynthGen.generate(200, 1, workingDirectory, template, prototypeStrategy, variationStrategy);
        }
}

/*
Shoggoth.generateSynths("/home/octopian/Documents/source/QtDev/Shoggoth/resources/", "NameSet.txt");
*/