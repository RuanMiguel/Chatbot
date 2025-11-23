#Chabot

🤖 Chatbot Simples em Java com Similaridade de Texto
- Este projeto é um chatbot simples desenvolvido em Java que utiliza técnicas básicas de Processamento de Linguagem Natural (PLN), especificamente TF-IDF e Similaridade de Cosseno, para determinar a melhor resposta para a pergunta de um usuário, comparando-a com um conjunto predefinido de perguntas/respostas.

✨ Conceitos-Chave
- O coração deste chatbot está na forma como ele entende (ou melhor, compara) o texto:

- TF-IDF (Term Frequency-Inverse Document Frequency): Uma técnica estatística para refletir a importância de uma palavra em um documento em relação a uma coleção de documentos (o seu conjunto de perguntas). Palavras raras têm um peso maior (IDF), e palavras frequentes no documento atual têm um peso maior (TF).

- Similaridade de Cosseno (Cosine Similarity): Usada para medir a similaridade entre dois vetores de texto (o vetor da pergunta do usuário e o vetor de cada pergunta conhecida). O resultado é um valor entre 0 e 1, onde 1 indica vetores idênticos (máxima similaridade).

🚀 Como Executar
- Pré-requisitos
- Java Development Kit (JDK) 8 ou superior.

Passos para Execução
- Salvar o Código: Salve o código-fonte como Main.java.

- Compilar: Abra seu terminal no diretório do arquivo e compile o código:

**javac Main.java**

- Executar: Execute a classe compilada:

**java Main**

-Interação: O chatbot será iniciado, e você poderá digitar suas perguntas. Digite sair para encerrar.
