/*　テーブルの更新前後を比較するテンプレクエリを作るクエリ　*/

DECLARE @TABLE_LIST TABLE(
	DB	VARCHAR(16),
	TABLE_NAME VARCHAR(56)
);

DECLARE @DB VARCHAR(16);
DECLARE @TABLE_NAME VARCHAR(56);


INSERT INTO @TABLE_LIST VALUES
('HOGE','HOGE_NOTE_DATA'),
('MOGE','MOGE_DEBUG_DATA');

DECLARE CREATE_SQL CURSOR FOR
SELECT DB,TABLE_NAME FROM @TABLE_LIST;

OPEN CREATE_SQL;

FETCH NEXT FROM CREATE_SQL INTO @DB,@TABLE_NAME;


PRINT '＜＜＜＜＜ CREATE SQL!!! ＞＞＞＞＞＞'

WHILE (@@FETCH_STATUS = 0)
BEGIN
	
	PRINT '
		IF (PBJECT_ID( ''TEMPDB.DBO.#_' + @TABLE_NAME + ''' ) IS NOT NULL)
		BEGIN
			PRINT ''DROP TABLE #_' + @TABLE_NAME + '''
			DROP TABLE #_' + @TABLE_NAME + '
		END

		SELECT ''01.BEFORE'' AS ''CHK'',* 
		INTO #_' + @TABLE_NAME + '
		FROM ' + @DB + '.DBO.' + @TABLE_NAME + '
		★PLEASE CUSTOMIZE WHERE PHRASE

		★PLEASE WRITE PROCESSING(UPDATE/DELETE/INSERT) HERE

		INSERT INTO #_' + @TABLE_NAME + '
		SELECT ''02.AFTER'' AS ''CHK'',* 
		FROM ' + @DB + '.DBO.' + @TABLE_NAME + '
		★PLEASE CUSTOMIZE WHERE PHRASE

		SELECT * FROM #_' + @TABLE_NAME + ' ORDER BY CHK
	'

	FETCH NEXT FROM CREATE_SQL INTO @DB,@TABLE_NAME;

END