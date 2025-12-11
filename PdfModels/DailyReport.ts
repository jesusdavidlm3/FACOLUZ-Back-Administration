import PDFDocument from "pdfkit"

export function BuildReport(dataCallback, endCallback){
    const doc = new PDFDocument()

    doc.on('data', dataCallback)
    doc.on('end', endCallback)

    doc.image('./assets/Logo_LUZ.png', 70, 50, {width: 60, align: 'center', valign: 'center'})
    doc.image('./assets/Logo_FacoLuz.png', 450, 60, {width: 110, align: 'center', valign: 'center'})
    doc.fontSize(16).text('Reporte del dia 00/00/0000', {align: 'center'})

    doc.end()
}