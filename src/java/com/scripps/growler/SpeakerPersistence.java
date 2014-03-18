package com.scripps.growler;

import java.sql.*;
import java.util.*;

/**
 * Handles the database entries for Speakers
 *
 * @see com.scripps.growler.Speaker
 * @author "Justin Bauguess"
 */
public class SpeakerPersistence extends GrowlerPersistence {

    /**
     * Sorts queries by last name in ascending order
     */
    final public String SORT_BY_LAST_NAME_ASC = " order by speaker.last_name asc";
    /**
     * Sorts queries by first name in ascending order
     */
    final public String SORT_BY_FIRST_NAME_ASC = " order by speaker.first_name asc";
    /**
     * Sorts queries by id in ascending order
     */
    final public String SORT_BY_ID_ASC = " order by speaker.id asc";
    /**
     * Sorts queries by suggested by in ascending order
     */
    final public String SORT_BY_CREATOR_ASC = " order by speaker.suggested_by asc";
    /**
     * Sorts queries by visibility in ascending order
     */
    final public String SORT_BY_VISIBILITY_ASC = " order by speaker.visible asc";
    /**
     * Sorts queries by the 2012 rank in ascending order
     */
    final public String SORT_BY_2012_RANK_ASC = " order by ranks_2012.rating asc";
    /**
     * Sorts queries by the 2012 count in ascending order
     */
    final public String SORT_BY_2012_COUNT_ASC = " order by ranks_2012.count asc";
    /**
     * Sorts queries by last name in descending order
     */
    final public String SORT_BY_LAST_NAME_DESC = " order by speaker.last_name desc";
    /**
     * Sorts queries by first name in descending order
     */
    final public String SORT_BY_FIRST_NAME_DESC = " order by speaker.first_name desc";
    /**
     * Sorts queries by id in descending order
     */
    final public String SORT_BY_ID_DESC = " order by speaker.id desc";
    /**
     * Sorts queries by suggested by in descending order
     */
    final public String SORT_BY_CREATOR_DESC = " order by speaker.suggested_by desc";
    /**
     * Sorts queries by visibility in descending order
     */
    final public String SORT_BY_VISIBILITY_DESC = " order by speaker.visible desc";
    /**
     * Sorts queries by the 2012 rank in descending order
     */
    final public String SORT_BY_2012_RANK_DESC = " order by ranks_2012.rating desc";
    /**
     * Sorts queries by the 2012 rank in ascending order
     */
    final public String SORT_BY_2012_COUNT_DESC = " order by ranks_2012.count desc";

    /**
     * Default constructor
     */
    public SpeakerPersistence() {
    }

    /**
     * Adds a speaker to the database
     * 3/17/2014 Thuy added an email field and ? for the value
     * @param s The speaker to add
     */
    public void addSpeaker(Speaker s) {
        try {
            initializeJDBC();
            String preparedQuery = "INSERT INTO speaker "
                                    + "(first_name, last_name, suggested_by, visible, type, reason, email) "
                                    + "VALUES (?, ?, ?, false, ?, ?, ?)";
            statement = connection.prepareStatement(preparedQuery);
            statement.setString(1, s.getFirstName());
            statement.setString(2, s.getLastName());
            statement.setInt(3, s.getSuggestedBy());
            statement.setString(4, s.getType());
            statement.setString(5, s.getReason());
            //*******************************************
            //added the email value to the db email field
            statement.setString(6, s.getEmail());
            //*******************************************
            success = statement.execute();
            closeJDBC();
        } catch (Exception e) {
        }
    }

