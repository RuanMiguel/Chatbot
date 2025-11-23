import java.util.*;

public class Main {

    private static final String[] perguntas = {
            "qual é o seu nome?",
            "o que você faz?",
            "como funciona o chatbot?",
            "o que é inteligência artificial?",
            "como usar o sistema?"
    };

    private static final String[] respostas = {
            "Eu sou um chatbot simples feito em Java!",
            "Eu respondo perguntas usando similaridade de texto.",
            "Eu comparo sua pergunta com minhas perguntas conhecidas usando TF-IDF.",
            "Inteligência artificial é a área que cria sistemas capazes de aprender e tomar decisões.",
            "Basta digitar uma pergunta e eu tento responder!"
    };

    private static List<String> tokenize(String text) {
        return Arrays.asList(text.toLowerCase().replaceAll("[^a-zA-Z0-9áéíóúãõç ]", "").split(" "));
    }

    private static Map<String, Integer> wordCount(List<String> words) {
        Map<String, Integer> count = new HashMap<>();
        for (String w : words) {
            if (w.isBlank()) continue;
            count.put(w, count.getOrDefault(w, 0) + 1);
        }
        return count;
    }

    private static double cosineSimilarity(Map<String, Double> v1, Map<String, Double> v2) {
        Set<String> allWords = new HashSet<>();
        allWords.addAll(v1.keySet());
        allWords.addAll(v2.keySet());

        double dot = 0;
        double mag1 = 0;
        double mag2 = 0;

        for (String w : allWords) {
            double a = v1.getOrDefault(w, 0.0);
            double b = v2.getOrDefault(w, 0.0);
            dot += a * b;
            mag1 += a * a;
            mag2 += b * b;
        }

        return (mag1 == 0 || mag2 == 0) ? 0 : dot / (Math.sqrt(mag1) * Math.sqrt(mag2));
    }

    private static Map<String, Double> tfidfVector(String text, List<List<String>> docs) {
        List<String> words = tokenize(text);
        Map<String, Integer> counts = wordCount(words);
        Map<String, Double> vec = new HashMap<>();

        for (String w : counts.keySet()) {
            double tf = counts.get(w);
            double df = 0;

            for (List<String> d : docs) {
                if (d.contains(w)) df++;
            }

            double idf = (df == 0) ? 0 : Math.log(docs.size() / df);
            vec.put(w, tf * idf);
        }

        return vec;
    }

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        List<List<String>> docs = new ArrayList<>();
        for (String p : perguntas) {
            docs.add(tokenize(p));
        }

        System.out.println("Chatbot iniciado! Digite sua pergunta:");

        while (true) {
            String user = sc.nextLine();

            if (user.equalsIgnoreCase("sair")) {
                System.out.println("Chatbot encerrado.");
                break;
            }

            Map<String, Double> userVec = tfidfVector(user, docs);

            double bestScore = -1;
            int bestIndex = -1;

            for (int i = 0; i < perguntas.length; i++) {
                Map<String, Double> docVec = tfidfVector(perguntas[i], docs);
                double score = cosineSimilarity(userVec, docVec);

                if (score > bestScore) {
                    bestScore = score;
                    bestIndex = i;
                }
            }

            if (bestScore < 0.05) {
                System.out.println("Não entendi muito bem. Pode reformular?");
            } else {
                System.out.println(respostas[bestIndex]);
            }
        }

        sc.close();
    }
}
