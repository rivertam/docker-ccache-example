# Docker C++ caching example

This example is a simple C++ binary with two compilation units and a Dockerfile
that builds them using a build cache volume to avoid recompiling the whole
thing.

Initially this included ccache but it doesn't seem necessary anymore.

## Testing

Step 1:

```
docker buildx build . -t playground --progress=plain --build-arg PLATFORM=x86
```

Notice how both "compiling Doofus" and "compiling main" are printed.

Step 2:

Modify `lib.cpp` with something inconsequential. I recommend adding an
apostrophe to "D'oh".

Step 3:

```
docker buildx build . -t playground --progress=plain --build-arg PLATFORM=x86
```

Notice how only "compiling Doofus" is printed. This is because main.cpp has been
cached!
