import UIKit
import PDFKit

class FranceschiViewController: UIViewController {
    var pdfView: PDFView! // Declaração de uma variável para o visualizador de PDF
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Inicialização do visualizador de PDF
        pdfView = PDFView(frame: view.bounds)
        pdfView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        pdfView.backgroundColor = .lightGray
        view.addSubview(pdfView)
        
        // Localização do arquivo PDF a ser exibido
        guard let path = Bundle.main.path(forResource: "FranceschiExemploExame", ofType: "pdf") else { return }
        let url = URL(fileURLWithPath: path)
        
        // Criação de um documento PDF a partir do arquivo localizado
        let pdfDocument = PDFDocument(url: url)
        
        // Exibe o documento no visualizador de PDF
        pdfView.document = pdfDocument
        
        // Extrai informações específicas do documento PDF
        extractInformation(from: pdfDocument!)
    }
    
    func extractInformation(from pdfDocument: PDFDocument) {
        var fullText = ""
        
        // Itera por cada página do documento PDF
        for i in 0..<pdfDocument.pageCount {
            guard let page = pdfDocument.page(at: i) else { continue }
            
            // Obtém o texto da página atual
            let pageContent = page.string
            fullText += page.string ?? ""
            
            if let rangeOfExamForVitaminD = pageContent!.range(of: "VITAMINA D") {
                let startIndex = rangeOfExamForVitaminD.upperBound
                let rangeAfterStartIndex = startIndex..<pageContent!.endIndex
                let rangeOfResult = pageContent!.range(of: "RESULTADO", options: .caseInsensitive, range: rangeAfterStartIndex, locale: nil)
                if let rangeOfResult = rangeOfResult {
                    let startIndexOfValue = rangeOfResult.upperBound
                    let endIndexOfValue = pageContent!.range(of: "\n", range: startIndexOfValue..<pageContent!.endIndex)?.lowerBound ?? pageContent!.endIndex
                    let exam = pageContent![startIndexOfValue..<endIndexOfValue].trimmingCharacters(in: .whitespacesAndNewlines).trimmingCharacters(in: [".", ":"," "])
                    let examWords = exam.components(separatedBy: " ")
                    let firstWord = examWords.first
                    print("Página: \(i+1)")
                    print("VITAMINA D: \(firstWord ?? "")")
                }
            }
            
            if let rangeOfExamForSO = pageContent!.range(of: "SANGUE OCULTO") {
                let startIndex = rangeOfExamForSO.upperBound
                let rangeAfterStartIndex = startIndex..<pageContent!.endIndex
                let rangeOfResult = pageContent!.range(of: "RESULTADO", options: .caseInsensitive, range: rangeAfterStartIndex, locale: nil)
                if let rangeOfResult = rangeOfResult {
                    let startIndexOfValue = rangeOfResult.upperBound
                    let endIndexOfValue = pageContent!.range(of: "\n", range: startIndexOfValue..<pageContent!.endIndex)?.lowerBound ?? pageContent!.endIndex
                    let exam = pageContent![startIndexOfValue..<endIndexOfValue].trimmingCharacters(in: .whitespacesAndNewlines).trimmingCharacters(in: [".", ":"," "])
                    let examWords = exam.components(separatedBy: " ")
                    let firstWord = examWords.first
                    print("Página: \(i+1)")
                    print("SANGUE OCULTO: \(firstWord ?? "")")
                }
            }
            
            if let rangeOfExamForTSH = pageContent!.range(of: "TSH") {
                let startIndex = rangeOfExamForTSH.upperBound
                let rangeAfterStartIndex = startIndex..<pageContent!.endIndex
                let rangeOfResult = pageContent!.range(of: "RESULTADO", options: .caseInsensitive, range: rangeAfterStartIndex, locale: nil)
                if let rangeOfResult = rangeOfResult {
                    let startIndexOfValue = rangeOfResult.upperBound
                    let endIndexOfValue = pageContent!.range(of: "\n", range: startIndexOfValue..<pageContent!.endIndex)?.lowerBound ?? pageContent!.endIndex
                    let exam = pageContent![startIndexOfValue..<endIndexOfValue].trimmingCharacters(in: .whitespacesAndNewlines).trimmingCharacters(in: [".", ":"," "])
                    let examWords = exam.components(separatedBy: " ")
                    let firstWord = examWords.first
                    print("Página: \(i+1)")
                    print("TSH, ULTRA SENSÍVEL: \(firstWord ?? "")")
                }
            }
            
            if let rangeOfExamForColesterol = pageContent!.range(of: "TRIGLICÉRIDES") {
                let startIndex = rangeOfExamForColesterol.upperBound
                let endIndex = pageContent!.range(of: "\n", range: startIndex..<pageContent!.endIndex)?.lowerBound
                if let endIndex = endIndex {
                    let exam = pageContent![startIndex..<endIndex].trimmingCharacters(in: .whitespacesAndNewlines).trimmingCharacters(in: [":"," "])
                    let examWords = exam.components(separatedBy: " ")
                    let firstWord = examWords.first
                    print("Página: \(i+1)")
                    print("TRIGLICÉRIDES: \(firstWord ?? "")")
                }
            }
            
            if let rangeOfExamForColHDL = pageContent!.range(of: "COLESTEROL HDL") {
                let startIndex = rangeOfExamForColHDL.upperBound
                let endIndex = pageContent!.range(of: "\n", range: startIndex..<pageContent!.endIndex)?.lowerBound
                if let endIndex = endIndex {
                    let exam = pageContent![startIndex..<endIndex].trimmingCharacters(in: .whitespacesAndNewlines).trimmingCharacters(in: [":"," "])
                    let examWords = exam.components(separatedBy: " ")
                    let firstWord = examWords.first
                    print("Página: \(i+1)")
                    print("COLESTEROL HDL: \(firstWord ?? "")")
                }
            }
            
            if let rangeOfExamForColNotHDL = pageContent!.range(of: "COLESTEROL NÃO HDL") {
                let startIndex = rangeOfExamForColNotHDL.upperBound
                let endIndex = pageContent!.range(of: "\n", range: startIndex..<pageContent!.endIndex)?.lowerBound
                if let endIndex = endIndex {
                    let exam = pageContent![startIndex..<endIndex].trimmingCharacters(in: .whitespacesAndNewlines).trimmingCharacters(in: [":"," "])
                    let examWords = exam.components(separatedBy: " ")
                    let firstWord = examWords.first
                    print("Página: \(i+1)")
                    print("COLESTEROL NÃO HDL: \(firstWord ?? "")")
                }
            }
            
            if let rangeOfExamForColVLDL  = pageContent!.range(of: "COLESTEROL VLDL") {
                let startIndex = rangeOfExamForColVLDL.upperBound
                let endIndex = pageContent!.range(of: "\n", range: startIndex..<pageContent!.endIndex)?.lowerBound
                if let endIndex = endIndex {
                    let exam = pageContent![startIndex..<endIndex].trimmingCharacters(in: .whitespacesAndNewlines).trimmingCharacters(in: [":"," "])
                    let examWords = exam.components(separatedBy: " ")
                    let firstWord = examWords.first
                    print("Página: \(i+1)")
                    print("COLESTEROL VLDL: \(firstWord ?? "")")
                }
            }
            
            if let rangeOfExamForColLDL  = pageContent!.range(of: "COLESTEROL LDL") {
                let startIndex = rangeOfExamForColLDL.upperBound
                let endIndex = pageContent!.range(of: "\n", range: startIndex..<pageContent!.endIndex)?.lowerBound
                if let endIndex = endIndex {
                    let exam = pageContent![startIndex..<endIndex].trimmingCharacters(in: .whitespacesAndNewlines).trimmingCharacters(in: [":"," "])
                    let examWords = exam.components(separatedBy: " ")
                    let firstWord = examWords.first
                    print("Página: \(i+1)")
                    print("COLESTEROL LDL: \(firstWord ?? "")")
                }
            }
            
            if let rangeOfExamForCreatinina = pageContent!.range(of: "CREATININA") {
                let startIndex = rangeOfExamForCreatinina.upperBound
                let rangeAfterStartIndex = startIndex..<pageContent!.endIndex
                let rangeOfResult = pageContent!.range(of: "RESULTADO", options: .caseInsensitive, range: rangeAfterStartIndex, locale: nil)
                if let rangeOfResult = rangeOfResult {
                    let startIndexOfValue = rangeOfResult.upperBound
                    let endIndexOfValue = pageContent!.range(of: "\n", range: startIndexOfValue..<pageContent!.endIndex)?.lowerBound ?? pageContent!.endIndex
                    let exam = pageContent![startIndexOfValue..<endIndexOfValue].trimmingCharacters(in: .whitespacesAndNewlines).trimmingCharacters(in: [".", ":"," "])
                    let examWords = exam.components(separatedBy: " ")
                    let firstWord = examWords.first
                    print("Página: \(i+1)")
                    print("CREATININA: \(firstWord ?? "")")
                }
            }
            
            if let rangeOfExamForGlicose = pageContent!.range(of: "GLICOSE") {
                let startIndex = rangeOfExamForGlicose.upperBound
                let rangeAfterStartIndex = startIndex..<pageContent!.endIndex
                let rangeOfResult = pageContent!.range(of: "RESULTADO", options: .caseInsensitive, range: rangeAfterStartIndex, locale: nil)
                if let rangeOfResult = rangeOfResult {
                    let startIndexOfValue = rangeOfResult.upperBound
                    let endIndexOfValue = pageContent!.range(of: "\n", range: startIndexOfValue..<pageContent!.endIndex)?.lowerBound ?? pageContent!.endIndex
                    let exam = pageContent![startIndexOfValue..<endIndexOfValue].trimmingCharacters(in: .whitespacesAndNewlines).trimmingCharacters(in: [".", ":"," "])
                    let examWords = exam.components(separatedBy: " ")
                    let firstWord = examWords.first
                    print("Página: \(i+1)")
                    print("GLICOSE: \(firstWord ?? "")")
                }
            }
            
            if let rangeOfExamForHemoglobinaGlicada  = pageContent!.range(of: "HEMOGLOBINA GLICADA (A1C)") {
                let startIndex = rangeOfExamForHemoglobinaGlicada.upperBound
                let endIndex = pageContent!.range(of: "\n", range: startIndex..<pageContent!.endIndex)?.lowerBound
                if let endIndex = endIndex {
                    let exam = pageContent![startIndex..<endIndex].trimmingCharacters(in: .whitespacesAndNewlines).trimmingCharacters(in: [":"," "])
                    let examWords = exam.components(separatedBy: " ")
                    let firstWord = examWords.first
                    print("Página: \(i+1)")
                    print("HEMOGLOBINA GLICADA(A1C): \(firstWord ?? "")")
                }
            }
            
            if let rangeOfExamForGlicemia  = pageContent!.range(of: "GLICEMIA MÉDIA ESTIMADA") {
                let startIndex = rangeOfExamForGlicemia.upperBound
                let endIndex = pageContent!.range(of: "\n", range: startIndex..<pageContent!.endIndex)?.lowerBound
                if let endIndex = endIndex {
                    let exam = pageContent![startIndex..<endIndex].trimmingCharacters(in: .whitespacesAndNewlines).trimmingCharacters(in: [":"," "])
                    let examWords = exam.components(separatedBy: " ")
                    let firstWord = examWords.first
                    print("Página: \(i+1)")
                    print("GLICEMIA MÉDIA ESTIMADA: \(firstWord ?? "")")
                }
            }
            
            if let rangeOfExamForLeucocitos  = pageContent!.range(of: "Leucocitos") {
                let startIndex = rangeOfExamForLeucocitos.upperBound
                let endIndex = pageContent!.range(of: "\n", range: startIndex..<pageContent!.endIndex)?.lowerBound
                if let endIndex = endIndex {
                    let exam = pageContent![startIndex..<endIndex].trimmingCharacters(in: .whitespacesAndNewlines).trimmingCharacters(in: [":"," "])
                    let examWords = exam.components(separatedBy: " ")
                    let firstWord = examWords.first
                    print("Página: \(i+1)")
                    print("LEUCOCITOS: \(firstWord ?? "")")
                }
            }
            
            if let rangeOfExamForPlaquetas  = pageContent!.range(of: "Plaquetas") {
                let startIndex = rangeOfExamForPlaquetas.upperBound
                let endIndex = pageContent!.range(of: "\n", range: startIndex..<pageContent!.endIndex)?.lowerBound
                if let endIndex = endIndex {
                    let exam = pageContent![startIndex..<endIndex].trimmingCharacters(in: .whitespacesAndNewlines).trimmingCharacters(in: [":"," "])
                    let examWords = exam.components(separatedBy: " ")
                    let firstWord = examWords.first
                    print("Página: \(i+1)")
                    print("PLAQUETAS: \(firstWord ?? "")")
                }
            }
            
        }
    }
}
