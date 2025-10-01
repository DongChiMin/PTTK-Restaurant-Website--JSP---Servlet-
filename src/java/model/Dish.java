package model;

public class Dish {
    private int id;
    private String name;
    private String description;
    private float price;
    private String category;

    public Dish() {
    }

    public Dish(int id, String name, String description, float price, String category) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.price = price;
        this.category = category;
    }
    
}

