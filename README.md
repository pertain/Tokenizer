#Tokenizer & Stopword Remover

This program does two things:

1. Tokenize input text (i.e split at spaces etc.)
2. Read in a list of stopwords and remove all instances from the text

The final output is intended to be passed to a Porter stemmer, where
each remaining token is stemmed.
