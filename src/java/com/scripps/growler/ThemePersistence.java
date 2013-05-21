package com.scripps.growler;

import java.sql.*;
import java.util.*;

/**
 * Handles the data operations for Themes
 *
 * @see com.scripps.growler.Theme
 * @author "Justin Bauguess"
 */
public class ThemePersistence extends GrowlerPersistence {

    /**
     * Sorts queries by id in ascending order
     */
    final public String SORT_BY_ID_ASC = " order by id asc";
    /**
     * Sorts queries by id in descending order
     */
    final public String SORT_BY_ID_DESC = " order by id desc";
    /**
     * Sorts queries by name in ascending order
     */
    final public String SORT_BY_NAME_ASC = " order by name asc";
    /**
     * Sorts queries by name in descending order
     */
    final public String SORT_BY_NAME_DESC = " order by name desc";
    /**
     * Sorts queries by creator in ascending order
     */
    final public String SORT_BY_CREATOR_ASC = " order by creator asc";
    /**
     * Sorts queries by creator in descending order
     */
    final public String SORT_BY_CREATOR_DESC = " order by creator desc";
    /**
     * Sorts queries by visibility in ascending order
     */
    final public String SORT_BY_VISIBLE_ASC = " order by visible asc";
    /**
     * Sorts queries by visibility in descending order
     */
    final public String SORT_BY_VISIBLE_DESC = " order by visible desc";
    /**
     * Sorts queries by rating in ascending order
     */
    final public String SORT_BY_RATING_ASC = " order by rating asc";
    /**
     * Sorts queries by rating in descending order
     */
    final public String SORT_BY_RATING_DESC = " order by rating desc";
    /**
     * Sorts queries by rating, then name in ascending order
     */
    final public String SORT_BY_RATING_NAME_ASC = " order by rating, name asc";
    /**
     * Sorts queries by rating, then name in descending order
     */
    final public String SORT_BY_RATING_NAME_DESC = " order by rating desc, t.name asc";
    /**
     * A default constructor
     */
    public ThemePersistence() {
    }
    /**
     * Adds a theme to the database.
     *
     * @param t - a theme object
     */
    public void addTheme(Theme t) {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("insert into theme ("
                    + "name, description, reason, visible, creator) values "
                    + "(?, ?, ?, ?, ?)");
            statement.setString(1, t.getName());
            statement.setString(2, t.getDescription());
            statement.setString(3, t.getReason());
            statement.setBoolean(4, false);
            statement.setInt(5, t.getCreatorId());
            success = statement.execute();
            closeJDBC();
        } catch (Exception e) {
        }
    }
    /**
     * Searches for a string within the descriptions
     *
     * @param search a search criteria
     * @return A list of Themes that match the criteria
     */
    public ArrayList<Theme> searchDescription(String search) {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("select id, name, description"
                    + " from theme");
            result = statement.executeQuery();
            ArrayList<Theme> themes = new ArrayList<Theme>();
            while (result.next()) {
                String desc = result.getString("description");
                success = desc.contains(search.subSequence(0, search.length()));
                if (success) {
                    Theme t = new Theme();
                    t.setId(result.getInt("id"));
                    t.setName(result.getString("name"));
                    t.setDescription(result.getString("description"));
                }
            }
            closeJDBC();
            return themes;
        } catch (Exception e) {
        }
        return null;
    }
    /**
     * Returns a theme object corresponding to a given id
     *
     * @param id - The ID of the Theme, primary key of the Theme Table
     * @return the Theme that matches the given ID value
     */
    public Theme getThemeByID(int id) {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("select id, name, description, "
                    + "creator, visible from theme where id = ?");
            statement.setInt(1, id);
            result = statement.executeQuery();
            if (result.next()) {
                Theme t = new Theme();
                t.setId(result.getInt("id"));
                t.setName(result.getString("name"));
                t.setDescription(result.getString("description"));
                t.setCreatorId(result.getInt("creator"));
                t.setVisible(result.getBoolean("visible"));
		closeJDBC();
                return (t);
            }
            closeJDBC();
        } catch (Exception e) {
        }
        return (null);
    }
    /**
     * returns a list of Theme objects by a creator id
     *
     * @param c - a given creator id
     * @return an array list of theme objects
     */
    public ArrayList<Theme> getThemeByCreator(int c) {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("select id, name, description, "
                    + "creator, visible from theme where creator = ?");
            statement.setInt(1, c);
            result = statement.executeQuery();
            ArrayList<Theme> themes = new ArrayList<Theme>();
            while (result.next()) {
                Theme t = new Theme();
                t.setId(result.getInt("id"));
                t.setName(result.getString("name"));
                t.setDescription(result.getString("description"));
                t.setCreatorId(result.getInt("creator"));
                t.setVisible(result.getBoolean("visible"));
                themes.add(t);
            }
            closeJDBC();
            return (themes);
        } catch (Exception e) {
        }
        return (null);
    }
    /**
     * returns a list of Theme objects by visibility
     *
     * @param v - a given visibility value
     * @return an array list of theme objects that are visible (or not)
     */
    public ArrayList<Theme> getThemesByVisibility(boolean v) {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("select id, name, description, "
                    + "creator, visible from theme where visible = ?");
            statement.setBoolean(1, v);
            result = statement.executeQuery();
            ArrayList<Theme> themes = new ArrayList<Theme>();
            while (result.next()) {
                Theme t = new Theme();
                t.setId(result.getInt("id"));
                t.setName(result.getString("name"));
                t.setDescription(result.getString("description"));
                t.setCreatorId(result.getInt("creator"));
                t.setVisible(result.getBoolean("visible"));
                themes.add(t);
            }
            closeJDBC();
            return (themes);
        } catch (Exception e) {
        }
        return (null);
    }
    /**
     *
     * Returns a list of Themes ranked by a certain user
     *
     * @param id - The User's Id to get ranks for
     * @return A list of Themes that have been ranked
     */
    public ArrayList<Theme> getUserRanks(int id) {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("select r.theme_id, t.name from theme_ranking r, theme t where t.id = r.theme_id and r.user_id = " + id);
            result = statement.executeQuery();
            ArrayList<Theme> themes = new ArrayList<Theme>();
            while (result.next()) {
                Theme t = new Theme();
                t.setId(result.getInt("theme_id"));
                t.setName(result.getString("name"));
                themes.add(t);
            }
            closeJDBC();
            return (themes);
        } catch (Exception e) {
        }
        return (null);
    }
    /**
     * Returns a list of themes and their ranks/counts - used for admin page
     *
     * @return List of theme objects
     */
    public ArrayList<Theme> getRankedThemes() {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("select t.id, t.name, u.name as creator, sum(r.theme_rank) as rating, count(r.theme_id) as count, t.visible from theme t LEFT JOIN theme_ranking r on t.id = r.theme_id LEFT JOIN user u on u.id = t.creator group by t.id  order by rating desc, name");
            ArrayList<Theme> themes = new ArrayList<Theme>();
            while (result.next()) {
                Theme t = new Theme();
                t.setId(result.getInt("id"));
                t.setName(result.getString("name"));
                t.setCreatorId(result.getInt("creator"));
                t.setRank(result.getInt("rating"));
                t.setCount(result.getInt("count"));
                t.setVisible(result.getBoolean("visible"));
		themes.add(t);
            }
            closeJDBC();
	    return (themes);
        } catch (Exception e) {
        }
        return (null);
    }
    /**
     * Saves a user's ranks to the database
     *
     * @param themes - The list of themes a user will rank
     * @param user - The ID of the user
     */
    public void setUserRanks(ArrayList<Theme> themes, int user) {
        try {
            statement = connection.prepareStatement("insert into theme_ranking ("
                    + "user_id, theme_id, theme_rank) values (" + user + ",?,?)");
            for (int i = 0; i > themes.size(); i++) {
                statement.setInt(1, themes.get(i).getId());
                statement.setInt(2, 10 - i);
                statement.execute();
            }
            closeJDBC();
        } catch (Exception e) {
        }
    }
    /**
     *
     * Searches the database for all the themes and the information about them
     *
     * @param sort - the criteria to sort the query
     * @return An array list of all the Themes in the database
     */
    public ArrayList<Theme> getAllThemes(String sort) {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("select t.id as id, t.name as name, u.id as creator, sum(r.theme_rank) as rating, count(r.theme_id) as count, t.visible as visible from theme t LEFT JOIN theme_ranking r on t.id = r.theme_id LEFT JOIN user u on u.id = t.creator group by t.id " + sort);
            result = statement.executeQuery();
            ArrayList<Theme> themes = new ArrayList<Theme>();
            while (result.next()) {
                Theme t = new Theme();
                t.setId(result.getInt("id"));
                t.setName(result.getString("name"));
                t.setCreatorId(result.getInt("creator"));
                t.setVisible(result.getBoolean("visible"));
		t.setRank(result.getInt("rating"));
		t.setCount(result.getInt("count"));
                themes.add(t);
            }
            closeJDBC();
            return (themes);
        } catch (Exception e) {
        }
        return (null);
    }
    /**
     * updates the information for a theme - used by admins
     *
     * @param t The Theme to update
     */
    public void updateTheme(Theme t) {
        try {
            initializeJDBC();
            statement = connection.prepareStatement("update theme "
                    + "set name = ?, "
                    + "set description = ?, "
                    + "set creator = ?, "
                    + "set visibility = ?, "
                    + "where id = ?");
            statement.setString(1, t.getName());
            statement.setString(2, t.getDescription());
            statement.setInt(3, t.getCreatorId());
            statement.setBoolean(4, t.getVisible());
            statement.setInt(5, t.getId());
            success = statement.execute();
            closeJDBC();
        } catch (Exception e) {
        }
    }
    /**
     * Removes a theme from the database
     * @param t The theme to remove - all we really need is the ID
     */
    public void deleteTheme(Theme t) {
        try {
        initializeJDBC();
        statement = connection.prepareStatement("delete from theme where " +
                "id = ?");
        statement.setInt(1, t.getId());
        statement.execute();
        closeJDBC();
        }
        catch (Exception e) {
            
        }
    }
}