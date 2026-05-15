package com.svalero.booksland.model;

import lombok.Data;

@Data
public class Author {

    private int id;
    private String name;
    private String lastName;
    private String nationality;
    private String biography;

}
