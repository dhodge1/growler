/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.scripps.growler;

import java.util.ArrayList;
import java.util.ListIterator;

import com.itextpdf.text.*;
import com.itextpdf.text.pdf.*;
import java.io.*;
import java.net.URI;
import java.sql.*;
import java.util.Iterator;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author 162107
 */
public class ReportGenerator extends GrowlerPersistence {

    static Font tableHeader = new Font(Font.FontFamily.HELVETICA, 16, Font.BOLD);
    static Font tableData = new Font(Font.FontFamily.COURIER, 12);
    
    public String createReport() {
        try {
            
            File file = new File("report.pdf");
    
            Document document = new Document();
            PdfWriter.getInstance(document, new FileOutputStream(file));
            document.open();
            addContent(document);
            document.close();
            return (file.getAbsolutePath());
        } catch (Exception e) {
        }
        return "I don't know";
    }

    public void addContent(Document document) throws DocumentException {
        ArrayList<SurveyReport> report = generateSurveyReport();
        PdfPTable table = new PdfPTable(3);
//        float[] columnWidth = {10, 45, 45};
//        Rectangle pageSize = new Rectangle((float) 8.5, 11);
//        table.setWidthPercentage(columnWidth, pageSize);
        float cellHeight = 30;
        PdfPCell c1 = new PdfPCell(new Phrase("Entry Number"));
        c1.setHorizontalAlignment(Element.ALIGN_CENTER);
        c1.setFixedHeight(cellHeight);
        c1.setBorderWidthBottom((float)1.5);
        table.addCell(c1);

        PdfPCell c2 = new PdfPCell(new Phrase("User Name"));
        c2.setHorizontalAlignment(Element.ALIGN_CENTER);
        c2.setBorderWidthBottom((float)1.5);
        table.addCell(c2);
        

        PdfPCell c3 = new PdfPCell(new Phrase("Session Name"));
        c3.setHorizontalAlignment(Element.ALIGN_CENTER);
        c3.setBorderWidthBottom((float)1.5);
        table.addCell(c3);

        table.setHeaderRows(1);

        for (int i = 0; i < report.size(); i++) {
            PdfPCell c4 = new PdfPCell();
            c4.setHorizontalAlignment(Element.ALIGN_LEFT);
            c4.setFixedHeight(cellHeight);
            c4.setPhrase(new Phrase(String.valueOf(i + 1)));
            c4.setBorderWidthBottom((float)1.5);
            table.addCell(c4);
            PdfPCell c5 = new PdfPCell();
            c5.setHorizontalAlignment(Element.ALIGN_LEFT);
            c5.setFixedHeight(cellHeight);
            c5.setBorderWidthBottom((float)1.5);
            c5.setPhrase(new Phrase(report.get(i).getUser().getUserName()));
            table.addCell(c5);
            PdfPCell c6 = new PdfPCell();
            c6.setHorizontalAlignment(Element.ALIGN_LEFT);
            c6.setFixedHeight(cellHeight);
            c6.setBorderWidthBottom((float)1.5);
            c6.setPhrase(new Phrase(report.get(i).getSession().getName()));
            table.addCell(c6);
        }
        try {
            document.add(table);
        } catch (DocumentException ex) {
            Logger.getLogger(ReportGenerator.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    public ArrayList<InterestReport> generateInterestReport() {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("select count(r.session_id), s.id, s.name, s.description from registration r, session s where s.id = r.session_id group by (r.session_id) order by count(r.session_id) desc, s.name");
            result = statement.executeQuery();
            SpeakerPersistence sp = new SpeakerPersistence();
            ArrayList<InterestReport> interest = new ArrayList<InterestReport>();
            while (result.next()) {
                InterestReport i = new InterestReport();
                i.setSessionName(result.getString(3));
                i.setSessionDescription(result.getString(4));
                
                ArrayList<Speaker> speakers = sp.getSpeakersBySession(result.getInt(2));
                i.setSpeakers(speakers);
                i.setInterested(result.getInt(1));
                interest.add(i);
            }
            return interest;


        } catch (Exception e) {
        } finally {
            closeJDBC();
        }
        return null;
    }

    public ArrayList<SurveyReport> generateSurveyReport() {
        AttendancePersistence ap = new AttendancePersistence();
        UserPersistence up = new UserPersistence();
        SessionPersistence sp = new SessionPersistence();
        ArrayList<Attendance> attendances = ap.getAttendanceBySubmitTime();
        ListIterator<Attendance> iterator = attendances.listIterator();
        ArrayList<SurveyReport> report = new ArrayList<SurveyReport>();
        while (iterator.hasNext()) {
            Attendance a = iterator.next();
            User u = up.getUserByID(a.getUserId());
            Session s = sp.getSessionByID(a.getSessionId());
            SurveyReport r = new SurveyReport();
            r.setAttendance(a);
            r.setUser(u);
            r.setSession(s);
            report.add(r);
        }
        return report;
    }
    
    public ArrayList<QuestionReport> generateExpectationReport() {
        SurveyPersistence sp = new SurveyPersistence();
        SpeakerPersistence skp = new SpeakerPersistence();
        SessionPersistence ssp = new SessionPersistence();
        AttendancePersistence ap = new AttendancePersistence();
        Map<Integer, Double> map = sp.getAverageRankingByQuestion(1);
        ArrayList<QuestionReport> report = new ArrayList<QuestionReport>();
        Iterator iterator = map.entrySet().iterator();
        while(iterator.hasNext()){
            QuestionReport qr = new QuestionReport();
            Map.Entry pairs = (Map.Entry)iterator.next();
            Integer sessionId = (Integer)pairs.getKey();
            Double ranking = (Double)pairs.getValue();
            qr.setSession_name(ssp.getSessionByID(sessionId).getName());
            qr.setSession_description(ssp.getSessionByID(sessionId).getDescription());
            qr.setScore(ranking);
            qr.setAttendance(ap.getCountBySession(sessionId));
            qr.setSpeakers(skp.getSpeakersBySession(sessionId));
            qr.setRaters(sp.getCountBySession(sessionId));
            report.add(qr);
        }
        return report;
    }
    
    public ArrayList<QuestionReport> generateRankingsReport(int question) {
        SurveyPersistence sp = new SurveyPersistence();
        SpeakerPersistence skp = new SpeakerPersistence();
        SessionPersistence ssp = new SessionPersistence();
        AttendancePersistence ap = new AttendancePersistence();
        Map<Integer, Double> map = sp.getAverageRankingByQuestion(question);
        ArrayList<QuestionReport> report = new ArrayList<QuestionReport>();
        Iterator iterator = map.entrySet().iterator();
        while(iterator.hasNext()){
            QuestionReport qr = new QuestionReport();
            Map.Entry pairs = (Map.Entry)iterator.next();
            Integer sessionId = (Integer)pairs.getKey();
            Double ranking = (Double)pairs.getValue();
            qr.setSession_name(ssp.getSessionByID(sessionId).getName());
            qr.setSession_description(ssp.getSessionByID(sessionId).getDescription());
            qr.setScore(ranking);
            qr.setAttendance(ap.getCountBySession(sessionId));
            qr.setSpeakers(skp.getSpeakersBySession(sessionId));
            qr.setRaters(sp.getCountBySession(sessionId));
            report.add(qr);
        }
        return report;
    }
    
    public ArrayList<QuestionReport> generateTotalRankingsReport() {
        SurveyPersistence sp = new SurveyPersistence();
        SpeakerPersistence skp = new SpeakerPersistence();
        SessionPersistence ssp = new SessionPersistence();
        AttendancePersistence ap = new AttendancePersistence();
        Map<Integer, Double> map = sp.getAverageTotalRanking();
        ArrayList<QuestionReport> report = new ArrayList<QuestionReport>();
        Iterator iterator = map.entrySet().iterator();
        while(iterator.hasNext()){
            QuestionReport qr = new QuestionReport();
            Map.Entry pairs = (Map.Entry)iterator.next();
            Integer sessionId = (Integer)pairs.getKey();
            Double ranking = (Double)pairs.getValue();
            qr.setSession_name(ssp.getSessionByID(sessionId).getName());
            qr.setSession_description(ssp.getSessionByID(sessionId).getDescription());
            qr.setScore(ranking);
            qr.setAttendance(ap.getCountBySession(sessionId));
            qr.setSpeakers(skp.getSpeakersBySession(sessionId));
            qr.setRaters(sp.getCountBySession(sessionId));
            report.add(qr);
        }
        return report;
    }
}
