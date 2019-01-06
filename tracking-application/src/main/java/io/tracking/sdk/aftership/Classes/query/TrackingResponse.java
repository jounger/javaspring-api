package io.tracking.sdk.aftership.Classes.query;

import io.tracking.sdk.aftership.Classes.Tracking;

import java.util.List;

/**
 * Created by georgestoica on 30/3/16.
 */
public interface TrackingResponse {
    List<Tracking> getTrackingData();
}
