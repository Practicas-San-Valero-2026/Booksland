package com.svalero.booksland.model;

import lombok.Data;

@Data
public class Book {

    private int id;
    private String title;
    private String genre;
    private int pages;
    private String publisher;
    private int idAuthor;

}
