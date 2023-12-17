import std.stdio;
import std.array;
import std.algorithm;
import std.conv;
import std.math;
import stb.image;

void main(string[] args)
{
	if (args.length != 4) {
		string header = 
		"resizeimg (Resize Image) v0.1\n" ~
		"(ↄ) 2023 GPLv2 public domain\n" ~
		"Written by Hakan Candar\n" ~
		"\n" ~
		"Usage:\n" ~
		"resizeimg <image.png> <width>x<height> <out.png>\n" ~
		"resizeimg example.png 1000x700 output.png\n";

		writeln(header);
		return;
	}

	string filename = args[1];

	int[] val = args[2].split("x").map!(a => to!int(a)).array;
	int w = val[0];
	int h = val[1];

	string outFilename = args[3];

	Image image;
	try {
		image = new Image(filename);
	} catch (Exception e) {
		stderr.writeln("File ", filename, " not found.");
		return;
	}

	Color[] data = new Color[h * w];

	float wlen = cast(float)image.w / w;
	float hlen = cast(float)image.h / h;
	
	for (int x = 0; x < w; x++) {
		for (int y = 0; y < h; y++) {
			float xpos = wlen / 2 + wlen * x;
			float ypos = hlen / 2 + hlen * y;
			
			data[x + y * w] = image[cast(uint)floor(xpos), cast(uint)floor(ypos)];
		}
	}

	new Image(w, h, data).saveToFile(outFilename);
	
}