    /**
     * Removes a speaker from the database
     *
     * @param s The speaker to remove - although just the ID is needed
     */
    public void deleteSpeaker(Speaker s) {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("delete from speaker "
                    + "where id = ?");
            statement.setInt(1, s.getId());
            statement.execute();
            closeJDBC();
        } catch (Exception e) {
        }
    }

    /**
     * Returns an individual speaker based on an id
     *
     * @param id the id to search for
     * @return A speaker that matches the id given
     */
    public Speaker getSpeakerByID(int id) {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("select s.id, s.first_name,"
                    + "s.last_name, s.suggested_by, s.visible, s.type, s.reason from speaker s "
                    + "where s.id = ?");
            statement.setInt(1, id);
            result = statement.executeQuery();
            Speaker s = new Speaker();
            if (result.next()) {
                s.setId(result.getInt("id"));
                s.setFirstName(result.getString("first_name"));
                s.setLastName(result.getString("last_name"));
                s.setSuggestedBy(result.getInt("suggested_by"));
                s.setVisible(result.getBoolean("visible"));
                s.setType(result.getString("type"));
                s.setReason(result.getString("reason"));
            }
            closeJDBC();
            return (s);
        } catch (Exception e) {
        }
        return null;
    }

    public Speaker getSpeakerByName(String first, String last) {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("select s.id, s.first_name, "
                    + "s.last_name, s.suggested_by, s.visible, s.type, s.reason from speaker s "
                    + "where s.first_name = ? and s.last_name = ?");
            statement.setString(1, first);
            statement.setString(2, last);
            result = statement.executeQuery();
            Speaker s = new Speaker();
            if (result.next()) {
                s.setId(result.getInt("id"));
                s.setFirstName(result.getString("first_name"));
                s.setLastName(result.getString("last_name"));
                s.setSuggestedBy(result.getInt("suggested_by"));
                s.setVisible(result.getBoolean("visible"));
                s.setType(result.getString("type"));
                s.setReason(result.getString("reason"));
            }
            closeJDBC();
            return (s);
        } catch (Exception e) {
        }
        return null;
    }

    public Speaker getRanksByID(int id) {
        Speaker s = new Speaker();
        try {
            initializeJDBC();
            statement = connection.prepareStatement("select rating, count from ranks_2012 where speaker_id = ?");
            statement.setInt(1, id);
            result = statement.executeQuery();
            while (result.next()) {
                s.setCount2012(result.getInt("count"));
                s.setRank2012(result.getDouble("rating"));
                return s;
            }
        } catch (Exception e) {
            s.setCount2012(0);
            s.setRank2012(0);
            return s;
        } finally {
            closeJDBC();
        }
        s.setCount2012(0);
        s.setRank2012(0);
        return s;
    }

    /**
     * Gets every speaker in the database along with their rank - used for admin
     *
     * @param A criteria to sort the query
     * @return A list of all speakers in the database
     */
    public ArrayList<Speaker> getAllSpeakers(String sort) {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("select s.id as id, s.first_name as first_name, s.last_name as last_name, s.reason as reason, s.type as type, s.suggested_by as suggested_by, s.visible as visible, sum(sr.ranking) as points, count(sr.speaker_id) as votes, r.rating as rating, r.count as count from speaker s left join ranks_2012 r on r.speaker_id = s.id left join speaker_ranking sr on sr.speaker_id = s.id  group by (s.id) " + sort);
            Statement s2 = connection.createStatement();
            result = statement.executeQuery();
            if (sort.equals(" order by rating desc, last_name") || sort.equals(" order by rating asc, last_name") || sort.equals(" order by count desc, last_name") || sort.equals(" order by count asc, last_name")) {
                sort = "";
            }
            ResultSet result2 = s2.executeQuery("select s.id, s.last_name, s.visible, sum(sr.ranking) as points, count(sr.speaker_id) as votes, s.suggested_by as suggested_by from speaker s left join speaker_ranking sr on s.id = sr.speaker_id group by s.id " + sort);
            ArrayList<Speaker> speakers = new ArrayList<Speaker>();
            while (result.next() && result2.next()) {
                Speaker s = new Speaker();
                s.setId(result.getInt("id"));
                s.setFirstName(result.getString("first_name"));
                s.setLastName(result.getString("last_name"));
                s.setSuggestedBy(result.getInt("suggested_by"));
                s.setVisible(result.getBoolean("visible"));
                s.setType(result.getString("type"));
                s.setReason(result.getString("reason"));
                try {
                    s.setRank2012(result.getDouble("rating"));
                    s.setCount2012(result.getInt("count"));
                    s.setRank(result2.getInt("points"));
                    s.setCount(result2.getInt("votes"));

                } catch (Exception e) {
                }
                speakers.add(s);

            }
            closeJDBC();
            return (speakers);
        } catch (Exception e) {
        }
        return null;
    }

    /**
     * Gets a list of speaker objects based on who suggested them
     *
     * @param id the user who suggested the speakers
     * @param sort the criteria with which to sort the results
     * @return A list of speakers that have been suggested by a user
     */
    public ArrayList<Speaker> getSpeakersByCreator(int id, String sort) {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("select id, first_name, last_name, "
                    + "suggested_by, visible, type from speaker where suggested_by = ?"
                    + " ?");
            statement.setInt(1, id);
            statement.setString(2, sort);
            result = statement.executeQuery();
            ArrayList<Speaker> speakers = new ArrayList<Speaker>();
            while (result.next()) {
                Speaker s = new Speaker();
                s.setId(result.getInt("id"));
                s.setFirstName(result.getString("first_name"));
                s.setLastName(result.getString("last_name"));
                s.setSuggestedBy(result.getInt("suggested_by"));
                s.setVisible(result.getBoolean("visible"));
                s.setType(result.getString("type"));
                speakers.add(s);
            }
            closeJDBC();
            return speakers;
        } catch (Exception e) {
        }
        return null;
    }

    /**
     * Gets a list of speaker objects based on who suggested them
     *
     * @param id the user who suggested the speakers
     * @param sort the criteria with which to sort the results
     * @return A list of speakers that have been suggested by a user
     */
    public ArrayList<Speaker> getNonDefaultSpeakers() {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("select id, first_name, last_name, "
                    + "suggested_by, visible, type, reason from speaker where suggested_by <> 202300");
            result = statement.executeQuery();
            ArrayList<Speaker> speakers = new ArrayList<Speaker>();
            while (result.next()) {
                Speaker s = new Speaker();
                s.setId(result.getInt("id"));
                s.setFirstName(result.getString("first_name"));
                s.setLastName(result.getString("last_name"));
                s.setSuggestedBy(result.getInt("suggested_by"));
                s.setVisible(result.getBoolean("visible"));
                s.setType(result.getString("type"));
                s.setReason(result.getString("reason"));
                speakers.add(s);
            }
            closeJDBC();
            return speakers;
        } catch (Exception e) {
        }
        return null;
    }

    /**
     * Gets a list of speaker objects based on visibility
     *
     * @param v the visibility to search for
     * @param sort the criteria with which to sort the results
     * @return A list of speakers that have been suggested by a user
     */
    public ArrayList<Speaker> getSpeakersByVisibility(boolean v, String sort) {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("select id, first_name, last_name, suggested_by, visible, type, reason from speaker where visible = ? " + sort);
            statement.setBoolean(1, v);
            result = statement.executeQuery();
            ArrayList<Speaker> speakers = new ArrayList<Speaker>();
            while (result.next()) {
                Speaker s = new Speaker();
                s.setId(result.getInt("id"));
                s.setFirstName(result.getString("first_name"));
                s.setLastName(result.getString("last_name"));
                s.setSuggestedBy(result.getInt("suggested_by"));
                s.setVisible(result.getBoolean("visible"));
                s.setType(result.getString("type"));
                s.setReason(result.getString("reason"));
                speakers.add(s);
            }
            closeJDBC();
            return speakers;
        } catch (Exception e) {
        }
        return null;
    }

    /**
     * Takes a group of speakers and ranks them in order 1-10
     *
     * @param speakers a list of speaker objects
     * @param user the user who is rating the speakers
     */
    public void setUserRanks(ArrayList<Speaker> speakers, int user) {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("insert into speaker_ranking "
                    + "(speaker_id, ranking, user_id) values "
                    + "(?, ?, ?)");
            statement.setInt(3, user);
            for (int i = 0; i < speakers.size() && i < 10; i++) {
                statement.setInt(1, speakers.get(i).getId());
                statement.setInt(2, 10 - i);
                statement.execute();
            }
            closeJDBC();
        } catch (Exception e) {
        }
    }

    /**
     * Updates a speaker in the database
     * 3/17/2014 Thuy updated the email field 
     * @param s The speaker to be updated
     */
    public void updateSpeaker(Speaker s) {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("update speaker "
                    + "set first_name = ?, "
                    + "last_name = ?, "
                    + "suggested_by = ?, "
                    + "visible = ?, "
                    + "type = ?, "
                    + "email = ? "
                    + "where id = ?");
            statement.setString(1, s.getFirstName());
            statement.setString(2, s.getLastName());
            statement.setInt(3, s.getSuggestedBy());
            statement.setBoolean(4, s.getVisible());
            statement.setString(5, s.getType());
            statement.setInt(6, s.getId());
            statement.setString(7, s.getEmail());
            success = statement.execute();
            closeJDBC();
        } catch (Exception e) {
        }
    }

    /**
     * Gets a list of speaker objects based on a user's previous rankings
     *
     * @param id the user who ranked the speakers
     * @return A list of speakers that have been ranked by a user
     */
    public ArrayList<Speaker> getUserRanks(int id) {
        ArrayList<Speaker> speakers = new ArrayList<Speaker>();
        try {
            initializeJDBC();
            statement = connection.prepareStatement("select s.id, s.first_name, s.last_name, s.suggested_by, s.visible, sum(r.ranking) as rating, count(r.speaker_id) as count from speaker s, speaker_ranking r where s.id = r.speaker_id and r.user_id = " + id + " group by (s.id) order by rating desc");
            result = statement.executeQuery();
            while (result.next()) {
                Speaker s = new Speaker();
                s.setId(result.getInt("s.id"));
                s.setFirstName(result.getString("s.first_name"));
                s.setLastName(result.getString("s.last_name"));
                s.setSuggestedBy(result.getInt("s.suggested_by"));
                s.setVisible(result.getBoolean("s.visible"));
                s.setRank(result.getInt("rating"));
                s.setCount(result.getInt("count"));
                speakers.add(s);
            }
            closeJDBC();
            return speakers;
        } catch (Exception e) {
        }
        return speakers;
    }

    public ArrayList<Speaker> getSpeakersBySession(int session) {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("select k.id, s.name, k.first_name, k.last_name from speaker k, session s, speaker_team t where t.speaker_id = k.id and t.session_id = s.id and s.id = ?");
            statement.setInt(1, session);
            result = statement.executeQuery();
            ArrayList<Speaker> speakers = new ArrayList<Speaker>();
            while (result.next()) {
                Speaker s = new Speaker();
                s.setId(result.getInt(1));
                s.setFirstName(result.getString(3));
                s.setLastName(result.getString(4));
                speakers.add(s);
            }
            return speakers;
        } catch (Exception e) {
        } finally {
            closeJDBC();
        }
        return new ArrayList<Speaker>();
    }

    public int getSpeakersAssignments(int speaker) {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("select count(speaker_id) from speaker_team where session_id in (select ses.id from session ses where extract(year from session_date) = 2013) and speaker_id = ?");
            statement.setInt(1, speaker);
            result = statement.executeQuery();
            int count = 0;
            while (result.next()) {
                count = result.getInt(1);
            }
            return count;
        } catch (Exception e) {
        } finally {
            closeJDBC();
        }
        return 0;
    }

    public int getSpeakersRank(int speaker) {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("select sum(ranking), count(speaker_id) from speaker_ranking where speaker_id = ?");
            statement.setInt(1, speaker);
            result = statement.executeQuery();
            int rank = 0;
            int count = 0;
            while (result.next()) {
                rank = result.getInt(1);
                count = result.getInt(2);
            }
            if (count != 0) {
                return (rank / count);
            }
        } catch (Exception e) {
        } finally {
            closeJDBC();
        }
        return 0;
    }

    public boolean isSpeakerInSession(int speaker, int session) {
        try {
            statement = connection.prepareStatement("select count(speaker_id) from speaker_team where speaker_id = ? and session_id = ?");
            statement.setInt(1, speaker);
            statement.setInt(2, session);
            result = statement.executeQuery();
            result.next();
            if (result.getInt(1) == 0) {
                return false;
            }
            else {
                return true;
            }
        } catch (Exception e) {
        } finally {
        }
        return false;
    }


    //*****************************************************************************
    //*********************Thuy: Added Code for email feature**********************
    //*****************************************************************************

    /**
     * Gets a list of speaker objects for email the email feature
     *
     * @param v the visibility to search for
     * @param sort the criteria with which to sort the results
     * @return A list of speakers that have been suggested by a user
     */
    public ArrayList<Speaker> getAllSpeakersForEmailList()
    {
        try 
        {
              initializeJDBC();
              String preparedSQL = "SELECT * FROM speaker ";
              statement = connection.prepareStatement(preparedSQL);
              result = statement.executeQuery();
              ArrayList<Speaker> speakers = new ArrayList<Speaker>();
              while (result.next()) 
              {
                Speaker s = new Speaker();
                s.setId(result.getInt("id"));
                s.setFirstName(result.getString("first_name"));
                s.setLastName(result.getString("last_name"));
                s.setSuggestedBy(result.getInt("suggested_by"));
                s.setVisible(result.getBoolean("visible"));
                s.setType(result.getString("type"));
                s.setReason(result.getString("reason"));
                s.setEmail(result.getString("email"));
                speakers.add(s);
              }
            closeJDBC();
            return speakers;
        }
        catch (Exception e) {
        }
        return null;
    }
}
