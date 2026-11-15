#pragma once
#include <collection.h>
#include <ppltasks.h>
#include <robuffer.h>
#include <wrl/client.h>
#include <functional>
#include <memory>
#include <mutex>
#include <set>
#include <string>
#include <stdio.h>
#ifndef J2MEWP_WP81   // WP8.1 runtime component compiles AppState/engines without the XAML app
#include "App.xaml.h"
#endif
