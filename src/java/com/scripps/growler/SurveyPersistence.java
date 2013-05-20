package com.scripps.growler;
import java.util.*;
public class SurveyPersistence extends GrowlerPersistence {
	private ArrayList<Survey> surveys = new ArrayList<Survey>();
	public Survey saveSurvey(Survey s){
		try{
			initializeJDBC();
			statement = connection.prepareStatement("insert into session_ranking (session_id, question_id, ranking) values (?, ?, ?)");
			statement.setInt(1, s.getSessionId());
			statement.setInt(2, 1);
			statement.setInt(3, s.getQuestion1());
			statement.execute();
			statement.setInt(2, 2);
			statement.setInt(3, s.getQuestion2());
			statement.execute();
			statement.setInt(2, 3);
			statement.setInt(3, s.getQuestion3());
			statement.execute();
			statement.setInt(2, 4);
			statement.setInt(3, s.getQuestion4());
			statement.execute();
			closeJDBC();
                }
		catch(Exception e){
		}
		return null;
	}
	public ArrayList<Survey> getAllSurveys() {
		try {
			initializeJDBC();
			statement = connection.prepareStatement("select session_id, question_id, ranking from session_ranking order by session_id, question_id ");
			result = statement.executeQuery();
			while(result.next()){
				Survey s = new Survey();
				s.setSessionId(result.getInt("session_id"));
				s.setQuestion1(result.getInt("ranking"));
				result.next();
				s.setQuestion2(result.getInt("ranking"));
				result.next();
				s.setQuestion3(result.getInt("ranking"));
				result.next();
				s.setQuestion4(result.getInt("ranking"));
				surveys.add(s);
			}
			closeJDBC();
			return surveys;
		}
		catch(Exception e) {
		}
                return null;
	}
public ArrayList<Survey> getSurveysBySession(int session) {
		try {
			initializeJDBC();
			statement = connection.prepareStatement("select session_id, question_id, ranking from session_ranking  where session_id = ? order by  question_id ");
			statement.setInt(1,session);
			result = statement.executeQuery();
			while(result.next()){
				Survey s = new Survey();
				s.setSessionId(result.getInt("session_id"));
				s.setQuestion1(result.getInt("ranking"));
				result.next();
				s.setQuestion2(result.getInt("ranking"));
				result.next();
				s.setQuestion3(result.getInt("ranking"));
				result.next();
				s.setQuestion4(result.getInt("ranking"));
				surveys.add(s);
			}
			closeJDBC();
			return surveys;
		}
		catch(Exception e) {
		}
                return null;
	}

}