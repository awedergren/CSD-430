/**
 * Amanda Wedergren
 * November 24, 2025
 * Module 8.2 Assignment
 *
 * Movie JavaBean
 * ----------------
 * Simple POJO that maps to the `Amanda_movies_data` table used by the
 * Module-9 JSPs. This class follows JavaBean conventions (no-arg constructor,
 * getters/setters) so it can be used in JSPs or passed between layers.
 *
 * Fields and their mapping:
 * - `id`       : primary key (INT AUTO_INCREMENT)
 * - `title`    : movie title
 * - `genre`    : movie genre
 * - `year`     : release year
 * - `director` : director name
 * - `rating`   : numeric rating (e.g. 8.7)
 * - `notes`    : optional text notes
 *
 * The class implements `Serializable` as a best practice for beans used in
 * web applications (session storage, frameworks, etc.).
 */
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
