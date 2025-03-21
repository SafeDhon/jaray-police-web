import 'dart:convert';
import 'dart:html';
import 'package:flutter/services.dart';
import 'package:jaray_police_web/class.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class PdfService {
  Future<void> downloadPdf(List<dynamic> data, Infor information) async {
    PdfDocument document = PdfDocument();
    document.pageSettings.size = PdfPageSize.a4;
    document.pageSettings.margins.top = 10;

    PdfPage page = document.pages.add();

    final logo = await rootBundle.load('assets/images/logo.jpg');
    final logo_int =
        logo.buffer.asUint8List(logo.offsetInBytes, logo.lengthInBytes);
    final PdfBitmap image = PdfBitmap(logo_int);

    final font_similar = await rootBundle.load('assets/fonts/THSarabun.ttf');
    final font_bold = await rootBundle.load('assets/fonts/THSarabun Bold.ttf');
    final _similarFont = font_similar.buffer
        .asUint8List(font_similar.offsetInBytes, font_similar.lengthInBytes);
    final _boldFont = font_bold.buffer
        .asUint8List(font_bold.offsetInBytes, font_bold.lengthInBytes);
    final double fontSize = 14;

    page.graphics
        .drawImage(image, Rect.fromLTWH((page.size.width / 2) - 65, 0, 50, 53));

/////////////////////////////////////////////////////////////////////////////////////////////////////

// Draw the Header
    PdfTextElement textElement = PdfTextElement(
        format: PdfStringFormat(alignment: PdfTextAlignment.center),
        text: 'ผลสัมฤทธิ์จากการตรวจราชการ ด้าน ๔ การควบคุมและการจัดการจราจร\nตรวจ เมื่อ วัน ที่ พ.ศ.',
        font: PdfTrueTypeFont(_boldFont, fontSize + 2));
    PdfLayoutResult layoutResult = textElement.draw(
        page: page,
        bounds: Rect.fromLTWH(
            0, 60, page.getClientSize().width, page.getClientSize().height))!;
/////////////////////////////////////////////////////////////////////////////////////////////////////


// Build the Grid
    PdfGrid grid1 = PdfGrid();
    PdfGrid grid2 = PdfGrid();
    PdfGrid grid3 = PdfGrid();
    PdfGrid grid4 = PdfGrid();
    PdfGrid grid5 = PdfGrid();
    PdfGrid grid6 = PdfGrid();
    PdfGrid grid7 = PdfGrid();
    PdfGrid grid8 = PdfGrid();
    PdfGrid grid9 = PdfGrid();
    PdfGrid grid10 = PdfGrid();
    grid1.columns.add(count: 2);
    grid2.columns.add(count: 1);
    grid3.columns.add(count: 2);
    grid4.columns.add(count: 1);
    grid5.columns.add(count: 2);
    grid6.columns.add(count: 1);
    grid7.columns.add(count: 2);
    grid8.columns.add(count: 1);
    grid9.columns.add(count: 2);
    grid10.columns.add(count: 1);
/////////////////////////////////////////////////////////////////////////////////////////////////////

// Grid Style
    PdfGridStyle gridStyle = PdfGridStyle(
        cellPadding: PdfPaddings(left: 3, right: 1, top: 3, bottom: 0),
        backgroundBrush: PdfBrushes.white,
        textBrush: PdfBrushes.black,
        font: PdfTrueTypeFont(_similarFont, fontSize));

    grid1.style = gridStyle;
    grid2.style = gridStyle;
    grid3.style = gridStyle;
    grid4.style = gridStyle;
    grid5.style = gridStyle;
    grid6.style = gridStyle;
    grid7.style = gridStyle;
    grid8.style = gridStyle;
    grid9.style = gridStyle;
    grid10.style = gridStyle;

    grid1.columns[0].width = 400;
    grid3.columns[0].width = 400;
    grid5.columns[0].width = 400;
    grid7.columns[0].width = 400;


/////////////////////////////////////////////////////////////////////////////////////////////////////

// Cell Data
    PdfGridRow row1 = grid1.rows.add();
    row1.cells[0].value = 'กิจกรรม/หัวข้อ';
    row1.cells[1].value = 'ผลสัมฤทธิ์';
    PdfGridRow row2 = grid2.rows.add();
    row2.cells[0].value =
        'กิจกรรมที่ ๑ การป้องกัน อบถ. เพื่อความปลอดภัยด้านการจราจร (๒๙ คะแนน)';
    PdfGridRow row3 = grid3.rows.add();
    row3.cells[0].value =
        '๑.๑ การไปที่เกิดเหตุ อบถ. และจัดการจราจร ณ ที่เกิดเหตุให้ปลอดภัยและกลับคืนสู่สภาพการจราจร\nและสืบสวนหาสาเหตุ อบถ. (๕ คะแนน) \n๑.๒ การวิเคราะห์สาเหตุจากระบบข้อมูล อบถ.ตร. เพื่อวางแผนและกำหนดมาตรการแก้ไขและป้องกัน อบถ. เพื่อลดจำนวนคนบาดเจ็บ/ตาย (๔ คะแนน) \n๑.๓ การปฏิบัติในการแก้ไขและป้องกัน อบถ. ในแต่ละปัจจัยสาเหตุ และการนำเทคโนโลยีมาใช้งาน\n(๑๕ คะแนน) \n๑.๔ การเปรียบเทียบผลการปฏิบัติในการแก้ไข ป้องกัน อบถ. และลดสถิติคนตายจาก อบถ. (๕ คะแนน)';
    row3.cells[1].value =
        ' ๓๐ คะแนน\n\n ๓๐ คะแนน\n\n ๓๐ คะแนน\n\n ๓๐ คะแนน';
    PdfGridRow row4 = grid4.rows.add();
    row4.cells[0].value = 'กิจกรรมที่ ๒ การอำนวยการจราจร และบังคับใช้กฎหมาย (๔๑ คะแนน)';
    PdfGridRow row5 = grid5.rows.add();
    row5.cells[0].value =
        '๒.๑ การอบรมปล่อยแถวเจ้าหน้าที่ตำรวจจราจรก่อนออกปฏิบัติหน้าที่ตามหนังสือ ตร. ที่ ๐๖๐๑(ปป.)/๓๘๔ ลง ๙ ก.ค. ๒๕๔๐ เรื่องให้กวดขันเกี่ยวกับความประพฤติและระเบียบวินัยของข้าราชการตำรวจ รวมทั้ง\nกวดขันการแต่งเครื่องแบบและทรงผมให้ถือปฏิบัติตามระเบียบและเกณฑ์ที่ ตร. กำหนด (๕ คะแนน)\n๒.๒ ร่วมซักซ้อมแผนเผชิญเหตุของสถานีตำรวจ เดือนละ ๑ ครั้ง ตามความเหมาะสม (๑๐ คะแนน)\n๒.๓ การตั้งจุดตรวจเพื่อบังคับใช้กฎหมายกับประชาชนอย่างเหมาะสม และถูกต้องเป็นไปตามระเบียบฯ ตามหนังสือ ตร. ที่ ๐๐๐๗.๓๔/๕๕๗๘ ลง ๑๓ ธ.ค.๕๖, หนังสือ ตร. ที่ ๐๐๐๗.๒๒/๑๕๗๒ ลง ๓๑ พ.ค.๖๔, หนังสือ ตร. ที่ ๐๐๐๗.๓๔/๖๘๑ ลง ๓ มี.ค.๖๔ มาตราการปฏิบัติเกี่ยวกับการตั้งจุดตรวจ จุดบังคับใช้กฎหมาย\nและหนังสือ ตร. ด่วนที่สุด ที่ ๐๐๐๗.๒๒/๔๓๘ ลง ๒ ก.พ.๖๖ เรื่องกำชับการปฏิบัติเกี่ยวกับการตั้งด่านตรวจ จุดตรวจและจุดสกัด (๑๔ คะแนน)\n๒.๔ การจัดการเครื่องอุปกรณ์ตรวจจับผู้กระทำความผิดกฎหมายจราจร และการจัดทำระบบฐานข้อมูล\n(๑๒ คะแนน)';
    row5.cells[1].value =
        ' ๓๐ คะแนน\n\n\n ๓๐ คะแนน\n ๓๐ คะแนน\n\n\n\n\n ๓๐ คะแนน';
    PdfGridRow row6 = grid6.rows.add();
    row6.cells[0].value = 'กิจกรรมที่ ๓ การบริหารการมีส่วนร่วมของประชาชน และการประชาสัมพันธ์ (๓๐ คะแนน)';
    PdfGridRow row7 = grid7.rows.add();
    row7.cells[0].value =
        '๓.๑ การเผยแพร่ความรู้ ความเข้าใจเพื่อปลูกฝังวินัยจราจรในสถานศึกษา หน่วยงานสถานประกอบการ หรือชุมชนในพื้นที่ เพื่อให้เข้าใจและเห็นถึงความสำคัญในการมีวินัยการจราจร รวมทั้งจัดทำโครงการ/กิจกรรม\nร่วมหารือกับชุมชนในพื้นที่อย่างสม่ำเสมอ เพื่อเปิดโอกาสให้ทุกชุมชนได้เข้ามามีส่วนร่วมในการ\nแจ้งสภาพปัญหาและนำเสนอวิธีการแก้ไขเพื่อร่วมแก้ไขปัญหาจราจร (๑๐ คะแนน) \n๓.๒ แสวงหาความร่วมมือจากชุมชน และหน่วยงานอื่นๆ ให้เข้ามามีส่วนร่วมในการทำหน้าที่ช่วยเหลืองาน ด้านการจัดการจราจรในรูปแบบต่างๆ (๑๕ คะแนน) \n๓.๓ การประชาสัมพันธ์ให้ประชาชนทราบถึงการควบคุมและจัดการจราจร รวมทั้งการป้องกัน และลด\nอุบัติเหตุทางถนน (๕ คะแนน)';
    row7.cells[1].value = ' ๓๐ คะแนน\n\n\n\n ๓๐ คะแนน\n\n ๓๐ คะแนน';
    PdfGridRow row8 = grid8.rows.add();
    row8.cells[0].value =
        'ข้อเสนอแนะเพิ่มเติม';
    PdfGridRow row9 = grid9.rows.add();
    row9.cells[0].value =
        '๔.๑ การมีส่วนร่วมของภาคส่วนต่างๆ ในการปฏิบัติตามกฎหมายจราจร';
    row9.cells[1].value = '';
    // row9.cells[1].rowSpan = 2;
    PdfGridRow row10 = grid9.rows.add();
    row10.cells[0].value =
        '๔.๒ การประชาสัมพันธ์งานจราจร ร่วมกับหน่วยงานภาคีเครือข่าย เพื่อกวดขันวินัยจราจร และลดอุบัติเหตุทางถนน';
    row10.cells[1].value = '';
    PdfGridRow row11 = grid10.rows.add();
    row11.cells[0].value = '๒. มีการบันทึกภาพถ่ายประกอบการตรวจราชการ';

/////////////////////////////////////////////////////////////////////////////////////////////////////

    row1.cells[0].style.borders.left.width = 1;
    //Create and customize the string formats
    PdfStringFormat format = PdfStringFormat();
    format.alignment = PdfTextAlignment.center;
    format.lineAlignment = PdfVerticalAlignment.bottom;

    PdfGridCellStyle cellStyle = PdfGridCellStyle(
        format: PdfStringFormat(
      alignment: PdfTextAlignment.center,
    ));

    row1.cells[0].style = cellStyle;
    row1.cells[1].style = cellStyle;

// Draws the grid
    PdfLayoutResult res1 = grid1.draw(
        page: page,
        bounds: Rect.fromLTWH(0, layoutResult.bounds.bottom + 10, 0, 0))!;
    PdfLayoutResult res2 = grid2.draw(
        page: page, bounds: Rect.fromLTWH(0, res1.bounds.bottom, 0, 0))!;
    PdfLayoutResult res3 = grid3.draw(
        page: page, bounds: Rect.fromLTWH(0, res2.bounds.bottom, 0, 0))!;
    PdfLayoutResult res4 = grid4.draw(
        page: page, bounds: Rect.fromLTWH(0, res3.bounds.bottom, 0, 0))!;
    PdfLayoutResult res5 = grid5.draw(
        page: page, bounds: Rect.fromLTWH(0, res4.bounds.bottom, 0, 0))!;
    PdfLayoutResult res6 = grid6.draw(
        page: page, bounds: Rect.fromLTWH(0, res5.bounds.bottom, 0, 0))!;
    PdfLayoutResult res7 = grid7.draw(
        page: page, bounds: Rect.fromLTWH(0, res6.bounds.bottom, 0, 0))!;
    PdfLayoutResult res8 = grid8.draw(
        page: page, bounds: Rect.fromLTWH(0, res7.bounds.bottom, 0, 0))!;
    PdfLayoutResult res9 = grid9.draw(
        page: page, bounds: Rect.fromLTWH(0, res8.bounds.bottom, 0, 0))!;
    grid10.draw(
        page: page, bounds: Rect.fromLTWH(0, res9.bounds.bottom, 0, 0))!;

/////////////////////////////////////////////////////////////////////////////////////////////////////
// Save PDF File
    List<int> bytes = await document.save();
    AnchorElement(
        href:
            "data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}")
      ..setAttribute("download", "ตรวจ_${information.infor_1}_${information.infor_4}.pdf")
      ..click();

    document.dispose();
  }
}
