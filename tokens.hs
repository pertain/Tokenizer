-- tokens.hs
--
-- William Ersing
-- CSC 320 - Assignment 03
--
-- This program is broken into three parts:
--		(1)	Read in and tokenize a file containing English text
--		(2)	Read in a file of stopwords and remove any words
--			contained in the file from the tokenizer output
--		(3)	Pass the tokenized output, sans stopwords to a
--			Porter stemmer (a separate Haskell program).
-- The tokenizer and stopword remover were both written by myself.
-- The Porter stemmer was written by Dmitry Antonyuk, and can
-- be found at: "tartarus.org/~martin/PorterStemmer/haskell.txt"

import Data.Char (chr, toLower)
import Data.List.Split (endByOneOf)

-- Filenames
inputFilename = "assignment3-input.txt"
stopwordFilename = "assignment3-stopwords.txt"
tokensOutFile = "tokenized"
stopwordsOutFile = "no_stopwords"

-- a fairly comprehensive list of non-letter characters
nonLetters = map chr $ [00 .. 64] ++ [91 .. 96] ++ [123 .. 126]

main = do
	-- Read in both the input and stopword files
	inputFile <- readFile inputFilename
	stopwordFile <- readFile stopwordFilename
	let swList = lines stopwordFile
	let tokens = tokenize inputFile
	writeFile tokensOutFile (unlines $ tokens)
	writeFile stopwordsOutFile (unlines $ rmStopwords swList tokens)

-- converts string to lowercase
lowerString :: String -> String
lowerString = map toLower

-- removes null values from list of lists
rmNulls :: [[a]] -> [[a]]
rmNulls = filter (not.null)

-- splits input string at any non-letter character
tokenize :: String -> [String]
tokenize s = rmNulls $ endByOneOf nonLetters (lowerString s)

-- strips all stopwords from tokens list
rmStopwords :: [String] -> [String] -> [String]
rmStopwords sws = filter (`notElem` sws)
