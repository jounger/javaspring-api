package io.tracking.sdk.aftership.Classes;

/**
 * Created by User on 10/6/14.
 */
public class AftershipAPIException extends Exception{

    /**
	 * 
	 */
	private static final long serialVersionUID = 8744813363880126671L;

	public AftershipAPIException() {}

    public AftershipAPIException(String message)
    {
        super(message);
    }

}
