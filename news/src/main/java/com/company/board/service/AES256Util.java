package com.company.board.service;

import java.io.UnsupportedEncodingException;
import java.nio.charset.StandardCharsets;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

import org.springframework.stereotype.Service;

@Service
public class AES256Util {
	private static final String SECRET_KEY = "fUjXn2r5u8x/A?D(G+KbPdSgVkYp3s6v";
	private static final String IV = "ShVmYq3t6w9y$B&E";
	private static final String TRANSFORMATION = "AES/CBC/PKCS5Padding";

	public static String encrypt(String str) throws NoSuchPaddingException, NoSuchAlgorithmException,
		InvalidAlgorithmParameterException, InvalidKeyException, IllegalBlockSizeException, BadPaddingException {
		Cipher cipher = Cipher.getInstance(TRANSFORMATION);
		SecretKeySpec secretKeySpec = new SecretKeySpec(SECRET_KEY.getBytes(), "AES");
		IvParameterSpec ivParameterSpec = new IvParameterSpec(IV.getBytes(StandardCharsets.UTF_8));

		cipher.init(Cipher.ENCRYPT_MODE, secretKeySpec, ivParameterSpec);

		return Base64.getEncoder().encodeToString(cipher.doFinal(str.getBytes(StandardCharsets.UTF_8)));
	}

	public static String decrypt(String str) throws NoSuchPaddingException, NoSuchAlgorithmException, InvalidAlgorithmParameterException,
		InvalidKeyException, IllegalBlockSizeException, BadPaddingException, UnsupportedEncodingException {
		Cipher cipher = Cipher.getInstance(TRANSFORMATION);
		SecretKeySpec secretKeySpec = new SecretKeySpec(SECRET_KEY.getBytes(), "AES");
		IvParameterSpec ivParameterSpec = new IvParameterSpec(IV.getBytes(StandardCharsets.UTF_8));

		cipher.init(Cipher.DECRYPT_MODE, secretKeySpec, ivParameterSpec);

		return new String(cipher.doFinal(Base64.getDecoder().decode(str)), "UTF-8");
	}

}