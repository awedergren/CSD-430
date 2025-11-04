package com.wedergren.beans;

import java.io.Serializable;
import java.util.Arrays;

/**
 * Amanda Wedergren
 * November 3, 2025
 * Module 4.2 Assignment
 * 
 * JavaBean representing a job applicant.
 *
 * This bean is a simple data holder intended to be used from a JSP page (via
 * scriptlets or JSP actions). It implements {@link java.io.Serializable}. 
 * Keep the bean simple: no business logic here,
 * only fields, getters, and setters.
 *
 * Fields (minimum 5): fullName, email, phone, position, startDate, salary,
 * yearsExperience, skills, coverLetter.
 */
public class Applicant implements Serializable {

    private static final long serialVersionUID = 1L;

    private String fullName;
    private String email;
    private String phone;
    private String position;
    private String startDate; // kept as String for simplicity in JSP formatting
    private double salary;
    private int yearsExperience;
    private String[] skills;
    private String coverLetter;

    public Applicant() {
        // No-arg constructor required for JavaBean usage. Containers and JSPs
        // expect a public no-arg constructor so they can instantiate the bean
        // reflectively and then call setters.
    }

    // Getters and setters
    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    public String getStartDate() {
        return startDate;
    }

    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }

    public double getSalary() {
        return salary;
    }

    public void setSalary(double salary) {
        this.salary = salary;
    }

    public int getYearsExperience() {
        return yearsExperience;
    }

    public void setYearsExperience(int yearsExperience) {
        this.yearsExperience = yearsExperience;
    }

    public String[] getSkills() {
        return skills;
    }

    public void setSkills(String[] skills) {
        this.skills = skills;
    }

    public String getCoverLetter() {
        return coverLetter;
    }

    public void setCoverLetter(String coverLetter) {
        this.coverLetter = coverLetter;
    }

    @Override
    public String toString() {
        return "Applicant{" +
                "fullName='" + fullName + '\'' +
                ", email='" + email + '\'' +
                ", phone='" + phone + '\'' +
                ", position='" + position + '\'' +
                ", startDate='" + startDate + '\'' +
                ", salary=" + salary +
                ", yearsExperience=" + yearsExperience +
                ", skills=" + (skills == null ? "[]" : Arrays.toString(skills)) +
                ", coverLetter='" + (coverLetter == null ? "" : coverLetter) + '\'' +
                '}';
    }
}
