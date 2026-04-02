package com.sample_pro.service;

import com.sample_pro.domain.TempHistory;
import com.sample_pro.domain.TempTag;

import java.util.List;
import java.util.Map;

public interface TempService {
    List<TempTag> getTempTagList();
    void insertTempTag(TempTag tag);
    void updateTempTag(TempTag tag);
    void deleteTempTag(int tempId);

    List<TempHistory> getTempHistory(int limit, Integer tempId);

    List<Map<String, Object>> getTempSnapshot(int limit);
    List<Map<String, Object>> getTempSnapshotRange(String from, String to);
}
