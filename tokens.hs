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

module Main where
import Data.Char
import Data.List.Split

-- A fairly comprehensive list of non-letter characters
nonLetters = map chr $ [00 .. 64] ++ [91 .. 96] ++ [123 .. 126]

main = do
	-- Read in both the input and stopword files
	contents <- readFile "assignment3-input.txt"
	sw <- readFile "assignment3-stopwords.txt"
	
	-- Write the tokenizer and stopwords-free outputs to separate files
	writeFile "output1-tokens.txt" $ tokenizer contents
	writeFile "output2-stopwords.txt" $ stopFilter (lines $ tokenizer contents) (lines sw)

-- The tokenizer function splits the input text at any non-letter character
tokenizer :: [Char] -> String
tokenizer n = unlines $ filter (not.null) $ endByOneOf nonLetters $ map toLower n

-- The stopFilter function strips all stopwords from the tokenizer output
stopFilter :: [String] -> [String] -> String
stopFilter n m = unlines $ filter (\x -> not (elem x m)) n
