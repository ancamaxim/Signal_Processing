# Numerical music
- stereo_to_mono = am utilizat functia mean cu dand ca argumente matricea semnalelor sub forma stereo,
                   si 2, astfel realizandu-se media elementelor de pe fiecare rand al matricei
- spectrogram =
    - determina numarul de ferestre care trebuie procesate
    - aplica functia hanning pe numarul determinat anterior, rezultand un vector coloana Hann (fereastra Hann)
    - pentru fiecare fereastra, construieste un vector coloana cu dimensiunea ferestrei, aplicand pe continutul
      aferent ferestrei din matricea semnalelor, vectorul hanning (pentru a fi procesat mai usor), dupa care
      aplica algoritmul FFT, rezultand o serie de semnale in forma complexa.
      Pastreaza in matricea S doar modulul rezultatelor din FFT;
      In vectorul frecventelor, pastrez window_size frecvente, raportandu-le la frecventa maxima (Nyquist), 
      pentru a rezulta intreg range-ul frecventelor corespunzatoare ferestrei
      Vectorul intervalelor de timp asociaza un interval de timp fiecarei frecvente din vectorul determinat anterior.
    - Spectrograma din Plain Sound pare comprimata la o serie de ferestre egale in dimensiune, complexitatea
    acesteia este redusa si se pastreaza doar informatia esentiala legata de amplitudinea frecventelor din acea
    fereastra (inalta sau joasa, marcata prin culoare)
- oscillator =
    - determina vectorul intervalelor de timp cu lungimea egala 1/fs
    - determina numarul de sample-uri din fiecare tip folosindu-se de parametrii dati (A, D, S, R)
    - determina fiecare ramp prin pastrarea intr-un vector coloana a valorilor de la:
        - [0,1] cu pas no_A pt attack samples
        - [1 S] cu pas no_D pt decay samples
        - [0 S] cu pas no_R pt release samples
        - in sustain samples pastrez no_S valori constante egale cu S
    - La final, concatenez ramps obtinute si inmultesc element cu element cu sine wave-ul determinat anterior
- low_pass = 
    - aplica FFT pe vectorul dat ca parametru
    - creeaza vectorul de frecvente dupa modelul functiei oscillator
    - retine intr-un vector mask separat daca fiecare frecventa este mai mare decat frecventa cutoff
    - aplica masca prin produs Haddamard semnalului rezultat din FFT
    - normalizeaza semnalul rezultat

    - Spectrograma rezultata in urma aplicarii Low Pass Filter retine frecventele oscilatiilor dar sub forma atenuata, adica frecventele inalte sunt cu mult atenuate fata de forma initiala.

- reverb = realizeaza convolutia a doua semnale, dupa ce au fost aduse la forma mono. La final, semnalul e normalizat.
    - Spectrograma Reverb Sound arata modul in care semnalul persista in timp, mai exact persistenta frecventei in timp.
    - Spectrograma Tech evidentiaza evolutia frecventelor semnalului in timp, evaluata doar pentru primele 500k samples.
    - Spectrograma Low Pass Tech arata forma atenuata (in amplitudine) a frecventelor din Tech.
    - Spectrograma Reverb Tech arata convolutia normalizata a semnalului tech si impulse response.
    - Spectrogramele Low Pass Tech + Reverb si Reverb + Low Pass Tech arata aplicarea succesiva a functiilor de atenuare si convolutie a semnalelor, dar in ordine diferita. Rezultatele sunt asemanatoare, dar difera in amplitudine.

# Recommendations

- read_mat = citeste din fisierul .csv transmis prin path informatiile si le pune intr-o matrice
- cosine_similarity = returneaza gradul de similaritate dintre doi vectori, realizand produsul lor scalar, impartind la norma fiecarui vector
- preprocess = sterge randurile din matrice care au mai putin de min_reviews valori nenule
- recommendations
    - aplica algoritmul SVD de descompunere asupra matricei din fisierul .csv
    - aplica cosine_similarity pe randurile din matricea V si liked_theme pt a identifica cele mai apropiate rezultate de liked_theme
    - ordoneaza atat vectorul de indici pe baza rezultatelor obtinute (gradul de similaritate) si alege doar primele
num_recoms valori.
