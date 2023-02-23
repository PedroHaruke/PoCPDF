//
//  FlueryViewController.swift
//  PoCPDF
//
//  Created by Pedro Haruke Rinzo on 22/02/23.
//

import UIKit
import PDFKit

class FlueryViewController: UIViewController {
    var pdfView: PDFView! // Declaração de uma variável para o visualizador de PDF
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Inicialização do visualizador de PDF
        pdfView = PDFView(frame: view.bounds)
        pdfView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        pdfView.backgroundColor = .lightGray
        view.addSubview(pdfView)
        
        // Localização do arquivo PDF a ser exibido
        guard let path = Bundle.main.path(forResource: "FleuryExemploExame", ofType: "pdf") else { return }
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
        
            if let rangeOfExamForGlicose = pageContent!.range(of: "GLICOSE") {
                let startIndex = rangeOfExamForGlicose.upperBound
                let rangeAfterStartIndex = startIndex..<pageContent!.endIndex
                let rangeOfResult = pageContent!.range(of: "RESULTADO VALORES DE REFERÊNCIA", options: .caseInsensitive, range: rangeAfterStartIndex, locale: nil)
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
            
      
            if let rangeOfExamForPeptideo = pageContent!.range(of: "PEPTIDEO") {
                let startIndex = rangeOfExamForPeptideo.upperBound
                let rangeAfterStartIndex = startIndex..<pageContent!.endIndex
                let rangeOfResult = pageContent!.range(of: "RESULTADO VALORES DE REFERÊNCIA", options: .caseInsensitive, range: rangeAfterStartIndex, locale: nil)
                if let rangeOfResult = rangeOfResult {
                    let startIndexOfValue = rangeOfResult.upperBound
                    let endIndexOfValue = pageContent!.range(of: "\n", range: startIndexOfValue..<pageContent!.endIndex)?.lowerBound ?? pageContent!.endIndex
                    let exam = pageContent![startIndexOfValue..<endIndexOfValue].trimmingCharacters(in: .whitespacesAndNewlines).trimmingCharacters(in: [".", ":"," "])
                    let examWords = exam.components(separatedBy: " ")
                    let firstWord = examWords.first
                    print("Página: \(i+1)")
                    print("PEPTIDEO: \(firstWord ?? "")")
                }
            }
            
            if let rangeOfExamForLDL = pageContent!.range(of: "LDL-COLESTEROL") {
                let startIndex = rangeOfExamForLDL.upperBound
                let rangeAfterStartIndex = startIndex..<pageContent!.endIndex
                let rangeOfResult = pageContent!.range(of: "RESULTADO", options: .caseInsensitive, range: rangeAfterStartIndex, locale: nil)
                if let rangeOfResult = rangeOfResult {
                    let startIndexOfValue = rangeOfResult.upperBound
                    let endIndexOfValue = pageContent!.range(of: "\\f", options: .backwards, range: startIndexOfValue..<pageContent!.endIndex)?.lowerBound ?? pageContent!.endIndex
                    let exam = pageContent![startIndexOfValue..<endIndexOfValue].trimmingCharacters(in: .whitespacesAndNewlines).trimmingCharacters(in: [".", ":"," "])
                    let examWords = exam.components(separatedBy: " ")
                    let firstWord = examWords.first
                    print("Página: \(i+1)")
                    print("LDL - COLESTEROL: \(firstWord ?? "")")
                }
            }
            
            
            if let rangeOfExamForTiroxina = pageContent!.range(of: "TIROXINA") {
                let startIndex = rangeOfExamForTiroxina.upperBound
                let rangeAfterStartIndex = startIndex..<pageContent!.endIndex
                let rangeOfResult = pageContent!.range(of: "REFERÊNCIA", options: .caseInsensitive, range: rangeAfterStartIndex, locale: nil)
                if let rangeOfResult = rangeOfResult {
                    let startIndexOfValue = rangeOfResult.upperBound
                    let endIndexOfValue = pageContent!.range(of: "\\f", options: .backwards, range: startIndexOfValue..<pageContent!.endIndex)?.lowerBound ?? pageContent!.endIndex
                    let exam = pageContent![startIndexOfValue..<endIndexOfValue].trimmingCharacters(in: .whitespacesAndNewlines).trimmingCharacters(in: [".", ":"," "])
                    let examWords = exam.components(separatedBy: " ")
                    let firstWord = examWords.first
                    print("Página: \(i+1)")
                    print("TIROXINA: \(firstWord ?? "")")
                }
            }
            
            if let rangeOfExamForColesterolTotal = pageContent!.range(of: "COLESTEROL TOTAL") {
                let startIndex = rangeOfExamForColesterolTotal.upperBound
                let rangeAfterStartIndex = startIndex..<pageContent!.endIndex
                let rangeOfResult = pageContent!.range(of: "RESULTADO", options: .caseInsensitive, range: rangeAfterStartIndex, locale: nil)
                if let rangeOfResult = rangeOfResult {
                    let startIndexOfValue = rangeOfResult.upperBound
                    let endIndexOfValue = pageContent!.range(of: "\\f", options: .backwards, range: startIndexOfValue..<pageContent!.endIndex)?.lowerBound ?? pageContent!.endIndex
                    let exam = pageContent![startIndexOfValue..<endIndexOfValue].trimmingCharacters(in: .whitespacesAndNewlines).trimmingCharacters(in: [".", ":"," "])
                    let examWords = exam.components(separatedBy: " ")
                    let firstWord = examWords.first
                    print("Página: \(i+1)")
                    print("COLESTEROL TOTAL: \(firstWord ?? "")")
                }
            }
            
            if let rangeOfExamForHDL = pageContent!.range(of: "HDL-COLESTEROL") {
                let startIndex = rangeOfExamForHDL.upperBound
                let rangeAfterStartIndex = startIndex..<pageContent!.endIndex
                let rangeOfResult = pageContent!.range(of: "REFERÊNCIA", options: .caseInsensitive, range: rangeAfterStartIndex, locale: nil)
                if let rangeOfResult = rangeOfResult {
                    let startIndexOfValue = rangeOfResult.upperBound
                    let endIndexOfValue = pageContent!.range(of: "\\f", options: .backwards, range: startIndexOfValue..<pageContent!.endIndex)?.lowerBound ?? pageContent!.endIndex
                    let exam = pageContent![startIndexOfValue..<endIndexOfValue].trimmingCharacters(in: .whitespacesAndNewlines).trimmingCharacters(in: [".", ":"," "])
                    let examWords = exam.components(separatedBy: " ")
                    let firstWord = examWords.first
                    print("Página: \(i+1)")
                    print("HDL-COLESTEROL: \(firstWord ?? "")")
                }
            }
            
            if let rangeOfExamForTriglicerides = pageContent!.range(of: "TRIGLICERIDES,") {
                let startIndex = rangeOfExamForTriglicerides.upperBound
                let rangeAfterStartIndex = startIndex..<pageContent!.endIndex
                let rangeOfResult = pageContent!.range(of: "RESULTADO", options: .caseInsensitive, range: rangeAfterStartIndex, locale: nil)
                if let rangeOfResult = rangeOfResult {
                    let startIndexOfValue = rangeOfResult.upperBound
                    let endIndexOfValue = pageContent!.range(of: "\\f", options: .backwards, range: startIndexOfValue..<pageContent!.endIndex)?.lowerBound ?? pageContent!.endIndex
                    let exam = pageContent![startIndexOfValue..<endIndexOfValue].trimmingCharacters(in: .whitespacesAndNewlines).trimmingCharacters(in: [".", ":"," "])
                    let examWords = exam.components(separatedBy: " ")
                    let firstWord = examWords.first
                    print("Página: \(i+1)")
                    print("TRIGLICERIDES,: \(firstWord ?? "")")
                }
            }
            
            if let rangeOfExamForTriglicerides = pageContent!.range(of: "HORMONIO TIROESTIMULANTE (TSH)") {
                let startIndex = rangeOfExamForTriglicerides.upperBound
                let rangeAfterStartIndex = startIndex..<pageContent!.endIndex
                let rangeOfResult = pageContent!.range(of: "REFERÊNCIA", options: .caseInsensitive, range: rangeAfterStartIndex, locale: nil)
                if let rangeOfResult = rangeOfResult {
                    let startIndexOfValue = rangeOfResult.upperBound
                    let endIndexOfValue = pageContent!.range(of: "\\f", options: .backwards, range: startIndexOfValue..<pageContent!.endIndex)?.lowerBound ?? pageContent!.endIndex
                    let exam = pageContent![startIndexOfValue..<endIndexOfValue].trimmingCharacters(in: .whitespacesAndNewlines).trimmingCharacters(in: [".", ":"," "])
                    let examWords = exam.components(separatedBy: " ")
                    let firstWord = examWords.first
                    print("Página: \(i+1)")
                    print("HORMONIO TIROESTIMULANTE (TSH): \(firstWord ?? "")")
                }
            }
            
            if let rangeOfExamForNeutrofilos  = pageContent!.range(of: "Neutrófilos") {
                let startIndex = rangeOfExamForNeutrofilos.upperBound
                let endIndex = pageContent!.range(of: "\n", range: startIndex..<pageContent!.endIndex)?.lowerBound
                if let endIndex = endIndex {
                    let exam = pageContent![startIndex..<endIndex].trimmingCharacters(in: .whitespacesAndNewlines).trimmingCharacters(in: [":"," "])
                    let examWords = exam.components(separatedBy: " ")
                    let firstWord = examWords.first
                    print("Página: \(i+1)")
                    print("Neutrófilos: \(firstWord ?? "")")
                }
            }
            
            if let rangeOfExamForFerro = pageContent!.range(of: "FERRO") {
                let startIndex = rangeOfExamForFerro.upperBound
                let rangeAfterStartIndex = startIndex..<pageContent!.endIndex
                let rangeOfResult = pageContent!.range(of: "REFERÊNCIA", options: .caseInsensitive, range: rangeAfterStartIndex, locale: nil)
                if let rangeOfResult = rangeOfResult {
                    let startIndexOfValue = rangeOfResult.upperBound
                    let endIndexOfValue = pageContent!.range(of: "\\f", options: .backwards, range: startIndexOfValue..<pageContent!.endIndex)?.lowerBound ?? pageContent!.endIndex
                    let exam = pageContent![startIndexOfValue..<endIndexOfValue].trimmingCharacters(in: .whitespacesAndNewlines).trimmingCharacters(in: [".", ":"," "])
                    let examWords = exam.components(separatedBy: " ")
                    let firstWord = examWords.first
                    print("Página: \(i+1)")
                    print("FERRO: \(firstWord ?? "")")
                }
            }

            if let rangeOfExamForTGP = pageContent!.range(of: "(TGP)") {
                let startIndex = rangeOfExamForTGP.upperBound
                let rangeAfterStartIndex = startIndex..<pageContent!.endIndex
                let rangeOfResult = pageContent!.range(of: "REFERÊNCIA", options: .caseInsensitive, range: rangeAfterStartIndex, locale: nil)
                if let rangeOfResult = rangeOfResult {
                    let startIndexOfValue = rangeOfResult.upperBound
                    let endIndexOfValue = pageContent!.range(of: "\\f", options: .backwards, range: startIndexOfValue..<pageContent!.endIndex)?.lowerBound ?? pageContent!.endIndex
                    let exam = pageContent![startIndexOfValue..<endIndexOfValue].trimmingCharacters(in: .whitespacesAndNewlines).trimmingCharacters(in: [".", ":"," "])
                    let examWords = exam.components(separatedBy: " ")
                    let firstWord = examWords.first
                    print("Página: \(i+1)")
                    print("TGP: \(firstWord ?? "")")
                }
            }

            if let rangeOfExamForTesto = pageContent!.range(of: "TESTOSTERONA") {
                let startIndex = rangeOfExamForTesto.upperBound
                let rangeAfterStartIndex = startIndex..<pageContent!.endIndex
                let rangeOfResult = pageContent!.range(of: "REFERÊNCIA", options: .caseInsensitive, range: rangeAfterStartIndex, locale: nil)
                if let rangeOfResult = rangeOfResult {
                    let startIndexOfValue = rangeOfResult.upperBound
                    let endIndexOfValue = pageContent!.range(of: "\\f", options: .backwards, range: startIndexOfValue..<pageContent!.endIndex)?.lowerBound ?? pageContent!.endIndex
                    let exam = pageContent![startIndexOfValue..<endIndexOfValue].trimmingCharacters(in: .whitespacesAndNewlines).trimmingCharacters(in: [".", ":"," "])
                    let examWords = exam.components(separatedBy: " ")
                    let firstWord = examWords.first
                    print("Página: \(i+1)")
                    print("TESTOSTERONA: \(firstWord ?? "")")
                }
            }
            
            
            if let rangeOfExamForPSATotal = pageContent!.range(of: "(PSA)") {
                let startIndex = rangeOfExamForPSATotal.upperBound
                let rangeAfterStartIndex = startIndex..<pageContent!.endIndex
                let rangeOfResult = pageContent!.range(of: "TOTAL", options: .caseInsensitive, range: rangeAfterStartIndex, locale: nil)
                if let rangeOfResult = rangeOfResult {
                    let startIndexOfValue = rangeOfResult.upperBound
                    let endIndexOfValue = pageContent!.range(of: "\\f", options: .backwards, range: startIndexOfValue..<pageContent!.endIndex)?.lowerBound ?? pageContent!.endIndex
                    let exam = pageContent![startIndexOfValue..<endIndexOfValue].trimmingCharacters(in: .whitespacesAndNewlines).trimmingCharacters(in: [".", ":"," "])
                    let examWords = exam.components(separatedBy: " ")
                    let firstWord = examWords.first
                    print("Página: \(i+1)")
                    print("PSA Total: \(firstWord ?? "")")
                }
            }
            
            if let rangeOfExamForPSALivre = pageContent!.range(of: "(PSA)") {
                let startIndex = rangeOfExamForPSALivre.upperBound
                let rangeAfterStartIndex = startIndex..<pageContent!.endIndex
                let rangeOfResult = pageContent!.range(of: "LIVRE", options: .caseInsensitive, range: rangeAfterStartIndex, locale: nil)
                if let rangeOfResult = rangeOfResult {
                    let startIndexOfValue = rangeOfResult.upperBound
                    let endIndexOfValue = pageContent!.range(of: "\\f", options: .backwards, range: startIndexOfValue..<pageContent!.endIndex)?.lowerBound ?? pageContent!.endIndex
                    let exam = pageContent![startIndexOfValue..<endIndexOfValue].trimmingCharacters(in: .whitespacesAndNewlines).trimmingCharacters(in: [".", ":"," "])
                    let examWords = exam.components(separatedBy: " ")
                    let firstWord = examWords.first
                    print("Página: \(i+1)")
                    print("PSA LIVRE: \(firstWord ?? "")")
                }
            }
            
            if let rangeOfExamForTGO = pageContent!.range(of: "GLUTAMICO-OXALACETICA") {
                let startIndex = rangeOfExamForTGO.upperBound
                let rangeAfterStartIndex = startIndex..<pageContent!.endIndex
                let rangeOfResult = pageContent!.range(of: "REFERÊNCIA", options: .caseInsensitive, range: rangeAfterStartIndex, locale: nil)
                if let rangeOfResult = rangeOfResult {
                    let startIndexOfValue = rangeOfResult.upperBound
                    let endIndexOfValue = pageContent!.range(of: "\\f", options: .backwards, range: startIndexOfValue..<pageContent!.endIndex)?.lowerBound ?? pageContent!.endIndex
                    let exam = pageContent![startIndexOfValue..<endIndexOfValue].trimmingCharacters(in: .whitespacesAndNewlines).trimmingCharacters(in: [".", ":"," "])
                    let examWords = exam.components(separatedBy: " ")
                    let firstWord = examWords.first
                    print("Página: \(i+1)")
                    print("TRANSAMINASE GLUTAMICO-OXALACETICA (TGO): \(firstWord ?? "")")
                }
            }
            
            if let rangeOfExamForTGO = pageContent!.range(of: "TRANSAMINASE GLUTAMICO-PIRUVICA (TGP)") {
                let startIndex = rangeOfExamForTGO.upperBound
                let rangeAfterStartIndex = startIndex..<pageContent!.endIndex
                let rangeOfResult = pageContent!.range(of: "REFERÊNCIA", options: .caseInsensitive, range: rangeAfterStartIndex, locale: nil)
                if let rangeOfResult = rangeOfResult {
                    let startIndexOfValue = rangeOfResult.upperBound
                    let endIndexOfValue = pageContent!.range(of: "\\f", options: .backwards, range: startIndexOfValue..<pageContent!.endIndex)?.lowerBound ?? pageContent!.endIndex
                    let exam = pageContent![startIndexOfValue..<endIndexOfValue].trimmingCharacters(in: .whitespacesAndNewlines).trimmingCharacters(in: [".", ":"," "])
                    let examWords = exam.components(separatedBy: " ")
                    let firstWord = examWords.first
                    print("Página: \(i+1)")
                    print("TRANSAMINASE GLUTAMICO-PIRUVICA (TGP): \(firstWord ?? "")")
                }
            }
            
        }
    }
}
