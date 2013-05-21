package com.scripps.growler;

public class Survey {

    private int session_id;
    private int question_1;
    private int question_2;
    private int question_3;
    private int question_4;

    public Survey() {
    }

    public int getSessionId() {
        return session_id;
    }

    public void setSessionId(int s) {
        this.session_id = s;
    }

    public int getQuestion1() {
        return question_1;
    }

    public void setQuestion1(int q) {
        this.question_1 = q;
    }

    public int getQuestion2() {
        return question_2;
    }

    public void setQuestion2(int q) {
        this.question_2 = q;
    }

    public int getQuestion3() {
        return question_3;
    }

    public void setQuestion3(int q) {
        this.question_3 = q;
    }

    public int getQuestion4() {
        return question_4;
    }

    public void setQuestion4(int q) {
        this.question_4 = q;
    }
}