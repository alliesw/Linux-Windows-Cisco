------------------------------------------------------------------------------------------------------------------------------
REM File Name         : performance_metrics.sql
REM Author            : Alex Shields-Weber
REM Purpose	          : Displays the Buffer Cache Hit Ratio to
--                      indicate the percentage of pages found
--                      in the buffer cache without having to read from disk
-------------------------------------------------------------------------------------------------------------------------------

COLUMN BUFFER_POOL_NAME FORMAT A20

SELECT name BUFFER_POOL_NAME, consistent_gets Consistent, db_block_gets Dbblockgets,
physical_reads Physrds,
ROUND(100*(1 - (physical_reads/(consistent_gets + db_block_gets))),2) HitRatio
FROM v$buffer_pool_statistics
WHERE (consistent_gets + db_block_gets) != 0; 

-- COMMIT; 
REM End of Script!
