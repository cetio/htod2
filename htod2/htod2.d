module htod;

import std.stdio;
import std.string;
import std.algorithm;
import std.array;
import std.ascii;

private int main()
{
    writeln(himport!(r"vex_brain.h"));
    readln();
    return 0;
}

template himport(string filePath)
{   
    string setup()
	{
        string declarations = "extern (C)\n{\n";
        string text = import(filePath);

        text = text.replace("signed ", "");
        text = text.replace("int16_t", "short");
        text = text.replace("int8_t", "byte");
        text = text.replace("int16_t", "short");
        text = text.replace("int32_t", "int");
        text = text.replace("int64_t", "long");
        text = text.replace("wchar_t", "wchar");
        text = text.replace("char8_t", "char");
        text = text.replace("char16_t", "wchar");
        text = text.replace("char32_t", "dchar");
		text = text.replace("double _Complex", "cdouble");
        text = text.replace("long double _Complex", "creal");
		text = text.replace("signed char", "byte");
        text = text.replace("unsigned char", "ubyte");
		text = text.replace("long long", "cent");
        text = text.replace("long double", "real");
		text = text.replace("short int", "short");
        text = text.replace("int_least8_t", "byte");
		text = text.replace("int_least16_t", "short");
		text = text.replace("int_least32_t", "int");
		text = text.replace("int_least64_t", "long");
        text = text.replace("int_fast8_t", "byte");
		text = text.replace("int_fast16_t", "short");
		text = text.replace("int_fast32_t", "int");
		text = text.replace("int_fast64_t", "long");
		text = text.replace("intmax_t", "long");
		text = text.replace("intptr_t", "long");
        text = text.replace("char*", "string");

        auto lines = text.splitLines.map!(x => x.strip);
        // Need support for refs and function pointers
        foreach (line; lines)
		{
            string[] tokens = line.splitter.array;

			if (tokens.length >= 4 && tokens[0].length > 0 && tokens[1].length > 0 && tokens[2].length > 0 && tokens[$-1].length > 0 && tokens[$-1].endsWith(");"))
			{
                if (tokens[0].find('(').empty && (!tokens[1].find('(').empty || tokens[2].startsWith('(')))
				    declarations ~= "    " ~ line ~ "\n";
			}
		}
        
        return declarations ~= "}";
    }

    const string himport = setup();
}