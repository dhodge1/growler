package com.scripps.growler;

import java.sql.*;

/**
 * A class designed to return image tags to the Growler Project website
 *
 * @author "Justin Bauguess"
 */
public class GiveStars {

    GrowlerQueries list = new GrowlerQueries();
    private final String IMAGE_START = "<img src = \"";
    private final String IMAGE_END = "\" />";
    private final String GOLD_STAR = "../images/icon16-goldstar.png";
    private final String GREY_STAR = "../images/icon16-greystar.png";
    private final String HALF_STAR = "../images/icon16-halfstar.png";

    public GiveStars() {
    }

    /**
     * Gives a string that has the points a theme has earned so far in voting
     *
     * @param id the theme id to analyze
     * @return The numerical id of the points a theme has earned, in string form
     * @throws ClassNotFoundException
     * @throws SQLException
     */
    public String themePoints(int id) throws ClassNotFoundException, SQLException {
        DataConnection data = new DataConnection();
        Connection connection = data.sendConnection();
        Statement statement = connection.createStatement();
        ResultSet result = statement.executeQuery("select sum(ranking) from isolated_theme_ranking where theme_id = " + id);
        int c = 0;
        while (result.next()) {
            c = result.getInt(1);
        }
        String count = String.valueOf(c);
        connection.close();
        statement.close();
        result.close();
        return (count);
    }

    /**
     * Returns the number of ratings a speaker received in 2012
     *
     * @param id The speaker id we are analyzing
     * @return The Count of Ratings a speaker received in 2012
     * @throws SQLException
     * @throws ClassNotFoundException
     */
    public String returnCount(int id) throws ClassNotFoundException, SQLException {
        DataConnection data = new DataConnection();
        Connection connection = data.sendConnection();
        Statement statement = connection.createStatement();
        ResultSet result = statement.executeQuery("select * from ranks_2012, speaker where ranks_2012.speaker_id = speaker.id and speaker.id = " + id);
        String count = "";
        while (result.next()) {
            if (result.getInt(3) != 0) {
                count = " / " + result.getInt(3) + " ratings";
            } else {
                count = "";
            }
        }
        connection.close();
        statement.close();
        result.close();
        return (count);
    }

    /**
     * Returns the concatenated list of <img> tags for use in a web page (2012)
     * data
     *
     * @param id The Speaker id we are analyzing
     * @return the list of tags concatenated for use in the web page
     * @throws ClassNotFoundException
     * @throws SQLException
     */
    public String return2012Rank(int id) throws ClassNotFoundException, SQLException {
        ResultSet result;
        String imgTag = "";
        DataConnection data = new DataConnection();
        Connection connection = data.sendConnection();
        Statement statement = connection.createStatement();
        //ResultSet result = statement.executeQuery("select avg(ranking) from session_ranking where session_ranking.session_id in (select id from session where id in (select session_id from speaker_team where speaker_id = " + id + "))");
        result = statement.executeQuery("select r.rating, s.id, s.first_name, s.last_name from ranks_2012 r, speaker s where s.id = r.speaker_id and s.id = " + id);
        if (!result.next()) {
            imgTag = "Not Rated in 2012";
        } else {
            imgTag = returnIMGTag(result.getDouble(1));
        }
        connection.close();
        statement.close();
        result.close();
        return (imgTag);
    }

    /**
     * Returns HTML tag(s) that print star graphics on the page (user votes from
     * this year)
     *
     * @param id The id of the speaker we are trying to get Stars for
     * @return and image tag for an HTML page
     * @throws ClassNotFoundException
     * @throws SQLException
     */
    public String returnStar(int id) throws ClassNotFoundException, SQLException {
        String imgTag = "";
        DataConnection data = new DataConnection();
        Connection connection = data.sendConnection();
        Statement statement = connection.createStatement();
        ResultSet results = statement.executeQuery("select r.rating, s.id from speaker s left join ranks_2012 r on s.id = " + id);
        if (!results.next()) {
            imgTag = "Not Rated in 2012";
        } else {
            imgTag = returnIMGTag(results.getDouble(1));
        }
        connection.close();
        statement.close();
        results.close();
        return (imgTag);
    }

