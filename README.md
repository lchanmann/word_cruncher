# Word Cruncher Program

The word cruncher program (i.e. `client.rb`) reads in a given dictionary and spits out two output files: `sequences` and `words`. Sequences will contain every sequence of four letters that appears in exactly one word of the dictionary, one sequence per line. Words will contain the corresponding words that contain the sequences, in the same order.

## Directory structure
```
├── lib
│   ├── ext
│   │   └── string.rb
│   ├── output_strategy
│   │   ├── array.rb
│   │   ├── file.rb
│   │   └── tempfile.rb
│   ├── output_strategy.rb
│   └── word_cruncher.rb
├── spec
│   ├── ext
│   │   └── string_spec.rb
│   ├── spec_helper.rb
│   ├── output_strategy_spec.rb
│   ├── support
│   │   └── dictionary.txt
│   └── word_cruncher_spec.rb
├── client.rb
├── dictionary.txt
├── sequences
└── words
```

`lib/` contains the library classes that are used by `client.rb`.

`spec/` contains test classes for the library.

`client.rb` makes use of `WordCruncher` class to process the dictionary and write data output to files.

`dictionary.txt` is the dictionary to be processed.

`sequences` and `words` are the output files generated when the program run.


**NOTE:** There is no need to unit test `client.rb` because it contains only setup code and relies entirely on the library code.


## Core library

`WordCruncher` class accepts `sequences` and `words` to which the outputs will be written and `s_length` for customizing sequence length (default to 4) for processing.

I use [Strategy pattern](https://en.wikipedia.org/wiki/Strategy_pattern) initially to avoid tests from writing output files when run. Now it also helps improve the flexibility of the program when it need to support additional output types. There are currently three supported strategies:

1. Array strategy for storing the output in array in memory
2. File strategy for writing the output to file
3. Tempfile strategy for writing the output to temporary file

`lib/ext/string.rb` contains extensions for `String` class:

- `each_cons(n)` for enumerating list of consecutive n-character sequences of a string


## Running the program

Clone the repo:

    git clone https://github.com/lchanmann/word_cruncher.git
    cd word_cruncher


Install dependencies

    bundle install


To run the program:

    ruby client.rb


### Convention over configuration

The program assumes that the dictionary file exists and named `dictionary.txt` under the same directory as `client.rb`. Sequences and Words will be written to files named `sequences` and `words`.
However, dictionary, sequences and words files can be customized by using environment variables `DICTIONARY`, `SEQUENCES` and `WORDS`. E.g.:

    $ DICTIONARY=my_dictionary.txt ruby client.rb


## Running tests

To run tests:

    rspec

