package com.ruoair.uav.service;

import com.itextpdf.io.font.PdfEncodings;
import com.itextpdf.kernel.font.PdfFont;
import com.itextpdf.kernel.font.PdfFontFactory;
import com.itextpdf.kernel.pdf.PdfDocument;
import com.itextpdf.kernel.pdf.PdfWriter;
import com.itextpdf.layout.Document;
import com.itextpdf.layout.element.Cell;
import com.itextpdf.layout.element.Paragraph;
import com.itextpdf.layout.element.Table;
import com.itextpdf.kernel.colors.DeviceRgb;
import com.itextpdf.layout.properties.TextAlignment;
import com.itextpdf.layout.properties.UnitValue;
import com.ruoair.uav.domain.SysUavResult;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.io.ByteArrayOutputStream;
import java.text.SimpleDateFormat;

@Service
public class ReportExportService {

    private static final Logger log = LoggerFactory.getLogger(ReportExportService.class);

    /** 尝试加载中文字体，按优先级查找 */
    private PdfFont loadChineseFont() {
        String[] fontPaths = {
            "C:/Windows/Fonts/simsun.ttc,0",     // Windows 宋体
            "C:/Windows/Fonts/simhei.ttf",        // Windows 黑体
            "C:/Windows/Fonts/msyh.ttc,0",        // Windows 微软雅黑
            "/usr/share/fonts/truetype/wqy/wqy-zenhei.ttc", // Linux 文泉驿
            "/usr/share/fonts/truetype/droid/DroidSansFallbackFull.ttf", // Linux Droid
            "/System/Library/Fonts/PingFang.ttc",  // macOS 苹方
        };
        for (String path : fontPaths) {
            try {
                if (path.contains(",")) {
                    String[] parts = path.split(",");
                    return PdfFontFactory.createFont(parts[0], PdfEncodings.IDENTITY_H,
                        PdfFontFactory.EmbeddingStrategy.PREFER_EMBEDDED);
                }
                return PdfFontFactory.createFont(path, PdfEncodings.IDENTITY_H,
                    PdfFontFactory.EmbeddingStrategy.PREFER_EMBEDDED);
            } catch (Exception ignored) {}
        }
        // 回退：用内置字体（中文会显示为空白，至少不报错）
        try {
            return PdfFontFactory.createFont();
        } catch (Exception e) {
            throw new RuntimeException("无法加载任何字体", e);
        }
    }

    public byte[] generateReport(SysUavResult result) {
        try (ByteArrayOutputStream baos = new ByteArrayOutputStream()) {
            PdfWriter writer = new PdfWriter(baos);
            PdfDocument pdfDoc = new PdfDocument(writer);
            Document document = new Document(pdfDoc);

            PdfFont font = loadChineseFont();
            boolean hasCn = !"Helvetica".equals(font.getFontProgram().getFontNames().getFontName());
            log.info("PDF报告使用字体: {} (中文支持: {})",
                font.getFontProgram().getFontNames().getFontName(), hasCn);

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

            // 标题
            document.add(new Paragraph("无人机巡防报告")
                    .setFont(font).setFontSize(20).setBold()
                    .setTextAlignment(TextAlignment.CENTER));
            document.add(new Paragraph(""));

            // 基本信息表格
            Table table = new Table(UnitValue.createPercentArray(new float[]{30, 70}));
            table.setWidth(UnitValue.createPercentValue(100));
            addRow(table, "结果编号", nvl(result.getResultCode()), font);
            addRow(table, "任务名称", nvl(result.getTaskName()), font);
            addRow(table, "设备名称", nvl(result.getEquipmentName()), font);
            addRow(table, "航线名称", nvl(result.getRouteName()), font);
            addRow(table, "执行人", nvl(result.getExecutor()), font);
            addRow(table, "巡防时长", (result.getPatrolDuration() != null ? result.getPatrolDuration() : "-") + " 分钟", font);
            addRow(table, "完成时间", result.getCompletedTime() != null ? sdf.format(result.getCompletedTime()) : "-", font);
            document.add(table);

            // 巡防概述
            document.add(new Paragraph(""));
            document.add(new Paragraph("一、巡防概述").setFont(font).setBold().setFontSize(14));
            document.add(new Paragraph(nvl(result.getOverview())).setFont(font).setFontSize(11));

            // 发现情况
            document.add(new Paragraph(""));
            document.add(new Paragraph("二、发现情况").setFont(font).setBold().setFontSize(14));
            document.add(new Paragraph(nvl(result.getFindings())).setFont(font).setFontSize(11));

            // 处理情况
            document.add(new Paragraph(""));
            document.add(new Paragraph("三、处理情况").setFont(font).setBold().setFontSize(14));
            document.add(new Paragraph(nvl(result.getHandlingInfo())).setFont(font).setFontSize(11));

            // 备注
            if (result.getRemark() != null && !result.getRemark().isEmpty()) {
                document.add(new Paragraph(""));
                document.add(new Paragraph("四、备注").setFont(font).setBold().setFontSize(14));
                document.add(new Paragraph(result.getRemark()).setFont(font).setFontSize(11));
            }

            // 报告生成时间
            document.add(new Paragraph(""));
            document.add(new Paragraph("报告生成时间: " + sdf.format(new java.util.Date()))
                    .setFont(font).setFontSize(9).setTextAlignment(TextAlignment.RIGHT));

            document.close();
            return baos.toByteArray();
        } catch (Exception e) {
            log.error("PDF报告生成失败", e);
            throw new RuntimeException("PDF报告生成失败: " + e.getMessage());
        }
    }

    private void addRow(Table table, String label, String value, PdfFont font) {
        Cell labelCell = new Cell().add(new Paragraph(label).setFont(font).setBold().setFontSize(10));
        labelCell.setBackgroundColor(new DeviceRgb(0.95f, 0.95f, 0.95f));
        Cell valueCell = new Cell().add(new Paragraph(value).setFont(font).setFontSize(10));
        table.addCell(labelCell);
        table.addCell(valueCell);
    }

    private String nvl(String val) {
        return val != null && !val.isEmpty() ? val : "无";
    }
}