    /**
     * Returns a list of image tags
     *
     * Searches through a list of conditional statements to find how many image
     * tags to create for the rating that has been passed.
     *
     * @param rating the number used to determine which tags to send back
     * @return A list of image tags containing gold, half, or grey stars
     */
    public String returnIMGTag(double rating) {
        String img = "";
        //5 *
        if (rating >= 4.7) {
            for (int k = 0; k < 5; k++) {
                img = img + (IMAGE_START + GOLD_STAR + IMAGE_END);
            }
        } //4.5 *
        else if (rating < 4.7 && rating >= 4.3) {
            for (int k = 0; k < 4; k++) {
                img = img + (IMAGE_START + GOLD_STAR + IMAGE_END);
            }
            img = img + IMAGE_START + HALF_STAR + IMAGE_END;
        } //4 *
        else if (rating < 4.3 && rating >= 3.7) {
            for (int k = 0; k < 4; k++) {
                img = img + (IMAGE_START + GOLD_STAR + IMAGE_END);
            }
            img = img + IMAGE_START + GREY_STAR + IMAGE_END;
        } //3.5 *
        else if (rating < 3.7 && rating >= 3.3) {
            for (int k = 0; k < 3; k++) {
                img = img + (IMAGE_START + GOLD_STAR + IMAGE_END);
            }
            img = img + IMAGE_START + HALF_STAR + IMAGE_END;
            img = img + IMAGE_START + GREY_STAR + IMAGE_END;
        } //3 *
        else if (rating < 3.3 && rating >= 2.7) {
            for (int k = 0; k < 3; k++) {
                img = img + (IMAGE_START + GOLD_STAR + IMAGE_END);
            }
            img = img + IMAGE_START + GREY_STAR + IMAGE_END;
            img = img + IMAGE_START + GREY_STAR + IMAGE_END;
        } //2.5 *
        else if (rating < 2.7 && rating >= 2.3) {
            img = IMAGE_START + GOLD_STAR + IMAGE_END;
            img = img + IMAGE_START + GOLD_STAR + IMAGE_END;
            img = img + IMAGE_START + HALF_STAR + IMAGE_END;
            for (int k = 0; k < 2; k++) {
                img = img + IMAGE_START + GREY_STAR + IMAGE_END;
            }
        } //2 *
        else if (rating < 2.3 && rating >= 1.7) {
            img = IMAGE_START + GOLD_STAR + IMAGE_END;
            img = img + IMAGE_START + GOLD_STAR + IMAGE_END;
            for (int k = 0; k < 3; k++) {
                img = img + IMAGE_START + GREY_STAR + IMAGE_END;
            }
        } //1.5 *
        else if (rating < 1.7 && rating >= 1.2) {
            img = IMAGE_START + GOLD_STAR + IMAGE_END;
            img = img + IMAGE_START + HALF_STAR + IMAGE_END;
            for (int k = 0; k < 3; k++) {
                img = img + (IMAGE_START + GREY_STAR + IMAGE_END);
            }
        } //1 *
        else if (rating < 1.2 && rating >= 0.7) {
            img = IMAGE_START + GOLD_STAR + IMAGE_END;
            for (int k = 0; k < 4; k++) {
                img = img + (IMAGE_START + GREY_STAR + IMAGE_END);
            }

        } //0.5 *
        else if (rating < 0.7 && rating >= 0.3) {
            img = IMAGE_START + HALF_STAR + IMAGE_END;
            for (int k = 0; k < 4; k++) {
                img = img + (IMAGE_START + GREY_STAR + IMAGE_END);
            }
        } // 0 *
        else if (rating < 0.3 && rating > 0) {
            for (int k = 0; k < 5; k++) {
                img = img + (IMAGE_START + GREY_STAR + IMAGE_END);
            }
        } else {
            img = "(No Rating in 2012)";
        }
        return (img);
    }
}
