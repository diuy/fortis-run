package com.fortis.run;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.util.concurrent.locks.Condition;
import java.util.concurrent.locks.ReentrantLock;

public class Bootstrap {
    private static Log log = LogFactory.getLog(Bootstrap.class);
    private static final ReentrantLock LOCK = new ReentrantLock();
    private static final Condition STOP = LOCK.newCondition();
    public static void main(String[] args) throws InterruptedException {

        log.info("started");

        Runtime.getRuntime().addShutdownHook(new Thread() {
            public void run() {
                log.info("stopping");
                try {
                    Thread.sleep(3000);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
                try {
                    LOCK.lock();
                    STOP.signal();
                } finally {
                    LOCK.unlock();
                }
            }
        });
        try {
            LOCK.lock();
            STOP.await();
        } catch (InterruptedException e) {
            log.warn("interrupted by other thread!", e);
        } finally {
            LOCK.unlock();
        }
        System.out.println("stopped--");
        log.info("stopped");

    }
}
