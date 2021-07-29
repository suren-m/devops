#!/usr/bin/env python

# WS server that sends messages at random intervals

import asyncio
import datetime
import random
import websockets
import socket
import datetime  

async def time(websocket, path):
    while True:
        utc_time_now = datetime.datetime.now(datetime.timezone.utc).strftime("%Y-%m-%dT%H:%M:%S.%f%Z")
        now = f"Resp from {socket.gethostname()} - {utc_time_now}"
        await websocket.send(now)
        await asyncio.sleep(random.randrange(1, 3))

start_server = websockets.serve(time, "127.0.0.1", 8080)

asyncio.get_event_loop().run_until_complete(start_server)
asyncio.get_event_loop().run_forever()
