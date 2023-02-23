//
//  DMSBunierViewController.swift
//  PoCPDF
//
//  Created by Pedro Haruke Rinzo on 22/02/23.
//

import UIKit
import PDFKit

class DMSBunierViewController: UIViewController {
    var pdfView: PDFView! // Declaração de uma variável para o visualizador de PDF
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Inicialização do visualizador de PDF
        pdfView = PDFView(frame: view.bounds)
        pdfView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        pdfView.backgroundColor = .lightGray
        view.addSubview(pdfView)
        
        // Localização do arquivo PDF a ser exibido
        guard let path = Bundle.main.path(forResource: "DMSBunierExemplo", ofType: "pdf") else { return }
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
            
            if let rangeOfExamForHemacias = pageContent!.range(of: "Hemácias") {
                let startIndex = rangeOfExamForHemacias.upperBound
                let endIndex = pageContent!.range(of: "\n", range: startIndex..<pageContent!.endIndex)?.lowerBound
                if let endIndex = endIndex {
                    let exam = pageContent![startIndex..<endIndex].trimmingCharacters(in: .whitespacesAndNewlines).trimmingCharacters(in: [":"," "])
                    let examWords = exam.components(separatedBy: " ")
                    let firstWord = examWords.first
                    print("Página: \(i+1)")
                    print("Hemácias: \(firstWord ?? "")")
                }
            }
            
            if let rangeOfExamForRDW = pageContent!.range(of: "R. D. W.") {
                let startIndex = rangeOfExamForRDW.upperBound
                let endIndex = pageContent!.range(of: "\n", range: startIndex..<pageContent!.endIndex)?.lowerBound
                if let endIndex = endIndex {
                    let exam = pageContent![startIndex..<endIndex].trimmingCharacters(in: .whitespacesAndNewlines).trimmingCharacters(in: [":"," "])
                    let examWords = exam.components(separatedBy: " ")
                    let firstWord = examWords.first
                    print("Página: \(i+1)")
                    print("R. D. W.: \(firstWord ?? "")")
                }
            }
    
            if let rangeOfExamForLeucocitos = pageContent!.range(of: "Leucócitos") {
                let startIndex = rangeOfExamForLeucocitos.upperBound
                let endIndex = pageContent!.range(of: "\n", range: startIndex..<pageContent!.endIndex)?.lowerBound
                if let endIndex = endIndex {
                    let exam = pageContent![startIndex..<endIndex].trimmingCharacters(in: .whitespacesAndNewlines).trimmingCharacters(in: [":"," "])
                    let examWords = exam.components(separatedBy: " ")
                    let firstWord = examWords.first
                    print("Página: \(i+1)")
                    print("Leucócitos: \(firstWord ?? "")")
                }
            }
            
            if let rangeOfExamForVPMFL = pageContent!.range(of: "VPMemfL") {
                let startIndex = rangeOfExamForVPMFL.upperBound
                let endIndex = pageContent!.range(of: "\n", range: startIndex..<pageContent!.endIndex)?.lowerBound
                if let endIndex = endIndex {
                    let exam = pageContent![startIndex..<endIndex].trimmingCharacters(in: .whitespacesAndNewlines).trimmingCharacters(in: [":"," "])
                    let examWords = exam.components(separatedBy: " ")
                    let firstWord = examWords.first
                    print("Página: \(i+1)")
                    print("V P M em fL: \(firstWord ?? "")")
                }
            }
            
            if let rangeOfExamForTriglicerides = pageContent!.range(of: "TRIGLICERIDES") {
                let startIndex = rangeOfExamForTriglicerides.upperBound
                let endIndex = pageContent!.range(of: "\n", range: startIndex..<pageContent!.endIndex)?.lowerBound
                if let endIndex = endIndex {
                    let exam = pageContent![startIndex..<endIndex].trimmingCharacters(in: .whitespacesAndNewlines).trimmingCharacters(in: [":"," "])
                    let examWords = exam.components(separatedBy: " ")
                    let firstWord = examWords.first
                    print("Página: \(i+1)")
                    print("TRIGLICERIDES: \(firstWord ?? "")")
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
            

        }
    }
}
