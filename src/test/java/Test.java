import com.poojithairosha.shofy.service.FileUploadService;
import com.poojithairosha.shofy.util.ImageURIUtil;
import io.fusionauth.jwks.JSONWebKeySetHelper;
import io.fusionauth.jwks.domain.JSONWebKey;

import java.security.PublicKey;
import java.util.List;

public class Test {

    public static void main(String[] args) {
        FileUploadService fileUploadService = new FileUploadService();
        fileUploadService.deleteFile("priyani@gmail.com.jpg");
    }
}
