//Structural Design Pattern: Facade

// Framework für die Videokonvertierung
//
// In realen Anwendungen könnte dies eine komplexe Bibliothek sein
class VideoFile {
  final String filename;
  VideoFile(this.filename);
}

class File {
  final String filename;
  final String content;

  File(this.filename, this.content);

  void save() {
    print('Saving file $filename');
  }
}

abstract class Codec {
  void compress();
}

class OggCompressionCodec implements Codec {
  void compress() {
    print('Compressing video with Ogg codec...');
  }
}

class MPEG4CompressionCodec implements Codec {
  void compress() {
    print('Compressing video with MPEG4 codec...');
  }
}

class CodecFactory {
  Codec extract(VideoFile file) {
    print('Extracting codec from file: ${file.filename}');
    return file.filename.endsWith('.mp4') ? MPEG4CompressionCodec() : OggCompressionCodec();
  }
}

class BitrateReader {
  static String read(String filename, Codec codec) {
    print('Reading file $filename using codec...');
    return filename;
  }

  static String convert(String buffer, Codec codec) {
    print('Converting buffer using codec...');
    return buffer;
  }
}

class AudioMixer {
  String fix(String result) {
    print('Fixing audio...');
    return result;
  }
}

// Fassade für die Videokonvertierung
class VideoConverter {
  File convert(String filename, String format) {
    VideoFile file = VideoFile(filename);
    var codecFactory = CodecFactory();
    var sourceCodec = codecFactory.extract(file);

    Codec destinationCodec;
    if (format == "mp4") {
      destinationCodec = MPEG4CompressionCodec();
    } else {
      destinationCodec = OggCompressionCodec();
    }

    String buffer = BitrateReader.read(filename, sourceCodec);
    String result = BitrateReader.convert(buffer, destinationCodec);
    result = AudioMixer().fix(result);

    String newFilename = filename.split('.').first + '.' + format;

    return File(newFilename, result);
  }
}

void main() {
  final converter = VideoConverter();
  final mp4 = converter.convert("funny-cats-video.ogg", "mp4");
  mp4.save();
  print("--------------------");
  final ogg = converter.convert("funny-cats-video.mp4", "ogg");
  ogg.save();
}
