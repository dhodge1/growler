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
        c1.setBorderWidthBottom((float) 1.5);
        table.addCell(c1);

        PdfPCell c2 = new PdfPCell(new Phrase("User Name"));
        c2.setHorizontalAlignment(Element.ALIGN_CENTER);
        c2.setBorderWidthBottom((float) 1.5);
        table.addCell(c2);


        PdfPCell c3 = new PdfPCell(new Phrase("Session Name"));
        c3.setHorizontalAlignment(Element.ALIGN_CENTER);
        c3.setBorderWidthBottom((float) 1.5);
        table.addCell(c3);

        table.setHeaderRows(1);

        for (int i = 0; i < report.size(); i++) {
            PdfPCell c4 = new PdfPCell();
            c4.setHorizontalAlignment(Element.ALIGN_LEFT);
            c4.setFixedHeight(cellHeight);
            c4.setPhrase(new Phrase(String.valueOf(i + 1)));
            c4.setBorderWidthBottom((float) 1.5);
            table.addCell(c4);
            PdfPCell c5 = new PdfPCell();
            c5.setHorizontalAlignment(Element.ALIGN_LEFT);
            c5.setFixedHeight(cellHeight);
            c5.setBorderWidthBottom((float) 1.5);
            c5.setPhrase(new Phrase(report.get(i).getUser().getUserName()));
            table.addCell(c5);
            PdfPCell c6 = new PdfPCell();
            c6.setHorizontalAlignment(Element.ALIGN_LEFT);
            c6.setFixedHeight(cellHeight);
            c6.setBorderWidthBottom((float) 1.5);
            c6.setPhrase(new Phrase(report.get(i).getSession().getName()));
            table.addCell(c6);
        }
        try {
            document.add(table);
        } catch (DocumentException ex) {
            Logger.getLogger(ReportGenerator.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    public void addSpeakerContent(Document document) throws DocumentException {
        ArrayList<QuestionReport> report = generateRankingsReport(2);
        PdfPTable table = new PdfPTable(6);
//        float[] columnWidth = {10, 45, 45};
//        Rectangle pageSize = new Rectangle((float) 8.5, 11);
//        table.setWidthPercentage(columnWidth, pageSize);
        float cellHeight = 30;
        PdfPCell c1 = new PdfPCell(new Phrase("Session Name"));
        c1.setHorizontalAlignment(Element.ALIGN_CENTER);
        c1.setFixedHeight(cellHeight);
        c1.setBorderWidthBottom((float) 1.5);
        table.addCell(c1);

        PdfPCell c2 = new PdfPCell(new Phrase("Session Description"));
        c2.setHorizontalAlignment(Element.ALIGN_CENTER);
        c2.setBorderWidthBottom((float) 1.5);
        table.addCell(c2);


        PdfPCell c3 = new PdfPCell(new Phrase("Speaker(s)"));
        c3.setHorizontalAlignment(Element.ALIGN_CENTER);
        c3.setBorderWidthBottom((float) 1.5);
        table.addCell(c3);

        PdfPCell c4 = new PdfPCell(new Phrase("Avg Rating"));
        c4.setHorizontalAlignment(Element.ALIGN_CENTER);
        c4.setBorderWidthBottom((float) 1.5);
        table.addCell(c4);

        PdfPCell c5 = new PdfPCell(new Phrase("# Attended"));
        c5.setHorizontalAlignment(Element.ALIGN_CENTER);
        c5.setBorderWidthBottom((float) 1.5);
        table.addCell(c5);

        PdfPCell c6 = new PdfPCell(new Phrase("# Surveys"));
        c6.setHorizontalAlignment(Element.ALIGN_CENTER);
        c6.setBorderWidthBottom((float) 1.5);
        table.addCell(c6);

        table.setHeaderRows(1);

        for (int i = 0; i < report.size(); i++) {
            PdfPCell c7 = new PdfPCell();
            c7.setHorizontalAlignment(Element.ALIGN_LEFT);
            c7.setFixedHeight(cellHeight);
            c7.setPhrase(new Phrase(report.get(i).getSession_name()));
            c7.setBorderWidthBottom((float) 1.5);
            table.addCell(c7);
            PdfPCell c8 = new PdfPCell();
            c8.setHorizontalAlignment(Element.ALIGN_LEFT);
            c8.setFixedHeight(cellHeight);
            c8.setBorderWidthBottom((float) 1.5);
            c8.setPhrase(new Phrase(report.get(i).getSession_description()));
            table.addCell(c8);
            PdfPCell c9 = new PdfPCell();
            c9.setHorizontalAlignment(Element.ALIGN_LEFT);
            c9.setFixedHeight(cellHeight);
            c9.setBorderWidthBottom((float) 1.5);
            String[] speakers = (String[]) report.get(i).getSpeakers().toArray();
            String spkr = "";
            for (int f = 0; f < speakers.length; f++) {
                spkr = spkr.concat(speakers[f]);
                if (f != speakers.length) {
                    spkr = spkr.concat(" and ");
                }
            }
            c9.setPhrase(new Phrase(spkr));
            table.addCell(c9);
            PdfPCell c10 = new PdfPCell();
            c10.setHorizontalAlignment(Element.ALIGN_LEFT);
            c10.setFixedHeight(cellHeight);
            c10.setPhrase(new Phrase(String.valueOf(report.get(i).getScore())));
            c10.setBorderWidthBottom((float) 1.5);
            table.addCell(c10);
            PdfPCell c11 = new PdfPCell();
            c11.setHorizontalAlignment(Element.ALIGN_LEFT);
            c11.setFixedHeight(cellHeight);
            c11.setBorderWidthBottom((float) 1.5);
            c11.setPhrase(new Phrase(report.get(i).getAttendance()));
            table.addCell(c11);
            PdfPCell c12 = new PdfPCell();
            c12.setHorizontalAlignment(Element.ALIGN_LEFT);
            c12.setFixedHeight(cellHeight);
            c12.setBorderWidthBottom((float) 1.5);
            c12.setPhrase(new Phrase(report.get(i).getRaters()));
            table.addCell(c12);
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
    
    public ArrayList<SurveyCompleterReport> generateSurveyCompleterReport() {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("select name from user u, attendance a where a.user_id = u.id and a.isSurveyTaken = 1");
            result = statement.executeQuery();
            ArrayList<SurveyCompleterReport> completers = new ArrayList<SurveyCompleterReport>();
            while (result.next()) {
                SurveyCompleterReport s = new SurveyCompleterReport();
                s.setUserName(result.getString("name"));
                completers.add(s);
            }
            return completers;
        } catch (Exception e) {
        } finally {
            closeJDBC();
        }
        return null;
    }
    
    public ArrayList<MealReport> generateMealReport() {
        try{
            initializeJDBC();
            statement = connection.prepareStatement("select round(avg(quality), 1) as avgQuality, round(avg(selection), 1) as avgSelection, round(avg(room), 1) as avgRoom from mealSurvey");
            result = statement.executeQuery();
            ArrayList<MealReport> meals = new ArrayList<MealReport>();
            while (result.next()) {
                MealReport m = new MealReport();
                m.setQuality(result.getFloat("avgQuality"));
                m.setSelection(result.getFloat("avgSelection"));
                m.setRoom(result.getFloat("avgRoom"));
                meals.add(m);
            }
            return meals;
        } catch (Exception e) {
        } finally {
            closeJDBC();
        }
        return null;
    }
    
    public ArrayList<FacilityReport> generateFacilityReport() {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("select distinct location.description as room, (select round(avg(local_Attendees + remote_Attendees)) from attendees, session, location l where attendees.session_id = session.id and session.location = l.id and l.description = room) as avg_att, (select sum(local_Attendees + remote_Attendees) from attendees, session, location lo where attendees.session_id = session.id and session.location = lo.id and lo.description = room) as tot_att, (select round(avg(ranking), 2) from attendees, session, location loc, session_ranking where session_ranking.session_id = attendees.session_id and attendees.session_id = session.id and session.location = loc.id and loc.description = room) as avg_rat from location, session, attendees where location.id = session.location and session.id = attendees.session_id order by avg_rat desc");
            result = statement.executeQuery();
            ArrayList<FacilityReport> fac = new ArrayList<FacilityReport>();
            while (result.next()) {
                FacilityReport f = new FacilityReport();
                f.setRoom(result.getString("room"));
                f.setAvgAttendance(result.getFloat("avg_att"));
                f.setTotalAttendance(result.getInt("tot_att"));
                f.setAvgRating(result.getFloat("avg_rat"));
                fac.add(f);
            }
            return fac;
        } catch (Exception e) {
        } finally {
            closeJDBC();
        }
        return null;
    }
    
    public ArrayList<SurveyCompleterReport> generateSurveyCompleterReport2() {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("SET @serial=0; select @serial := @serial+1 AS `Number`, name from user u, attendance a where a.user_id = u.id");
            result = statement.executeQuery();
            ArrayList<SurveyCompleterReport> completers = new ArrayList<SurveyCompleterReport>();
            while (result.next()) {
                SurveyCompleterReport s = new SurveyCompleterReport();
                s.setUserName(result.getString("name"));
                s.setNumber(result.getInt("Number"));
                completers.add(s);
            }
            return completers;
        } catch (Exception e) {
        } finally {
            closeJDBC();
        }
        return null;
    }
    
    //Uses: SessionKeyReport.java
    public ArrayList<SessionKeyReport> generateSessionKeyReport() {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("select s.id, s.name, s.session_date, s.start_time, s.session_key from session s order by s.session_date desc, s.start_time, s.name");
            result = statement.executeQuery();
            SpeakerPersistence sp = new SpeakerPersistence();
            ArrayList<SessionKeyReport> keys = new ArrayList<SessionKeyReport>();
            while (result.next()) {
                SessionKeyReport k = new SessionKeyReport();
                k.setSessionName(result.getString(2));
                k.setSessionKey(result.getString(5));

                ArrayList<Speaker> speakers = sp.getSpeakersBySession(result.getInt(1));
                k.setSpeakers(speakers);
                keys.add(k);
            }
            return keys;


        } catch (Exception e) {
        } finally {
            closeJDBC();
        }
        return null;
    }
    
    //Uses: CommentsReport.java
    public ArrayList<CommentsReport> generateCommentsReport() {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("select s.id, s.name, c.session_id, c.comment from session s left join comments c on s.id = c.session_id order by s.name asc");
            result = statement.executeQuery();
            SpeakerPersistence sp = new SpeakerPersistence();
            ArrayList<CommentsReport> commentsrep = new ArrayList<CommentsReport>();
            while (result.next()) {
                CommentsReport c = new CommentsReport();
                c.setSessionName(result.getString(2));
                c.setComment(result.getString(4));

                ArrayList<Speaker> speakers = sp.getSpeakersBySession(result.getInt(1));
                c.setSpeakers(speakers);
                commentsrep.add(c);
            }
            return commentsrep;

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
        ArrayList<Attendance> attendances = ap.getAttendanceBySubTimeOrderDate();
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
        closeJDBC();
        return report;
    }

    public ArrayList<SurveyReport> generateSurveyReport(java.sql.Date date) {
        AttendancePersistence ap = new AttendancePersistence();
        UserPersistence up = new UserPersistence();
        SessionPersistence sp = new SessionPersistence();
        ArrayList<Attendance> attendances = ap.getAttendanceBySubTimeOrderDate();
        ListIterator<Attendance> iterator = attendances.listIterator();
        ArrayList<SurveyReport> report = new ArrayList<SurveyReport>();
        while (iterator.hasNext()) {
            Attendance a = iterator.next();
            User u = up.getUserByID(a.getUserId());
            Session s = sp.getSessionByID(a.getSessionId());
            if (s.getSessionDate().equals(date)) {
                SurveyReport r = new SurveyReport();
                r.setAttendance(a);
                r.setUser(u);
                r.setSession(s);
                report.add(r);
            }
        }
        closeJDBC();
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
        while (iterator.hasNext()) {
            QuestionReport qr = new QuestionReport();
            Map.Entry pairs = (Map.Entry) iterator.next();
            Integer sessionId = (Integer) pairs.getKey();
            Double ranking = (Double) pairs.getValue();
            qr.setSession_name(ssp.getSessionByID(sessionId).getName());
            qr.setSession_description(ssp.getSessionByID(sessionId).getDescription());
            qr.setScore(ranking);
            qr.setAttendance(ap.getCountBySession(sessionId));
            qr.setSpeakers(skp.getSpeakersBySession(sessionId));
            qr.setRaters(sp.getCountBySession(sessionId));
            report.add(qr);
        }
        closeJDBC();
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
        while (iterator.hasNext()) {
            QuestionReport qr = new QuestionReport();
            Map.Entry pairs = (Map.Entry) iterator.next();
            Integer sessionId = (Integer) pairs.getKey();
            Double ranking = (Double) pairs.getValue();
            qr.setSession_name(ssp.getSessionByID(sessionId).getName());
            qr.setSession_description(ssp.getSessionByID(sessionId).getDescription());
            qr.setScore(ranking);
            qr.setAttendance(ap.getCountBySession(sessionId));
            qr.setSpeakers(skp.getSpeakersBySession(sessionId));
            qr.setRaters(sp.getCountBySession(sessionId));
            if ((question == 1 || question == 3) && ranking < 3) {
                //exclude low rankings
            }
            else {
                report.add(qr);
            }
        }
        closeJDBC();
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
        while (iterator.hasNext()) {
            QuestionReport qr = new QuestionReport();
            Map.Entry pairs = (Map.Entry) iterator.next();
            Integer sessionId = (Integer) pairs.getKey();
            Double ranking = (Double) pairs.getValue();
            qr.setSession_name(ssp.getSessionByID(sessionId).getName());
            qr.setSession_description(ssp.getSessionByID(sessionId).getDescription());
            qr.setScore(ranking);
            qr.setAttendance(ap.getCountBySession(sessionId));
            qr.setSpeakers(skp.getSpeakersBySession(sessionId));
            qr.setRaters(sp.getCountBySession(sessionId));
            report.add(qr);
        }
        closeJDBC();
        return report;
    }
    
    
    public ArrayList<AttendeeReport> generateAttendeeReport() {
        AttendeePersistence ap = new AttendeePersistence();
        ArrayList<Attendees> attendees = ap.getAllSessions(" order by session.name asc");
        ListIterator<Attendees> iterator = attendees.listIterator();
        ArrayList<AttendeeReport> report = new ArrayList<AttendeeReport>();
        SessionPersistence sp = new SessionPersistence();
        
        while (iterator.hasNext()) {
            AttendeeReport r = new AttendeeReport();
            Integer sessionId = r.getId();
            Integer localAttendees = r.getLocalAttendees();
            Integer remoteAttendees = r.getRemoteAttendees();
            Session sessionInfo = sp.getSessionByID(sessionId);
            String sessionName = sessionInfo.getName();
            r.setSessionName(sessionName);
            r.setLocalAttendees(localAttendees);
            r.setRemoteAttendees(remoteAttendees);
            report.add(r);
        }
        closeJDBC();
        return report;
    }


    
}
