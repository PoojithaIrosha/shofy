package com.poojithairosha.shofy.util;

import java.util.concurrent.LinkedBlockingQueue;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

public class ThreadPoolExecutorUtil {

    private static final ThreadPoolExecutor THREAD_POOL_EXECUTOR = buildThreadPoolExecutor();

    private static ThreadPoolExecutor buildThreadPoolExecutor() {
        return new ThreadPoolExecutor(1, 1, 2, TimeUnit.MINUTES, new LinkedBlockingQueue<>());
    }

    public static ThreadPoolExecutor getExecutor() {
        return THREAD_POOL_EXECUTOR;
    }

}
