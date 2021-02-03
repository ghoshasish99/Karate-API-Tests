package features.registration;

import com.intuit.karate.junit5.Karate;

class RegistrationRunner {
    
    @Karate.Test
    Karate testUsers() {
        return Karate.run("registration").relativeTo(getClass());
    }    

}
