import UIKit
import PDFKit

class ViewController: UIViewController {
    var pdfView: PDFView! // Declaração de uma variável para o visualizador de PDF
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Inicialização do visualizador de PDF
        pdfView = PDFView(frame: view.bounds)
        pdfView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        pdfView.backgroundColor = .lightGray
        view.addSubview(pdfView)
        
        // Localização do arquivo PDF a ser exibido
        guard let path = Bundle.main.path(forResource: "hemogramaExample", ofType: "pdf") else { return }
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
            
            // Extrai a densidade da página atual, se presente
            if let rangeOfExamForPH = pageContent!.range(of: "Densidade") {
                let startIndex = rangeOfExamForPH.upperBound
                let endIndex = pageContent!.range(of: "\n", range: startIndex..<pageContent!.endIndex)?.lowerBound
                if let endIndex = endIndex {
                    let exam = pageContent![startIndex..<endIndex].trimmingCharacters(in: .whitespacesAndNewlines).trimmingCharacters(in: [".", ":"," "])
                    let examWords = exam.components(separatedBy: " ")
                    let firstWord = examWords.first
                    print("Página: \(i+1)")
                    print("Densidade: \(firstWord ?? "")")
                }
            }
            
            // Extrai o número de linfócitos da página atual, se presente
            if let rangeOfExamForLinfocitos = pageContent!.range(of: "Linfocitos") {
                let startIndex = rangeOfExamForLinfocitos.upperBound
                let endIndex = pageContent!.range(of: "Liberação", range: startIndex..<pageContent!.endIndex)?.lowerBound
                if let endIndex = endIndex {
                    let exam = pageContent![startIndex..<endIndex].trimmingCharacters(in: .whitespacesAndNewlines).trimmingCharacters(in: [".", ":"," "])
                    let examWords = exam.components(separatedBy: " ")
                    let firstWord = examWords.first
                    print("Página: \(i+1)")
                    print("Linfocitos: \(firstWord ?? "")")
                }
            }
        }
    }
}
