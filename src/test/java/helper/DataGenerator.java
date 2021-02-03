package helper;

import com.github.javafaker.Faker;

public class DataGenerator {
	
	public static String getRandomEmail() {
		Faker faker = new Faker();
		String email = faker.name().firstName().toLowerCase() + faker.random().nextInt(0, 99) + "@karate.com";
		return email;
	}
	
	public static String getRandomPwd() {
		Faker faker = new Faker();
		String pwd = faker.gameOfThrones().character();
		return pwd;
	}
	
	public static String getRandomName() {
		Faker faker = new Faker();
		String name = faker.name().firstName();
		return name;
	}
	
	public static String getRandomJob() {
		Faker faker = new Faker();
		String job = faker.job().position();
		return job;
	}

}
