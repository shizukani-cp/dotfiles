import asyncio
import os
import sys
import uuid

SOCK_PATH = "/tmp/nvim-vime.sock"
RUN_DIR = os.environ.get("XDG_RUNTIME_DIR", "/tmp")


class VimeServer:
    def __init__(self):
        self.ready_pipe = None
        self.nvim_proc = None

    async def spawn_nvim(self):
        """裏でNeovimを1台事前起動して待機させておく（ホットスタンドバイ）"""
        pipe_path = os.path.join(RUN_DIR,
                                 f"nvim-vime-pool-{uuid.uuid4().hex[:8]}.pipe")
        cmd = ["nvim", "--listen", pipe_path, "--headless", "-c", "normal! i"]
        proc = await asyncio.create_subprocess_exec(*cmd)
        while not os.path.exists(pipe_path):
            await asyncio.sleep(0.01)

        self.ready_pipe = pipe_path
        self.nvim_proc = proc

    async def handle_client(self, reader, writer):
        data = await reader.read(100)
        message = data.decode().strip()

        if message == "GET":
            if self.ready_pipe:
                assigned_pipe = self.ready_pipe
                self.ready_pipe = None
                self.nvim_proc = None
                writer.write(assigned_pipe.encode())
                await writer.drain()
                asyncio.create_task(self.spawn_nvim())
            else:
                writer.write(b"")
                await writer.drain()

        elif message.startswith("RELEASE"):
            parts = message.split(maxsplit=1)
            if len(parts) > 1 and os.path.exists(parts[1]):
                try:
                    os.remove(parts[1])
                except OSError:
                    pass
            writer.write(b"OK")
            await writer.drain()

        writer.close()
        await writer.wait_closed()


async def main():
    if os.path.exists(SOCK_PATH):
        os.remove(SOCK_PATH)

    server = VimeServer()
    await server.spawn_nvim()

    srv = await asyncio.start_unix_server(server.handle_client, path=SOCK_PATH)
    await srv.serve_forever()

if __name__ == "__main__":
    try:
        asyncio.run(main())
    except KeyboardInterrupt:
        sys.exit(0)
