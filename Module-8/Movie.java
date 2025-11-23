package com.csd430.beans;

import java.io.Serializable;

/**
 * Movie JavaBean used by Module-6 JSPs.
 * Fields match the columns in Amanda_movies_data table.
 * Implements Serializable as required for JavaBean usage.
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

    public Movie() {
        // no-arg constructor required for beans
    }

    // Getters and setters
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

    @Override
    public String toString() {
        return "Movie{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", genre='" + genre + '\'' +
                ", year=" + year +
                ", director='" + director + '\'' +
                ", rating=" + rating +
                ", notes='" + notes + '\'' +
                '}';
    }
}
