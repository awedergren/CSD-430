package com.csd430.beans;

import java.io.Serializable;

/**
 * Simple JavaBean representing a movie record used by the JSPs in this exercise.
 *
 * Note: keep this class minimal and serializable so it can be placed in
 * session/request scope if needed. The JSPs in the assignment expect setters
 * like setTitle(...), setGenre(...), setYear(...), setDirector(...),
 * setRating(...), setNotes(...).
 */
public class Movie implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private String title;
    private String genre;
    private int year;
    private String director;
    private double rating;
    private String notes;

    public Movie() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getGenre() { return genre; }
    public void setGenre(String genre) { this.genre = genre; }

    public int getYear() { return year; }
    public void setYear(int year) { this.year = year; }

    public String getDirector() { return director; }
    public void setDirector(String director) { this.director = director; }

    public double getRating() { return rating; }
    public void setRating(double rating) { this.rating = rating; }

    public String getNotes() { return notes; }
    public void setNotes(String notes) { this.notes = notes; }
}
